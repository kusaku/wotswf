package net.wg.gui.lobby.fortifications {
import flash.display.InteractiveObject;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.division.impl.ChoiceDivisionSelector;
import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionSelectorVO;
import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionVO;
import net.wg.infrastructure.base.meta.IFortChoiceDivisionWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortChoiceDivisionWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ButtonGroup;
import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class FortChoiceDivisionWindow extends FortChoiceDivisionWindowMeta implements IFortChoiceDivisionWindowMeta {

    public var description:TextField = null;

    public var applyBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var middleDivision:ChoiceDivisionSelector = null;

    public var championDivision:ChoiceDivisionSelector = null;

    public var absoluteDivision:ChoiceDivisionSelector = null;

    private var _selectors:Array = null;

    private var _model:FortChoiceDivisionVO = null;

    private var _divisionGroup:ButtonGroup = null;

    public function FortChoiceDivisionWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
        this.description.mouseEnabled = false;
        this._selectors = [this.middleDivision, this.championDivision, this.absoluteDivision];
        TextFieldEx.setVerticalAlign(this.description, TextFieldEx.VALIGN_CENTER);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        App.utils.commons.initTabIndex(new <InteractiveObject>[this.middleDivision, this.championDivision, this.absoluteDivision, this.applyBtn, this.cancelBtn, window.getCloseBtn()]);
    }

    override protected function configUI():void {
        super.configUI();
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onClickApplyBtnHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onClickCancelBtnHandler);
    }

    override protected function setData(param1:FortChoiceDivisionVO):void {
        this._divisionGroup = ButtonGroup.getGroup("divisionGroup", this);
        this._model = param1;
        invalidateData();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:ChoiceDivisionSelector = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._model) {
            window.title = this._model.windowTitle;
            this.description.htmlText = this._model.description;
            this.applyBtn.label = this._model.applyBtnLbl;
            this.cancelBtn.label = this._model.cancelBtnLbl;
            if (this._model.selectorsData) {
                _loc1_ = this._selectors.length;
                _loc2_ = 0;
                while (_loc2_ < _loc1_) {
                    _loc3_ = ChoiceDivisionSelector(this._selectors[_loc2_]);
                    _loc3_.setData(this._model.selectorsData[_loc2_]);
                    _loc3_.groupName = "divisionGroup";
                    _loc3_.allowDeselect = false;
                    _loc3_.addEventListener(MouseEvent.DOUBLE_CLICK, this.onDivisionItemDoubleClickHandler);
                    _loc3_.addEventListener(FocusEvent.FOCUS_IN, this.onDivisionItemFocusInHandler);
                    if (this._model.autoSelect != Values.DEFAULT_INT && this._model.autoSelect == FortChoiceDivisionSelectorVO(this._model.selectorsData[_loc2_]).divisionID) {
                        setFocus(this._selectors[_loc2_]);
                    }
                    _loc2_++;
                }
            }
        }
    }

    override protected function onDispose():void {
        var _loc1_:ChoiceDivisionSelector = null;
        App.utils.scheduler.cancelTask(onWindowCloseS);
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onClickApplyBtnHandler);
        this.applyBtn.dispose();
        this.applyBtn = null;
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onClickCancelBtnHandler);
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        for each(_loc1_ in this._selectors) {
            _loc1_.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onDivisionItemDoubleClickHandler);
            _loc1_.removeEventListener(FocusEvent.FOCUS_IN, this.onDivisionItemFocusInHandler);
            _loc1_.dispose();
        }
        this._selectors.splice(0, this._selectors.length);
        this._selectors = null;
        this._model = null;
        this.middleDivision = null;
        this.championDivision = null;
        this.absoluteDivision = null;
        this._divisionGroup.dispose();
        this._divisionGroup = null;
        this.description = null;
        super.onDispose();
    }

    private function getDivisionID():int {
        return ChoiceDivisionSelector(this._divisionGroup.selectedButton).divisionID;
    }

    private function onClickApplyBtnHandler(param1:ButtonEvent):void {
        if (this._model.isInChangeDivisionMode) {
            changedDivisionS(this.getDivisionID());
        }
        else {
            selectedDivisionS(this.getDivisionID());
        }
        App.utils.scheduler.scheduleOnNextFrame(onWindowCloseS);
    }

    private function onDivisionItemDoubleClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isLeftButton(param1)) {
            selectedDivisionS(this.getDivisionID());
            App.utils.scheduler.scheduleOnNextFrame(onWindowCloseS);
        }
    }

    private function onDivisionItemFocusInHandler(param1:FocusEvent):void {
        var _loc2_:ChoiceDivisionSelector = param1.target as ChoiceDivisionSelector;
        if (_loc2_) {
            this.applyBtn.enabled = _loc2_.divisionID != this._model.currentDivisionID;
        }
    }

    private function onClickCancelBtnHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}

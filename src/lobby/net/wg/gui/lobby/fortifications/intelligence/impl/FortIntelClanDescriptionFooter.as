package net.wg.gui.lobby.fortifications.intelligence.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionButtonRenderer;
import net.wg.gui.lobby.fortifications.cmp.tankIcon.impl.FortTankIcon;
import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;

public class FortIntelClanDescriptionFooter extends UIComponent implements IFocusContainer {

    private static const LINKBTN_OFFSET_X:int = 7;

    private static const LINKBTN_OFFSET_Y:int = 4;

    private static const CALENDAR_ICON_PNG:String = "calendar.png";

    private static const ALPHA_ENABLE:Number = 1;

    private static const ALPHA_DISABLE:Number = 0.5;

    private static const DEFAULT_WAR_TIME_POSITION:int = 46;

    private static const WAR_TIME_Y_OFFSET:int = 2;

    public var selectDateTF:TextField = null;

    public var dateSelectedTF:TextField = null;

    public var warDeclaredTF:TextField = null;

    public var warDescriptionTF:TextField = null;

    public var warTimeTF:TextField = null;

    public var warDisableTF:TextField = null;

    public var warningIcon:Sprite = null;

    public var divisionIcon:FortTankIcon = null;

    public var calendarBtn:IconTextButton = null;

    public var linkBtn:SoundButtonEx = null;

    public var background:MovieClip = null;

    public var direction0:DirectionButtonRenderer;

    public var direction1:DirectionButtonRenderer;

    public var direction2:DirectionButtonRenderer;

    public var direction3:DirectionButtonRenderer;

    private var allRenderers:Array;

    private var _model:ClanDescriptionVO = null;

    public function FortIntelClanDescriptionFooter() {
        super();
        this.allRenderers = [this.direction0, this.direction1, this.direction2, this.direction3];
        this.divisionIcon.visible = false;
    }

    private static function onCalendarBtnRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onLinkBtnRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_LINKBTN);
    }

    private static function onLinkBtnRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onWarTimeTFRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this.calendarBtn.icon = CALENDAR_ICON_PNG;
    }

    override protected function onDispose():void {
        this.calendarBtn.removeEventListener(ButtonEvent.CLICK, this.onClickCalendarBtnHandler);
        this.calendarBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onCalendarBtnRollOverHandler);
        this.calendarBtn.removeEventListener(MouseEvent.ROLL_OUT, onCalendarBtnRollOutHandler);
        this.linkBtn.removeEventListener(ButtonEvent.CLICK, this.onClickLinkBtnHandler);
        this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER, onLinkBtnRollOverHandler);
        this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT, onLinkBtnRollOutHandler);
        this.selectDateTF = null;
        this.dateSelectedTF = null;
        this.warDeclaredTF = null;
        this.warDescriptionTF = null;
        this.warTimeTF = null;
        this.warDisableTF = null;
        this.warningIcon = null;
        this.divisionIcon.dispose();
        this.divisionIcon = null;
        this.calendarBtn.dispose();
        this.calendarBtn = null;
        this.linkBtn.dispose();
        this.linkBtn = null;
        this.background = null;
        this.disposeDirections();
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._model) {
            this.updateElements();
            this.updateDirections();
        }
    }

    private function disposeDirections():void {
        var _loc1_:DirectionButtonRenderer = null;
        for each(_loc1_ in this.allRenderers) {
            _loc1_.dispose();
            _loc1_ = null;
        }
        this.allRenderers.splice(0);
        this.allRenderers = null;
    }

    private function updateDirections():void {
        var _loc2_:DirectionButtonRenderer = null;
        var _loc3_:DirectionVO = null;
        var _loc1_:int = 0;
        if (this._model && this._model.hasDirections) {
            while (_loc1_ < this._model.directions.length) {
                _loc3_ = this._model.directions[_loc1_];
                _loc2_ = this.allRenderers[_loc1_];
                _loc2_.model = _loc3_;
                _loc2_.canAttackMode = this._model.canAttackDirection && !this._model.isOurFortFrozen;
                _loc2_.canAvailableMode = this._model.isAvailableByLevel;
                _loc1_++;
            }
        }
        while (_loc1_ < this.allRenderers.length) {
            _loc2_ = this.allRenderers[_loc1_];
            _loc2_.model = null;
            _loc1_++;
        }
    }

    private function updateElements():void {
        var _loc1_:Number = NaN;
        this.warDisableTF.visible = this.warningIcon.visible = !this._model.isAvailableByLevel;
        if (!this._model.isAvailableByLevel) {
            this.selectDateTF.visible = false;
            this.dateSelectedTF.visible = false;
            this.warDeclaredTF.visible = false;
            this.warDescriptionTF.visible = false;
            this.warTimeTF.visible = false;
            this.divisionIcon.visible = false;
            this.calendarBtn.visible = false;
            this.linkBtn.visible = false;
            this.background.alpha = ALPHA_ENABLE;
            this.warDisableTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_DISABLEATTACK);
            return;
        }
        this.selectDateTF.htmlText = this._model.selectedDateText;
        if (this._model.warPlannedTime) {
            this.warTimeTF.visible = true;
            this.warTimeTF.htmlText = this._model.warPlannedTime;
            this.warTimeTF.addEventListener(MouseEvent.ROLL_OVER, this.onWarTimeTFRollOverHandler);
            this.warTimeTF.addEventListener(MouseEvent.ROLL_OUT, onWarTimeTFRollOutHandler);
        }
        else {
            this.warTimeTF.visible = false;
            this.warTimeTF.removeEventListener(MouseEvent.ROLL_OVER, this.onWarTimeTFRollOverHandler);
            this.warTimeTF.removeEventListener(MouseEvent.ROLL_OUT, onWarTimeTFRollOutHandler);
        }
        this.divisionIcon.visible = this._model.divisionIcon != null;
        if (this._model.divisionIcon != null) {
            this.divisionIcon.update(this._model.divisionIcon);
        }
        if (!this._model.canAttackDirection) {
            this.selectDateTF.visible = true;
            this.warDeclaredTF.visible = false;
            this.warDescriptionTF.visible = false;
            this.dateSelectedTF.visible = true;
            this.dateSelectedTF.text = this._model.dateSelected;
            this.calendarBtn.visible = true;
            this.addCalendarBtnListeners();
            this.linkBtn.visible = false;
            this.removeLinkBtnListeners();
            this.background.alpha = ALPHA_ENABLE;
        }
        else if (this._model.isWarDeclared) {
            this.selectDateTF.visible = false;
            this.dateSelectedTF.visible = false;
            this.calendarBtn.visible = false;
            this.warDeclaredTF.visible = true;
            this.warDescriptionTF.visible = true;
            this.linkBtn.visible = true;
            this.background.alpha = ALPHA_DISABLE;
            this.warDeclaredTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_WARDECLARED, {"clanName": this._model.clanTag});
            this.warDescriptionTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NEXTAVAILABLEATTACKINAWEEK, {"nextDate": this._model.warPlannedDate});
            _loc1_ = this.warDescriptionTF.getLineMetrics(this.warDescriptionTF.numLines - 1).width;
            this.linkBtn.y = Math.round(this.warDescriptionTF.textHeight + this.warDescriptionTF.y - this.linkBtn.height + LINKBTN_OFFSET_Y);
            this.linkBtn.x = Math.round(this.warDescriptionTF.x + _loc1_ + LINKBTN_OFFSET_X);
            this.addLinkBtnListeners();
            this.removeCalendarBtnListeners();
        }
        else if (this._model.isAlreadyFought) {
            this.selectDateTF.visible = false;
            this.dateSelectedTF.visible = false;
            this.calendarBtn.visible = false;
            this.warDeclaredTF.visible = true;
            this.warDescriptionTF.visible = true;
            this.linkBtn.visible = false;
            this.background.alpha = ALPHA_DISABLE;
            this.warDeclaredTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_ALREADYFOUGHT, {"clanName": this._model.clanTag});
            this.warDescriptionTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NEXTAVAILABLEATTACK, {"nextDate": this._model.warNextAvailableDate});
            this.removeLinkBtnListeners();
            this.removeCalendarBtnListeners();
        }
        else {
            this.selectDateTF.visible = true;
            this.dateSelectedTF.visible = true;
            this.calendarBtn.visible = true;
            this.warDeclaredTF.visible = false;
            this.warDescriptionTF.visible = false;
            this.linkBtn.visible = false;
            this.dateSelectedTF.text = this._model.dateSelected;
            this.background.alpha = ALPHA_ENABLE;
            this.addCalendarBtnListeners();
            this.removeLinkBtnListeners();
        }
        if (this._model.warPlannedTime) {
            this.updateWarTimePosition();
        }
    }

    private function updateWarTimePosition():void {
        if (!this.warTimeTF.visible) {
            return;
        }
        if (this.linkBtn.visible) {
            this.warTimeTF.y = this.linkBtn.y - WAR_TIME_Y_OFFSET;
        }
        else if (this.calendarBtn.visible) {
            this.warTimeTF.y = this.calendarBtn.y - WAR_TIME_Y_OFFSET;
        }
        else {
            this.warTimeTF.y = DEFAULT_WAR_TIME_POSITION;
        }
    }

    private function addCalendarBtnListeners():void {
        this.calendarBtn.addEventListener(ButtonEvent.CLICK, this.onClickCalendarBtnHandler);
        this.calendarBtn.addEventListener(MouseEvent.ROLL_OVER, this.onCalendarBtnRollOverHandler);
        this.calendarBtn.addEventListener(MouseEvent.ROLL_OUT, onCalendarBtnRollOutHandler);
        this.calendarBtn.addEventListener(InputEvent.INPUT, this.onCalendarBtnInputHandler);
    }

    private function removeCalendarBtnListeners():void {
        this.calendarBtn.removeEventListener(ButtonEvent.CLICK, this.onClickCalendarBtnHandler);
        this.calendarBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onCalendarBtnRollOverHandler);
        this.calendarBtn.removeEventListener(MouseEvent.ROLL_OUT, onCalendarBtnRollOutHandler);
        this.calendarBtn.removeEventListener(InputEvent.INPUT, this.onCalendarBtnInputHandler);
    }

    private function addLinkBtnListeners():void {
        this.linkBtn.addEventListener(ButtonEvent.CLICK, this.onClickLinkBtnHandler);
        this.linkBtn.addEventListener(MouseEvent.ROLL_OVER, onLinkBtnRollOverHandler);
        this.linkBtn.addEventListener(MouseEvent.ROLL_OUT, onLinkBtnRollOutHandler);
    }

    private function removeLinkBtnListeners():void {
        this.linkBtn.removeEventListener(ButtonEvent.CLICK, this.onClickLinkBtnHandler);
        this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER, onLinkBtnRollOverHandler);
        this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT, onLinkBtnRollOutHandler);
    }

    public function get model():ClanDescriptionVO {
        return this._model;
    }

    public function set model(param1:ClanDescriptionVO):void {
        this._model = param1;
        invalidateData();
    }

    private function onClickCalendarBtnHandler(param1:ButtonEvent):void {
        dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.OPEN_CALENDAR));
    }

    private function onCalendarBtnRollOverHandler(param1:MouseEvent):void {
        if (this._model.canAttackDirection) {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_CALENDARBTN);
        }
        else {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_CALENDARBTN_CANTATTACK);
        }
    }

    private function onClickLinkBtnHandler(param1:ButtonEvent):void {
        dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.CLICK_LINK_BTN));
    }

    private function onWarTimeTFRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this._model.warPlannedTimeTT);
    }

    public function getComponentForFocus():InteractiveObject {
        return this.calendarBtn;
    }

    private function onCalendarBtnInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.UP) {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.FOCUS_UP));
            param1.handled = true;
        }
    }
}
}

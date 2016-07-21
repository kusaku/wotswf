package net.wg.gui.lobby.fallout {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fallout.data.FalloutBattleSelectorTooltipVO;
import net.wg.gui.lobby.fallout.data.SelectorWindowBtnStatesVO;
import net.wg.gui.lobby.fallout.data.SelectorWindowStaticDataVO;
import net.wg.infrastructure.base.meta.IFalloutBattleSelectorWindowMeta;
import net.wg.infrastructure.base.meta.impl.FalloutBattleSelectorWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class FalloutBattleSelectorWindow extends FalloutBattleSelectorWindowMeta implements IFalloutBattleSelectorWindowMeta {

    private static const WINDOW_PADDING_BOTTOM:int = 4;

    private static const BTN_TOP_PADDING:int = 23;

    private static const DESCRIPTION_TOP_PADDING:int = 14;

    private static const CHECK_BOX_RIGHT_PADDING:int = 15;

    public var headerTitleTF:TextField;

    public var headerDescTF:TextField;

    public var dominationBattleTitleTF:TextField;

    public var dominationBattleDescTF:TextField;

    public var dominationBattleBtn:ISoundButtonEx;

    public var multiteamTitleTF:TextField;

    public var multiteamDescTF:TextField;

    public var multiteamBattleBtn:ISoundButtonEx;

    public var bgImg:UILoaderAlt;

    public var autoSquadInfo:InfoIcon;

    public var checkBoxAutoSquad:CheckBox;

    private var _btnsWithTooltip:Array;

    private var _initData:SelectorWindowStaticDataVO;

    private var _tooltipData:FalloutBattleSelectorTooltipVO = null;

    public function FalloutBattleSelectorWindow() {
        super();
        canMinimize = true;
    }

    override public function getClientItemID():Number {
        return getClientIDS();
    }

    override protected function draw():void {
        super.draw();
        if (this._initData == null) {
            return;
        }
        if (isInvalid(InvalidationType.DATA)) {
            window.title = this._initData.windowTitle;
            this.headerTitleTF.htmlText = this._initData.headerTitleStr;
            this.headerDescTF.htmlText = this._initData.headerDescStr;
            this.dominationBattleTitleTF.htmlText = this._initData.dominationBattleTitleStr;
            this.dominationBattleDescTF.htmlText = this._initData.dominationBattleDescStr;
            this.dominationBattleBtn.label = this._initData.dominationBattleBtnStr;
            this.multiteamTitleTF.htmlText = this._initData.multiteamTitleStr;
            this.multiteamDescTF.htmlText = this._initData.multiteamDescStr;
            this.multiteamBattleBtn.label = this._initData.multiteamBattleBtnStr;
            this.checkBoxAutoSquad.label = this._initData.multiteamAutoSquadLabel;
            this.checkBoxAutoSquad.selected = this._initData.multiteamAutoSquadEnabled;
            this.checkBoxAutoSquad.autoSize = TextFieldAutoSize.LEFT;
            this.autoSquadInfo.tooltip = this._tooltipData.autoSquadStr;
            this.updateAutoSquadElementsPosition();
            this.bgImg.source = this._initData.bgImg;
            this.updatePositions();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this._btnsWithTooltip = [this.dominationBattleBtn, this.multiteamBattleBtn];
        this.addListeners();
        this.headerTitleTF.autoSize = TextFieldAutoSize.CENTER;
        this.headerDescTF.autoSize = TextFieldAutoSize.CENTER;
        this.dominationBattleTitleTF.autoSize = TextFieldAutoSize.CENTER;
        this.dominationBattleDescTF.autoSize = TextFieldAutoSize.CENTER;
        this.multiteamTitleTF.autoSize = TextFieldAutoSize.CENTER;
        this.multiteamDescTF.autoSize = TextFieldAutoSize.CENTER;
        this.checkBoxAutoSquad.addEventListener(Event.SELECT, this.onSelectCheckBoxAutoSquadHandler);
        this.dominationBattleBtn.mouseEnabledOnDisabled = true;
        this.multiteamBattleBtn.mouseEnabledOnDisabled = true;
    }

    override protected function setInitData(param1:SelectorWindowStaticDataVO):void {
        this._initData = param1;
        this._tooltipData = param1.tooltipData;
        invalidateData();
    }

    override protected function setBtnStates(param1:SelectorWindowBtnStatesVO):void {
        this.dominationBattleBtn.enabled = param1.dominationBtnEnabled;
        this.multiteamBattleBtn.enabled = param1.multiteamBtnEnabled;
        enabledCloseBtn = param1.closeBtnEnabled;
        this.checkBoxAutoSquad.enabled = param1.autoSquadCheckboxEnabled;
    }

    override protected function onDispose():void {
        this.removeListeners();
        this._btnsWithTooltip.splice(0, this._btnsWithTooltip.length);
        this._btnsWithTooltip = null;
        this.dominationBattleBtn.dispose();
        this.multiteamBattleBtn.dispose();
        this.bgImg.dispose();
        this.headerTitleTF = null;
        this.headerDescTF = null;
        this.dominationBattleTitleTF = null;
        this.dominationBattleDescTF = null;
        this.dominationBattleBtn = null;
        this.multiteamTitleTF = null;
        this.multiteamDescTF = null;
        this.multiteamBattleBtn = null;
        this.autoSquadInfo.dispose();
        this.autoSquadInfo = null;
        this.checkBoxAutoSquad.removeEventListener(Event.SELECT, this.onSelectCheckBoxAutoSquadHandler);
        this.checkBoxAutoSquad.dispose();
        this.checkBoxAutoSquad = null;
        this.bgImg = null;
        this._initData = null;
        this._tooltipData = null;
        super.onDispose();
    }

    override protected function setTooltips(param1:FalloutBattleSelectorTooltipVO):void {
        this._tooltipData = param1;
        this.autoSquadInfo.tooltip = this._tooltipData.autoSquadStr;
        App.toolTipMgr.hide();
    }

    private function updateAutoSquadElementsPosition():void {
        this.checkBoxAutoSquad.validateNow();
        var _loc1_:int = this.checkBoxAutoSquad.textField.width;
        var _loc2_:int = this.multiteamBattleBtn.x + (this.multiteamBattleBtn.width >> 1);
        var _loc3_:int = _loc1_ + CHECK_BOX_RIGHT_PADDING + this.autoSquadInfo.width;
        this.checkBoxAutoSquad.x = _loc2_ - (_loc3_ >> 1);
        this.autoSquadInfo.x = this.checkBoxAutoSquad.x + _loc1_ + CHECK_BOX_RIGHT_PADDING;
    }

    private function addListeners():void {
        var _loc3_:SoundButtonEx = null;
        this.bgImg.addEventListener(UILoaderEvent.COMPLETE, this.onBgImgCompleteHandler);
        this.dominationBattleBtn.addEventListener(ButtonEvent.CLICK, this.onDominationBtnClickHandler);
        this.multiteamBattleBtn.addEventListener(ButtonEvent.CLICK, this.onMultiteamBtnClickHandler);
        var _loc1_:int = this._btnsWithTooltip.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this._btnsWithTooltip[_loc2_];
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOverHandler);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOutHandler);
            _loc2_++;
        }
    }

    private function removeListeners():void {
        var _loc4_:SoundButtonEx = null;
        var _loc1_:String = "Array \"btnsWithTooltip\" already disposed";
        this.bgImg.removeEventListener(UILoaderEvent.COMPLETE, this.onBgImgCompleteHandler);
        this.dominationBattleBtn.removeEventListener(ButtonEvent.CLICK, this.onDominationBtnClickHandler);
        this.multiteamBattleBtn.removeEventListener(ButtonEvent.CLICK, this.onMultiteamBtnClickHandler);
        assertNotNull(this._btnsWithTooltip, _loc1_);
        var _loc2_:int = this._btnsWithTooltip.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this._btnsWithTooltip[_loc3_];
            _loc4_.removeEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOverHandler);
            _loc4_.removeEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOutHandler);
            _loc3_++;
        }
    }

    private function updateSize():void {
        var _loc1_:Rectangle = getBounds(this);
        window.updateSize(_loc1_.width, _loc1_.height + WINDOW_PADDING_BOTTOM, true);
    }

    private function updatePositions():void {
        var _loc1_:int = Math.max(this.dominationBattleDescTF.textHeight, this.multiteamDescTF.textHeight);
        var _loc2_:int = this.dominationBattleBtn.y - BTN_TOP_PADDING - _loc1_;
        var _loc3_:int = _loc2_ - DESCRIPTION_TOP_PADDING - this.dominationBattleTitleTF.textHeight;
        this.multiteamDescTF.y = this.dominationBattleDescTF.y = _loc2_;
        this.dominationBattleTitleTF.y = this.multiteamTitleTF.y = _loc3_;
    }

    private function onSelectCheckBoxAutoSquadHandler(param1:Event):void {
        onSelectCheckBoxAutoSquadS(this.checkBoxAutoSquad.selected);
    }

    private function onBgImgCompleteHandler(param1:UILoaderEvent):void {
        this.updateSize();
    }

    private function onMultiteamBtnClickHandler(param1:ButtonEvent):void {
        onMultiteamBtnClickS();
    }

    private function onDominationBtnClickHandler(param1:ButtonEvent):void {
        onDominationBtnClickS();
    }

    private function onBtnMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onBtnMouseOverHandler(param1:MouseEvent):void {
        var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.currentTarget);
        var _loc3_:String = Values.EMPTY_STR;
        if (_loc2_ == this.dominationBattleBtn) {
            _loc3_ = this._tooltipData.dominationStr;
        }
        else if (_loc2_ == this.multiteamBattleBtn) {
            _loc3_ = this._tooltipData.multiteamStr;
        }
        App.toolTipMgr.showComplex(_loc3_);
    }
}
}

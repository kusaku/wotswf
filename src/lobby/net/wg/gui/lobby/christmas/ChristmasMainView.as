package net.wg.gui.lobby.christmas {
import flash.display.InteractiveObject;
import flash.ui.Keyboard;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.BackButton;
import net.wg.gui.components.controls.CloseButtonText;
import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.data.MainViewStaticDataVO;
import net.wg.gui.lobby.christmas.data.ProgressBarVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataClassVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataVO;
import net.wg.gui.lobby.christmas.event.ChristmasConversionEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationFilterEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationTabEvent;
import net.wg.gui.lobby.christmas.event.ChristmasDecorationsListEvent;
import net.wg.gui.lobby.christmas.event.ChristmasProgressBarEvent;
import net.wg.gui.lobby.christmas.event.ChristmasSlotsEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasMainView;
import net.wg.gui.lobby.christmas.interfaces.IChristmasProgressBar;
import net.wg.gui.lobby.components.HeaderBackground;
import net.wg.gui.lobby.components.data.InfoMessageVO;
import net.wg.infrastructure.base.meta.impl.ChristmasMainViewMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.utils.IAssertable;
import net.wg.utils.ICommons;
import net.wg.utils.IScheduler;

import scaleform.clik.constants.InputValue;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class ChristmasMainView extends ChristmasMainViewMeta implements IChristmasMainView {

    private static const VIEW_PADDING_BOTTOM:int = 4;

    private static const BTN_CLOSE_MARGIN_RIGHT:int = 15;

    private static const FOCUS_CHAIN:String = "focusChain";

    private static const HEADER_ENABLE_ALPHA:Number = 1;

    private static const HEADER_DISABLE_ALPHA:Number = 0.4;

    public var btnBack:BackButton = null;

    public var btnClose:CloseButtonText = null;

    public var customizationView:ChristmasCustomizationView;

    public var progressBar:IChristmasProgressBar = null;

    public var headerBackground:HeaderBackground = null;

    private var _staticData:MainViewStaticDataVO = null;

    private var _slotsData:SlotsDataVO;

    private var _focusChain:Vector.<InteractiveObject>;

    private var _commons:ICommons;

    private var _scheduler:IScheduler;

    private var _asserter:IAssertable;

    private var _switchCameraFrameCounter:int = 0;

    private var _headerControls:Vector.<IUIComponentEx> = null;

    public function ChristmasMainView() {
        this._focusChain = new Vector.<InteractiveObject>();
        this._commons = App.utils.commons;
        this._scheduler = App.utils.scheduler;
        this._asserter = App.utils.asserter;
        super();
        this._headerControls = new <IUIComponentEx>[this.btnBack, this.btnClose];
    }

    override public function updateStage(param1:Number, param2:Number):void {
        setViewSize(param1, param2);
    }

    override protected function configUI():void {
        super.configUI();
        this.btnBack.addEventListener(ButtonEvent.CLICK, this.onBtnBackClickHandler);
        this.btnClose.addEventListener(ButtonEvent.CLICK, this.onBtnCloseClickHandler);
        this.customizationView.addEventListener(ChristmasCustomizationFilterEvent.RANK_CHANGE, this.onCustomizationViewRankChangeHandler);
        this.customizationView.addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onCustomizationViewFocusChainChangeHandler);
        this.customizationView.addEventListener(ChristmasCustomizationFilterEvent.TYPE_CHANGE, this.onCustomizationViewTypeChangeHandler);
        this.customizationView.addEventListener(ChristmasCustomizationEvent.SHOW_CONVERSION, this.onCustomizationViewShowConversionHandler);
        this.customizationView.addEventListener(ChristmasCustomizationEvent.EMPTY_LIST_BTN_CLICK, this.onCustomizationViewEmptyListBtnClickHandler);
        this.customizationView.addEventListener(ChristmasDecorationsListEvent.INSTALL_ITEM, this.onCustomizationViewInstallItemHandler);
        this.customizationView.addEventListener(ChristmasDecorationsListEvent.HIDE_NEW_ITEM, this.onCustomizationViewHideNewItemHandler);
        this.customizationView.addEventListener(ChristmasSlotsEvent.ITEM_REMOVED, this.onCustomizationViewItemRemovedHandler);
        this.customizationView.addEventListener(ChristmasSlotsEvent.ITEM_MOVED, this.onCustomizationViewItemMovedHandler);
        this.customizationView.addEventListener(ChristmasCustomizationTabEvent.CHANGE_TAB, this.onCustomizationViewChangeTabHandler);
        this.customizationView.addEventListener(ChristmasConversionEvent.CONVERT_ITEMS, this.onCustomizationViewConvertItemsHandler);
        this.customizationView.addEventListener(ChristmasConversionEvent.CANCEL_CONVERSION, this.onCustomizationViewCancelConversionHandler);
        this.customizationView.addEventListener(ChristmasConversionEvent.ANIMATION_COMPLETE, this.onCustomizationViewAnimationCompleteHandler);
        this.progressBar.addEventListener(ChristmasProgressBarEvent.SHOW_RULES, this.onProgressBarShowRulesHandler);
        this._scheduler.scheduleOnNextFrame(this.trySwitchCamera);
        invalidate(FOCUS_CHAIN);
    }

    override protected function onDispose():void {
        this._scheduler.cancelTask(this.trySwitchCamera);
        this.progressBar.removeEventListener(ChristmasProgressBarEvent.SHOW_RULES, this.onProgressBarShowRulesHandler);
        this.btnBack.removeEventListener(ButtonEvent.CLICK, this.onBtnBackClickHandler);
        this.btnClose.removeEventListener(ButtonEvent.CLICK, this.onBtnCloseClickHandler);
        this.customizationView.removeEventListener(ChristmasCustomizationFilterEvent.RANK_CHANGE, this.onCustomizationViewRankChangeHandler);
        this.customizationView.removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onCustomizationViewFocusChainChangeHandler);
        this.customizationView.removeEventListener(ChristmasCustomizationFilterEvent.TYPE_CHANGE, this.onCustomizationViewTypeChangeHandler);
        this.customizationView.removeEventListener(ChristmasCustomizationEvent.SHOW_CONVERSION, this.onCustomizationViewShowConversionHandler);
        this.customizationView.removeEventListener(ChristmasCustomizationEvent.EMPTY_LIST_BTN_CLICK, this.onCustomizationViewEmptyListBtnClickHandler);
        this.customizationView.removeEventListener(ChristmasDecorationsListEvent.INSTALL_ITEM, this.onCustomizationViewInstallItemHandler);
        this.customizationView.removeEventListener(ChristmasDecorationsListEvent.HIDE_NEW_ITEM, this.onCustomizationViewHideNewItemHandler);
        this.customizationView.removeEventListener(ChristmasSlotsEvent.ITEM_REMOVED, this.onCustomizationViewItemRemovedHandler);
        this.customizationView.removeEventListener(ChristmasSlotsEvent.ITEM_MOVED, this.onCustomizationViewItemMovedHandler);
        this.customizationView.removeEventListener(ChristmasCustomizationTabEvent.CHANGE_TAB, this.onCustomizationViewChangeTabHandler);
        this.customizationView.removeEventListener(ChristmasConversionEvent.CONVERT_ITEMS, this.onCustomizationViewConvertItemsHandler);
        this.customizationView.removeEventListener(ChristmasConversionEvent.CANCEL_CONVERSION, this.onCustomizationViewCancelConversionHandler);
        this.customizationView.removeEventListener(ChristmasConversionEvent.ANIMATION_COMPLETE, this.onCustomizationViewAnimationCompleteHandler);
        this.btnBack.dispose();
        this.btnBack = null;
        this.customizationView.dispose();
        this.customizationView = null;
        this.progressBar.dispose();
        this.progressBar = null;
        this.headerBackground.dispose();
        this.headerBackground = null;
        this.btnClose.dispose();
        this.btnClose = null;
        this._headerControls.splice(0, this._headerControls.length);
        this._headerControls = null;
        this._staticData = null;
        this._slotsData = null;
        this.tryToClearFocusChain();
        this._commons = null;
        this._asserter = null;
        this._scheduler = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.invalidateViewSize();
        }
        if (isInvalid(FOCUS_CHAIN)) {
            this.invalidateFocusChain();
        }
    }

    override protected function setEmptyListData(param1:Boolean, param2:InfoMessageVO):void {
        this.customizationView.setEmptyListData(param1, param2);
    }

    override protected function setStaticData(param1:MainViewStaticDataVO):void {
        this._asserter.assertNull(this._staticData, "Reinitialization ChristmasMainView");
        this._staticData = param1;
        this.customizationView.setStaticData(this._staticData);
        this.btnClose.label = this._staticData.btnCloseLabel;
        this.btnClose.validateNow();
        this.btnBack.label = this._staticData.btnBackLabel;
        this.btnBack.descrLabel = this._staticData.btnBackDescription;
        this._switchCameraFrameCounter = this._staticData.switchCameraDelayFrames;
    }

    override protected function setFilters(param1:ChristmasFiltersVO, param2:ChristmasFiltersVO):void {
        this.customizationView.setFilters(param1, param2);
    }

    override protected function setProgress(param1:ProgressBarVO):void {
        this.progressBar.setData(param1);
    }

    override protected function setSlotsData(param1:SlotsDataClassVO):void {
        this._slotsData = param1.targetData;
        this.customizationView.setSlotsData(this._slotsData);
    }

    override protected function updateSlot(param1:SlotVO):void {
        this.customizationView.updateSlot(param1);
        this._asserter.assert(this._slotsData.updateSlotData(param1), "Can\'t find data for update, slotId: " + param1.slotId);
    }

    public function as_getDecorationsDP():Object {
        return this.customizationView.getDecorationsDP();
    }

    public function as_scrollToItem(param1:int):void {
        this.customizationView.scrollToItem(param1);
    }

    public function as_selectSlotsTab(param1:int):void {
        this.customizationView.selectSlotsTab(param1);
    }

    public function as_showSlotsView(param1:String):void {
        this.customizationView.showSlotsView(param1);
        this.enableHeader(this._staticData.getSlotsStaticData(param1).isHeaderEnabled);
    }

    public function as_updateConversionBtn(param1:Boolean, param2:String):void {
        this.customizationView.updateConversionBtn(param1, param2);
    }

    public function getComponentForFocus():InteractiveObject {
        return this.progressBar.getComponentForFocus();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_.push(this.btnBack);
        _loc1_ = _loc1_.concat(this.progressBar.getFocusChain());
        _loc1_ = _loc1_.concat(this.customizationView.getFocusChain());
        _loc1_.push(this.btnClose);
        return _loc1_;
    }

    private function enableHeader(param1:Boolean):void {
        var _loc3_:IUIComponentEx = null;
        var _loc2_:Number = !!param1 ? Number(HEADER_ENABLE_ALPHA) : Number(HEADER_DISABLE_ALPHA);
        for each(_loc3_ in this._headerControls) {
            _loc3_.enabled = param1;
            _loc3_.alpha = _loc2_;
        }
    }

    private function invalidateViewSize():void {
        this.headerBackground.width = width;
        this.customizationView.x = width - this.customizationView.width | 0;
        this.customizationView.y = this.headerBackground.y + this.headerBackground.height | 0;
        this.customizationView.height = height - this.customizationView.y + VIEW_PADDING_BOTTOM;
        this.btnClose.x = width - this.btnClose.width - BTN_CLOSE_MARGIN_RIGHT | 0;
        this.progressBar.x = width >> 1;
    }

    private function invalidateFocusChain():void {
        var _loc1_:int = this._focusChain.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._focusChain[_loc2_].tabIndex = Values.DEFAULT_INT;
            _loc2_++;
        }
        this.tryToClearFocusChain();
        this._focusChain = this.getFocusChain();
        this._commons.initTabIndex(this._focusChain);
        setFocus(this.getComponentForFocus());
    }

    private function tryToClearFocusChain():void {
        if (this._focusChain != null) {
            this._focusChain.splice(0, this._focusChain.length);
            this._focusChain = null;
        }
    }

    private function trySwitchCamera():void {
        this._switchCameraFrameCounter--;
        if (this._switchCameraFrameCounter == 0) {
            this._scheduler.cancelTask(this.trySwitchCamera);
            switchCameraS();
        }
        else {
            this._scheduler.scheduleOnNextFrame(this.trySwitchCamera);
        }
    }

    override public function handleInput(param1:InputEvent):void {
        var _loc2_:InputDetails = null;
        this.customizationView.handleInput(param1);
        if (!param1.handled) {
            _loc2_ = param1.details;
            if (_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN) {
                param1.handled = true;
                closeWindowS();
            }
        }
    }

    private function onCustomizationViewFocusChainChangeHandler(param1:FocusChainChangeEvent):void {
        invalidate(FOCUS_CHAIN);
    }

    private function onProgressBarShowRulesHandler(param1:ChristmasProgressBarEvent):void {
        showRulesS();
    }

    private function onCustomizationViewItemRemovedHandler(param1:ChristmasSlotsEvent):void {
        uninstallItemS(param1.targetSlotId);
    }

    private function onCustomizationViewItemMovedHandler(param1:ChristmasSlotsEvent):void {
        moveItemS(param1.sourceSlotId, param1.targetSlotId);
    }

    private function onBtnBackClickHandler(param1:ButtonEvent):void {
        closeWindowS();
    }

    private function onBtnCloseClickHandler(param1:ButtonEvent):void {
        closeWindowS();
    }

    private function onCustomizationViewRankChangeHandler(param1:ChristmasCustomizationFilterEvent):void {
        applyRankFilterS(param1.index);
    }

    private function onCustomizationViewTypeChangeHandler(param1:ChristmasCustomizationFilterEvent):void {
        applyTypeFilterS(param1.index);
    }

    private function onCustomizationViewShowConversionHandler(param1:ChristmasCustomizationEvent):void {
        showConversionS();
    }

    private function onCustomizationViewEmptyListBtnClickHandler(param1:ChristmasCustomizationEvent):void {
        onEmptyListBtnClickS();
    }

    private function onCustomizationViewInstallItemHandler(param1:ChristmasDecorationsListEvent):void {
        installItemS(param1.id, param1.slotId);
    }

    private function onCustomizationViewHideNewItemHandler(param1:ChristmasDecorationsListEvent):void {
        switchOffNewItemS(param1.id);
    }

    private function onCustomizationViewChangeTabHandler(param1:ChristmasCustomizationTabEvent):void {
        onChangeTabS(param1.id);
    }

    private function onCustomizationViewConvertItemsHandler(param1:ChristmasConversionEvent):void {
        convertItemsS();
    }

    private function onCustomizationViewCancelConversionHandler(param1:ChristmasConversionEvent):void {
        cancelConversionS();
    }

    private function onCustomizationViewAnimationCompleteHandler(param1:ChristmasConversionEvent):void {
        onConversionAnimationCompleteS();
    }
}
}

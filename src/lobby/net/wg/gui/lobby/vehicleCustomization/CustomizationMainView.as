package net.wg.gui.lobby.vehicleCustomization {
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.geom.Point;

import net.wg.gui.events.LobbyEvent;
import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselDataVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationTotalBonusPanelVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSlotEvent;
import net.wg.gui.notification.events.NotificationLayoutEvent;
import net.wg.infrastructure.base.meta.ICustomizationMainViewMeta;
import net.wg.infrastructure.base.meta.impl.CustomizationMainViewMeta;

import scaleform.clik.constants.InvalidationType;

public class CustomizationMainView extends CustomizationMainViewMeta implements ICustomizationMainViewMeta {

    private static const OFFSET:Number = 7;

    private static const HEADER_GAP:Number = -50;

    private static const BOTTOM_OFFSET:Number = 38;

    private static const BONUS_PANEL_GAP:Number = 20;

    private static const SM_PADDING_X:Number = 4;

    private static const SM_PADDING_Y:Number = -21;

    private static const INV_FOCUS_CHAIN:String = "InvFocusChain";

    private static const INV_SYSTEM_MESSAGE:String = "InvSystemMessage";

    public var customizationHeader:CustomizationHeader = null;

    public var crewBonusPanel:CustomizationBonusPanel = null;

    public var visibilityBonusPanel:CustomizationBonusPanel = null;

    public var bottomPanel:BottomPanel = null;

    private var _actualWidth:int = 0;

    private var _actualHeight:int = 0;

    private var _focusChain:Vector.<InteractiveObject>;

    private var _systemMessages:DisplayObjectContainer;

    private var _smPadding:Number = 0;

    public function CustomizationMainView() {
        this._focusChain = new Vector.<InteractiveObject>();
        super();
        this._systemMessages = App.systemMessages;
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this._actualWidth = param1;
        this._actualHeight = param2;
        invalidateSize();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.customizationHeader.updateSize(this._actualWidth);
            this.bottomPanel.y = this._actualHeight - this.bottomPanel.height + BOTTOM_OFFSET;
            this.bottomPanel.width = this._actualWidth;
            this.crewBonusPanel.x = OFFSET;
            this.visibilityBonusPanel.x = OFFSET;
            _loc1_ = this.customizationHeader.y + this.customizationHeader.height;
            _loc2_ = this.bottomPanel.y - _loc1_;
            this.crewBonusPanel.y = (_loc2_ - this.crewBonusPanel.height - this.visibilityBonusPanel.height >> 1) + _loc1_ + HEADER_GAP - BONUS_PANEL_GAP;
            this.visibilityBonusPanel.y = this.crewBonusPanel.y + this.crewBonusPanel.height;
        }
        if (isInvalid(INV_FOCUS_CHAIN)) {
            this.refreshFocusChain();
        }
        if (isInvalid(INV_SYSTEM_MESSAGE)) {
            this._systemMessages.dispatchEvent(new NotificationLayoutEvent(NotificationLayoutEvent.UPDATE_LAYOUT, new Point(SM_PADDING_X, this._smPadding + SM_PADDING_Y)));
        }
    }

    override protected function configUI():void {
        super.configUI();
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
        addEventListener(CustomizationEvent.CLOSE_VIEW, this.onCloseViewHandler);
        addEventListener(CustomizationEvent.SHOW_BUY_WINDOW, this.onShowBuyWindowHandler);
        addEventListener(CustomizationEvent.FILTER_DURATION_TYPE, this.onFilterDurationTypeHandler);
        addEventListener(CustomizationEvent.FILTER_PURCHASED, this.onFilterPurchasedHandler);
        addEventListener(CustomizationEvent.BACK_TO_GROUP_SELECTOR, this.onBackToGroupSelectorHandler);
        addEventListener(CustomizationItemEvent.INSTALL_ITEM, this.onInstallItemHandler);
        addEventListener(CustomizationItemEvent.GO_TO_TASK, this.onGoToTaskHandler);
        addEventListener(CustomizationSlotEvent.SELECT_SLOT, this.onSelectSlotHandler);
        addEventListener(CustomizationSlotEvent.REMOVE_SLOT, this.onRemoveSlotHandler);
        addEventListener(CustomizationSlotEvent.REVERT_SLOT, this.onRevertSlotHandler);
        this._smPadding = this.bottomPanel.background.height;
        invalidate(INV_SYSTEM_MESSAGE);
    }

    override protected function onDispose():void {
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
        removeEventListener(CustomizationEvent.CLOSE_VIEW, this.onCloseViewHandler);
        removeEventListener(CustomizationEvent.SHOW_BUY_WINDOW, this.onShowBuyWindowHandler);
        removeEventListener(CustomizationEvent.FILTER_DURATION_TYPE, this.onFilterDurationTypeHandler);
        removeEventListener(CustomizationEvent.FILTER_PURCHASED, this.onFilterPurchasedHandler);
        removeEventListener(CustomizationEvent.BACK_TO_GROUP_SELECTOR, this.onBackToGroupSelectorHandler);
        removeEventListener(CustomizationItemEvent.INSTALL_ITEM, this.onInstallItemHandler);
        removeEventListener(CustomizationItemEvent.GO_TO_TASK, this.onGoToTaskHandler);
        removeEventListener(CustomizationSlotEvent.SELECT_SLOT, this.onSelectSlotHandler);
        removeEventListener(CustomizationSlotEvent.REMOVE_SLOT, this.onRemoveSlotHandler);
        removeEventListener(CustomizationSlotEvent.REVERT_SLOT, this.onRevertSlotHandler);
        this.customizationHeader.dispose();
        this.customizationHeader = null;
        this.crewBonusPanel.dispose();
        this.crewBonusPanel = null;
        this.visibilityBonusPanel.dispose();
        this.visibilityBonusPanel = null;
        this.bottomPanel.dispose();
        this.bottomPanel = null;
        this._focusChain.splice(0, this._focusChain.length);
        this._focusChain = null;
        this._systemMessages = null;
        super.onDispose();
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        if (param1 == null) {
            param1 = this;
        }
        super.onSetModalFocus(param1);
    }

    override protected function setHeaderData(param1:CustomizationHeaderVO):void {
        this.customizationHeader.setData(param1);
    }

    override protected function setSlotsPanelData(param1:CustomizationSlotsPanelVO):void {
        this.bottomPanel.setSlotsPanelData(param1);
    }

    override protected function setBonusPanelData(param1:CustomizationTotalBonusPanelVO):void {
        this.crewBonusPanel.setData(param1.crewBonusPanelVO);
        this.visibilityBonusPanel.setData(param1.visibilityBonusPanel);
    }

    override protected function setCarouselData(param1:CarouselDataVO):void {
        this.bottomPanel.setCarouselData(param1);
    }

    override protected function setCarouselInit(param1:CarouselInitVO):void {
        this.bottomPanel.setCarouselInit(param1);
    }

    override protected function updateSlot(param1:CustomizationSlotUpdateVO):void {
        this.bottomPanel.updateSlot(param1);
    }

    override protected function setBottomPanelInitData(param1:CustomizationBottomPanelInitVO):void {
        this.bottomPanel.setInitData(param1);
    }

    override protected function setBottomPanelHeader(param1:BottomPanelVO):void {
        this.bottomPanel.setPanelData(param1);
    }

    public function as_hideBuyingPanel():void {
        invalidate(INV_FOCUS_CHAIN, INV_SYSTEM_MESSAGE);
        this.bottomPanel.hidePrice();
        this._smPadding = this.bottomPanel.background.height;
    }

    public function as_showBuyingPanel():void {
        invalidate(INV_FOCUS_CHAIN, INV_SYSTEM_MESSAGE);
        this.bottomPanel.showPrice();
        this._smPadding = this.bottomPanel.background.height + this.bottomPanel.pricePanel.height;
    }

    public function as_showSelectorGroup():void {
        this.bottomPanel.showSelectorGroup();
        invalidate(INV_FOCUS_CHAIN);
    }

    public function as_showSelectorItem(param1:int):void {
        this.bottomPanel.showSelectorItem(param1);
        invalidate(INV_FOCUS_CHAIN);
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_ = _loc1_.concat(this.bottomPanel.getFocusChain());
        if (this.bottomPanel.buyBtn.enabled) {
            _loc1_.push(this.bottomPanel.buyBtn);
        }
        _loc1_.push(this.customizationHeader.closeBtn);
        return _loc1_;
    }

    private function refreshFocusChain():void {
        var _loc1_:InteractiveObject = null;
        for each(_loc1_ in this._focusChain) {
            _loc1_.tabIndex = -1;
        }
        this._focusChain.splice(0, this._focusChain.length);
        this._focusChain = this.getFocusChain();
        App.utils.commons.initTabIndex(this._focusChain);
        if (this._focusChain.length > 0) {
            setFocus(this._focusChain[0]);
        }
    }

    private function onCloseViewHandler(param1:CustomizationEvent):void {
        closeWindowS();
    }

    private function onShowBuyWindowHandler(param1:CustomizationEvent):void {
        showBuyWindowS();
    }

    private function onFilterDurationTypeHandler(param1:CustomizationEvent):void {
        setDurationTypeS(param1.index);
    }

    private function onFilterPurchasedHandler(param1:CustomizationEvent):void {
        showPurchasedS(param1.select);
    }

    private function onInstallItemHandler(param1:CustomizationItemEvent):void {
        installCustomizationElementS(param1.itemId);
    }

    private function onGoToTaskHandler(param1:CustomizationItemEvent):void {
        goToTaskS(param1.itemId);
    }

    private function onSelectSlotHandler(param1:CustomizationSlotEvent):void {
        showGroupS(param1.groupId, param1.slotId);
    }

    private function onRemoveSlotHandler(param1:CustomizationSlotEvent):void {
        removeSlotS(param1.groupId, param1.slotId);
    }

    private function onRevertSlotHandler(param1:CustomizationSlotEvent):void {
        revertSlotS(param1.groupId, param1.slotId);
    }

    private function onBackToGroupSelectorHandler(param1:CustomizationEvent):void {
        backToSelectorGroupS();
    }
}
}

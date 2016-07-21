package net.wg.gui.lobby.vehicleCustomization {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.ui.Keyboard;

import net.wg.gui.components.advanced.BackButton;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselDataVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsPanelVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.utils.IGameInputManager;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;

public class BottomPanel extends UIComponentEx implements IFocusChainContainer {

    private static const SLOTS_POSITION_ONLYSLOTS:int = 95;

    private static const SLOTS_POSITION_BUYMODE:int = -1;

    private static const BUY_OFFSET_VERTICAL:int = 24;

    private static const BUY_OFFSET_HORIZONTAL:int = 15;

    private static const PRICE_OFFSET_VERTICAL:int = 39;

    private static const PRICE_OFFSET_HORIZONTAL:int = 5;

    private static const SLOTS_HEADER_GAP:int = 20;

    public var slotsPanel:CustomizationSlotsPanelView = null;

    public var carousel:CustomizationCarousel = null;

    public var headerText:TextField = null;

    public var btnBack:BackButton = null;

    public var buyBtn:SoundButtonEx = null;

    public var background:Sprite = null;

    public var buyBackground:Sprite = null;

    public var pricePanel:CustomizationBuyingPanel = null;

    private var _stateOnlySlots:Boolean = true;

    private var _gameInputMgr:IGameInputManager = null;

    public function BottomPanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._gameInputMgr = App.gameInputMgr;
        this.headerText.autoSize = TextFieldAutoSize.CENTER;
        this.buyBtn.enabled = false;
        this.pricePanel.visible = false;
        this.buyBackground.visible = false;
        this.btnBack.addEventListener(ButtonEvent.CLICK, this.onBtnBackHandler);
        this.buyBtn.addEventListener(ButtonEvent.CLICK, this.onBuyBtnClickHandler);
        this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.onHandleEscapeHandler, true);
    }

    override protected function onDispose():void {
        this.btnBack.removeEventListener(ButtonEvent.CLICK, this.onBtnBackHandler);
        this.buyBtn.removeEventListener(ButtonEvent.CLICK, this.onBuyBtnClickHandler);
        this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this._gameInputMgr = null;
        this.background = null;
        this.headerText = null;
        this.buyBackground = null;
        this.carousel.dispose();
        this.carousel = null;
        this.slotsPanel.dispose();
        this.slotsPanel = null;
        this.btnBack.dispose();
        this.btnBack = null;
        this.buyBtn.dispose();
        this.buyBtn = null;
        this.pricePanel.dispose();
        this.pricePanel = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.background.width = width;
            this.carousel.width = width;
            this.buyBtn.x = width - this.buyBtn.width - BUY_OFFSET_VERTICAL;
            this.buyBackground.x = this.buyBtn.x - BUY_OFFSET_HORIZONTAL;
            this.slotsPanel.x = width - this.slotsPanel.mainPanel.width >> 1;
            if (this._stateOnlySlots) {
                this.slotsPanel.y = SLOTS_POSITION_ONLYSLOTS;
                this.headerText.x = width - this.headerText.width >> 1;
                this.carousel.visible = false;
                this.btnBack.visible = false;
            }
            else {
                this.slotsPanel.y = SLOTS_POSITION_BUYMODE;
                this.headerText.x = this.slotsPanel.x - this.headerText.width - SLOTS_HEADER_GAP;
                this.carousel.visible = true;
                this.btnBack.visible = true;
            }
            this.pricePanel.x = width - this.pricePanel.width - PRICE_OFFSET_HORIZONTAL;
            this.pricePanel.y = PRICE_OFFSET_VERTICAL - this.pricePanel.height;
        }
    }

    public function showPrice():void {
        this.pricePanel.visible = true;
        this.buyBackground.visible = true;
        this.buyBtn.enabled = true;
    }

    public function hidePrice():void {
        this.pricePanel.visible = false;
        this.buyBackground.visible = false;
        this.buyBtn.enabled = false;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_ = _loc1_.concat(this.slotsPanel.getFocusChain());
        _loc1_ = _loc1_.concat(this.carousel.getFocusChain());
        if (this.buyBtn.enabled) {
            _loc1_.push(this.buyBtn);
        }
        _loc1_.push(this.btnBack);
        return _loc1_;
    }

    public function setCarouselData(param1:CarouselDataVO):void {
        this.carousel.setData(param1);
    }

    public function setCarouselInit(param1:CarouselInitVO):void {
        this.carousel.setInitData(param1);
    }

    public function setPanelData(param1:BottomPanelVO):void {
        this.headerText.htmlText = param1.newHeaderText;
        this.buyBtn.label = param1.buyBtnLabel;
        this.pricePanel.setData(param1.pricePanel);
        invalidateSize();
    }

    public function setInitData(param1:CustomizationBottomPanelInitVO):void {
        this.btnBack.label = param1.backBtnLabel;
        this.btnBack.descrLabel = param1.backBtnDescription;
        this.pricePanel.setInitData(param1.pricePanelVO);
    }

    public function setSlotsPanelData(param1:CustomizationSlotsPanelVO):void {
        this.slotsPanel.mainPanel.setData(new DataProvider(App.utils.data.vectorToArray(param1.groups)));
        this.slotsPanel.width = this.slotsPanel.mainPanel.width;
        this.slotsPanel.height = this.slotsPanel.mainPanel.height;
    }

    public function showSelectorGroup():void {
        this._stateOnlySlots = true;
        this.slotsPanel.mainPanel.showAllGroups();
        this.slotsPanel.mainPanel.diselectAll();
        invalidateSize();
    }

    public function showSelectorItem(param1:int):void {
        this._stateOnlySlots = false;
        this.slotsPanel.mainPanel.showOneGroup(param1);
        invalidateSize();
    }

    public function updateSlot(param1:CustomizationSlotUpdateVO):void {
        this.slotsPanel.mainPanel.updateSlot(param1.type, param1);
    }

    private function onBuyBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_BUY_WINDOW));
    }

    private function onBtnBackHandler(param1:ButtonEvent):void {
        dispatchEvent(new CustomizationEvent(CustomizationEvent.BACK_TO_GROUP_SELECTOR));
    }

    private function onHandleEscapeHandler(param1:InputEvent):void {
        App.popoverMgr.hide();
        if (this._stateOnlySlots) {
            dispatchEvent(new CustomizationEvent(CustomizationEvent.CLOSE_VIEW));
        }
        else {
            dispatchEvent(new CustomizationEvent(CustomizationEvent.BACK_TO_GROUP_SELECTOR));
        }
    }
}
}

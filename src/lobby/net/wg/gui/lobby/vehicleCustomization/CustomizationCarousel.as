package net.wg.gui.lobby.vehicleCustomization {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.Aliases;
import net.wg.gui.components.carousels.ScrollCarousel;
import net.wg.gui.components.controls.ButtonIconLoader;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.lobby.vehicleCustomization.controls.CheckBoxIcon;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselDataVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselInitVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IPopOverCaller;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class CustomizationCarousel extends ScrollCarousel implements IPopOverCaller, IFocusChainContainer {

    private static const FILTER_WIDTH:Number = 210;

    private static const RIGHT_BORDER:Number = 20;

    private static const RENDERER_GLOW_SIZE:Number = 10;

    public var btnFilter:ButtonIconLoader = null;

    public var listDurationType:ScrollingListEx = null;

    public var chbPurchased:CheckBoxIcon = null;

    public var lblFilterCounter:TextField = null;

    public var lblMessage:TextField = null;

    public var countBack:MovieClip = null;

    public var scrollBar:ScrollBar = null;

    public function CustomizationCarousel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        scrollList.hasHorizontalElasticEdges = true;
        scrollList.snapScrollPositionToItemRendererSize = false;
        scrollList.snapToPages = true;
        scrollList.cropContent = true;
        this.countBack.mouseEnabled = false;
        this.btnFilter.addEventListener(ButtonEvent.CLICK, this.onBtnFilterClickHandler);
        this.chbPurchased.addEventListener(ButtonEvent.CLICK, this.onChbPurchasedClickHandler);
        this.listDurationType.addEventListener(ListEvent.INDEX_CHANGE, this.onListDurationTypeIndexChangeHandler);
        this.lblMessage.autoSize = TextFieldAutoSize.LEFT;
        scrollList.setScrollbar(this.scrollBar);
    }

    override protected function onDispose():void {
        this.btnFilter.removeEventListener(ButtonEvent.CLICK, this.onBtnFilterClickHandler);
        this.chbPurchased.removeEventListener(ButtonEvent.CLICK, this.onChbPurchasedClickHandler);
        this.listDurationType.removeEventListener(ListEvent.INDEX_CHANGE, this.onListDurationTypeIndexChangeHandler);
        this.scrollBar.dispose();
        this.scrollBar = null;
        this.btnFilter.dispose();
        this.btnFilter = null;
        this.chbPurchased.dispose();
        this.chbPurchased = null;
        this.listDurationType.dispose();
        this.listDurationType = null;
        this.lblFilterCounter = null;
        this.lblMessage = null;
        this.countBack = null;
        super.onDispose();
    }

    override protected function updateLayout(param1:Number, param2:Number = 0):void {
        var _loc3_:Number = param1 - FILTER_WIDTH - RIGHT_BORDER;
        var _loc4_:Number = param2 + FILTER_WIDTH;
        this.lblMessage.x = (_loc3_ - this.lblMessage.textWidth >> 1) + _loc4_;
        super.updateLayout(_loc3_, _loc4_);
        this.scrollBar.width = scrollList.width - (RENDERER_GLOW_SIZE << 1);
        this.scrollBar.x = scrollList.x + RENDERER_GLOW_SIZE;
    }

    override protected function scrollListResizeComplete():void {
        super.scrollListResizeComplete();
        invalidateSize();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        if (visible) {
            _loc1_.push(this.btnFilter);
            _loc1_.push(this.chbPurchased);
            _loc1_.push(this.listDurationType);
            _loc1_.push(scrollList);
            _loc1_.push(rightArrow);
            _loc1_.push(leftArrow);
        }
        return _loc1_;
    }

    public function getHitArea():DisplayObject {
        return this.btnFilter;
    }

    public function getTargetButton():DisplayObject {
        return this.btnFilter;
    }

    public function setData(param1:CarouselDataVO):void {
        if (rendererWidth != param1.rendererWidth) {
            rendererWidth = param1.rendererWidth;
        }
        dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.renderersList));
        selectedIndex = param1.selectedIndex;
        goToItem(param1.goToIndex);
        this.lblFilterCounter.htmlText = param1.filterCounter;
        this.lblMessage.visible = param1.messageVisible;
        scrollList.visible = !param1.messageVisible;
        this.setCounterVisible(param1.counterVisible);
    }

    public function setInitData(param1:CarouselInitVO):void {
        this.btnFilter.iconSource = param1.icoFilter;
        this.chbPurchased.iconSource = param1.icoPurchased;
        this.chbPurchased.selected = param1.onlyPurchased;
        this.listDurationType.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.durationType));
        this.listDurationType.selectedIndex = param1.durationSelectIndex;
        this.lblMessage.htmlText = param1.message;
        this.btnFilter.tooltip = param1.fitterTooltip;
        this.chbPurchased.toolTip = param1.chbPurchasedTooltip;
    }

    private function setCounterVisible(param1:Boolean):void {
        this.countBack.visible = param1;
        this.lblFilterCounter.visible = param1;
    }

    private function onBtnFilterClickHandler(param1:ButtonEvent):void {
        App.popoverMgr.show(this, Aliases.CUSTOMIZATION_FILTER_POPOVER);
    }

    private function onChbPurchasedClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CustomizationEvent(CustomizationEvent.FILTER_PURCHASED, this.chbPurchased.selected));
    }

    private function onListDurationTypeIndexChangeHandler(param1:ListEvent):void {
        dispatchEvent(new CustomizationEvent(CustomizationEvent.FILTER_DURATION_TYPE, true, param1.index));
    }
}
}

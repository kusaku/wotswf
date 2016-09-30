package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.MovieClip;
import flash.events.Event;

import net.wg.data.FilterDAAPIDataProvider;
import net.wg.data.constants.Directions;
import net.wg.gui.components.controls.events.RendererEvent;
import net.wg.gui.components.controls.scroller.data.ScrollConfig;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterSelectedVO;
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.event.TankFiltersEvents;
import net.wg.gui.lobby.hangar.tcarousel.event.TankItemEvent;
import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import net.wg.infrastructure.base.meta.impl.TankCarouselMeta;
import net.wg.utils.helpLayout.HelpLayoutVO;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class TankCarousel extends TankCarouselMeta implements ITankCarousel {

    private static const HELP_ID_SEPARATOR:String = "_";

    private static const FILTERS_WIDTH:Number = 58;

    private static const ELASTICITY:Number = 0.25;

    private static const MASK_OFFSET:int = -10;

    private static const THROW_ACCELERATION_RATE:int = 4;

    private static const OFFSET_FILTERS:int = 20;

    private static const OFFSET_ARROW:int = 14;

    private static const THRESHOLD:int = 809;

    private static const GO_TO_OFFSET:Number = 0.5;

    private static const INV_ROW_COUNT:String = "invRowCount";

    public var vehicleFilters:TankCarouselFilters = null;

    public var background:MovieClip = null;

    public var rightFadeEndItem:MovieClip = null;

    public var leftFadeEndItem:MovieClip = null;

    public var filterCounter:TankFilterCounter = null;

    private var _dataProvider:FilterDAAPIDataProvider = null;

    private var _isDAAPIInited:Boolean = false;

    private var _carouselHelpLayoutId:String = null;

    private var _filtersHelpLayoutId:String = null;

    private var _stageHeight:Number = 0;

    private var _rowCount:int = 1;

    private var _helper:ITankCarouselHelper = null;

    public function TankCarousel() {
        super();
    }

    override protected function updateLayout(param1:Number, param2:Number = 0):void {
        var _loc3_:Number = param2 + FILTERS_WIDTH + OFFSET_FILTERS + OFFSET_ARROW;
        var _loc4_:Number = param1 - _loc3_ - OFFSET_ARROW;
        this.background.width = param1;
        super.updateLayout(_loc4_, _loc3_);
        this.rightFadeEndItem.x = rightArrow.x - rightArrow.width - this.rightFadeEndItem.width;
    }

    override protected function configUI():void {
        super.configUI();
        this.rightFadeEndItem.mouseEnabled = false;
        this.leftFadeEndItem.mouseEnabled = false;
        roundCountRenderer = false;
        var _loc1_:ScrollConfig = new ScrollConfig();
        _loc1_.elasticity = ELASTICITY;
        _loc1_.throwAccelerationRate = THROW_ACCELERATION_RATE;
        scrollList.scrollConfig = _loc1_;
        scrollList.useTimer = true;
        scrollList.hasHorizontalElasticEdges = true;
        scrollList.snapScrollPositionToItemRendererSize = false;
        scrollList.snapToPages = true;
        scrollList.cropContent = true;
        scrollList.maskOffsetLeft = scrollList.maskOffsetRight = MASK_OFFSET;
        scrollList.goToOffset = GO_TO_OFFSET;
        this._helper = new TankCarouselHelper();
        this.updateScrollListSettings();
        leftArrow.mouseEnabledOnDisabled = rightArrow.mouseEnabledOnDisabled = true;
        addEventListener(TankItemEvent.SELECT_ITEM, this.onSelectItemHandler);
        addEventListener(TankItemEvent.SELECT_BUY_SLOT, this.onSelectBuySlotHandler);
        addEventListener(TankItemEvent.SELECT_BUY_TANK, this.onSelectBuyTankHandler);
        this.vehicleFilters.addEventListener(RendererEvent.ITEM_CLICK, this.onVehicleFiltersItemClickHandler);
        this.vehicleFilters.addEventListener(Event.RESIZE, this.onVehicleFiltersResizeHandler);
        this.filterCounter.addEventListener(TankFiltersEvents.FILTER_RESET, this.onVehicleFiltrsFilterResetHandler);
        this.background.mouseEnabled = false;
        this.background.mouseChildren = false;
        mouseEnabled = false;
        App.utils.helpLayout.registerComponent(this);
    }

    override protected function draw():void {
        var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
        if (_loc1_) {
            this._helper = this.getNewHelper();
        }
        if (isInvalid(INV_ROW_COUNT)) {
            scrollList.rowCount = this._rowCount;
            this.goToSelectedItem();
            invalidate(InvalidationType.SETTINGS);
        }
        if (isInvalid(InvalidationType.SETTINGS)) {
            this.updateScrollListSettings();
        }
        super.draw();
        if (_loc1_) {
            dispatchEvent(new Event(Event.RESIZE));
        }
    }

    override protected function onDispose():void {
        removeEventListener(TankItemEvent.SELECT_ITEM, this.onSelectItemHandler);
        removeEventListener(TankItemEvent.SELECT_BUY_SLOT, this.onSelectBuySlotHandler);
        removeEventListener(TankItemEvent.SELECT_BUY_TANK, this.onSelectBuyTankHandler);
        this.filterCounter.removeEventListener(TankFiltersEvents.FILTER_RESET, this.onVehicleFiltrsFilterResetHandler);
        App.contextMenuMgr.hide();
        this.vehicleFilters.removeEventListener(Event.RESIZE, this.onVehicleFiltersResizeHandler);
        this.vehicleFilters.removeEventListener(RendererEvent.ITEM_CLICK, this.onVehicleFiltersItemClickHandler);
        this.vehicleFilters.dispose();
        this.vehicleFilters = null;
        this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        this._dataProvider = null;
        this.filterCounter.dispose();
        this.filterCounter = null;
        this.background = null;
        this.rightFadeEndItem = null;
        this.leftFadeEndItem = null;
        this._helper = null;
        super.onDispose();
    }

    override protected function initCarouselFilter(param1:TankCarouselFilterInitVO):void {
        this.filterCounter.setCloseButtonTooltip(param1.counterCloseTooltip);
        this.vehicleFilters.initData(param1);
    }

    override protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO):void {
        this.vehicleFilters.setSelectedData(param1);
    }

    public function as_blinkCounter():void {
        this.filterCounter.blink();
    }

    public function as_dispose():void {
        dispose();
    }

    public function as_getDataProvider():Object {
        if (scrollList.dataProvider == null) {
            this._dataProvider = new FilterDAAPIDataProvider(this.getRendererVo());
            scrollList.dataProvider = this._dataProvider;
            this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        }
        return this._dataProvider;
    }

    public function as_hideCounter():void {
        this.filterCounter.hide();
    }

    public function as_populate():void {
        this._isDAAPIInited = true;
    }

    public function as_rowCount(param1:int):void {
        if (this._rowCount != param1) {
            this._rowCount = param1;
            invalidate(InvalidationType.SIZE, INV_ROW_COUNT);
        }
    }

    public function as_showCounter(param1:String, param2:Boolean):void {
        this.filterCounter.setCount(param1, param2);
    }

    public function getBottom():Number {
        return this.background.height + this.background.y;
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
        if (StringUtils.isEmpty(this._carouselHelpLayoutId)) {
            this._carouselHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
        }
        var _loc2_:HelpLayoutVO = new HelpLayoutVO();
        _loc2_.x = leftArrow.x;
        _loc2_.y = scrollList.y;
        _loc2_.width = rightArrow.x - leftArrow.x;
        _loc2_.height = scrollList.height;
        _loc2_.extensibilityDirection = Directions.RIGHT;
        _loc2_.message = LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL;
        _loc2_.id = name + HELP_ID_SEPARATOR + Math.random();
        _loc2_.scope = this;
        _loc1_.push(_loc2_);
        if (StringUtils.isEmpty(this._filtersHelpLayoutId)) {
            this._filtersHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
        }
        var _loc3_:HelpLayoutVO = new HelpLayoutVO();
        _loc3_.x = this.vehicleFilters.x;
        _loc3_.y = this.vehicleFilters.y;
        _loc3_.width = this.vehicleFilters.width;
        _loc3_.height = this.vehicleFilters.height;
        _loc3_.extensibilityDirection = Directions.RIGHT;
        _loc3_.message = LOBBY_HELP.HANGAR_VEHFILTERS;
        _loc3_.id = this._filtersHelpLayoutId;
        _loc3_.scope = this;
        _loc1_.push(_loc3_);
        return _loc1_;
    }

    public function updateStage(param1:Number, param2:Number):void {
        width = param1;
        this._stageHeight = param2;
        invalidate(InvalidationType.SIZE);
    }

    protected function getNewHelper():ITankCarouselHelper {
        var _loc1_:ITankCarouselHelper = this._helper;
        if (this._rowCount > 1 && this._stageHeight < THRESHOLD) {
            if (!(_loc1_ is SmallTankCarouselHelper)) {
                _loc1_ = new SmallTankCarouselHelper();
                invalidate(InvalidationType.SETTINGS);
            }
        }
        else if (!(_loc1_ is TankCarouselHelper)) {
            _loc1_ = new TankCarouselHelper();
            invalidate(InvalidationType.SETTINGS);
        }
        return _loc1_;
    }

    protected function getRendererVo():Class {
        return VehicleCarouselVO;
    }

    protected function updateSelectedIndex():void {
        selectedIndex = this._dataProvider.getDAAPIselectedIdx();
    }

    private function updateScrollListSettings():void {
        scrollList.itemRendererClassReference = this._helper.linkRenderer;
        gap = this._helper.gap;
        rendererWidth = this._helper.rendererWidth;
        pageWidth = this._helper.rendererWidth + this._helper.gap;
        scrollList.height = (this._helper.gap + this._helper.rendererHeight) * this._rowCount - this._helper.gap;
        scrollList.y = this._helper.padding.top;
        this.background.height = -this.background.y + scrollList.height + scrollList.y + this._helper.padding.bottom;
        this.leftFadeEndItem.height = this.rightFadeEndItem.height = leftArrow.height = rightArrow.height = scrollList.height;
        this.leftFadeEndItem.y = this.rightFadeEndItem.y = scrollList.y;
        leftArrow.y = scrollList.y;
        rightArrow.y = scrollList.y + rightArrow.height;
        this.vehicleFilters.height = scrollList.height;
    }

    private function goToSelectedItem():void {
        if (selectedIndex < 0) {
            goToItem(0);
        }
        else {
            goToItem(selectedIndex, true);
        }
    }

    public function get isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    public function get disposed():Boolean {
        return false;
    }

    public function get helper():ITankCarouselHelper {
        return this._helper;
    }

    private function onSelectBuyTankHandler(param1:TankItemEvent):void {
        buyTankS();
    }

    private function onSelectBuySlotHandler(param1:TankItemEvent):void {
        buySlotS();
    }

    private function onVehicleFiltrsFilterResetHandler(param1:Event):void {
        resetFiltersS();
    }

    private function onSelectItemHandler(param1:TankItemEvent):void {
        selectVehicleS(param1.itemId);
    }

    private function onVehicleFiltersItemClickHandler(param1:RendererEvent):void {
        setFilterS(param1.index);
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        this.updateSelectedIndex();
        this.goToSelectedItem();
    }

    private function onVehicleFiltersResizeHandler(param1:Event):void {
        this.vehicleFilters.y = scrollList.y + (scrollList.height - this.vehicleFilters.height >> 1);
        updateHotFiltersS();
    }
}
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;

import scaleform.clik.utils.Padding;

class TankCarouselHelper implements ITankCarouselHelper {

    private static const PADDING:Padding = new Padding(10);

    function TankCarouselHelper() {
        super();
    }

    public function get linkRenderer():String {
        return "TankCarouselItemRendererUI";
    }

    public function get rendererWidth():Number {
        return 162;
    }

    public function get rendererHeight():Number {
        return 102;
    }

    public function get gap():Number {
        return 10;
    }

    public function get padding():Padding {
        return PADDING;
    }
}

class SmallTankCarouselHelper implements ITankCarouselHelper {

    private static const PADDING:Padding = new Padding(20);

    function SmallTankCarouselHelper() {
        super();
    }

    public function get linkRenderer():String {
        return "SmallTankCarouselItemRendererUI";
    }

    public function get rendererWidth():Number {
        return 162;
    }

    public function get rendererHeight():Number {
        return 37;
    }

    public function get gap():Number {
        return 10;
    }

    public function get padding():Padding {
        return PADDING;
    }
}

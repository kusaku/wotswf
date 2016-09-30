package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.DisplayObject;
import flash.events.Event;

import net.wg.data.Aliases;
import net.wg.gui.components.controls.ButtonIconNormal;
import net.wg.gui.components.controls.SimpleTileList;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterSelectedVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.managers.IPopoverManager;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ComponentEvent;
import scaleform.clik.interfaces.IListItemRenderer;

public class TankCarouselFilters extends UIComponentEx implements IPopOverCaller {

    private static const SELECTED_INVALID:String = "selected_invalid";

    private static const INIT_INVALID:String = "init_invalid";

    private static const LINKAGE_TOGGLE_RENDERER:String = "ToggleHotFilterRendererUI";

    private static const HOT_FILTER_TILE_WIDTH:uint = 58;

    private static const HOT_FILTER_TILE_HEIGHT:uint = 22;

    private static const HOT_FILTERS_GAP:int = 13;

    public var paramsFilter:ButtonIconNormal = null;

    public var listHotFilter:SimpleTileList = null;

    private var _initVO:TankCarouselFilterInitVO = null;

    private var _selectedVO:TankCarouselFilterSelectedVO = null;

    private var _popoverMgr:IPopoverManager = null;

    public function TankCarouselFilters() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
    }

    override protected function configUI():void {
        super.configUI();
        initSize();
        mouseEnabled = false;
        this._popoverMgr = App.popoverMgr;
        this.listHotFilter.itemRenderer = App.utils.classFactory.getClass(LINKAGE_TOGGLE_RENDERER);
        this.listHotFilter.tileWidth = HOT_FILTER_TILE_WIDTH;
        this.listHotFilter.tileHeight = HOT_FILTER_TILE_HEIGHT;
        this.listHotFilter.verticalGap = HOT_FILTERS_GAP;
        this.listHotFilter.directionMode = DirectionMode.HORIZONTAL;
        this.listHotFilter.autoSize = false;
        this.paramsFilter.addEventListener(ButtonEvent.CLICK, this.onParamsFilterClickHandler);
        addEventListener(ComponentEvent.HIDE, this.onHideHandler);
    }

    override protected function onDispose():void {
        this._popoverMgr = null;
        this._initVO = null;
        this._selectedVO = null;
        this.listHotFilter.dispose();
        this.listHotFilter = null;
        this.paramsFilter.removeEventListener(ButtonEvent.CLICK, this.onParamsFilterClickHandler);
        this.paramsFilter.dispose();
        this.paramsFilter = null;
        removeEventListener(ComponentEvent.HIDE, this.onHideHandler);
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:Vector.<Boolean> = null;
        var _loc5_:int = 0;
        var _loc6_:IListItemRenderer = null;
        var _loc7_:int = 0;
        super.draw();
        if (isInvalid(INIT_INVALID)) {
            this.paramsFilter.iconSource = this._initVO.mainBtn.value;
            this.paramsFilter.tooltip = this._initVO.mainBtn.tooltip;
            this.listHotFilter.dataProvider = this._initVO.hotFilters;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = HOT_FILTER_TILE_HEIGHT + HOT_FILTERS_GAP;
            _loc2_ = Math.round((height - this.listHotFilter.y + HOT_FILTERS_GAP) / _loc1_) * _loc1_ - HOT_FILTERS_GAP;
            _loc3_ = _loc1_ * this._initVO.hotFilters.length - HOT_FILTERS_GAP;
            this.listHotFilter.height = Math.min(_loc2_, _loc3_);
            _height = this.listHotFilter.y + this.listHotFilter.height;
            dispatchEvent(new Event(Event.RESIZE));
        }
        if (isInvalid(SELECTED_INVALID)) {
            this.listHotFilter.validateNow();
            _loc4_ = this._selectedVO.hotFilters;
            _loc5_ = this.listHotFilter.length;
            _loc7_ = 0;
            while (_loc7_ < _loc5_) {
                _loc6_ = this.listHotFilter.getRendererAt(_loc7_);
                _loc6_.validateNow();
                _loc6_.selectable = _loc4_[_loc7_];
                _loc7_++;
            }
        }
    }

    public function getHitArea():DisplayObject {
        return this.paramsFilter;
    }

    public function getTargetButton():DisplayObject {
        return this.paramsFilter;
    }

    public function initData(param1:TankCarouselFilterInitVO):void {
        this._initVO = param1;
        invalidate(INIT_INVALID);
    }

    public function setSelectedData(param1:TankCarouselFilterSelectedVO):void {
        this._selectedVO = param1;
        invalidate(SELECTED_INVALID);
    }

    private function onParamsFilterClickHandler(param1:ButtonEvent):void {
        this._popoverMgr.show(this, Aliases.TANK_CAROUSEL_FILTER_POPOVER);
    }

    private function onHideHandler(param1:ComponentEvent):void {
        if (this._popoverMgr.popoverCaller == this) {
            this._popoverMgr.hide();
        }
    }
}
}

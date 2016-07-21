package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.DisplayObject;

import net.wg.data.Aliases;
import net.wg.gui.components.controls.ButtonIconNormal;
import net.wg.gui.components.controls.SimpleTileList;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterSelectedVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.managers.IPopoverManager;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ComponentEvent;

public class TankCarouselFilters extends UIComponentEx implements IPopOverCaller {

    private static const SELECTED_INVALID:String = "selected_invalid";

    private static const INIT_INVALID:String = "init_invalid";

    private static const LINKAGE_TOGGLE_RENDERER:String = "ToggleHotFilterRendererUI";

    private static const HOT_FILTER_TILE_WIDTH:uint = 58;

    private static const HOT_FILTER_TILE_HEIGHT:uint = 35;

    private static const COUNTER_LAYOUT:String = "counter_layout";

    public var paramsFilter:ButtonIconNormal = null;

    public var listHotFilter:SimpleTileList = null;

    public var filterCounter:TankFilterCounter = null;

    private var _initVO:TankCarouselFilterInitVO = null;

    private var _selectedVO:TankCarouselFilterSelectedVO = null;

    private var _popoverMgr:IPopoverManager = null;

    private var _counterPosY:Number = 0;

    public function TankCarouselFilters() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        mouseEnabled = false;
        this._popoverMgr = App.popoverMgr;
        this.listHotFilter.itemRenderer = App.utils.classFactory.getClass(LINKAGE_TOGGLE_RENDERER);
        this.listHotFilter.tileWidth = HOT_FILTER_TILE_WIDTH;
        this.listHotFilter.tileHeight = HOT_FILTER_TILE_HEIGHT;
        this.listHotFilter.directionMode = DirectionMode.HORIZONTAL;
        this.paramsFilter.addEventListener(ButtonEvent.CLICK, this.onParamsFilterClickHandler);
        addEventListener(ComponentEvent.HIDE, this.onHideHandler);
    }

    override protected function onDispose():void {
        this._popoverMgr = null;
        this._initVO = null;
        this._selectedVO = null;
        this.filterCounter.dispose();
        this.filterCounter = null;
        this.listHotFilter.dispose();
        this.listHotFilter = null;
        this.paramsFilter.removeEventListener(ButtonEvent.CLICK, this.onParamsFilterClickHandler);
        this.paramsFilter.dispose();
        this.paramsFilter = null;
        removeEventListener(ComponentEvent.HIDE, this.onHideHandler);
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Vector.<Boolean> = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        super.draw();
        if (isInvalid(INIT_INVALID) && this._initVO != null) {
            this.paramsFilter.iconSource = this._initVO.mainBtn.value;
            this.paramsFilter.tooltip = this._initVO.mainBtn.tooltip;
            this.listHotFilter.dataProvider = this._initVO.hotFilters;
            this.filterCounter.setCloseButtonTooltip(this._initVO.counterCloseTooltip);
        }
        if (isInvalid(SELECTED_INVALID) && this._selectedVO) {
            _loc1_ = this._selectedVO.hotFilters;
            _loc2_ = _loc1_.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.listHotFilter.getRendererAt(_loc3_).selectable = _loc1_[_loc3_];
                _loc3_++;
            }
        }
        if (isInvalid(COUNTER_LAYOUT)) {
            this.filterCounter.y = this._counterPosY;
        }
    }

    public function counterBlink():void {
        this.filterCounter.blink();
    }

    public function counterHide():void {
        this.filterCounter.hide();
    }

    public function counterShow(param1:String, param2:Boolean):void {
        this.filterCounter.setCount(param1, param2);
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

    public function setCounterY(param1:Number):void {
        if (this._counterPosY != param1) {
            this._counterPosY = param1;
            invalidate(COUNTER_LAYOUT);
        }
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

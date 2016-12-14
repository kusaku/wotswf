package net.wg.gui.components.carousels {
import flash.display.DisplayObject;
import flash.events.Event;

import net.wg.gui.components.controls.scroller.IListViewPort;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.components.controls.scroller.ListRendererEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IAssertable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;

public class HorizontalScrollerViewPort extends UIComponentEx implements IListViewPort {

    protected static const INVALIDATE_RENDERER:String = "rendererInvalid";

    protected static const INVALIDATE_LAYOUT_RENDERER:String = "rendererLayoutInvalid";

    private var _activeRenderers:Vector.<IScrollerItemRenderer>;

    private var _inactiveRenderers:Vector.<IScrollerItemRenderer>;

    private var _typicalRendererWidth:Number = 0;

    private var _dataCount:Number = 0;

    private var _leftVisibleIndex:int = 0;

    private var _asserter:IAssertable = null;

    private var _owner:IUIComponentEx = null;

    private var _itemRendererFactory:Class = null;

    private var _dataProvider:IDataProvider = null;

    private var _gap:Number = 0;

    private var _horizontalScrollPosition:Number = 0;

    private var _verticalScrollPosition:Number = 0;

    private var _visibleWidth:Number = 0;

    private var _visibleHeight:Number = 0;

    private var _rendererWidth:Number = 0;

    private var _tooltipDecorator:ITooltipMgr;

    private var _selectedIndex:int = -1;

    private var _rowCount:int = 1;

    public function HorizontalScrollerViewPort() {
        this._activeRenderers = new Vector.<IScrollerItemRenderer>(0);
        this._inactiveRenderers = new Vector.<IScrollerItemRenderer>(0);
        super();
        this._asserter = App.utils.asserter;
    }

    override protected function onDispose():void {
        this._dataProvider = null;
        this._itemRendererFactory = null;
        this.deactivateRenderers(0, this._activeRenderers.length);
        this._activeRenderers = null;
        this.disposeInactiveRenderers();
        this._inactiveRenderers = null;
        this._owner = null;
        this._tooltipDecorator = null;
        this._asserter = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        var _loc1_:Boolean = isInvalid(INVALIDATE_RENDERER);
        var _loc2_:Boolean = _loc1_ || isInvalid(InvalidationType.DATA);
        var _loc3_:Boolean = _loc2_ || isInvalid(InvalidationType.SIZE);
        if (_loc2_) {
            this.deactivateRenderers(0, this._activeRenderers.length);
        }
        if (_loc1_) {
            this.disposeInactiveRenderers();
        }
        if (_loc3_) {
            this.updateDataCount();
        }
        if (_loc3_ || isInvalid(INVALIDATE_LAYOUT_RENDERER)) {
            this.updateActiveRenderer();
        }
        if (_loc3_) {
            this.resize();
        }
    }

    public function get validWidth():Number {
        var _loc1_:uint = 0;
        if (this._dataProvider && this._dataProvider.length > 0) {
            _loc1_ = Math.ceil(this._dataProvider.length / this.rowCount);
            return this.rendererWidth * _loc1_ + this.gap * (_loc1_ - 1);
        }
        return width;
    }

    public function get validHeight():Number {
        return height;
    }

    public function setSelectedIndex(param1:int):void {
        if (this._selectedIndex != param1) {
            this.switchSelectedIndex(param1, this.getRendererByIndex(param1));
        }
    }

    protected function newRenderer():IScrollerItemRenderer {
        var _loc1_:IScrollerItemRenderer = new this._itemRendererFactory() as IScrollerItemRenderer;
        this._asserter.assertNotNull(_loc1_, "Invalid IScrollerItemRenderer factory = " + this._itemRendererFactory);
        return _loc1_;
    }

    private function disposeInactiveRenderers():void {
        var _loc1_:IScrollerItemRenderer = null;
        for each(_loc1_ in this._inactiveRenderers) {
            _loc1_.removeEventListener(ListRendererEvent.SELECT, this.onRendererSelectHandler);
            _loc1_.dispose();
            removeChild(DisplayObject(_loc1_));
        }
        this._inactiveRenderers.splice(0, this._inactiveRenderers.length);
    }

    private function resize():void {
        var _loc1_:Number = this._typicalRendererWidth * (this._dataCount / this._rowCount) - this._gap;
        if (_width !== _loc1_ || _height !== this._visibleHeight) {
            _width = _loc1_;
            _height = this._visibleHeight;
            if (hasEventListener(Event.RESIZE)) {
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
    }

    private function deactivateRenderers(param1:int, param2:int):void {
        var _loc4_:IScrollerItemRenderer = null;
        var _loc3_:Vector.<IScrollerItemRenderer> = this._activeRenderers.splice(param1, param2);
        for each(_loc4_ in _loc3_) {
            _loc4_.data = null;
            _loc4_.visible = false;
            this._inactiveRenderers.push(_loc4_);
        }
    }

    private function updateActiveRenderer():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc8_:int = 0;
        if (this._dataCount > 0) {
            _loc1_ = (this._horizontalScrollPosition / this._typicalRendererWidth ^ 0) * this._rowCount;
            _loc2_ = _loc1_ + Math.ceil((this._visibleWidth + this._gap) / this._typicalRendererWidth) * this._rowCount + this._rowCount;
            _loc1_ = Math.max(0, _loc1_);
            _loc2_ = Math.min(this._dataCount - 1, _loc2_);
            if (this._activeRenderers.length > 0) {
                _loc4_ = this._activeRenderers[0].index;
                _loc5_ = this._activeRenderers[this._activeRenderers.length - 1].index;
                _loc6_ = _loc4_ - _loc1_;
                _loc7_ = _loc5_ - _loc2_;
                if (Math.max(-_loc6_, _loc7_) > this._activeRenderers.length) {
                    this.deactivateRenderers(0, this._activeRenderers.length);
                    this.createRenderers(_loc1_, _loc2_ - _loc1_);
                }
                else {
                    if (_loc6_ < 0) {
                        this.deactivateRenderers(0, -_loc6_);
                    }
                    else if (_loc6_ > 0) {
                        _loc3_ = _loc4_ - 1;
                        while (_loc3_ >= _loc1_) {
                            this._activeRenderers.unshift(this.getRenderer(this.getDataByIndex(_loc3_), _loc3_, true));
                            _loc3_--;
                        }
                    }
                    if (_loc7_ < 0) {
                        _loc3_ = _loc5_ + 1;
                        while (_loc3_ <= _loc2_) {
                            this._activeRenderers.push(this.getRenderer(this.getDataByIndex(_loc3_), _loc3_, true));
                            _loc3_++;
                        }
                    }
                    else if (_loc7_ > 0) {
                        _loc8_ = this._activeRenderers.length - _loc7_;
                        this.deactivateRenderers(_loc8_, _loc7_);
                    }
                }
            }
            else {
                this.createRenderers(_loc1_, _loc2_ - _loc1_);
            }
        }
    }

    private function createRenderers(param1:int, param2:int):void {
        var _loc4_:int = 0;
        var _loc3_:int = 0;
        while (_loc3_ <= param2) {
            _loc4_ = param1 + _loc3_;
            this._activeRenderers[_loc3_] = this.getRenderer(this.getDataByIndex(_loc4_), _loc4_, true);
            _loc3_++;
        }
    }

    private function getRenderer(param1:Object, param2:int, param3:Boolean):IScrollerItemRenderer {
        var _loc4_:IScrollerItemRenderer = null;
        if (!param3 || this._inactiveRenderers.length == 0) {
            _loc4_ = this.newRenderer();
            _loc4_.tooltipDecorator = this._tooltipDecorator;
            _loc4_.owner = this;
            _loc4_.addEventListener(ListRendererEvent.SELECT, this.onRendererSelectHandler);
            this._asserter.assert(_loc4_ is DisplayObject, "IScrollerItemRenderer must be DisplayObject");
            addChild(DisplayObject(_loc4_));
        }
        else {
            _loc4_ = this._inactiveRenderers.shift();
        }
        _loc4_.data = param1;
        _loc4_.index = param2;
        _loc4_.selected = param2 == this._selectedIndex;
        _loc4_.visible = true;
        if (this._rendererWidth != 0 && _loc4_.width != this._rendererWidth) {
            _loc4_.width = this._rendererWidth;
        }
        _loc4_.x = (_loc4_.index / this._rowCount ^ 0) * this._typicalRendererWidth;
        _loc4_.y = _loc4_.index % this._rowCount * (_loc4_.height + this._gap);
        return _loc4_;
    }

    private function getRendererByIndex(param1:int):IScrollerItemRenderer {
        var _loc2_:uint = 0;
        if (this._activeRenderers.length > 0) {
            _loc2_ = this._activeRenderers[0].index;
            if (param1 >= _loc2_ && param1 < _loc2_ + this._activeRenderers.length) {
                return this._activeRenderers[param1 - _loc2_];
            }
        }
        return null;
    }

    private function switchSelectedIndex(param1:int, param2:IScrollerItemRenderer = null):void {
        var _loc3_:IScrollerItemRenderer = null;
        if (this._selectedIndex != -1) {
            _loc3_ = this.getRendererByIndex(this._selectedIndex);
            if (_loc3_ != null) {
                _loc3_.selected = false;
            }
        }
        this._selectedIndex = param1;
        if (param2 != null) {
            param2.selected = true;
        }
    }

    private function getDataByIndex(param1:int):Object {
        if (this._dataProvider != null && this._dataProvider.length > param1) {
            return this._dataProvider.requestItemAt(param1);
        }
        return null;
    }

    private function updateDataCount():void {
        var _loc1_:int = Math.ceil((this._visibleWidth + this._gap) / this._typicalRendererWidth) * this._rowCount;
        if (this._dataProvider != null && this._dataProvider.length > _loc1_) {
            this._dataCount = this._dataProvider.length;
        }
        else {
            this._dataCount = _loc1_;
        }
        var _loc2_:int = this._dataCount % this._rowCount;
        if (_loc2_ != 0) {
            this._dataCount = this._dataCount + (this._rowCount - _loc2_);
        }
    }

    public function get owner():IUIComponentEx {
        return this._owner;
    }

    public function set owner(param1:IUIComponentEx):void {
        if (param1 != this._owner) {
            this._owner = param1;
            invalidate(InvalidationType.DATA);
        }
    }

    public function set itemRendererFactory(param1:Class):void {
        if (param1 != this._itemRendererFactory) {
            this._itemRendererFactory = param1;
            invalidate(INVALIDATE_RENDERER);
        }
    }

    public function get dataProvider():IDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:IDataProvider):void {
        this._dataProvider = param1;
        invalidate(InvalidationType.DATA);
    }

    public function get gap():Number {
        return this._gap;
    }

    public function set gap(param1:Number):void {
        this._gap = param1;
        this._typicalRendererWidth = this._rendererWidth + this._gap;
        invalidate(InvalidationType.SIZE);
    }

    public function get horizontalScrollPosition():Number {
        return this._horizontalScrollPosition;
    }

    public function set horizontalScrollPosition(param1:Number):void {
        var _loc2_:* = 0;
        if (param1 != this._horizontalScrollPosition) {
            this._horizontalScrollPosition = param1;
            _loc2_ = this._horizontalScrollPosition / this._typicalRendererWidth ^ 0;
            if (this._leftVisibleIndex != _loc2_) {
                this._leftVisibleIndex = _loc2_;
                invalidate(INVALIDATE_LAYOUT_RENDERER);
            }
        }
    }

    public function get verticalScrollPosition():Number {
        return this._verticalScrollPosition;
    }

    public function set verticalScrollPosition(param1:Number):void {
        if (param1 != this._verticalScrollPosition) {
            this._verticalScrollPosition = param1;
        }
    }

    public function get visibleWidth():Number {
        return this._visibleWidth;
    }

    public function set visibleWidth(param1:Number):void {
        if (param1 != this._visibleWidth) {
            this._visibleWidth = param1;
            invalidate(InvalidationType.SIZE);
        }
    }

    public function get visibleHeight():Number {
        return this._visibleHeight;
    }

    public function set visibleHeight(param1:Number):void {
        if (param1 != this._visibleHeight) {
            this._visibleHeight = param1;
            invalidate(InvalidationType.SIZE);
        }
    }

    public function get rendererWidth():Number {
        return this._rendererWidth;
    }

    public function set rendererWidth(param1:Number):void {
        this._rendererWidth = param1;
        this._typicalRendererWidth = this._rendererWidth + this._gap;
        invalidate(InvalidationType.DATA);
    }

    public function set tooltipDecorator(param1:ITooltipMgr):void {
        this._tooltipDecorator = param1;
    }

    public function get selectedIndex():int {
        return this._selectedIndex;
    }

    public function get rowCount():int {
        return this._rowCount;
    }

    public function set rowCount(param1:int):void {
        this._rowCount = param1;
        invalidate(InvalidationType.DATA);
    }

    protected function get activeRenderers():Vector.<IScrollerItemRenderer> {
        return this._activeRenderers;
    }

    protected function get inactiveRenderers():Vector.<IScrollerItemRenderer> {
        return this._inactiveRenderers;
    }

    private function onRendererSelectHandler(param1:Event):void {
        var _loc2_:IScrollerItemRenderer = IScrollerItemRenderer(param1.currentTarget);
        if (this._selectedIndex != _loc2_.index) {
            this.switchSelectedIndex(_loc2_.index, _loc2_);
        }
    }
}
}

package net.wg.gui.components.controls {
import flash.display.DisplayObject;
import flash.events.Event;

import net.wg.gui.components.controls.events.VerticalListViewportEvent;
import net.wg.gui.components.controls.scroller.IViewPort;
import net.wg.gui.components.interfaces.IReusableListItemRenderer;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;

public class VerticalListViewPort extends UIComponentEx implements IViewPort {

    private static const INVALID_BOUNDS:String = "invalidBounds";

    private static const INVALID_LAYOUT:String = "invalidLayout";

    private static const CACHE_SIZE_CORRECTION_VALUE:int = 2;

    private var _visibleBottomThreshold:Number = 0;

    private var _renderers:Vector.<IReusableListItemRenderer> = null;

    private var _renderersCache:Vector.<IReusableListItemRenderer> = null;

    private var _assertCacheValue:int = 0;

    private var _renderersY:Vector.<int> = null;

    private var _renderersHeight:Vector.<int> = null;

    private var _defRendererHeight:int = 0;

    private var _minRendererHeight:int = 2147483647;

    private var _firstRndrInd:int = -1;

    private var _lastRndrInd:int = -1;

    private var _dataLen:int = 0;

    private var _visibleWidth:Number = 0;

    private var _visibleHeight:Number = 0;

    private var _verticalScrollPosition:Number = 0;

    private var _itemRendererClassName:String = null;

    private var _dataProvider:IDataProvider = null;

    private var _gap:Number = 0;

    public function VerticalListViewPort() {
        super();
        this._renderers = new Vector.<IReusableListItemRenderer>(0);
        this._renderersCache = new Vector.<IReusableListItemRenderer>(0);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.RENDERERS)) {
            this.disposeRenderersVector(this._renderers);
            this.disposeRenderersVector(this._renderersCache);
            this._defRendererHeight = 0;
            invalidate(INVALID_BOUNDS);
        }
        if (isInvalid(INVALID_BOUNDS)) {
            this.tryDisposeRenderersBounds();
            this._minRendererHeight = int.MAX_VALUE;
            this.resetRenderers();
            if (this._dataLen > 0) {
                this._renderersY = new Vector.<int>(this._dataLen, true);
                this._renderersHeight = new Vector.<int>(this._dataLen, true);
                this.refreshRenderersBounds();
            }
            invalidateSize();
            this.checkLayout();
        }
        if (isInvalid(INVALID_LAYOUT) && this._dataLen > 0) {
            this.layoutRenderers();
        }
        if (isInvalid(InvalidationType.SIZE)) {
            dispatchEvent(new Event(Event.RESIZE));
        }
    }

    override protected function onDispose():void {
        this.tryDisposeDataProvider();
        this.tryDisposeRenderersBounds();
        this.disposeRenderersVector(this._renderers);
        this.disposeRenderersVector(this._renderersCache);
        this._renderers = null;
        this._renderersCache = null;
        super.onDispose();
    }

    public function invalidateRenderers():void {
        this.resetRenderers();
        this.checkLayout();
    }

    public function updateData(param1:int):void {
        if (param1 >= this._firstRndrInd && param1 <= this._lastRndrInd) {
            this.invalidateRenderers();
        }
    }

    private function checkLayout():void {
        var _loc1_:Boolean = false;
        if (this._dataLen > 0) {
            _loc1_ = false;
            if (!this.isIndexesInvalid()) {
                while (this._firstRndrInd < this._lastRndrInd && !this.hitRndrInVisibleArea(this._firstRndrInd)) {
                    this.pushActiveRendererToCache(this._renderers.shift());
                    this._firstRndrInd++;
                    _loc1_ = true;
                }
                while (this._lastRndrInd >= this._firstRndrInd && !this.hitRndrInVisibleArea(this._lastRndrInd)) {
                    this.pushActiveRendererToCache(this._renderers.pop());
                    this._lastRndrInd--;
                    _loc1_ = true;
                }
                if (this._renderers.length == 0) {
                    this.resetIndexes();
                }
            }
            if (this.isIndexesInvalid()) {
                this._firstRndrInd = 0;
                while (this._firstRndrInd < this._dataLen && this.getRendererBottomY(this._firstRndrInd) < this._verticalScrollPosition) {
                    this._firstRndrInd++;
                }
                this._lastRndrInd = this._firstRndrInd - 1;
                _loc1_ = true;
            }
            while (this._firstRndrInd > 0 && this.getRendererBottomY(this._firstRndrInd - 1) > this._verticalScrollPosition) {
                this._renderers.unshift(this.validateRenderer(--this._firstRndrInd, true));
                _loc1_ = true;
            }
            while (this._lastRndrInd < this._dataLen - 1 && this.getRendererY(this._lastRndrInd + 1) < this._visibleBottomThreshold) {
                this._renderers.push(this.validateRenderer(++this._lastRndrInd, false));
                _loc1_ = true;
            }
            if (_loc1_) {
                invalidate(INVALID_LAYOUT);
            }
        }
    }

    private function resetRenderers():void {
        var _loc1_:IReusableListItemRenderer = null;
        if (this._renderers != null) {
            for each(_loc1_ in this._renderers) {
                this.pushActiveRendererToCache(_loc1_);
            }
            this._renderers.splice(0, this._renderers.length);
        }
        this.resetIndexes();
    }

    private function isIndexesInvalid():Boolean {
        return this._firstRndrInd < 0 && this._lastRndrInd < 0;
    }

    private function resetIndexes():void {
        this._firstRndrInd = -1;
        this._lastRndrInd = -1;
    }

    private function validateRenderer(param1:int, param2:Boolean):IReusableListItemRenderer {
        var _loc3_:IReusableListItemRenderer = this.getRenderer();
        _loc3_.setData(this._dataProvider.requestItemAt(param1));
        _loc3_.validateNow();
        var _loc4_:int = this.setRendererHeight(param1, _loc3_.height);
        if (_loc4_ > 0) {
            dispatchEvent(new VerticalListViewportEvent(!!param2 ? VerticalListViewportEvent.RESIZE_TOP : VerticalListViewportEvent.RESIZE_BOTTOM, _loc4_));
        }
        return _loc3_;
    }

    private function hitPosInVisibleArea(param1:int):Boolean {
        return param1 > this._verticalScrollPosition && param1 < this._visibleBottomThreshold;
    }

    private function hitRndrInVisibleArea(param1:int):Boolean {
        return this.hitPosInVisibleArea(this.getRendererY(param1)) || this.hitPosInVisibleArea(this.getRendererBottomY(param1));
    }

    private function getRendererY(param1:int):int {
        if (param1 >= 0 && param1 < this._renderersY.length) {
            return this._renderersY[param1];
        }
        return 0;
    }

    private function getRendererBottomY(param1:int):int {
        return this.getRendererY(param1) + this.getRendererHeight(param1);
    }

    private function tryDisposeRenderersBounds():void {
        if (this._renderersY != null) {
            this._renderersY.fixed = false;
            this._renderersY.splice(0, this._renderersY.length);
            this._renderersY = null;
        }
        if (this._renderersHeight != null) {
            this._renderersHeight.fixed = false;
            this._renderersHeight.splice(0, this._renderersHeight.length);
            this._renderersHeight = null;
        }
    }

    private function tryDisposeDataProvider():void {
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            this._dataProvider.cleanUp();
            this._dataProvider = null;
        }
    }

    private function disposeRenderersVector(param1:Vector.<IReusableListItemRenderer>):void {
        var _loc2_:IReusableListItemRenderer = null;
        for each(_loc2_ in param1) {
            _loc2_.dispose();
        }
        param1.splice(0, param1.length);
    }

    private function pushActiveRendererToCache(param1:IReusableListItemRenderer):void {
        param1.visible = false;
        param1.cleanUp();
        this.pushItemToCache(param1);
    }

    private function pushItemToCache(param1:IReusableListItemRenderer, param2:Boolean = true):void {
        if (param2 && this._renderersCache.length + 1 > this._assertCacheValue) {
            App.utils.asserter.assert(false, "Too many items in cache");
        }
        this._renderersCache.push(param1);
    }

    private function refreshRenderersBounds():void {
        var _loc2_:int = 0;
        var _loc1_:int = this.getDefRendererHeight();
        if (this._dataLen > 0) {
            this._renderersHeight[0] = _loc1_;
            _loc2_ = 1;
            while (_loc2_ < this._dataLen) {
                this._renderersHeight[_loc2_] = _loc1_;
                this._renderersY[_loc2_] = this._renderersY[_loc2_ - 1] + _loc1_ + this._gap;
                _loc2_++;
            }
        }
        this.tryChangeMinRendererHeight(_loc1_);
    }

    private function offsetRenderers(param1:int, param2:int = 1):void {
        var _loc3_:int = param2;
        while (_loc3_ < this._dataLen) {
            this._renderersY[_loc3_] = this._renderersY[_loc3_] + param1;
            _loc3_++;
        }
        invalidateSize();
    }

    private function layoutRenderers():void {
        var _loc1_:IReusableListItemRenderer = null;
        var _loc2_:int = this._lastRndrInd - this._firstRndrInd + 1;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ = this._renderers[_loc3_];
            _loc1_.visible = true;
            _loc1_.y = this.getRendererY(_loc3_ + this._firstRndrInd);
            _loc3_++;
        }
    }

    private function setRendererHeight(param1:int, param2:int):int {
        var _loc4_:int = 0;
        var _loc3_:int = this.getRendererHeight(param1);
        if (_loc3_ != param2) {
            this._renderersHeight[param1] = param2;
            _loc4_ = param2 - _loc3_;
            this.offsetRenderers(_loc4_, param1 + 1);
            this.tryChangeMinRendererHeight(param2);
            return _loc4_;
        }
        return 0;
    }

    private function tryChangeMinRendererHeight(param1:int):void {
        if (this._minRendererHeight > param1) {
            this._minRendererHeight = param1;
            this._assertCacheValue = this.calcAssertCacheValue();
        }
    }

    private function calcAssertCacheValue():int {
        return Math.floor(this._visibleHeight / this._minRendererHeight) + CACHE_SIZE_CORRECTION_VALUE;
    }

    private function getRendererHeight(param1:int):int {
        if (param1 >= 0 && param1 < this._renderersHeight.length) {
            return this._renderersHeight[param1];
        }
        return 0;
    }

    private function getDefRendererHeight():int {
        var _loc1_:IReusableListItemRenderer = null;
        if (this._defRendererHeight <= 0) {
            _loc1_ = this.getRenderer();
            this._defRendererHeight = _loc1_.height;
            this.pushItemToCache(_loc1_, false);
        }
        return this._defRendererHeight;
    }

    private function getRenderer():IReusableListItemRenderer {
        var _loc1_:IReusableListItemRenderer = null;
        if (this._renderersCache.length > 0) {
            return this._renderersCache.pop();
        }
        _loc1_ = this.createNewRenderer();
        _loc1_.visible = false;
        addChild(DisplayObject(_loc1_));
        return _loc1_;
    }

    private function createNewRenderer():IReusableListItemRenderer {
        return App.utils.classFactory.getComponent(this._itemRendererClassName, IReusableListItemRenderer);
    }

    override public function get height():Number {
        return this._dataLen > 0 ? Number(this.getRendererBottomY(this._dataLen - 1)) : Number(0);
    }

    public function get visibleWidth():Number {
        return this._visibleWidth;
    }

    public function set visibleWidth(param1:Number):void {
        this._visibleWidth = param1;
    }

    public function get visibleHeight():Number {
        return this._visibleHeight;
    }

    public function set visibleHeight(param1:Number):void {
        if (this._visibleHeight != param1) {
            this._visibleHeight = param1;
            this._visibleBottomThreshold = this._verticalScrollPosition + this._visibleHeight;
            this.checkLayout();
        }
    }

    public function get verticalScrollPosition():Number {
        return this._verticalScrollPosition;
    }

    public function set verticalScrollPosition(param1:Number):void {
        if (this._verticalScrollPosition != param1) {
            this._verticalScrollPosition = param1;
            this._visibleBottomThreshold = this._verticalScrollPosition + this._visibleHeight;
            this.checkLayout();
        }
    }

    public function get itemRendererClassName():String {
        return this._itemRendererClassName;
    }

    public function set itemRendererClassName(param1:String):void {
        if (this._itemRendererClassName != param1) {
            this._itemRendererClassName = param1;
            invalidate(InvalidationType.RENDERERS);
        }
    }

    public function get dataProvider():IDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:IDataProvider):void {
        this.tryDisposeDataProvider();
        this._dataProvider = param1;
        this._dataLen = this._dataProvider != null ? int(this._dataProvider.length) : 0;
        if (this._dataProvider != null) {
            this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        }
        invalidate(INVALID_BOUNDS);
    }

    public function get gap():Number {
        return this._gap;
    }

    public function set gap(param1:Number):void {
        var _loc2_:int = 0;
        if (this._gap != param1) {
            _loc2_ = this._gap;
            this._gap = param1;
            this.offsetRenderers(_loc2_ - this._gap);
        }
    }

    public function get horizontalScrollPosition():Number {
        return 0;
    }

    public function set horizontalScrollPosition(param1:Number):void {
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        this._dataLen = this._dataProvider.length;
        invalidate(INVALID_BOUNDS);
    }
}
}

package net.wg.gui.components.controls {
import flash.display.DisplayObject;
import flash.events.Event;

import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.IAssertable;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;

public class SimpleTileList extends UIComponentEx {

    private static const INVALIDATE_LAYOUT:String = "invalidate_layout";

    private static const INVALIDATE_RENDERER:String = "invalidate_renderer";

    public var border:DisplayObject = null;

    private var _renderers:Vector.<IListItemRenderer> = null;

    private var _dataProvider:IDataProvider = null;

    private var _itemRenderer:Class = null;

    private var _directionMode:String = "horizontal";

    private var _tileWidth:uint = 0;

    private var _tileHeight:uint = 0;

    private var _autoSize:Boolean = true;

    private var _asserter:IAssertable = null;

    public function SimpleTileList() {
        super();
        this._asserter = App.utils.asserter;
        this.border.visible = false;
    }

    override protected function configUI():void {
        super.configUI();
        this._renderers = new Vector.<IListItemRenderer>();
        initSize();
    }

    override protected function draw():void {
        var _loc3_:int = 0;
        super.draw();
        var _loc1_:Boolean = isInvalid(INVALIDATE_RENDERER);
        var _loc2_:Boolean = isInvalid(InvalidationType.DATA);
        if (_loc1_) {
            this.removeRenderers(this._renderers.length);
        }
        if (_loc2_ || _loc1_) {
            if (this._dataProvider != null) {
                _loc3_ = this._renderers.length - this._dataProvider.length;
                if (_loc3_ > 0) {
                    this.removeRenderers(_loc3_);
                }
                else if (_loc3_ < 0) {
                    this.createRenderers(-_loc3_);
                }
                this.updateRenderers();
            }
            else {
                this.removeRenderers(this._renderers.length);
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            if (this.border.width != width) {
                this.border.width = width;
                if (this._directionMode == DirectionMode.HORIZONTAL) {
                    this.updateLayout();
                }
            }
            if (this.border.height != height) {
                this.border.height = height;
                if (this._directionMode == DirectionMode.VERTICAL) {
                    this.updateLayout();
                }
            }
        }
        else if (_loc2_ || _loc1_ || isInvalid(INVALIDATE_LAYOUT)) {
            this.updateLayout();
        }
    }

    override protected function onDispose():void {
        this.removeRenderers(this._renderers.length);
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            this._dataProvider = null;
        }
        this.border = null;
        this._renderers = null;
        this._itemRenderer = null;
        this._asserter = null;
        super.onDispose();
    }

    public function getRendererAt(param1:uint):IListItemRenderer {
        return this._renderers[param1];
    }

    private function updateRenderers():void {
        var _loc4_:IListItemRenderer = null;
        var _loc1_:uint = this._renderers.length;
        var _loc2_:Array = this._dataProvider.requestItemRange(0, _loc1_);
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc4_ = this._renderers[_loc3_];
            _loc4_.index = _loc3_;
            _loc4_.setData(_loc2_[_loc3_]);
            _loc3_++;
        }
    }

    private function createRenderers(param1:uint):void {
        var _loc3_:IListItemRenderer = null;
        var _loc2_:int = 0;
        while (_loc2_ < param1) {
            _loc3_ = IListItemRenderer(new this._itemRenderer());
            addChild(DisplayObject(_loc3_));
            this._renderers.push(_loc3_);
            _loc2_++;
        }
    }

    private function removeRenderers(param1:uint):void {
        var _loc2_:IListItemRenderer = null;
        var _loc3_:int = 0;
        while (_loc3_ < param1) {
            _loc2_ = this._renderers[_loc3_];
            _loc2_.dispose();
            removeChild(DisplayObject(_loc2_));
            _loc3_++;
        }
        this._renderers.splice(0, param1);
    }

    private function updateLayout():void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:DisplayObject = null;
        var _loc1_:int = 0;
        _loc2_ = 0;
        if (this._directionMode == DirectionMode.HORIZONTAL) {
            _loc3_ = width / this._tileWidth - 1;
            this._asserter.assert(_loc3_ >= _loc1_, "Child size exceeds container size");
            for each(_loc4_ in this._renderers) {
                _loc4_.x = _loc1_ * this._tileWidth;
                _loc4_.y = _loc2_;
                if (_loc3_ > _loc1_) {
                    _loc1_++;
                }
                else {
                    _loc2_ = _loc2_ + this._tileHeight;
                    _loc1_ = 0;
                }
            }
            if (this._autoSize) {
                height = _loc1_ > 0 ? Number(_loc2_ + this._tileHeight) : Number(_loc2_);
            }
        }
        else {
            _loc3_ = height / this._tileHeight - 1;
            this._asserter.assert(_loc3_ >= _loc1_, "Child size exceeds container size");
            for each(_loc4_ in this._renderers) {
                _loc4_.y = _loc1_ * this._tileHeight;
                _loc4_.x = _loc2_;
                if (_loc3_ > _loc1_) {
                    _loc1_++;
                }
                else {
                    _loc2_ = _loc2_ + this._tileWidth;
                    _loc1_ = 0;
                }
            }
            if (this._autoSize) {
                width = _loc1_ > 0 ? Number(_loc2_ + this._tileWidth) : Number(_loc2_);
            }
        }
    }

    public function get length():int {
        return this._renderers.length;
    }

    public function get itemRenderer():Class {
        return this._itemRenderer;
    }

    public function set itemRenderer(param1:Class):void {
        this._asserter.assertNotNull(param1, "itemRenderer" + Errors.CANT_NULL);
        this._itemRenderer = param1;
        invalidate(INVALIDATE_RENDERER);
    }

    public function get directionMode():String {
        return this._directionMode;
    }

    public function set directionMode(param1:String):void {
        this._asserter.assert(param1 == DirectionMode.HORIZONTAL || param1 == DirectionMode.HORIZONTAL, "Invalid value directionMode in SimpleTileList");
        this._directionMode = param1;
        invalidate(INVALIDATE_LAYOUT);
    }

    public function get dataProvider():IDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:IDataProvider):void {
        if (param1 != this._dataProvider) {
            if (this._dataProvider != null) {
                this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            }
            this._dataProvider = param1;
            if (this._dataProvider != null) {
                this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            }
            invalidateData();
        }
    }

    public function get autoSize():Boolean {
        return this._autoSize;
    }

    public function set autoSize(param1:Boolean):void {
        this._autoSize = param1;
        invalidate(INVALIDATE_LAYOUT);
    }

    public function get tileWidth():uint {
        return this._tileWidth;
    }

    public function set tileWidth(param1:uint):void {
        this._tileWidth = param1;
        invalidate(INVALIDATE_LAYOUT);
    }

    public function get tileHeight():uint {
        return this._tileHeight;
    }

    public function set tileHeight(param1:uint):void {
        this._tileHeight = param1;
        invalidate(INVALIDATE_LAYOUT);
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        invalidateData();
    }
}
}

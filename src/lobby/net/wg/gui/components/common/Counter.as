package net.wg.gui.components.common {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.UIComponentEx;

public class Counter extends UIComponentEx {

    private static const INVALIDATE_COUNT:String = "invalidateCount";

    private static const INVALIDATE_POSITION:String = "invalidatePosition";

    public var label:TextField = null;

    public var back:DisplayObject = null;

    private var _value:String = null;

    private var _target:DisplayObject = null;

    private var _offset:Point = null;

    private var _tfPadding:int = 0;

    private var _horizontalAlign:String = null;

    private var _addToTop:Boolean = true;

    private var _originalBackWidth:int = 0;

    public function Counter() {
        super();
        this._originalBackWidth = this.back.width;
    }

    override protected function onDispose():void {
        var _loc1_:DisplayObjectContainer = null;
        this.label = null;
        this.back = null;
        this._offset = null;
        if (this._target != null) {
            this._target.removeEventListener(Event.ADDED, this.onTargetAddedHandler);
            this._target.removeEventListener(Event.RESIZE, this.onTargetResizeHandler);
            _loc1_ = this._target.parent;
            if (_loc1_ != null && _loc1_.contains(this)) {
                _loc1_.removeChild(this);
            }
            this._target = null;
        }
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        mouseEnabled = false;
        mouseChildren = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_COUNT)) {
            this.applyCountValue();
        }
        if (isInvalid(INVALIDATE_POSITION)) {
            this.applyPosition();
        }
    }

    public function setCount(param1:String):void {
        if (param1 != this._value) {
            this._value = param1;
            invalidate(INVALIDATE_COUNT);
        }
    }

    public function setTarget(param1:DisplayObject, param2:Point = null, param3:String = null, param4:Boolean = true, param5:int = 0):void {
        App.utils.asserter.assertNotNull(param1, "Counter target" + Errors.CANT_NULL);
        this._target = param1;
        this._offset = param2;
        this._addToTop = param4;
        this._tfPadding = param5;
        this._horizontalAlign = param3;
        if (this._target.parent) {
            this.onTargetAddedHandler();
        }
        else {
            this._target.addEventListener(Event.ADDED, this.onTargetAddedHandler);
        }
    }

    public function updateHorizontalAlign(param1:String):void {
        if (param1 != this._horizontalAlign) {
            this._horizontalAlign = param1;
            this.invalidatePosition();
        }
    }

    public function updatePosition(param1:Point):void {
        if (!this._offset.equals(param1)) {
            this._offset = param1;
            this.invalidatePosition();
        }
    }

    private function invalidatePosition():void {
        invalidate(INVALIDATE_POSITION);
    }

    private function applyCountValue():void {
        var _loc1_:int = 0;
        if (this.label != null && this.label.htmlText != this._value) {
            this.label.htmlText = this._value;
            App.utils.commons.updateTextFieldSize(this.label);
            _loc1_ = this.label.width + (this._tfPadding << 1);
            this.back.width = _loc1_ < this._originalBackWidth ? Number(this._originalBackWidth) : Number(_loc1_);
            this.label.x = this.back.x + this._tfPadding + (this.back.width - _loc1_ >> 1) | 0;
            this.invalidatePosition();
        }
    }

    private function applyPosition():void {
        var _loc1_:Rectangle = this._target.getBounds(this._target.parent);
        x = _loc1_.x + _loc1_.width | 0;
        if (this._horizontalAlign == TextFormatAlign.RIGHT) {
            x = x - this.label.width;
        }
        else if (this._horizontalAlign == TextFormatAlign.CENTER) {
            x = x - (this.label.width >> 1);
        }
        y = _loc1_.y | 0;
        if (this._offset != null) {
            x = x + (this._offset.x | 0);
            y = y + (this._offset.y | 0);
        }
    }

    private function onTargetResizeHandler(param1:Event):void {
        this.applyPosition();
    }

    private function onTargetAddedHandler(param1:Event = null):void {
        this._target.removeEventListener(Event.ADDED, this.onTargetAddedHandler);
        this._target.addEventListener(Event.RESIZE, this.onTargetResizeHandler);
        if (this._addToTop) {
            this._target.parent.addChild(this);
        }
        else {
            this._target.parent.addChildAt(this, this._target.parent.getChildIndex(this._target) + 1);
        }
        this.applyPosition();
    }
}
}

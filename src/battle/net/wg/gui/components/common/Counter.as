package net.wg.gui.components.common {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
import net.wg.infrastructure.base.UIComponentEx;

public class Counter extends UIComponentEx {

    private static const INVALIDATE_COUNT:String = "invalidateCount";

    private static const INVALIDATE_POSITION:String = "invalidatePosition";

    private static const CHAR_99PLUS:String = "99+";

    private static const TEXT_POSITIONS_X:Array = [0, -19, -22, -25];

    public var label:TextField;

    public var back:MovieClip;

    private var _value:uint;

    private var _container:Sprite;

    private var _offset:Point;

    public function Counter() {
        super();
    }

    override protected function onDispose():void {
        this.label = null;
        this.back = null;
        this._offset = null;
        if (this._container) {
            this._container.removeEventListener(Event.ADDED, this.onContainerAddedHandler);
            this._container.removeEventListener(Event.RESIZE, this.onContainerResizeHandler);
            this._container = null;
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

    public function setCount(param1:uint):void {
        if (param1 != this._value) {
            this._value = param1;
            invalidate(INVALIDATE_COUNT);
        }
    }

    private function applyCountValue():void {
        var _loc1_:String = this._value > 99 ? CHAR_99PLUS : String(this._value);
        var _loc2_:int = _loc1_.length;
        this.back.gotoAndStop(_loc2_);
        this.label.x = TEXT_POSITIONS_X[_loc2_];
        this.label.htmlText = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.COUNTER_LABEL_TEXT, _loc1_);
    }

    private function applyPosition():void {
        var _loc1_:Rectangle = this._container.getBounds(this._container.parent);
        x = _loc1_.x + _loc1_.width;
        y = _loc1_.y;
        if (this._offset) {
            x = x + this._offset.x;
            y = y + this._offset.y;
        }
    }

    private function onContainerResizeHandler(param1:Event):void {
        this.applyPosition();
    }

    private function onContainerAddedHandler(param1:Event = null):void {
        this._container.removeEventListener(Event.ADDED, this.onContainerAddedHandler);
        this._container.addEventListener(Event.RESIZE, this.onContainerResizeHandler);
        this._container.parent.addChildAt(this, this._container.parent.getChildIndex(this._container) + 1);
        this.applyPosition();
    }

    public function setTarget(param1:Sprite, param2:Point = null):void {
        this._container = param1;
        App.utils.asserter.assertNotNull(param1, Errors.CANT_NULL);
        this._container = param1;
        this._offset = param2;
        if (this._container.parent) {
            this.onContainerAddedHandler();
        }
        else {
            this._container.addEventListener(Event.ADDED, this.onContainerAddedHandler);
        }
    }

    public function updatePosition():void {
        invalidate(INVALIDATE_POSITION);
    }
}
}

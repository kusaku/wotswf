package net.wg.gui.components.common.containers {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Point;

import net.wg.infrastructure.interfaces.IBaseLayout;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.core.UIComponent;

public class Group extends UIComponent {

    public static const LAYOUT_INVALID:String = "layoutInv";

    private var _layout:IBaseLayout;

    public function Group() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(Event.RESIZE, this.resizeHandler, false, 0, true);
    }

    private function resizeHandler(param1:Event):void {
        if (param1.target != this) {
            param1.stopImmediatePropagation();
            invalidate(LAYOUT_INVALID);
        }
    }

    override protected function draw():void {
        var _loc1_:Point = null;
        if (_baseDisposed) {
            return;
        }
        super.draw();
        if (isInvalid(LAYOUT_INVALID) && this._layout) {
            _loc1_ = Point(this._layout.invokeLayout());
            _width = _loc1_.x;
            _height = _loc1_.y;
            dispatchEvent(new Event(Event.RESIZE));
        }
    }

    public function set layout(param1:IBaseLayout):void {
        this._layout = param1;
        this._layout.target = this;
        invalidate(LAYOUT_INVALID);
    }

    public function get layout():IBaseLayout {
        return this._layout;
    }

    override public function addChild(param1:DisplayObject):DisplayObject {
        param1 = super.addChild(param1);
        invalidate(LAYOUT_INVALID);
        return param1;
    }

    override public function addChildAt(param1:DisplayObject, param2:int):DisplayObject {
        param1 = super.addChildAt(param1, param2);
        invalidate(LAYOUT_INVALID);
        return param1;
    }

    override public function removeChild(param1:DisplayObject):DisplayObject {
        param1 = super.removeChild(param1);
        if (param1 is IDisposable) {
            IDisposable(param1).dispose();
        }
        invalidate(LAYOUT_INVALID);
        return param1;
    }

    override public function removeChildAt(param1:int):DisplayObject {
        var _loc2_:DisplayObject = null;
        if (!_baseDisposed) {
            _loc2_ = super.removeChildAt(param1);
            invalidate(LAYOUT_INVALID);
            return _loc2_;
        }
        return super.removeChildAt(param1);
    }

    public function removeAllChildren(param1:Boolean = false):void {
        var _loc2_:DisplayObject = null;
        while (numChildren > 0) {
            _loc2_ = this.removeChildAt(0);
            if (param1 && _loc2_ is IDisposable) {
                IDisposable(_loc2_).dispose();
            }
        }
    }

    public function invalidateLayout():void {
        invalidate(LAYOUT_INVALID);
    }

    override protected function onDispose():void {
        if (this._layout) {
            this._layout.dispose();
            this._layout = null;
        }
        this.removeAllChildren(true);
        removeEventListener(Event.RESIZE, this.resizeHandler);
        super.onDispose();
    }

    protected function validateChildren():void {
        var _loc2_:UIComponent = null;
        var _loc1_:int = numChildren - 1;
        while (_loc1_ >= 0) {
            _loc2_ = getChildAt(_loc1_) as UIComponent;
            if (_loc2_) {
                _loc2_.validateNow();
            }
            _loc1_--;
        }
    }
}
}

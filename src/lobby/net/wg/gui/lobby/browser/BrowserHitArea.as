package net.wg.gui.lobby.browser {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;

import net.wg.utils.IEventCollector;

import scaleform.clik.core.UIComponent;

public class BrowserHitArea extends UIComponent {

    private var _events:IEventCollector;

    private var _bgImg:Bitmap;

    private var _mouseDown:Boolean = false;

    public function BrowserHitArea() {
        this._events = App.utils.events;
        super();
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
        removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
        removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        this._events.removeEvent(App.stage, MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        this._events.removeEvent(App.stage, MouseEvent.MOUSE_UP, this.onMouseUpHandler);
        removeChild(this._bgImg);
        this._bgImg.bitmapData.dispose();
        this._bgImg.bitmapData = null;
        this._bgImg = null;
        this._events = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler, false, 0, true);
        addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler, false, 0, true);
        this._events.addEvent(App.stage, MouseEvent.MOUSE_DOWN, this.onMouseDownHandler, false, 0, true);
        this._events.addEvent(App.stage, MouseEvent.MOUSE_UP, this.onMouseUpHandler, false, 0, true);
    }

    public function setBgClass(param1:Boolean):void {
        var _loc2_:Class = null;
        if (param1) {
            _loc2_ = App.browserBgClass;
        }
        else {
            _loc2_ = App.altBrowserBgClass;
        }
        this._bgImg = new _loc2_();
        addChild(this._bgImg);
    }

    public function setMaskSize(param1:Number, param2:Number):void {
        this.width = param1;
        this.height = param2;
        var _loc3_:BitmapData = new BitmapData(param1, param2, true, 0);
        var _loc4_:Bitmap = new Bitmap(_loc3_);
        this.mask = _loc4_;
        addChild(_loc4_);
    }

    private function onMouseRollOverHandler(param1:MouseEvent):void {
        addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler, false, 0, true);
        dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_IN));
    }

    private function onMouseRollOutHandler(param1:MouseEvent):void {
        if (!this._mouseDown) {
            removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_OUT));
        }
    }

    private function onMouseWheelHandler(param1:MouseEvent):void {
        dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_MOVE, 0, 0, param1.delta));
    }

    private function onMouseDownHandler(param1:MouseEvent):void {
        if (param1.target == this) {
            this._mouseDown = true;
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_DOWN, this.mouseX, this.mouseY));
        }
        else {
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_OUT));
        }
    }

    private function onMouseUpHandler(param1:MouseEvent):void {
        this._mouseDown = false;
        dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_UP, this.mouseX, this.mouseY));
    }

    private function onMouseMoveHandler(param1:MouseEvent):void {
        dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_MOVE, this.mouseX, this.mouseY));
    }
}
}

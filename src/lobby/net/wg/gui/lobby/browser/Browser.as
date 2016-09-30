package net.wg.gui.lobby.browser {
import flash.display.Bitmap;
import flash.events.MouseEvent;

import net.wg.gui.lobby.browser.events.BrowserEvent;
import net.wg.infrastructure.base.meta.IBrowserMeta;
import net.wg.infrastructure.base.meta.impl.BrowserMeta;

public class Browser extends BrowserMeta implements IBrowserMeta {

    public var serviceView:ServiceView = null;

    private var _bgImg:Bitmap = null;

    private var _mouseDown:Boolean = false;

    private var _hideContentOnLoading:Boolean = true;

    public function Browser() {
        super();
        this.serviceView.visible = false;
    }

    override public function setSize(param1:Number, param2:Number):void {
        super.setSize(param1, param2);
        setBrowserSizeS(param1, param2);
        if (this._bgImg != null) {
            this._bgImg.width = param1;
            this._bgImg.height = param2;
        }
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
        removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUpHandler);
        if (this._bgImg != null) {
            removeChild(this._bgImg);
            this._bgImg.bitmapData.dispose();
            this._bgImg.bitmapData = null;
            this._bgImg = null;
        }
        this.serviceView.dispose();
        this.serviceView = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler, false, 0, true);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_UP, this.onMouseUpHandler, false, 0, true);
    }

    public function as_hideServiceView():void {
        this.serviceView.visible = false;
        if (this._bgImg != null) {
            this._bgImg.visible = true;
        }
        dispatchEvent(new BrowserEvent(BrowserEvent.SERVICE_VIEW_HIDDEN));
    }

    public function as_loadingStart():void {
        this.checkAndCreateBgImg();
        if (this._hideContentOnLoading) {
            this._bgImg.visible = false;
        }
        dispatchEvent(new BrowserEvent(BrowserEvent.LOADING_STARTED));
    }

    public function as_loadingStop():void {
        this.checkAndCreateBgImg();
        if (this._hideContentOnLoading) {
            this._bgImg.visible = true;
        }
        dispatchEvent(new BrowserEvent(BrowserEvent.LOADING_STOPPED));
    }

    public function as_showServiceView(param1:String, param2:String):void {
        this.serviceView.setData(param1, param2);
        this.serviceView.x = width - this.serviceView.width >> 1;
        this.serviceView.y = height - this.serviceView.height >> 1;
        this.serviceView.visible = true;
        if (this._bgImg != null) {
            this._bgImg.visible = false;
        }
        dispatchEvent(new BrowserEvent(BrowserEvent.SERVICE_VIEW_SHOWED));
    }

    private function checkAndCreateBgImg():void {
        if (this._bgImg == null) {
            this._bgImg = new App.browserBgClass();
            addChild(this._bgImg);
        }
    }

    public function get hideContentOnLoading():Boolean {
        return this._hideContentOnLoading;
    }

    public function set hideContentOnLoading(param1:Boolean):void {
        this._hideContentOnLoading = param1;
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler, false, 0, true);
        onBrowserShowS(false);
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        if (!this._mouseDown) {
            removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            browserFocusOutS();
        }
    }

    private function onMouseWheelHandler(param1:MouseEvent):void {
        browserMoveS(0, 0, param1.delta);
    }

    private function onMouseDownHandler(param1:MouseEvent):void {
        this._mouseDown = true;
        browserDownS(mouseX, mouseY, 0);
    }

    private function onMouseUpHandler(param1:MouseEvent):void {
        this._mouseDown = false;
        browserUpS(mouseX, mouseY, 0);
    }

    private function onMouseMoveHandler(param1:MouseEvent):void {
        browserMoveS(mouseX, mouseY, 0);
    }
}
}

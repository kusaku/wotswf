package net.wg.gui.components.common.cursor.base {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.infrastructure.base.AbstractView;

import scaleform.gfx.MouseCursorEvent;

class BaseCursor extends AbstractView {

    private var _attachedSprite:Sprite = null;

    private var _lastCursor:String = "arrow";

    private var _isServiceListenersAdded:Boolean = false;

    function BaseCursor() {
        super();
    }

    public function attachToCursor(param1:Sprite, param2:Number, param3:Number):void {
        if (this._attachedSprite != null) {
            this.detachFromCursor();
        }
        assertNotNull(param1, "sprite");
        this._attachedSprite = param1;
        addChildAt(this._attachedSprite, 0);
        this._attachedSprite.x = param2;
        this._attachedSprite.y = param3;
    }

    public function getAttachedSprite():Sprite {
        return this._attachedSprite;
    }

    public function detachFromCursor():void {
        assertNotNull(this._attachedSprite, "sprite");
        removeChild(this._attachedSprite);
        this._attachedSprite = null;
    }

    protected function resetCursor():void {
        this.setCursor(this._lastCursor);
    }

    protected function setCursor(param1:String):void {
        this._lastCursor = param1;
        if (this.cursorIsFree()) {
            this.forceSetCursor(param1);
        }
    }

    override protected function nextFrameAfterPopulateHandler():void {
        this.updateServiceListeners();
        App.stage.addEventListener(MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
    }

    override protected function onDispose():void {
        this.removeServiceListeners();
        App.stage.removeEventListener(MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
        if (this._attachedSprite) {
            this.detachFromCursor();
        }
        super.onDispose();
    }

    override public function setViewSize(param1:Number, param2:Number):void {
    }

    protected final function forceSetCursor(param1:String):void {
        gotoAndStop(param1);
    }

    protected final function tryToResetCursor():void {
        if (this.cursorIsFree()) {
            this.resetCursor();
        }
    }

    protected function cursorIsFree():Boolean {
        return true;
    }

    protected function updateServiceListeners():void {
        if (this.visible) {
            this.addServiceListeners();
        }
        else {
            this.removeServiceListeners();
        }
    }

    protected function addServiceListeners():void {
        if (!this._isServiceListenersAdded) {
            App.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            this._isServiceListenersAdded = true;
        }
    }

    private function removeServiceListeners():void {
        if (this._isServiceListenersAdded) {
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            this._isServiceListenersAdded = false;
        }
    }

    private function onChangeCursorHandler(param1:MouseCursorEvent):void {
        this.setCursor(param1.cursor);
        param1.preventDefault();
    }

    private function onMouseMoveHandler(param1:MouseEvent):void {
        x = stage.mouseX - MovieClip(App.instance).x;
        y = stage.mouseY - MovieClip(App.instance).y;
    }
}
}

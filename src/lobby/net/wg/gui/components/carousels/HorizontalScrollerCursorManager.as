package net.wg.gui.components.carousels {
import flash.display.InteractiveObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import net.wg.data.constants.Cursors;
import net.wg.data.constants.DragType;
import net.wg.gui.components.carousels.interfaces.IHorizontalScrollerCursorManager;

public class HorizontalScrollerCursorManager extends Sprite implements IHorizontalScrollerCursorManager {

    public function HorizontalScrollerCursorManager() {
        super();
        alpha = 0;
        var _loc1_:Shape = new Shape();
        _loc1_.graphics.beginFill(0);
        _loc1_.graphics.drawRect(0, 0, 1, 1);
        _loc1_.graphics.endFill();
        addChild(_loc1_);
        App.cursor.registerDragging(this, Cursors.MOVE);
        alpha = 0;
    }

    public final function dispose():void {
        this.onDispose();
        App.cursor.unRegisterDragging(this);
        while (numChildren > 0) {
            removeChildAt(0);
        }
    }

    public function getDragType():String {
        return DragType.SOFT;
    }

    public function getHitArea():InteractiveObject {
        return this;
    }

    public function onDragging(param1:Number, param2:Number):void {
    }

    public function onEndDrag():void {
    }

    public function onStartDrag():void {
    }

    public function setTouchRect(param1:Rectangle):void {
        x = param1.x;
        y = param1.y;
        width = param1.width;
        height = param1.height;
    }

    public function startTouchScroll():void {
        dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, false));
    }

    public function stopTouchScroll():void {
        dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, false));
    }

    protected function onDispose():void {
    }

    public function get enable():Boolean {
        return mouseEnabled;
    }

    public function set enable(param1:Boolean):void {
        mouseEnabled = param1;
    }
}
}

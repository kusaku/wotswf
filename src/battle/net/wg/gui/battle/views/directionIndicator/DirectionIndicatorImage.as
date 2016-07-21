package net.wg.gui.battle.views.directionIndicator {
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DirectionIndicatorImage extends Sprite implements IDisposable {

    public var green:DisplayObject;

    public var red:DisplayObject;

    public var purple:DisplayObject;

    public function DirectionIndicatorImage() {
        super();
        this.green.visible = false;
        this.red.visible = false;
        this.purple.visible = false;
    }

    public function setShape(param1:String):void {
        this.green.visible = param1 == DirectionIndicatorShape.SHAPE_GREEN;
        this.red.visible = param1 == DirectionIndicatorShape.SHAPE_RED;
        this.purple.visible = param1 == DirectionIndicatorShape.SHAPE_PURPLE;
    }

    public function dispose():void {
        this.green = null;
        this.red = null;
        this.purple = null;
    }
}
}

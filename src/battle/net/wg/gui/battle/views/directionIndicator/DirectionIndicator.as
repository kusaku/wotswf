package net.wg.gui.battle.views.directionIndicator {
import flash.display.Sprite;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DirectionIndicator extends Sprite implements IDisposable {

    public var indicator:DirectionIndicatorImage = null;

    public var distance:DirnIndicatorDistance = null;

    private var _shape:String = null;

    public function DirectionIndicator() {
        super();
    }

    public function setShape(param1:String):void {
        if (!param1 || param1 == this._shape) {
            return;
        }
        this.indicator.setShape(param1);
        this.distance.setShape(param1);
        this._shape = param1;
    }

    public function setDistance(param1:Number):void {
        this.distance.setDistance(param1);
    }

    public function dispose():void {
        this.indicator.dispose();
        this.distance.dispose();
        this.indicator = null;
        this.distance = null;
    }
}
}

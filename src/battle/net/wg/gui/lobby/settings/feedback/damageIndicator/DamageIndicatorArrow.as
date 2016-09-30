package net.wg.gui.lobby.settings.feedback.damageIndicator {
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DamageIndicatorArrow extends Sprite implements IDisposable {

    public var circleMc:MovieClip = null;

    public var critArrowMc:MovieClip = null;

    public function DamageIndicatorArrow() {
        super();
    }

    public final function dispose():void {
        this.circleMc = null;
        this.critArrowMc = null;
    }

    public function update(param1:String, param2:String):void {
        this.circleMc.gotoAndStop(param1);
        this.circleMc.valueTF.text = param2;
    }
}
}

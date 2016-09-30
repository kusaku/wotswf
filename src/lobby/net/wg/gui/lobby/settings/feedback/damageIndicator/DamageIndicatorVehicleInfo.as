package net.wg.gui.lobby.settings.feedback.damageIndicator {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DamageIndicatorVehicleInfo extends Sprite implements IDisposable {

    public var vehicleTypeMc:MovieClip = null;

    public var vehicleNameTF:TextField = null;

    private var _alreadyFlipped:Boolean = false;

    public function DamageIndicatorVehicleInfo() {
        super();
    }

    public final function dispose():void {
        this.vehicleNameTF = null;
        this.vehicleTypeMc = null;
    }

    public function update(param1:String, param2:String, param3:Boolean):void {
        var _loc4_:Matrix = null;
        var _loc5_:TextFormat = null;
        this.vehicleTypeMc.gotoAndStop(param1);
        this.vehicleNameTF.text = param2;
        if (param3 && !this._alreadyFlipped) {
            this._alreadyFlipped = true;
            _loc4_ = this.vehicleNameTF.transform.matrix;
            _loc4_.a = -1;
            _loc4_.d = -1;
            _loc4_.tx = this.vehicleNameTF.width + this.vehicleNameTF.x;
            _loc4_.ty = this.vehicleNameTF.height + this.vehicleNameTF.y;
            this.vehicleNameTF.transform.matrix = _loc4_;
            _loc5_ = this.vehicleNameTF.defaultTextFormat;
            _loc5_.align = TextFormatAlign.RIGHT;
            this.vehicleNameTF.setTextFormat(_loc5_);
        }
    }
}
}

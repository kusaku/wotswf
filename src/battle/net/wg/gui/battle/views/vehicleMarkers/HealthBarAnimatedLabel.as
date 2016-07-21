package net.wg.gui.battle.views.vehicleMarkers {
import net.wg.data.constants.Values;
import net.wg.gui.battle.components.constants.InvalidationType;

public class HealthBarAnimatedLabel extends HealthBarAnimatedPart {

    private static const INVALIDATE_DAMAGE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

    public var damageLabel:DamageLabel = null;

    private var _damage:int;

    private var _fakeDamage:int;

    private var _imitation:Boolean = false;

    private var _imitationFlag:String = "";

    public function HealthBarAnimatedLabel() {
        super();
        partType = VehicleMarkersConstants.HB_ANIMATED_PART_LABEL;
    }

    override protected function onDispose():void {
        this.damageLabel.dispose();
        this.damageLabel = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_DAMAGE)) {
            if (this._imitation) {
                this.damage(this._fakeDamage, this._imitationFlag);
                tweenState = VehicleMarkersConstants.HB_ANIMATED_IMITATION_STATE;
                setState();
            }
            visible = this._imitation;
        }
    }

    public function damage(param1:int, param2:String):void {
        if (tweenState != VehicleMarkersConstants.HB_ANIMATED_INACTIVE_STATE && tweenState != VehicleMarkersConstants.HB_ANIMATED_IMITATION_STATE) {
            this._damage = this._damage + param1;
        }
        else {
            this._damage = param1;
        }
        this.damageLabel.color = param2;
        this.damageLabel.text = this._damage > 0 ? String(-this._damage) : Values.EMPTY_STR;
    }

    private function imitationDamage(param1:Boolean, param2:int, param3:String):void {
    }

    public function get fakeDamage():Number {
        return this._fakeDamage;
    }

    public function set fakeDamage(param1:Number):void {
        if (this._fakeDamage == param1) {
            return;
        }
        this._fakeDamage = param1;
        invalidate(INVALIDATE_DAMAGE);
    }

    public function get imitationFlag():String {
        return this._imitationFlag;
    }

    public function set imitationFlag(param1:String):void {
        if (param1 == this._imitationFlag) {
            return;
        }
        this._imitationFlag = param1;
        invalidate(INVALIDATE_DAMAGE);
    }

    public function get imitation():Boolean {
        return this._imitation;
    }

    public function set imitation(param1:Boolean):void {
        if (this._imitation == param1) {
            return;
        }
        this._imitation = param1;
        invalidate(INVALIDATE_DAMAGE);
    }
}
}

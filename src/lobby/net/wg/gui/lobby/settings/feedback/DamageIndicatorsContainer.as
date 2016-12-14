package net.wg.gui.lobby.settings.feedback {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.generated.DAMAGE_INDICATOR_ATLAS_ITEMS;
import net.wg.data.constants.generated.TANK_TYPES;
import net.wg.gui.lobby.settings.feedback.damageIndicator.DamageIndicatorArrow;
import net.wg.gui.lobby.settings.feedback.damageIndicator.DamageIndicatorExtended;
import net.wg.gui.lobby.settings.feedback.damageIndicator.DamageIndicatorVehicleInfo;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DamageIndicatorsContainer extends Sprite implements IDisposable {

    private static const EMPTY_STR:String = "";

    private static const T57_58:String = "#usa_vehicles:T57_58_short";

    private static const M103:String = "#usa_vehicles:M103";

    private static const T34:String = "#usa_vehicles:T34_hvy";

    public var standartMc:MovieClip = null;

    public var extendedMc:DamageIndicatorExtended = null;

    private var _arrows:Array = null;

    private var _tfWithArrow:Array = null;

    private var _vehicles:Array = null;

    private var _isWithValue:Boolean = true;

    private var _isWithTankInfo:Boolean = true;

    private var _isInitialized:Boolean = false;

    private var _indicatorsExtendedData:Vector.<IndicatorData>;

    public function DamageIndicatorsContainer() {
        this._indicatorsExtendedData = new <IndicatorData>[new IndicatorData(DAMAGE_INDICATOR_ATLAS_ITEMS.CRIT_CIRCLE, T57_58, TANK_TYPES.HEAVY_TANK, EMPTY_STR), new IndicatorData(DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCK_CIRCLE, M103, TANK_TYPES.HEAVY_TANK, SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_BLOCKEDVALUE), new IndicatorData(DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_CIRCLE, T34, TANK_TYPES.HEAVY_TANK, SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_DAMAGEVALUE)];
        super();
        this._arrows = [this.extendedMc.critArrowMc, this.extendedMc.blockedArrowMc, this.extendedMc.damageArrowMc];
        this._tfWithArrow = [this.extendedMc.damageModuleTF, this.extendedMc.blockDamageCountTF, this.extendedMc.damageCountTF];
        this._vehicles = [this.extendedMc.critVehicleMc, this.extendedMc.blockedVehicleMc, this.extendedMc.damageVehicleMc];
    }

    public final function dispose():void {
        this._arrows.splice(0, this._arrows.length);
        this._arrows = null;
        this._vehicles.splice(0, this._vehicles.length);
        this._vehicles = null;
        this._tfWithArrow.splice(0, this._tfWithArrow.length);
        this._tfWithArrow = null;
        this._indicatorsExtendedData.splice(0, this._indicatorsExtendedData.length);
        this._indicatorsExtendedData = null;
        this.standartMc = null;
        this.extendedMc.dispose();
        this.extendedMc = null;
    }

    public function updateSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void {
        var _loc5_:Vector.<IndicatorData> = null;
        var _loc6_:uint = 0;
        var _loc7_:IndicatorData = null;
        var _loc8_:DamageIndicatorArrow = null;
        var _loc9_:DamageIndicatorVehicleInfo = null;
        var _loc10_:int = 0;
        var _loc11_:TextField = null;
        this.standartMc.visible = param1;
        this.extendedMc.visible = !param1;
        if (!param1) {
            _loc5_ = this._indicatorsExtendedData;
            _loc6_ = _loc5_.length;
            _loc10_ = 0;
            while (_loc10_ < _loc6_) {
                _loc7_ = _loc5_[_loc10_];
                _loc8_ = this._arrows[_loc10_];
                _loc11_ = this._tfWithArrow[_loc10_];
                if (param2 != this._isWithValue || !this._isInitialized) {
                    _loc8_.visible = _loc11_.visible = param2;
                    _loc8_.update(_loc7_.circle, _loc7_.itemValue);
                }
                if (param3 != this._isWithTankInfo || !this._isInitialized) {
                    _loc9_ = this._vehicles[_loc10_];
                    _loc9_.visible = param3;
                    _loc9_.update(_loc7_.tankType, _loc7_.tankName, _loc8_.circleMc.rotation > 0);
                }
                _loc10_++;
            }
            this.extendedMc.critArrowMc.visible = this.extendedMc.damageModuleTF.visible = param4 && param2;
            this.extendedMc.critBgMc.visible = this.extendedMc.critTF.visible = param4;
            this.extendedMc.critVehicleMc.visible = param4 && param3;
            this._isInitialized = true;
            this._isWithValue = param2;
            this._isWithTankInfo = param3;
        }
    }
}
}
class IndicatorData {

    public var circle:String;

    public var tankName:String;

    public var tankType:String;

    public var itemValue:String;

    function IndicatorData(param1:String = "", param2:String = "", param3:String = "", param4:String = "") {
        super();
        this.circle = param1;
        this.tankName = param2;
        this.tankType = param3;
        this.itemValue = param4;
    }
}

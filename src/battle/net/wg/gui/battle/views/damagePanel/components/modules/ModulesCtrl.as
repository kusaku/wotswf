package net.wg.gui.battle.views.damagePanel.components.modules {
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.data.constants.VehicleModules;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;

public class ModulesCtrl implements IDamagePanelItemsCtrl {

    private var engine:ModuleAssets;

    private var ammoBay:ModuleAssets;

    private var gun:ModuleAssets;

    private var turretRotator:ModuleAssets;

    private var chassis:ModuleAssets;

    private var surveyingDevice:ModuleAssets;

    private var radio:ModuleAssets;

    private var fuelTank:ModuleAssets;

    private var lastDestroyedTrack:String = "";

    private var _isDestroyed:Boolean = false;

    private var _modules:Vector.<ModuleAssets>;

    public function ModulesCtrl() {
        super();
        this.engine = new ModuleAssets(VehicleModules.ENGINE, Linkages.MODULE_ORANGE_ENGINE, Linkages.MODULE_RED_ENGINE, true, ModuleAssets.TOP_POSITION_IDX_0);
        this.ammoBay = new ModuleAssets(VehicleModules.AMMO_BAY, Linkages.MODULE_ORANGE_AMMO, Linkages.MODULE_RED_AMMO, true, ModuleAssets.TOP_POSITION_IDX_1);
        this.gun = new ModuleAssets(VehicleModules.GUN, Linkages.MODULE_ORANGE_GUN, Linkages.MODULE_RED_GUN, true, ModuleAssets.TOP_POSITION_IDX_2);
        this.turretRotator = new ModuleAssets(VehicleModules.TURRET_ROTATOR, Linkages.MODULE_ORANGE_TURRET, Linkages.MODULE_RED_TURRET, true, ModuleAssets.TOP_POSITION_IDX_3);
        this.chassis = new ModuleAssets(VehicleModules.CHASSIS, Linkages.MODULE_ORANGE_CHASSIS, Linkages.MODULE_RED_CHASSIS, false, ModuleAssets.TOP_POSITION_IDX_0);
        this.surveyingDevice = new ModuleAssets(VehicleModules.SURVEYING_DEVICE, Linkages.MODULE_ORANGE_TRIPLEX, Linkages.MODULE_RED_TRIPLEX, false, ModuleAssets.TOP_POSITION_IDX_1);
        this.radio = new ModuleAssets(VehicleModules.RADIO, Linkages.MODULE_ORANGE_RADIO, Linkages.MODULE_RED_RADIO, false, ModuleAssets.TOP_POSITION_IDX_2);
        this.fuelTank = new ModuleAssets(VehicleModules.FUEL_TANK, Linkages.MODULE_ORANGE_TANKS, Linkages.MODULE_RED_TANKS, false, ModuleAssets.TOP_POSITION_IDX_3);
        this._modules = new <ModuleAssets>[this.engine, this.ammoBay, this.gun, this.turretRotator, this.chassis, this.surveyingDevice, this.radio, this.fuelTank];
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        this.engine.dispose();
        this.engine = null;
        this.ammoBay.dispose();
        this.ammoBay = null;
        this.gun.dispose();
        this.gun = null;
        this.turretRotator.dispose();
        this.turretRotator = null;
        this.chassis.dispose();
        this.chassis = null;
        this.surveyingDevice.dispose();
        this.surveyingDevice = null;
        this.radio.dispose();
        this.radio = null;
        this.fuelTank.dispose();
        this.fuelTank = null;
        this._modules.splice(0, this._modules.length);
        this._modules = null;
    }

    public function getItemByName(param1:String):IDamagePanelClickableItem {
        App.utils.asserter.assert(VehicleModules.MODULES_LIST.indexOf(param1) >= 0, "Not valid itemName = " + param1);
        if (this.isTrack(param1)) {
            param1 = VehicleModules.CHASSIS;
        }
        var _loc2_:ModuleAssets = this[param1];
        App.utils.asserter.assertNotNull(_loc2_, "Not module with name = " + param1);
        return _loc2_;
    }

    public function getItems():Vector.<IDamagePanelClickableItem> {
        return new <IDamagePanelClickableItem>[this.engine, this.ammoBay, this.gun, this.turretRotator, this.chassis, this.surveyingDevice, this.radio, this.fuelTank];
    }

    public function reset():void {
        var _loc1_:int = this._modules.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._modules[_loc2_].state = BATTLE_ITEM_STATES.NORMAL;
            _loc2_++;
        }
    }

    public function setModuleRepairing(param1:String, param2:int, param3:int):void {
        var _loc4_:ModuleAssets = null;
        if (!this._isDestroyed) {
            _loc4_ = ModuleAssets(this.getItemByName(param1));
            if (this.isTrack(param1)) {
                if (this.lastDestroyedTrack == param1) {
                    _loc4_.setModuleRepairing(param2, param3);
                }
            }
            else {
                _loc4_.setModuleRepairing(param2, param3);
            }
        }
    }

    public function setPlaybackSpeed(param1:Number):void {
        var _loc2_:Vector.<IDamagePanelClickableItem> = null;
        var _loc3_:IDamagePanelClickableItem = null;
        if (!this._isDestroyed) {
            _loc2_ = this.getItems();
            for each(_loc3_ in _loc2_) {
                ModuleAssets(_loc3_).setPlaybackSpeed(param1);
            }
        }
    }

    public function setState(param1:String, param2:String):void {
        var _loc4_:* = false;
        var _loc5_:Boolean = false;
        if (this._isDestroyed) {
            this._isDestroyed = param2 == BATTLE_ITEM_STATES.DESTROYED;
        }
        var _loc3_:IAssetCreator = this.getItemByName(param1);
        if (this.isTrack(param1)) {
            if (param2 == BATTLE_ITEM_STATES.DESTROYED) {
                this.lastDestroyedTrack = param1;
            }
            _loc4_ = this.lastDestroyedTrack == param1;
            _loc5_ = param2 == BATTLE_ITEM_STATES.REPAIRED || param2 == BATTLE_ITEM_STATES.REPAIRED_FULL;
            if (_loc5_ && _loc4_) {
                this.lastDestroyedTrack = Values.EMPTY_STR;
            }
            if (this.lastDestroyedTrack == Values.EMPTY_STR || _loc4_) {
                _loc3_.state = param2;
            }
        }
        else {
            _loc3_.state = param2;
        }
    }

    public function get lastDestroyedTrackName():String {
        return this.lastDestroyedTrack;
    }

    public function showDestroyed():void {
        var _loc2_:IDamagePanelClickableItem = null;
        this._isDestroyed = true;
        var _loc1_:Vector.<IDamagePanelClickableItem> = this.getItems();
        for each(_loc2_ in _loc1_) {
            _loc2_.showDestroyed();
        }
    }

    private function isTrack(param1:String):Boolean {
        return param1 == VehicleModules.LEFT_TRACK || param1 == VehicleModules.RIGHT_TRACK;
    }
}
}

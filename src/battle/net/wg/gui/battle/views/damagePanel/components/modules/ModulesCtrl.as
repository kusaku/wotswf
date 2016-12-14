package net.wg.gui.battle.views.damagePanel.components.modules {
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.data.constants.VehicleModules;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;

public class ModulesCtrl implements IDamagePanelItemsCtrl {

    private var _engine:ModuleAssets;

    private var _ammoBay:ModuleAssets;

    private var _gun:ModuleAssets;

    private var _turretRotator:ModuleAssets;

    private var _chassis:ModuleAssets;

    private var _surveyingDevice:ModuleAssets;

    private var _radio:ModuleAssets;

    private var _fuelTank:ModuleAssets;

    private var _lastDestroyedTrack:String = "";

    private var _lastBrokenTrack:String = "";

    private var _destroyedTracks:Object;

    private var _isDestroyed:Boolean = false;

    private var _modules:Vector.<ModuleAssets>;

    public function ModulesCtrl() {
        super();
        this._engine = new ModuleAssets(VehicleModules.ENGINE, Linkages.MODULE_ORANGE_ENGINE, Linkages.MODULE_RED_ENGINE, true, ModuleAssets.TOP_POSITION_IDX_0);
        this._ammoBay = new ModuleAssets(VehicleModules.AMMO_BAY, Linkages.MODULE_ORANGE_AMMO, Linkages.MODULE_RED_AMMO, true, ModuleAssets.TOP_POSITION_IDX_1);
        this._gun = new ModuleAssets(VehicleModules.GUN, Linkages.MODULE_ORANGE_GUN, Linkages.MODULE_RED_GUN, true, ModuleAssets.TOP_POSITION_IDX_2);
        this._turretRotator = new ModuleAssets(VehicleModules.TURRET_ROTATOR, Linkages.MODULE_ORANGE_TURRET, Linkages.MODULE_RED_TURRET, true, ModuleAssets.TOP_POSITION_IDX_3);
        this._chassis = new ModuleAssets(VehicleModules.CHASSIS, Linkages.MODULE_ORANGE_CHASSIS, Linkages.MODULE_RED_CHASSIS, false, ModuleAssets.TOP_POSITION_IDX_0);
        this._surveyingDevice = new ModuleAssets(VehicleModules.SURVEYING_DEVICE, Linkages.MODULE_ORANGE_TRIPLEX, Linkages.MODULE_RED_TRIPLEX, false, ModuleAssets.TOP_POSITION_IDX_1);
        this._radio = new ModuleAssets(VehicleModules.RADIO, Linkages.MODULE_ORANGE_RADIO, Linkages.MODULE_RED_RADIO, false, ModuleAssets.TOP_POSITION_IDX_2);
        this._fuelTank = new ModuleAssets(VehicleModules.FUEL_TANK, Linkages.MODULE_ORANGE_TANKS, Linkages.MODULE_RED_TANKS, false, ModuleAssets.TOP_POSITION_IDX_3);
        this._modules = new <ModuleAssets>[this._engine, this._ammoBay, this._gun, this._turretRotator, this._chassis, this._surveyingDevice, this._radio, this._fuelTank];
        this._destroyedTracks = {};
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        this._engine.dispose();
        this._engine = null;
        this._ammoBay.dispose();
        this._ammoBay = null;
        this._gun.dispose();
        this._gun = null;
        this._turretRotator.dispose();
        this._turretRotator = null;
        this._chassis.dispose();
        this._chassis = null;
        this._surveyingDevice.dispose();
        this._surveyingDevice = null;
        this._radio.dispose();
        this._radio = null;
        this._fuelTank.dispose();
        this._fuelTank = null;
        this._modules.splice(0, this._modules.length);
        this._modules = null;
        this._destroyedTracks = null;
    }

    public function getItemByName(param1:String):IDamagePanelClickableItem {
        App.utils.asserter.assert(VehicleModules.MODULES_LIST.indexOf(param1) >= 0, "Not valid itemName = " + param1);
        if (this.isTrack(param1)) {
            param1 = VehicleModules.CHASSIS;
        }
        param1 = "_" + param1;
        var _loc2_:ModuleAssets = this[param1];
        App.utils.asserter.assertNotNull(_loc2_, "Not module with name = " + param1);
        return _loc2_;
    }

    public function getItems():Vector.<IDamagePanelClickableItem> {
        return new <IDamagePanelClickableItem>[this._engine, this._ammoBay, this._gun, this._turretRotator, this._chassis, this._surveyingDevice, this._radio, this._fuelTank];
    }

    public function reset():void {
        var _loc1_:int = this._modules.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._modules[_loc2_].resetModule();
            _loc2_++;
        }
        this._isDestroyed = false;
    }

    public function updateAvailableAssets():void {
        var _loc1_:int = this._modules.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            if (this._modules[_loc2_].destroyAvailability) {
                this._modules[_loc2_].state = BATTLE_ITEM_STATES.NORMAL;
                this._modules[_loc2_].resetModuleRepairing();
            }
            _loc2_++;
        }
    }

    public function setModuleRepairing(param1:String, param2:int, param3:int):void {
        var _loc4_:ModuleAssets = null;
        if (!this._isDestroyed) {
            _loc4_ = ModuleAssets(this.getItemByName(param1));
            if (this.isTrack(param1)) {
                if (this._lastDestroyedTrack == param1) {
                    _loc4_.setModuleRepairing(param2, param3);
                }
                else if (this._destroyedTracks[param1] < param3 && this._destroyedTracks[this._lastDestroyedTrack] < param3) {
                    this._lastDestroyedTrack = param1;
                    _loc4_.setModuleRepairing(param2, param3);
                }
                this._destroyedTracks[param1] = param3;
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
        if (this._isDestroyed) {
            this._isDestroyed = param2 == BATTLE_ITEM_STATES.DESTROYED;
        }
        var _loc3_:IAssetCreator = this.getItemByName(param1);
        if (this.isTrack(param1)) {
            _loc4_ = true;
            if (param2 == BATTLE_ITEM_STATES.DESTROYED) {
                this._destroyedTracks[param1] = 0;
                this._lastBrokenTrack = param1;
                this._lastDestroyedTrack = param1;
            }
            else if (param2 == BATTLE_ITEM_STATES.CRITICAL) {
                _loc4_ = this._lastDestroyedTrack == Values.EMPTY_STR;
            }
            else if (param2 == BATTLE_ITEM_STATES.REPAIRED || param2 == BATTLE_ITEM_STATES.REPAIRED_FULL) {
                this._destroyedTracks[param1] = 0;
                this._lastBrokenTrack = param1;
                if (this._lastDestroyedTrack == param1) {
                    this._lastDestroyedTrack = Values.EMPTY_STR;
                }
                else {
                    _loc4_ = false;
                }
            }
            else if (param2 == BATTLE_ITEM_STATES.NORMAL) {
                this._destroyedTracks[param1] = 0;
                this._lastBrokenTrack = Values.EMPTY_STR;
                if (this._lastDestroyedTrack == param1) {
                    this._lastDestroyedTrack = Values.EMPTY_STR;
                }
            }
            if (_loc4_) {
                _loc3_.state = param2;
            }
        }
        else {
            _loc3_.state = param2;
        }
    }

    public function get lastBrokenTrackName():String {
        return this._lastBrokenTrack;
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

    public function set hasTurretRotator(param1:Boolean):void {
        this._turretRotator.destroyAvailability = param1;
        if (!param1) {
            this._turretRotator.hideAsset();
        }
    }
}
}

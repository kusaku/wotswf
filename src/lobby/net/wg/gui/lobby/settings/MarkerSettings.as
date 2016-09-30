package net.wg.gui.lobby.settings {
import net.wg.data.constants.Errors;
import net.wg.data.constants.MarkerState;
import net.wg.data.constants.Values;
import net.wg.gui.components.common.markers.VehicleMarker;
import net.wg.gui.components.common.markers.data.VehicleMarkerVO;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.events.SettingViewEvent;
import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class MarkerSettings extends MarkerSettingsBase {

    private static const HEAVY_TANK_STR:String = "heavyTank";

    private static const T32_STR:String = "T32";

    private static const E75_STR:String = "E-75";

    private static const TIGER_STR:String = "PzKpfw VI Tiger";

    private static const KILLER_STR:String = "Killer";

    private static const ALLY_STR:String = "ally";

    private static const ENEMY_STR:String = "enemy";

    private static const FORM_STR:String = "Form";

    private static const ALT_STR:String = "Alt";

    private var __currentTab:uint = 0;

    private var _dynamicMarkersData:Object = null;

    private var _setDataInProgress:Boolean = false;

    private var _markerAllyData:VehicleMarkerVO = null;

    private var _markerEnemyData:VehicleMarkerVO = null;

    private var _markerDeadData:VehicleMarkerVO = null;

    public function MarkerSettings() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._markerAllyData = new VehicleMarkerVO({
            "vClass": HEAVY_TANK_STR,
            "vIconSource": RES_ICONS.MAPS_ICONS_LIBRARY_USA_A12_T32,
            "vType": T32_STR,
            "vLevel": 8,
            "pFullName": KILLER_STR,
            "curHealth": 1075,
            "maxHealth": 1400,
            "entityName": ALLY_STR,
            "speaking": false,
            "hunt": false,
            "entityType": ALLY_STR
        });
        this._markerEnemyData = new VehicleMarkerVO({
            "vClass": HEAVY_TANK_STR,
            "vIconSource": RES_ICONS.MAPS_ICONS_LIBRARY_GERMANY_PZVI,
            "vType": TIGER_STR,
            "vLevel": 7,
            "pFullName": KILLER_STR,
            "curHealth": 985,
            "maxHealth": 1350,
            "entityName": ENEMY_STR,
            "speaking": false,
            "hunt": false,
            "entityType": ENEMY_STR
        });
        this._markerDeadData = new VehicleMarkerVO({
            "vClass": HEAVY_TANK_STR,
            "vIconSource": RES_ICONS.MAPS_ICONS_LIBRARY_GERMANY_E_75,
            "vType": E75_STR,
            "vLevel": 9,
            "pFullName": KILLER_STR,
            "curHealth": 0,
            "maxHealth": 1920,
            "entityName": ALLY_STR,
            "speaking": false,
            "hunt": false,
            "entityType": ALLY_STR
        });
        this.initMarkers();
    }

    private function initMarkers():void {
        markerAlly.init(this._markerAllyData);
        markerAllyAlt.init(this._markerAllyData);
        markerEnemy.init(this._markerEnemyData);
        markerEnemyAlt.init(this._markerEnemyData);
        markerDead.init(this._markerDeadData);
        markerDeadAlt.init(this._markerDeadData);
        markerAlly.setMarkerState(MarkerState.STATE_NORMAL);
        markerAllyAlt.setMarkerState(MarkerState.STATE_NORMAL);
        markerEnemy.setMarkerState(MarkerState.STATE_NORMAL);
        markerEnemyAlt.setMarkerState(MarkerState.STATE_NORMAL);
        markerDead.setMarkerState(MarkerState.STATE_IMMEDIATE_DEAD);
        markerDeadAlt.setMarkerState(MarkerState.STATE_IMMEDIATE_DEAD);
        markerAllyAlt.exInfo = true;
        markerEnemyAlt.exInfo = true;
        markerDeadAlt.exInfo = true;
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc14_:int = 0;
        super.setData(param1);
        var _loc2_:String = FORM_STR;
        App.utils.data.cleanupDynamicObject(this._dynamicMarkersData);
        this._dynamicMarkersData = {};
        this._setDataInProgress = true;
        var _loc3_:SettingsMarkersForm = null;
        var _loc4_:Vector.<String> = param1.keys;
        var _loc5_:Vector.<Object> = param1.values;
        var _loc6_:int = _loc4_.length;
        var _loc7_:int = 0;
        var _loc8_:String = Values.EMPTY_STR;
        var _loc9_:String = Values.EMPTY_STR;
        var _loc10_:SettingsDataVo = null;
        var _loc11_:Vector.<String> = null;
        var _loc12_:Vector.<Object> = null;
        var _loc13_:int = 0;
        while (_loc13_ < _loc6_) {
            _loc8_ = _loc4_[_loc13_];
            _loc10_ = _loc5_[_loc13_] as SettingsDataVo;
            App.utils.asserter.assertNotNull(_loc10_, "values[i] must be SettingsDataVo");
            if (this[_loc8_ + _loc2_]) {
                _loc3_ = SettingsMarkersForm(this[_loc8_ + _loc2_]);
                _loc3_.setData(_loc8_, _loc10_);
                _loc3_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormOnControlChangeHandler);
            }
            _loc11_ = _loc10_.keys;
            _loc12_ = _loc10_.values;
            _loc7_ = _loc11_.length;
            _loc14_ = 0;
            while (_loc14_ < _loc7_) {
                _loc9_ = _loc11_[_loc14_];
                if (!this._dynamicMarkersData.hasOwnProperty(_loc8_)) {
                    this._dynamicMarkersData[_loc8_] = {};
                }
                App.utils.asserter.assertNotNull(_loc10_, "ViewData[formID] " + Errors.CANT_NULL);
                this._dynamicMarkersData[_loc8_][_loc9_] = SettingsControlProp(_loc12_[_loc14_]).current;
                _loc14_++;
            }
            _loc13_++;
        }
        this._setDataInProgress = false;
        tabs.dataProvider = new DataProvider(SettingsConfigHelper.instance.markerTabsDataProvider);
        tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        tabs.selectedIndex = this.__currentTab;
    }

    private function onFormOnControlChangeHandler(param1:SettingsSubVewEvent):void {
        if (this._setDataInProgress) {
            return;
        }
        var _loc2_:String = param1.subViewId;
        var _loc3_:String = param1.controlId;
        var _loc4_:Object = {};
        _loc4_[_loc3_] = param1.controlValue;
        if (this._dynamicMarkersData != null) {
            this._dynamicMarkersData[_loc2_][param1.controlId] = param1.controlValue;
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc2_, _loc4_));
        this.updateShowContent();
    }

    override public function updateDependentData():void {
        this.updateShowContent();
    }

    override protected function onBeforeDispose():void {
        tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        enemyForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormOnControlChangeHandler);
        allyForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormOnControlChangeHandler);
        deadForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormOnControlChangeHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._dynamicMarkersData = App.utils.data.cleanupDynamicObject(this._dynamicMarkersData);
        this._dynamicMarkersData = null;
        this._markerAllyData.dispose();
        this._markerAllyData = null;
        this._markerEnemyData.dispose();
        this._markerEnemyData = null;
        this._markerDeadData.dispose();
        this._markerDeadData = null;
        super.onDispose();
    }

    override public function toString():String {
        return "[WG MarkerSettings " + name + "]";
    }

    private function onTabIndexChangeHandler(param1:IndexEvent):void {
        this.__currentTab = param1.index;
        this.updateShowContent();
    }

    private function updateShowContent():void {
        var _loc1_:int = SettingsConfigHelper.instance.markerTabsDataProvider.length;
        var _loc2_:Object = null;
        var _loc3_:String = Values.EMPTY_STR;
        var _loc4_:String = Values.EMPTY_STR;
        var _loc5_:String = Values.EMPTY_STR;
        var _loc6_:Number = Values.DEFAULT_ALPHA;
        var _loc7_:SettingsMarkersForm = null;
        var _loc8_:VehicleMarker = null;
        var _loc9_:VehicleMarker = null;
        var _loc10_:* = false;
        var _loc11_:Number = 0;
        while (_loc11_ < _loc1_) {
            _loc2_ = SettingsConfigHelper.instance.markerTabsDataProvider[_loc11_];
            _loc3_ = _loc2_.formID;
            _loc4_ = _loc2_.markerID;
            _loc5_ = _loc2_.id;
            _loc6_ = _loc2_.markerFlag;
            _loc10_ = this.__currentTab == _loc11_;
            if (this[_loc3_]) {
                _loc7_ = SettingsMarkersForm(this[_loc3_]);
                _loc7_.visible = _loc10_;
            }
            if (this[_loc4_]) {
                _loc8_ = VehicleMarker(this[_loc4_]);
                _loc8_.visible = _loc10_;
                _loc8_.markerSettings = this._dynamicMarkersData[_loc5_];
                _loc8_.settingsUpdate(_loc6_);
            }
            if (this[_loc4_ + ALT_STR]) {
                _loc9_ = VehicleMarker(this[_loc4_ + ALT_STR]);
                _loc9_.visible = _loc10_;
                _loc9_.markerSettings = this._dynamicMarkersData[_loc5_];
                _loc9_.settingsUpdate(_loc6_);
            }
            _loc11_++;
        }
        bg.gotoAndStop(SettingsConfigHelper.instance.markerTabsDataProvider[this.__currentTab].id);
    }
}
}

package net.wg.gui.settings {
import flash.display.MovieClip;

import net.wg.data.constants.Errors;
import net.wg.data.constants.MarkerState;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.common.VehicleMarkerAlly;
import net.wg.gui.components.common.VehicleMarkerEnemy;
import net.wg.gui.components.common.markers.VehicleMarker;
import net.wg.gui.components.common.markers.data.VehicleMarkerVO;
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.gui.settings.evnts.SettingViewEvent;
import net.wg.gui.settings.evnts.SettingsSubVewEvent;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class MarkerSettings extends SettingsBaseView {

    public var tabs:ButtonBarEx = null;

    public var bg:MovieClip = null;

    public var enemyForm:SettingsMarkersForm = null;

    public var allyForm:SettingsMarkersForm = null;

    public var deadForm:SettingsMarkersForm = null;

    public var markerEnemy:VehicleMarkerEnemy = null;

    public var markerEnemyAlt:VehicleMarkerEnemy = null;

    public var markerAlly:VehicleMarkerAlly = null;

    public var markerAllyAlt:VehicleMarkerAlly = null;

    public var markerDead:VehicleMarkerAlly = null;

    public var markerDeadAlt:VehicleMarkerAlly = null;

    private const FORM:String = "Form";

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
            "vClass": "heavyTank",
            "vIconSource": RES_ICONS.MAPS_ICONS_LIBRARY_USA_A12_T32,
            "vType": "T32",
            "vLevel": 8,
            "pFullName": "Killer",
            "curHealth": 1075,
            "maxHealth": 1400,
            "entityName": "ally",
            "speaking": false,
            "hunt": false,
            "entityType": "ally"
        });
        this._markerEnemyData = new VehicleMarkerVO({
            "vClass": "heavyTank",
            "vIconSource": RES_ICONS.MAPS_ICONS_LIBRARY_GERMANY_PZVI,
            "vType": "PzKpfw VI Tiger",
            "vLevel": 7,
            "pFullName": "Killer",
            "curHealth": 985,
            "maxHealth": 1350,
            "entityName": "enemy",
            "speaking": false,
            "hunt": false,
            "entityType": "enemy"
        });
        this._markerDeadData = new VehicleMarkerVO({
            "vClass": "heavyTank",
            "vIconSource": RES_ICONS.MAPS_ICONS_LIBRARY_GERMANY_E_75,
            "vType": "E-75",
            "vLevel": 9,
            "pFullName": "Killer",
            "curHealth": 0,
            "maxHealth": 1920,
            "entityName": "ally",
            "speaking": false,
            "hunt": false,
            "entityType": "ally"
        });
        this.initMarkers();
    }

    private function initMarkers():void {
        this.markerAlly.init(this._markerAllyData);
        this.markerAllyAlt.init(this._markerAllyData);
        this.markerEnemy.init(this._markerEnemyData);
        this.markerEnemyAlt.init(this._markerEnemyData);
        this.markerDead.init(this._markerDeadData);
        this.markerDeadAlt.init(this._markerDeadData);
        this.markerAlly.setMarkerState(MarkerState.STATE_NORMAL);
        this.markerAllyAlt.setMarkerState(MarkerState.STATE_NORMAL);
        this.markerEnemy.setMarkerState(MarkerState.STATE_NORMAL);
        this.markerEnemyAlt.setMarkerState(MarkerState.STATE_NORMAL);
        this.markerDead.setMarkerState(MarkerState.STATE_IMMEDIATE_DEAD);
        this.markerDeadAlt.setMarkerState(MarkerState.STATE_IMMEDIATE_DEAD);
        this.markerAllyAlt.exInfo = true;
        this.markerEnemyAlt.exInfo = true;
        this.markerDeadAlt.exInfo = true;
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc14_:int = 0;
        super.setData(param1);
        var _loc2_:String = "Form";
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
            if (this[_loc8_ + _loc2_]) {
                _loc3_ = SettingsMarkersForm(this[_loc8_ + _loc2_]);
                _loc3_.setData(_loc8_, _loc10_);
                _loc3_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChangeHandler);
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
        this.tabs.dataProvider = new DataProvider(SettingsConfigHelper.instance.markerTabsDataProvider);
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        this.tabs.selectedIndex = this.__currentTab;
    }

    private function onControlChangeHandler(param1:SettingsSubVewEvent):void {
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
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc2_, _loc4_));
        this.updateShowContent();
    }

    override public function updateDependentData():void {
        this.updateShowContent();
    }

    override protected function onDispose():void {
        this.removeListeners();
        this.disposeMarkers();
        this.enemyForm.dispose();
        this.allyForm.dispose();
        this.deadForm.dispose();
        this._dynamicMarkersData = App.utils.data.cleanupDynamicObject(this._dynamicMarkersData);
        this._markerAllyData.dispose();
        this._markerAllyData = null;
        this._markerEnemyData.dispose();
        this._markerEnemyData = null;
        this._markerDeadData.dispose();
        this._markerDeadData = null;
        this.tabs.dispose();
        this.tabs = null;
        this.bg = null;
        super.onDispose();
    }

    private function removeListeners():void {
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        this.enemyForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChangeHandler);
        this.allyForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChangeHandler);
        this.deadForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChangeHandler);
    }

    private function disposeMarkers():void {
        this.markerEnemy.dispose();
        this.markerEnemy = null;
        this.markerEnemyAlt.dispose();
        this.markerEnemyAlt = null;
        this.markerAlly.dispose();
        this.markerAlly = null;
        this.markerAllyAlt.dispose();
        this.markerAllyAlt = null;
        this.markerDead.dispose();
        this.markerDead = null;
        this.markerDeadAlt.dispose();
        this.markerDeadAlt = null;
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
            if (this[_loc4_ + "Alt"]) {
                _loc9_ = VehicleMarker(this[_loc4_ + "Alt"]);
                _loc9_.visible = _loc10_;
                _loc9_.markerSettings = this._dynamicMarkersData[_loc5_];
                _loc9_.settingsUpdate(_loc6_);
            }
            _loc11_++;
        }
        this.bg.gotoAndStop(SettingsConfigHelper.instance.markerTabsDataProvider[this.__currentTab].id);
    }
}
}

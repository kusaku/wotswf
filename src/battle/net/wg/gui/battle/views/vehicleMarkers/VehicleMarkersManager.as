package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.Graphics;
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.Values;
import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerSettings;
import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
import net.wg.gui.utils.RootSWFAtlasManager;
import net.wg.infrastructure.base.meta.IVehicleMarkersManagerMeta;
import net.wg.infrastructure.base.meta.impl.VehicleMarkersManagerMeta;
import net.wg.infrastructure.events.AtlasEvent;

public class VehicleMarkersManager extends VehicleMarkersManagerMeta implements IVehicleMarkersManagerMeta {

    public static var sInstance:VehicleMarkersManager = null;

    private var _showExInfo:Boolean = false;

    private var _isColorBlind:Boolean = false;

    private var _markerSettings:Object;

    private var _defaultSchemes:Object = null;

    private var _colorBlindSchemes:Object = null;

    private var _currentSchemes:Object = null;

    private var _splashDuration:int = 1000;

    private var _atlasManager:RootSWFAtlasManager;

    private var _markersCallback:Array;

    public var isAtlasInited:Boolean;

    public function VehicleMarkersManager() {
        this._markerSettings = {
            "ally": new VehicleMarkerSettings(),
            "enemy": new VehicleMarkerSettings(),
            "dead": new VehicleMarkerSettings()
        };
        super();
        sInstance = this;
        this._atlasManager = RootSWFAtlasManager.instance;
        this._atlasManager.addEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitialized);
        this._atlasManager.initAtlas(AtlasConstants.VEHICLE_MARKERS_ATLAS);
        this._markersCallback = [];
        addEventListener(Event.ENTER_FRAME, this.callExternalInterface);
    }

    public static function getInstance():VehicleMarkersManager {
        if (sInstance == null) {
            sInstance = new VehicleMarkersManager();
        }
        return sInstance;
    }

    private function onAtlasInitialized(param1:AtlasEvent):void {
        var _loc2_:IMarkerManagerHandler = null;
        if (this._atlasManager.isAtlasInitialized(AtlasConstants.VEHICLE_MARKERS_ATLAS)) {
            this.isAtlasInited = true;
            this._atlasManager.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitialized);
            while (this._markersCallback.length > 0) {
                _loc2_ = this._markersCallback.shift();
                _loc2_.managerReadyHandler();
            }
        }
    }

    public function addReadyHandler(param1:IMarkerManagerHandler):void {
        if (this._markersCallback.indexOf(param1) == -1) {
            this._markersCallback.push(param1);
        }
    }

    public function drawGraphics(param1:String, param2:Graphics, param3:Point = null):void {
        this._atlasManager.drawGraphics(AtlasConstants.VEHICLE_MARKERS_ATLAS, param1, param2, param3);
    }

    public function drawWithCenterAlign(param1:String, param2:Graphics, param3:Boolean, param4:Boolean, param5:int = 0, param6:int = 0):void {
        this._atlasManager.drawWithCenterAlign(AtlasConstants.VEHICLE_MARKERS_ATLAS, param1, param2, param3, param4, param5, param6);
    }

    public function getAtlasItemBounds(param1:String):Rectangle {
        return this._atlasManager.getAtlasItemBounds(AtlasConstants.VEHICLE_MARKERS_ATLAS, param1);
    }

    override protected function onDispose():void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        this._markerSettings = null;
        this._defaultSchemes = null;
        this._colorBlindSchemes = null;
        this._currentSchemes = null;
        RootSWFAtlasManager.instance.dispose();
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function onPopulate():void {
        super.onPopulate();
    }

    public function as_setColorBlind(param1:Boolean):void {
        this._isColorBlind = param1;
        this._currentSchemes = !!this._isColorBlind ? this._colorBlindSchemes : this._defaultSchemes;
        dispatchEvent(new VehicleMarkersManagerEvent(VehicleMarkersManagerEvent.UPDATE_COLORS));
    }

    public function as_setColorSchemes(param1:Object, param2:Object):void {
        this._defaultSchemes = param1;
        this._colorBlindSchemes = param2;
    }

    public function as_setMarkerDuration(param1:int):void {
        this._splashDuration = param1;
    }

    public function as_setMarkerSettings(param1:Object):void {
        this._markerSettings = param1;
    }

    public function as_setShowExInfoFlag(param1:Boolean):void {
        if (param1 == this._showExInfo) {
            return;
        }
        this._showExInfo = param1;
        dispatchEvent(new VehicleMarkersManagerEvent(VehicleMarkersManagerEvent.SHOW_EX_INFO));
    }

    public function as_updateMarkersSettings():void {
        dispatchEvent(new VehicleMarkersManagerEvent(VehicleMarkersManagerEvent.UPDATE_SETTINGS));
    }

    public function getAliasColor(param1:String):String {
        if (this._currentSchemes == null) {
            return Values.EMPTY_STR;
        }
        if (this._currentSchemes.hasOwnProperty(param1)) {
            return this._currentSchemes[param1].alias_color;
        }
        return Values.EMPTY_STR;
    }

    public function getRGB(param1:String):uint {
        var _loc2_:Array = null;
        if (this._currentSchemes == null) {
            return 0;
        }
        if (this._currentSchemes.hasOwnProperty(param1)) {
            _loc2_ = this._currentSchemes[param1].rgba;
            return (_loc2_[0] << 16) + (_loc2_[1] << 8) + (_loc2_[2] << 0);
        }
        return 0;
    }

    public function getTransform(param1:String):ColorTransform {
        var _loc2_:Array = null;
        var _loc3_:Array = null;
        if (this._currentSchemes == null) {
            return null;
        }
        if (this._currentSchemes.hasOwnProperty(param1)) {
            _loc2_ = this._currentSchemes[param1].transform.mult;
            _loc3_ = this._currentSchemes[param1].transform.offset;
            return new ColorTransform(_loc2_[0], _loc2_[1], _loc2_[2], _loc2_[3], _loc3_[0], _loc3_[1], _loc3_[2], _loc3_[3]);
        }
        return null;
    }

    public function get showExInfo():Boolean {
        return this._showExInfo;
    }

    public function get markerSettings():Object {
        return this._markerSettings;
    }

    public function get splashDuration():int {
        return this._splashDuration;
    }

    private function callExternalInterface(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        ExternalInterface.call("registerMarkersManager");
    }

    public function get isColorBlind():Boolean {
        return this._isColorBlind;
    }
}
}

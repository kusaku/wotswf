package net.wg.gui.lobby.fortifications.cmp.build.impl {
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IFortBuilding;
import net.wg.gui.fortBase.IFortBuildingsContainer;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.core.UIComponent;

public class FortBuildingsContainer extends UIComponent implements IFortBuildingsContainer {

    public var baseBuilding:IFortBuilding = null;

    public var building1:IFortBuilding = null;

    public var building2:IFortBuilding = null;

    public var building3:IFortBuilding = null;

    public var building4:IFortBuilding = null;

    public var building5:IFortBuilding = null;

    public var building6:IFortBuilding = null;

    public var building7:IFortBuilding = null;

    public var building8:IFortBuilding = null;

    private var _buildings:Vector.<IFortBuilding> = null;

    private var _helper:FortBuildingsContainerHelper;

    public function FortBuildingsContainer() {
        var _loc1_:IFortBuilding = null;
        super();
        this._buildings = new <IFortBuilding>[this.baseBuilding, this.building1, this.building2, this.building3, this.building4, this.building5, this.building6, this.building7, this.building8];
        this._helper = new FortBuildingsContainerHelper(this._buildings);
        for each(_loc1_ in this._buildings) {
            _loc1_.visible = false;
        }
        addEventListener(FortBuildingEvent.BUILDING_SELECTED, this.onBuildingSelectedHandler);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        removeEventListener(FortBuildingEvent.BUILDING_SELECTED, this.onBuildingSelectedHandler);
        for each(_loc1_ in this._buildings) {
            _loc1_.dispose();
        }
        this._buildings.splice(0, this._buildings.length);
        this._buildings = null;
        this.baseBuilding = null;
        this.building1 = null;
        this.building2 = null;
        this.building3 = null;
        this.building4 = null;
        this.building5 = null;
        this.building6 = null;
        this.building7 = null;
        this.building8 = null;
        super.onDispose();
    }

    public function setBuildingData(param1:IBuildingVO, param2:Boolean):void {
        var _loc3_:IFortBuilding = null;
        for each(_loc3_ in this._buildings) {
            if (_loc3_.uid == param1.uid) {
                _loc3_.userCanAddBuilding = param2;
                _loc3_.setData(param1);
                break;
            }
        }
    }

    public function update(param1:Vector.<IBuildingVO>, param2:Boolean):void {
        this._helper.updateBuildings(param1, param2);
    }

    public function updateCommonMode(param1:IFortModeVO):void {
        var _loc2_:IFortBuilding = null;
        for each(_loc2_ in this._buildings) {
            _loc2_.updateCommonMode(param1);
        }
    }

    public function updateDirectionsMode(param1:IFortModeVO):void {
        var _loc2_:IFortBuilding = null;
        for each(_loc2_ in this._buildings) {
            _loc2_.updateDirectionsMode(param1);
        }
    }

    public function get buildings():Vector.<IFortBuilding> {
        return this._buildings;
    }

    private function onBuildingSelectedHandler(param1:FortBuildingEvent):void {
        var _loc3_:IFortBuilding = null;
        var _loc2_:String = IFortBuilding(param1.target).uid;
        for each(_loc3_ in this._buildings) {
            if (_loc3_.uid != _loc2_ && _loc3_.selected) {
                _loc3_.forceSelected = false;
            }
            else if (_loc3_.uid == _loc2_) {
                _loc3_.forceSelected = param1.isOpenedCtxMenu || !_loc3_.selected;
            }
        }
    }
}
}

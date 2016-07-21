package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.InteractiveObject;
import flash.geom.Point;

import net.wg.data.constants.Linkages;
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IBuildingsComponentVO;
import net.wg.gui.fortBase.IFortBuilding;
import net.wg.gui.fortBase.IFortBuildingsContainer;
import net.wg.gui.fortBase.IFortDirectionsContainer;
import net.wg.gui.fortBase.IFortLandscapeCmp;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.fortBase.events.FortInitEvent;
import net.wg.gui.lobby.fortifications.data.BuildingVO;
import net.wg.gui.lobby.fortifications.data.BuildingsComponentVO;
import net.wg.gui.lobby.fortifications.data.FunctionalStates;
import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
import net.wg.gui.lobby.fortifications.utils.ITransportingHelper;
import net.wg.gui.lobby.profile.components.SimpleLoader;
import net.wg.infrastructure.base.meta.impl.FortBuildingComponentMeta;
import net.wg.infrastructure.events.IconLoaderEvent;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public class FortLandscapeCmpnt extends FortBuildingComponentMeta implements IFortLandscapeCmp {

    private static const DEFAULT_LANDSCAPE_WIDTH:int = 1600;

    private static const INVISIBLE_BACKGROUND_ALPHA:Number = 0.4;

    public var shadowMC:IUIComponentEx = null;

    public var bgFore:IUIComponentEx = null;

    private var _landscapeBG:SimpleLoader = null;

    private var _directionsContainer:IFortDirectionsContainer = null;

    private var _buildingContainer:IFortBuildingsContainer = null;

    private var _model:IBuildingsComponentVO = null;

    private var _transportingHelper:ITransportingHelper = null;

    public function FortLandscapeCmpnt() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._buildingContainer.addEventListener(FortBuildingEvent.BUY_BUILDINGS, this.onBuildingContainerBuyBuildingsHandler);
        this._buildingContainer.addEventListener(FortBuildingEvent.BUILDING_SELECTED, this.onBuildingContainerBuildingSelectedHandler);
        this.shadowMC.mouseChildren = false;
        this.shadowMC.mouseEnabled = false;
        this._landscapeBG.addEventListener(IconLoaderEvent.ICON_LOADED, this.onLandscapeBGIconLoadedHandler);
        this._landscapeBG.addEventListener(IconLoaderEvent.ICON_LOADING_FAILED, this.onLandscapeBGIconLoadingFailedHandler);
        this._landscapeBG.setSource(RES_FORT.MAPS_FORT_FORTLANDSCAPE);
    }

    override protected function setData(param1:BuildingsComponentVO):void {
        this._model = param1;
        var _loc2_:Vector.<IBuildingVO> = this._model.buildingData;
        this._buildingContainer.update(_loc2_, this._model.canAddBuilding);
        this._directionsContainer.update(_loc2_);
    }

    override protected function setBuildingData(param1:BuildingVO):void {
        this._buildingContainer.setBuildingData(param1, this._model.canAddBuilding);
    }

    override protected function onPopulate():void {
        var _loc1_:IFortBuilding = null;
        super.onPopulate();
        for each(_loc1_ in this._buildingContainer.buildings) {
            _loc1_.toolTipDataProvider = this;
        }
    }

    override protected function onDispose():void {
        if (this._transportingHelper) {
            this._transportingHelper.dispose();
            this._transportingHelper = null;
        }
        this._directionsContainer.dispose();
        this._directionsContainer = null;
        this._model = null;
        this._buildingContainer.removeEventListener(FortBuildingEvent.BUY_BUILDINGS, this.onBuildingContainerBuyBuildingsHandler);
        this._buildingContainer.removeEventListener(FortBuildingEvent.BUILDING_SELECTED, this.onBuildingContainerBuildingSelectedHandler);
        this._buildingContainer.dispose();
        this._buildingContainer = null;
        this._landscapeBG.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onLandscapeBGIconLoadedHandler);
        this._landscapeBG.removeEventListener(IconLoaderEvent.ICON_LOADING_FAILED, this.onLandscapeBGIconLoadingFailedHandler);
        this._landscapeBG.dispose();
        this._landscapeBG = null;
        this.shadowMC.dispose();
        this.shadowMC = null;
        this.bgFore.dispose();
        this.bgFore = null;
        super.onDispose();
    }

    public function as_refreshTransporting():void {
        this._transportingHelper.updateTransportMode(this._transportingHelper.getModeVO(false, false));
        this._transportingHelper.updateTransportMode(this._transportingHelper.getModeVO(true, false));
    }

    public function as_setBuildingToolTipData(param1:String, param2:String, param3:String, param4:String):void {
        var _loc5_:IFortBuilding = null;
        for each(_loc5_ in this._buildingContainer.buildings) {
            if (_loc5_.uid == param1) {
                _loc5_.setToolTipData(param2, param3, param4);
                break;
            }
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this._directionsContainer.getComponentForFocus();
    }

    public function onStartExporting():void {
        dispatchEvent(new FortBuildingEvent(FortBuildingEvent.FIRST_TRANSPORTING_STEP));
    }

    public function onStartImporting():void {
        dispatchEvent(new FortBuildingEvent(FortBuildingEvent.NEXT_TRANSPORTING_STEP));
    }

    public function onTransportingSuccess(param1:IFortBuilding, param2:IFortBuilding):void {
        onTransportingRequestS(param1.uid, param2.uid);
    }

    public function requestToolTipDataForBuilding(param1:String, param2:String):void {
        requestBuildingToolTipDataS(param1, param2);
    }

    public function setInitialData(param1:IBuildingsComponentVO):void {
        var _loc2_:Vector.<IBuildingVO> = param1.buildingData;
        this._buildingContainer.update(_loc2_, param1.canAddBuilding);
        this._directionsContainer.update(_loc2_);
    }

    public function updateCommonMode(param1:IFortModeVO):void {
        this._buildingContainer.updateCommonMode(param1);
    }

    public function updateControlPositions():void {
        this.bgFore.x = globalToLocal(new Point(0, 0)).x;
        this.bgFore.y = -y;
        this.bgFore.setActualSize(App.appWidth, App.appHeight);
        var _loc1_:Number = globalToLocal(new Point(0, 0)).x;
        this.shadowMC.x = this._landscapeBG.x = (App.appWidth - DEFAULT_LANDSCAPE_WIDTH >> 1) + _loc1_ ^ 0;
    }

    public function updateDirectionsMode(param1:IFortModeVO):void {
        this._directionsContainer.updateDirectionsMode(param1);
        this._buildingContainer.updateDirectionsMode(param1);
        this.toggleBackground(param1.isEntering);
    }

    public function updateTransportMode(param1:IFortModeVO):void {
        var _loc2_:Class = null;
        if (!param1.isTutorial && param1.currentMode != FunctionalStates.TRANSPORTING_NEXT_STEP || param1.isTutorial && param1.currentMode == FunctionalStates.TRANSPORTING_TUTORIAL_FIRST_STEP) {
            this._directionsContainer.updateTransportMode(param1);
            if (param1.isEntering && this._transportingHelper == null) {
                _loc2_ = App.utils.classFactory.getClass(Linkages.TRANSPORTING_HELPER);
                this._transportingHelper = ITransportingHelper(new _loc2_(this._buildingContainer.buildings, this));
            }
            if (this._transportingHelper != null) {
                this._transportingHelper.updateTransportMode(param1);
                this.toggleBackground(param1.isEntering);
            }
        }
    }

    private function toggleBackground(param1:Boolean):void {
        this._landscapeBG.alpha = !!param1 ? Number(INVISIBLE_BACKGROUND_ALPHA) : Number(1);
    }

    public function get buildingContainer():IFortBuildingsContainer {
        return this._buildingContainer;
    }

    public function set buildingContainer(param1:IFortBuildingsContainer):void {
        this._buildingContainer = param1;
    }

    public function get directionsContainer():IFortDirectionsContainer {
        return this._directionsContainer;
    }

    public function set directionsContainer(param1:IFortDirectionsContainer):void {
        this._directionsContainer = param1;
    }

    public function get landscapeBG():SimpleLoader {
        return this._landscapeBG;
    }

    public function set landscapeBG(param1:SimpleLoader):void {
        this._landscapeBG = param1;
    }

    private function onLandscapeBGIconLoadingFailedHandler(param1:IconLoaderEvent):void {
        dispatchEvent(new FortInitEvent(FortInitEvent.LANDSCAPE_LOADING_COMPLETE));
    }

    private function onLandscapeBGIconLoadedHandler(param1:IconLoaderEvent):void {
        dispatchEvent(new FortInitEvent(FortInitEvent.LANDSCAPE_LOADING_COMPLETE));
    }

    private function onBuildingContainerBuildingSelectedHandler(param1:FortBuildingEvent):void {
        if (param1.uid) {
            upgradeVisitedBuildingS(param1.uid);
        }
    }

    private function onBuildingContainerBuyBuildingsHandler(param1:FortBuildingEvent):void {
        requestBuildingProcessS(param1.direction, param1.position);
    }
}
}

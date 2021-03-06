package net.wg.gui.lobby.vehicleCompare {
import flash.display.BitmapData;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.events.LobbyEvent;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareMainPanel;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTopPanel;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehParamsListDataProvider;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareDataProvider;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareStaticDataVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareScrollEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehicleRendererEvent;
import net.wg.gui.lobby.vehicleCompare.interfaces.IMainPanel;
import net.wg.gui.lobby.vehicleCompare.interfaces.ITopPanel;
import net.wg.gui.lobby.vehicleCompare.interfaces.IVehCompareViewHeader;
import net.wg.infrastructure.base.meta.IVehicleCompareViewMeta;
import net.wg.infrastructure.base.meta.impl.VehicleCompareViewMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.InputEvent;
import scaleform.clik.interfaces.IDataProvider;

public class VehicleCompareView extends VehicleCompareViewMeta implements IVehicleCompareViewMeta {

    private static const TOP_PANEL_HEIGHT:int = 162;

    private static const BOTTOM_PANEL_HEIGHT:int = 36;

    private static const DELTA_DATA_INV:String = "DeltaDataInv";

    public var header:IVehCompareViewHeader = null;

    public var topPanel:ITopPanel = null;

    public var mainPanel:IMainPanel = null;

    public var background:Sprite = null;

    private var _bgBitmapData:BitmapData;

    private var _vehicleParamsData:IDataProvider = null;

    private var _vehiclesDP:IDataProvider = null;

    private var _vehParamsDeltaData:VehCompareParamsDeltaVO = null;

    public function VehicleCompareView() {
        super();
        var _loc1_:Class = App.utils.classFactory.getClass(Linkages.VEH_CMP_WINDOW_BG_UI);
        this._bgBitmapData = new _loc1_();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        setSize(param1, param2);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        var _loc2_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.header.backBtn), InteractiveObject(this.header.closeBtn)];
        App.utils.commons.initTabIndex(_loc2_);
        setFocus(_loc2_[0]);
        _loc2_.splice(0, _loc2_.length);
    }

    override protected function setStaticData(param1:VehCompareStaticDataVO):void {
        this.header.update(param1.header);
    }

    override protected function configUI():void {
        super.configUI();
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
        addEventListener(VehCompareEvent.CLOSE_CLICK, this.onCloseClickHandler);
        addEventListener(VehCompareEvent.BACK_CLICK, this.onBackClickHandler);
        addEventListener(VehCompareVehParamRendererEvent.PARAM_MOUSE_OVER, this.onParamMouseOverHandler);
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.onEscapeKeyUpHandler, true);
        this.mainPanel.addEventListener(VehCompareScrollEvent.SCROLL_CHANGED, this.onMainPanelScrollChangedHandler);
        this.mainPanel.addEventListener(VehCompareVehicleRendererEvent.GO_TO_PREVIEW_CLICK, this.onPanelGoToPreviewClickHandler);
        this.mainPanel.addEventListener(VehCompareVehicleRendererEvent.GO_TO_HANGAR_CLICK, this.onPanelGoToHangarClickHandler);
        this.topPanel.addEventListener(VehCompareScrollEvent.SCROLL_CHANGED, this.onTopPanelScrollChangedHandler);
        this.topPanel.addEventListener(VehCompareVehicleRendererEvent.CREW_LEVEL_CHANGED, this.onTopPanelCrewLevelChangedHandler);
        this.topPanel.addEventListener(VehCompareVehicleRendererEvent.MODULES_CLICK, this.onTopPanelModulesClickHandler);
        this.topPanel.addEventListener(VehCompareVehicleRendererEvent.REMOVE_CLICK, this.onTopPanelRemoveClickHandler);
        this.topPanel.addEventListener(VehCompareVehicleRendererEvent.RIGHT_CLICK, this.onTopPanelRightClickHandler);
        this.topPanel.addEventListener(VehCompareEvent.REMOVE_ALL_CLICK, this.onTopPanelRemoveAllClickHandler);
        this.topPanel.addEventListener(VehCompareVehicleRendererEvent.GO_TO_PREVIEW_CLICK, this.onPanelGoToPreviewClickHandler);
        this.topPanel.addEventListener(VehCompareVehicleRendererEvent.GO_TO_HANGAR_CLICK, this.onPanelGoToHangarClickHandler);
    }

    override protected function onDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
        removeEventListener(VehCompareEvent.CLOSE_CLICK, this.onCloseClickHandler);
        removeEventListener(VehCompareEvent.BACK_CLICK, this.onBackClickHandler);
        removeEventListener(VehCompareVehParamRendererEvent.PARAM_MOUSE_OVER, this.onParamMouseOverHandler);
        this.header.dispose();
        this.header = null;
        this.topPanel.removeEventListener(VehCompareVehicleRendererEvent.MODULES_CLICK, this.onTopPanelModulesClickHandler);
        this.topPanel.removeEventListener(VehCompareVehicleRendererEvent.CREW_LEVEL_CHANGED, this.onTopPanelCrewLevelChangedHandler);
        this.topPanel.removeEventListener(VehCompareScrollEvent.SCROLL_CHANGED, this.onTopPanelScrollChangedHandler);
        this.topPanel.removeEventListener(VehCompareVehicleRendererEvent.REMOVE_CLICK, this.onTopPanelRemoveClickHandler);
        this.topPanel.removeEventListener(VehCompareEvent.REMOVE_ALL_CLICK, this.onTopPanelRemoveAllClickHandler);
        this.topPanel.removeEventListener(VehCompareVehicleRendererEvent.RIGHT_CLICK, this.onTopPanelRightClickHandler);
        this.topPanel.dispose();
        this.topPanel = null;
        this.mainPanel.removeEventListener(VehCompareScrollEvent.SCROLL_CHANGED, this.onMainPanelScrollChangedHandler);
        this.mainPanel.removeEventListener(VehCompareVehicleRendererEvent.GO_TO_PREVIEW_CLICK, this.onPanelGoToPreviewClickHandler);
        this.mainPanel.removeEventListener(VehCompareVehicleRendererEvent.GO_TO_HANGAR_CLICK, this.onPanelGoToHangarClickHandler);
        this.mainPanel.dispose();
        this.mainPanel = null;
        this.background = null;
        this._vehiclesDP.cleanUp();
        this._vehiclesDP = null;
        if (this._vehicleParamsData) {
            this._vehicleParamsData.cleanUp();
            this._vehicleParamsData = null;
        }
        this._bgBitmapData.dispose();
        this._bgBitmapData = null;
        this._vehParamsDeltaData = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.header.width = width;
            this.topPanel.width = width;
            this.topPanel.height = height;
            this.mainPanel.width = width;
            this.mainPanel.y = this.topPanel.y + TOP_PANEL_HEIGHT;
            this.mainPanel.height = height - this.mainPanel.y;
            this.updateBgSize();
        }
        if (isInvalid(InvalidationType.DATA)) {
            if (this._vehicleParamsData) {
                this.mainPanel.setVehicleParams(this._vehicleParamsData);
                if (this._vehiclesDP) {
                    VehCompareDataProvider(this._vehiclesDP).setVehParamsDP(this._vehicleParamsData);
                }
            }
        }
        if (this._vehParamsDeltaData && isInvalid(DELTA_DATA_INV)) {
            this.mainPanel.setParamsDelta(this._vehParamsDeltaData);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this._vehiclesDP = new VehCompareDataProvider(VehCompareVehicleVO);
        this.topPanel.setVehiclesData(this._vehiclesDP);
        this.mainPanel.setVehiclesData(this._vehiclesDP);
    }

    override protected function setParamsDelta(param1:VehCompareParamsDeltaVO):void {
        this._vehParamsDeltaData = param1;
        invalidate(DELTA_DATA_INV);
    }

    public function as_getVehiclesDP():Object {
        return this._vehiclesDP;
    }

    public function as_setAttentionVisible(param1:Boolean):void {
        this.topPanel.setAttentionVisible(param1);
    }

    override protected function setVehicleParamsData(param1:Array):void {
        if (this._vehicleParamsData) {
            this._vehicleParamsData.cleanUp();
        }
        this._vehicleParamsData = new VehParamsListDataProvider(param1);
        invalidateData();
    }

    public function as_setVehiclesCountText(param1:String):void {
        this.topPanel.setVehiclesCountText(param1);
    }

    private function updateBgSize():void {
        this.background.graphics.clear();
        this.background.graphics.beginBitmapFill(this._bgBitmapData);
        this.background.graphics.drawRect(0, 0, width, height + BOTTOM_PANEL_HEIGHT);
        this.background.graphics.endFill();
    }

    private function onTopPanelRightClickHandler(param1:VehCompareVehicleRendererEvent):void {
        App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.VEH_COMPARE, this, {
            "id": param1.vehId,
            "index": param1.index
        });
    }

    private function onTopPanelRemoveAllClickHandler(param1:VehCompareEvent):void {
        onRemoveAllVehiclesS();
    }

    private function onTopPanelRemoveClickHandler(param1:VehCompareVehicleRendererEvent):void {
        onRemoveVehicleS(param1.index);
    }

    private function onTopPanelCrewLevelChangedHandler(param1:VehCompareVehicleRendererEvent):void {
        onCrewLevelChangedS(param1.index, param1.crewLevelId);
    }

    private function onParamMouseOverHandler(param1:VehCompareVehParamRendererEvent):void {
        onParamDeltaRequestedS(param1.index, param1.paramID);
    }

    private function onTopPanelModulesClickHandler(param1:VehCompareVehicleRendererEvent):void {
        onSelectModulesClickS(param1.vehId, param1.index);
    }

    private function onPanelGoToPreviewClickHandler(param1:VehCompareVehicleRendererEvent):void {
        onGoToPreviewClickS(param1.vehId);
    }

    private function onPanelGoToHangarClickHandler(param1:VehCompareVehicleRendererEvent):void {
        onGoToHangarClickS(param1.vehId);
    }

    private function onTopPanelScrollChangedHandler(param1:VehCompareScrollEvent):void {
        VehCompareMainPanel(this.mainPanel).updateTableScrollPosition(param1.horizintalScrollPosition);
    }

    private function onMainPanelScrollChangedHandler(param1:VehCompareScrollEvent):void {
        VehCompareTopPanel(this.topPanel).updateTableScrollPosition(param1.horizintalScrollPosition);
    }

    private function onEscapeKeyUpHandler(param1:InputEvent):void {
        closeViewS();
    }

    private function onCloseClickHandler(param1:VehCompareEvent):void {
        closeViewS();
    }

    private function onBackClickHandler(param1:VehCompareEvent):void {
        onBackClickS();
    }
}
}

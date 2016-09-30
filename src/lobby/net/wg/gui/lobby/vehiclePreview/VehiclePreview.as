package net.wg.gui.lobby.vehiclePreview {
import flash.display.InteractiveObject;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
import net.wg.gui.events.LobbyEvent;
import net.wg.gui.interfaces.IUpdatableComponent;
import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewStaticDataVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewInfoPanelEvent;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBottomPanel;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanel;
import net.wg.infrastructure.base.meta.IVehiclePreviewMeta;
import net.wg.infrastructure.base.meta.impl.VehiclePreviewMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.InputEvent;

public class VehiclePreview extends VehiclePreviewMeta implements IVehiclePreviewMeta {

    private static const BOTTOM_OFFSET:Number = 76;

    private static const GAP:int = 2;

    private static const PARAMS_TOP_MARGIN:int = 100 + GAP;

    public var header:IVehPreviewHeader = null;

    public var infoPanel:IVehPreviewInfoPanel = null;

    public var bottomPanel:IVehPreviewBottomPanel = null;

    public var vehParams:IVehicleParameters = null;

    public var vehicleInfoPanel:IUpdatableComponent = null;

    public function VehiclePreview() {
        super();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        setSize(param1, param2);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        var _loc2_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.header.backBtn), InteractiveObject(this.bottomPanel.buyingPanel.buyBtn), InteractiveObject(this.header.closeBtn)];
        App.utils.commons.initTabIndex(_loc2_);
        setFocus(_loc2_[0]);
        _loc2_.splice(0, _loc2_.length);
    }

    override protected function updateInfoData(param1:VehPreviewInfoPanelVO):void {
        this.infoPanel.update(param1);
    }

    override protected function setStaticData(param1:VehPreviewStaticDataVO):void {
        this.header.update(param1.header);
        this.bottomPanel.update(param1.bottomPanel);
        this.vehicleInfoPanel.update(param1.vehicleInfo);
        this.infoPanel.updateTabButtonsData(param1.tabButtonsData);
    }

    override protected function configUI():void {
        super.configUI();
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
        registerFlashComponentS(this.bottomPanel.modules, VEHPREVIEW_CONSTANTS.MODULES_PY_ALIAS);
        registerFlashComponentS(this.vehParams, VEHPREVIEW_CONSTANTS.PARAMETERS_PY_ALIAS);
        this.updatePosition();
        addEventListener(VehPreviewEvent.BUY_CLICK, this.onBuyClickHandler);
        addEventListener(VehPreviewEvent.CLOSE_CLICK, this.onCloseClickHandler);
        addEventListener(VehPreviewEvent.BACK_CLICK, this.onBackClickHandler);
        addEventListener(VehPreviewInfoPanelEvent.INFO_TAB_CHANGED, this.onInfoTabChangedHandler);
        addEventListener(VehPreviewEvent.COMPARE_CLICK, this.onCompareClickHandler);
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.onEscapeKeyUpHandler, true);
    }

    override protected function onDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
        removeEventListener(VehPreviewEvent.BUY_CLICK, this.onBuyClickHandler);
        removeEventListener(VehPreviewEvent.CLOSE_CLICK, this.onCloseClickHandler);
        removeEventListener(VehPreviewEvent.BACK_CLICK, this.onBackClickHandler);
        removeEventListener(VehPreviewInfoPanelEvent.INFO_TAB_CHANGED, this.onInfoTabChangedHandler);
        removeEventListener(VehPreviewEvent.COMPARE_CLICK, this.onCompareClickHandler);
        this.vehParams = null;
        this.header.dispose();
        this.header = null;
        this.infoPanel.dispose();
        this.infoPanel = null;
        this.bottomPanel.dispose();
        this.bottomPanel = null;
        this.vehicleInfoPanel.dispose();
        this.vehicleInfoPanel = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = width;
            _loc2_ = height;
            this.header.width = _loc1_;
            this.bottomPanel.width = _loc1_;
            this.bottomPanel.y = _loc2_ - this.bottomPanel.height + BOTTOM_OFFSET | 0;
            this.updatePosition();
        }
    }

    override protected function updatePrice(param1:VehPreviewPriceDataVO):void {
        this.bottomPanel.updatePrice(param1);
    }

    public function as_updateBuyButton(param1:Boolean, param2:String):void {
        this.bottomPanel.updateBuyButton(param1, param2);
    }

    public function as_updateVehicleStatus(param1:String):void {
        this.bottomPanel.updateVehicleStatus(param1);
    }

    private function updatePosition():void {
        var _loc1_:Number = width;
        this.vehicleInfoPanel.x = _loc1_ - this.vehicleInfoPanel.width ^ 0;
        this.vehicleInfoPanel.y = PARAMS_TOP_MARGIN;
        this.vehParams.x = _loc1_ - this.vehParams.width ^ 0;
        this.vehParams.y = this.vehicleInfoPanel.y + this.vehicleInfoPanel.height + GAP;
        var _loc2_:int = this.bottomPanel.y - GAP;
        this.vehParams.height = _loc2_ - this.vehParams.y;
        this.infoPanel.height = _loc2_ - this.infoPanel.y;
    }

    private function onEscapeKeyUpHandler(param1:InputEvent):void {
        closeViewS();
    }

    private function onInfoTabChangedHandler(param1:VehPreviewInfoPanelEvent):void {
        onOpenInfoTabS(param1.selectedTabIndex);
    }

    private function onBuyClickHandler(param1:VehPreviewEvent):void {
        onBuyOrResearchClickS();
    }

    private function onCloseClickHandler(param1:VehPreviewEvent):void {
        closeViewS();
    }

    private function onBackClickHandler(param1:VehPreviewEvent):void {
        onBackClickS();
    }

    private function onCompareClickHandler(param1:VehPreviewEvent):void {
        onCompareClickS();
    }
}
}

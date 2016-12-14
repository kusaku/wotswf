package net.wg.gui.lobby.store.inventory {
import flash.events.MouseEvent;

import net.wg.data.VO.StoreTableData;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.data.VehCompareEntrypointVO;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.store.StoreEvent;
import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.utils.Constraints;

public class InventoryVehicleListItemRdr extends InventoryListItemRenderer {

    private static const ADD_TO_COMPARE_BTN_ORIGINAL_X:int = 593;

    private static const ADD_TO_COMPARE_BTN_ORIGINAL_WIDTH:int = 160;

    public var vehicleIcon:TankIcon = null;

    public var addToCompareBtn:IButtonIconLoader = null;

    private var _compareModeOn:Boolean = false;

    private var _tooltipMgr:ITooltipMgr;

    public function InventoryVehicleListItemRdr() {
        super();
        this._tooltipMgr = App.toolTipMgr;
    }

    override protected function configUI():void {
        super.configUI();
        mouseChildren = true;
        this.addToCompareBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_VEHICLECOMPAREBTN;
        this.addToCompareBtn.focusable = false;
        this.addToCompareBtn.mouseEnabledOnDisabled = true;
        this.addToCompareBtn.visible = false;
        this.addToCompareBtn.validateNow();
        constraints.addElement("vehicleIcon", this.vehicleIcon, Constraints.ALL);
    }

    override protected function onDispose():void {
        this.vehicleIcon.dispose();
        this.vehicleIcon = null;
        this.addToCompareBtn.dispose();
        this.addToCompareBtn = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.addToCompareBtn.x = ADD_TO_COMPARE_BTN_ORIGINAL_X / scaleX;
            this.addToCompareBtn.scaleX = 1 / scaleX;
            this.addToCompareBtn.width = ADD_TO_COMPARE_BTN_ORIGINAL_WIDTH;
        }
    }

    override protected function onLeftButtonClick(param1:Object):void {
        if (param1 == this.addToCompareBtn) {
            if (this.addToCompareBtn.enabled) {
                dispatchEvent(new StoreEvent(StoreEvent.ADD_TO_COMPARE, StoreTableData(data).id));
            }
        }
        else {
            super.onLeftButtonClick(param1);
        }
    }

    override protected function update():void {
        var _loc1_:StoreTableData = null;
        var _loc2_:VehCompareEntrypointVO = null;
        var _loc3_:Boolean = false;
        super.update();
        if (data) {
            _loc1_ = StoreTableData(data);
            this.updateVehicleIcon(_loc1_);
            _loc2_ = _loc1_.vehCompareVO;
            _loc3_ = _loc2_.modeAvailable;
            this._compareModeOn = _loc3_;
            this.addToCompareBtn.visible = this._compareModeOn;
            if (this._compareModeOn) {
                this.addToCompareBtn.enabled = _loc2_.btnEnabled;
                this.addToCompareBtn.tooltip = _loc2_.btnTooltip;
            }
        }
    }

    override protected function onRightButtonClick():void {
        if (this._compareModeOn) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.STORE_VEHICLE, this, {"id": StoreTableData(data).id});
        }
        else {
            infoItem();
        }
    }

    override protected function shopTooltip():void {
        if (this.addToCompareBtn.hitTestPoint(App.stage.mouseX, App.stage.mouseY, true)) {
            this._tooltipMgr.showComplex(this.addToCompareBtn.tooltip);
        }
        else {
            super.shopTooltip();
        }
    }

    private function updateVehicleIcon(param1:StoreTableData):void {
        getHelper().initVehicleIcon(this.vehicleIcon, param1);
    }

    override public function set selected(param1:Boolean):void {
        if (!this.addToCompareBtn.hitTestPoint(App.stage.mouseX, App.stage.mouseY, true)) {
            super.selected = param1;
        }
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        if (param1.target != this.addToCompareBtn) {
            super.handleMousePress(param1);
        }
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        if (param1.target != this.addToCompareBtn) {
            super.handleMouseRelease(param1);
        }
    }
}
}

package net.wg.gui.lobby.vehicleCompare.controls {
import flash.text.TextField;

import net.wg.data.VO.ButtonPropertiesVO;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.components.popovers.PopOver;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAddVehiclePopoverVO;
import net.wg.gui.lobby.vehicleCompare.events.VehicleCompareAddVehicleRendererEvent;
import net.wg.infrastructure.base.meta.IVehicleCompareAddVehiclePopoverMeta;
import net.wg.infrastructure.base.meta.impl.VehicleCompareAddVehiclePopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class VehicleCompareAddVehiclePopover extends VehicleCompareAddVehiclePopoverMeta implements IVehicleCompareAddVehiclePopoverMeta {

    public var selector:VehicleCompareVehicleSelector;

    public var addButton:IconTextButton;

    public var cancelButton:ISoundButtonEx;

    public var infoTF:TextField;

    private var _initData:VehicleCompareAddVehiclePopoverVO;

    public function VehicleCompareAddVehiclePopover() {
        super();
    }

    override protected function setInitData(param1:VehicleCompareAddVehiclePopoverVO):void {
        this._initData = param1;
        invalidateData();
    }

    override protected function draw():void {
        super.draw();
        if (this._initData && isInvalid(InvalidationType.DATA)) {
            this.selector.setHeaderDP(this._initData.tableHeaders);
            this.selector.setFiltersData(this._initData.filters);
            this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE, this.onFiltersViewChangeHandler);
            this.cancelButton.label = this._initData.btnCancel;
            this.infoTF.htmlText = this._initData.header;
        }
    }

    override protected function onDispose():void {
        this.selector.removeEventListener(VehicleCompareAddVehicleRendererEvent.RENDERER_CLICK, this.onSelectorRendererClickHandler);
        this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE, this.onFiltersViewChangeHandler);
        this.selector.dispose();
        this.selector = null;
        this.addButton.removeEventListener(ButtonEvent.CLICK, this.onAddButtonClickHandler);
        this.addButton.dispose();
        this.addButton = null;
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.cancelButton.dispose();
        this.cancelButton = null;
        this.infoTF = null;
        this._initData = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.selector.addEventListener(VehicleCompareAddVehicleRendererEvent.RENDERER_CLICK, this.onSelectorRendererClickHandler);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.addButton.addEventListener(ButtonEvent.CLICK, this.onAddButtonClickHandler);
        this.addButton.mouseEnabledOnDisabled = true;
    }

    override protected function setAddButtonState(param1:ButtonPropertiesVO):void {
        this.addButton.tooltip = param1.btnTooltip;
        this.addButton.iconSource = param1.btnIcon;
        this.addButton.label = param1.btnLabel;
        this.addButton.enabled = param1.btnEnabled;
    }

    public function as_getTableDP():Object {
        return this.selector.getListDP();
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    private function onAddButtonClickHandler(param1:ButtonEvent):void {
        addButtonClickedS();
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onFiltersViewChangeHandler(param1:VehicleSelectorFilterEvent):void {
        applyFiltersS(param1.nation, param1.vehicleType, param1.level, param1.isMain, param1.compatibleOnly);
    }

    private function onSelectorRendererClickHandler(param1:VehicleCompareAddVehicleRendererEvent):void {
        var _loc2_:int = param1.dbID;
        setVehicleSelectedS(_loc2_);
    }

    public function as_updateTableSortField(param1:String, param2:String):void {
        this.selector.updateTableSortField(param1, param2);
    }
}
}

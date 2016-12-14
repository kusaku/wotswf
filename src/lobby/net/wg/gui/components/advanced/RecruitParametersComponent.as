package net.wg.gui.components.advanced {
import flash.events.Event;
import flash.text.TextField;

import net.wg.gui.components.advanced.vo.RecruitParametersVO;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.infrastructure.base.meta.IRecruitParametersMeta;
import net.wg.infrastructure.base.meta.impl.RecruitParametersMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class RecruitParametersComponent extends RecruitParametersMeta implements IRecruitParametersMeta {

    private static const NATIONS_INV:String = "nationsInv";

    private static const VEHICLE_CLASS_INV:String = "vClassInv";

    private static const VEHICLE_INV:String = "vehInv";

    private static const TANKMAN_ROLE_INV:String = "tManInv";

    public var nationDropdown:DropdownMenu;

    public var vehicleClassDropdown:DropdownMenu;

    public var vehicleTypeDropdown:DropdownMenu;

    public var roleDropdown:DropdownMenu;

    public var nationTF:TextField = null;

    public var vehicleClassTF:TextField = null;

    public var vehicleTypeTF:TextField = null;

    public var specializationTF:TextField = null;

    private var _nationsData:RecruitParametersVO;

    private var _vehicleClassData:RecruitParametersVO;

    private var _vehicleData:RecruitParametersVO;

    private var _tankmanRoleData:RecruitParametersVO;

    public function RecruitParametersComponent() {
        super();
    }

    private static function applyData(param1:DropdownMenu, param2:RecruitParametersVO):void {
        param1.dataProvider = new DataProvider(param2.data);
        param1.selectedIndex = param2.selectedIndex;
        param1.enabled = param2.enabled;
    }

    override protected function setVehicleClassData(param1:RecruitParametersVO):void {
        this._vehicleClassData = param1;
        invalidate(VEHICLE_CLASS_INV);
    }

    override protected function setVehicleData(param1:RecruitParametersVO):void {
        this._vehicleData = param1;
        invalidate(VEHICLE_INV);
    }

    override protected function setTankmanRoleData(param1:RecruitParametersVO):void {
        this._tankmanRoleData = param1;
        invalidate(TANKMAN_ROLE_INV);
    }

    override protected function setNationsData(param1:RecruitParametersVO):void {
        this._nationsData = param1;
        invalidate(NATIONS_INV);
    }

    public function getSelectedNation():int {
        return this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
    }

    public function getSelectedVehicleClass():String {
        return this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
    }

    public function getSelectedVehicle():Number {
        return this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
    }

    public function getSelectedTankmanRole():String {
        return this.roleDropdown.dataProvider[this.roleDropdown.selectedIndex].id;
    }

    override protected function configUI():void {
        super.configUI();
        this.nationTF.mouseEnabled = false;
        this.vehicleClassTF.mouseEnabled = false;
        this.vehicleTypeTF.mouseEnabled = false;
        this.specializationTF.mouseEnabled = false;
        this.nationTF.text = DIALOGS.RECRUITWINDOW_NATION;
        this.vehicleClassTF.text = DIALOGS.RECRUITWINDOW_VEHICLECLASS;
        this.vehicleTypeTF.text = DIALOGS.RECRUITWINDOW_VEHICLETYPE;
        this.specializationTF.text = DIALOGS.RECRUITWINDOW_SPECIALIZATION;
        this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onNationIndexChangeHandler);
        this.vehicleClassDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onVehicleClassIndexChangeHandler);
        this.vehicleTypeDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onVehicleTypeIndexChangeHandler);
        this.roleDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onRoleIndexChangeHandler);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(NATIONS_INV) && this._nationsData) {
            applyData(this.nationDropdown, this._nationsData);
        }
        if (isInvalid(VEHICLE_CLASS_INV) && this._vehicleClassData) {
            applyData(this.vehicleClassDropdown, this._vehicleClassData);
        }
        if (isInvalid(VEHICLE_INV) && this._vehicleData) {
            applyData(this.vehicleTypeDropdown, this._vehicleData);
        }
        if (isInvalid(TANKMAN_ROLE_INV) && this._tankmanRoleData) {
            applyData(this.roleDropdown, this._tankmanRoleData);
        }
    }

    override protected function onDispose():void {
        this._nationsData = null;
        this._vehicleClassData = null;
        this._vehicleData = null;
        this._tankmanRoleData = null;
        this.nationTF = null;
        this.vehicleClassTF = null;
        this.vehicleTypeTF = null;
        this.specializationTF = null;
        this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onNationIndexChangeHandler);
        this.vehicleClassDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onVehicleClassIndexChangeHandler);
        this.vehicleTypeDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onVehicleTypeIndexChangeHandler);
        this.roleDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onRoleIndexChangeHandler);
        this.nationDropdown.dispose();
        this.vehicleClassDropdown.dispose();
        this.vehicleTypeDropdown.dispose();
        this.roleDropdown.dispose();
        this.nationDropdown = null;
        this.vehicleClassDropdown = null;
        this.vehicleTypeDropdown = null;
        this.roleDropdown = null;
        super.onDispose();
    }

    private function onNationIndexChangeHandler(param1:ListEvent):void {
        onNationChangedS(this.getSelectedNation());
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function onVehicleClassIndexChangeHandler(param1:ListEvent):void {
        onVehicleClassChangedS(this.getSelectedVehicleClass());
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function onVehicleTypeIndexChangeHandler(param1:ListEvent):void {
        onVehicleChangedS(this.getSelectedVehicle());
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function onRoleIndexChangeHandler(param1:ListEvent):void {
        onTankmanRoleChangedS(this.getSelectedTankmanRole());
        dispatchEvent(new Event(Event.CHANGE));
    }
}
}

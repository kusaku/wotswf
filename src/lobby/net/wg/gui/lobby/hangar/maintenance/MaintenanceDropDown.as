package net.wg.gui.lobby.hangar.maintenance {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.constants.ComponentState;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
import net.wg.utils.IEventCollector;

import scaleform.clik.constants.InvalidationType;

public class MaintenanceDropDown extends DropdownMenu {

    public function MaintenanceDropDown() {
        super();
    }

    override protected function showDropdown():void {
        var _loc1_:IEventCollector = null;
        super.showDropdown();
        if (_dropdownRef) {
            _loc1_ = App.utils.events;
            _loc1_.disableDisposingForObj(_dropdownRef);
            parent.parent.addChild(_dropdownRef);
            _loc1_.enableDisposingForObj(_dropdownRef);
            _loc1_.addEvent(_dropdownRef, OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.handleOnEquipmentRendererOver, false, 0, true);
            this.updateDDPosition(null);
        }
    }

    private function handleOnEquipmentRendererOver(param1:OnEquipmentRendererOver):void {
        dispatchEvent(new OnEquipmentRendererOver(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, param1.moduleID, param1.modulePrices, param1.inventoryCount, param1.vehicleCount, param1.moduleIndex));
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        if (!param1.buttonDown) {
            if (!enabled) {
                return;
            }
            setState(ComponentState.OUT);
        }
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (!param1.buttonDown) {
            if (!enabled) {
                return;
            }
            setState(ComponentState.OVER);
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            enabled = _dataProvider.length > 0;
        }
    }

    override protected function updateDDPosition(param1:Event):void {
        var _loc2_:Point = null;
        if (_dropdownRef) {
            super.updateDDPosition(param1);
            _dropdownRef.x = _dropdownRef.x * App.appScale;
            _dropdownRef.y = _dropdownRef.y * App.appScale;
            _loc2_ = parent.parent.parent.globalToLocal(new Point(_dropdownRef.x, _dropdownRef.y));
            _dropdownRef.x = _loc2_.x;
            _dropdownRef.y = _loc2_.y;
        }
    }
}
}

package net.wg.gui.lobby.hangar.ammunitionPanel {
import flash.display.MovieClip;

import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;

import scaleform.clik.constants.InvalidationType;

public class EquipmentSlot extends DeviceSlot {

    private static const EMPTY:String = "empty";

    public var moduleType:ModuleTypesUIWithFill = null;

    public var locked:MovieClip = null;

    public function EquipmentSlot() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.locked.mouseEnabled = this.locked.mouseChildren = false;
        this.moduleType.mouseEnabled = this.moduleType.mouseChildren = false;
    }

    override protected function onDispose():void {
        this.moduleType.dispose();
        this.moduleType = null;
        this.locked = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && slotData != null) {
            if (!isEmpty()) {
                this.setIconLabel(slotData.moduleLabel, slotData.removable);
            }
            else {
                this.setIconLabel(EMPTY, true);
            }
        }
    }

    private function setIconLabel(param1:String, param2:Boolean):void {
        App.utils.asserter.assertFrameExists(param1, this.moduleType);
        this.moduleType.gotoAndStop(param1);
        this.locked.visible = !param2;
    }
}
}

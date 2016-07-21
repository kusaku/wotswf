package net.wg.gui.lobby.store.inventory {
import flash.text.TextField;

import net.wg.data.VO.StoreTableData;
import net.wg.gui.components.advanced.ExtraModuleIcon;
import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;

import scaleform.clik.utils.Constraints;

public class InventoryModuleListItemRenderer extends InventoryListItemRenderer {

    public var moduleIcon:ExtraModuleIcon = null;

    public var vehCount:TextField = null;

    public var count:TextField = null;

    public function InventoryModuleListItemRenderer() {
        super();
    }

    override protected function onDispose():void {
        if (this.moduleIcon != null) {
            this.moduleIcon.dispose();
            this.moduleIcon = null;
        }
        this.vehCount = null;
        this.count = null;
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(this.moduleIcon.name, this.moduleIcon, Constraints.LEFT);
        constraints.addElement(this.count.name, this.count, Constraints.RIGHT);
    }

    override protected function update():void {
        var _loc1_:StoreTableData = null;
        super.update();
        if (data) {
            _loc1_ = StoreTableData(data);
            this.updateModuleIcon(_loc1_);
            getHelper().updateCountFields(this.count, this.vehCount, _loc1_);
        }
        else {
            visible = false;
            getHelper().initModuleIconAsDefault(this.moduleIcon);
        }
    }

    private function updateModuleIcon(param1:StoreTableData):void {
        if (this.moduleIcon) {
            this.moduleIcon.setValuesWithType(param1.requestType, param1.moduleLabel, param1.level);
            this.moduleIcon.extraIconSource = param1.extraModuleInfo;
        }
    }
}
}

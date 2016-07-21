package net.wg.gui.components.advanced {
import net.wg.data.constants.Linkages;

public class ExtraModuleIcon extends ModuleIcon {

    private static const VEHICLE_GUN:String = "vehicleGun";

    public function ExtraModuleIcon() {
        super();
    }

    override protected function onDispose():void {
        ModuleTypesUIWithFill(moduleType).hideExtraIcon();
        super.onDispose();
    }

    public function set extraIconSource(param1:String):void {
        ModuleTypesUIWithFill(moduleType).hideExtraIcon();
        if (moduleType.currentLabel == VEHICLE_GUN) {
            if (param1 == RES_ICONS.MAPS_ICONS_MODULES_MAGAZINEGUNICON) {
                ModuleTypesUIWithFill(moduleType).setExtraIcon(Linkages.MAGAZINE_GUN_ICON);
                ModuleTypesUIWithFill(moduleType).showExtraIcon();
            }
        }
    }
}
}

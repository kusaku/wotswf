package net.wg.gui.cyberSport.staticFormation.data {
import flash.utils.Dictionary;

import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationLadderViewIconsVO extends DAAPIDataClass {

    private static const ICONS_MAP_FIELD_NAME:String = "iconsMap";

    public var iconsMap:Dictionary;

    public function StaticFormationLadderViewIconsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:* = null;
        if (param1 == ICONS_MAP_FIELD_NAME) {
            this.iconsMap = new Dictionary();
            for (_loc3_ in param2) {
                this.iconsMap[_loc3_] = param2[_loc3_];
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        App.utils.data.cleanupDynamicObject(this.iconsMap);
        this.iconsMap = null;
        super.onDispose();
    }
}
}

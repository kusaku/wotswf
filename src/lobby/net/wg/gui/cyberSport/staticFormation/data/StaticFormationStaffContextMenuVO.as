package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationStaffContextMenuVO extends DAAPIDataClass {

    public var dbID:Number = -1;

    public var userName:String = "";

    public var clubDbID:Number = -1;

    public function StaticFormationStaffContextMenuVO(param1:Object) {
        super(param1);
    }
}
}

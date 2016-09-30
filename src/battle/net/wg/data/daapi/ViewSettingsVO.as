package net.wg.data.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ViewSettingsVO extends DAAPIDataClass {

    public var alias:String = "";

    public var url:String = "";

    public var type:String = "";

    public var event:String = "";

    public var group:String = "";

    public var isGrouped:Boolean = false;

    public function ViewSettingsVO(param1:Object) {
        super(param1);
    }
}
}

package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ClanStatItemVO extends DAAPIDataClass {

    public var label:String = "";

    public var value:String = "";

    public var icon:String = "";

    public var enabled:Boolean = true;

    public var ttHeader:String = "";

    public var ttBody:String = "";

    public var ttBodyParams:Object;

    public var ttLabel:String = "";

    public function ClanStatItemVO(param1:Object) {
        this.ttBodyParams = {};
        super(param1);
    }
}
}

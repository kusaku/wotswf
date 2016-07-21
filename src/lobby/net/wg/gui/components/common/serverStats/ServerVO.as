package net.wg.gui.components.common.serverStats {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ServerVO extends DAAPIDataClass {

    public var label:String = "";

    public var csisStatus:int = -1;

    public var id:int = 0;

    public var selected:Boolean = false;

    public var data:String = "";

    public var pingState:int = -1;

    public var pingValue:String = "";

    public var tooltip:String = "";

    public var colorBlind:Boolean = false;

    public var enabled:Boolean = false;

    public function ServerVO(param1:Object) {
        super(param1);
    }
}
}

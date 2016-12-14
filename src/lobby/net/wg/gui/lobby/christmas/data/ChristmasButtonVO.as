package net.wg.gui.lobby.christmas.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ChristmasButtonVO extends DAAPIDataClass {

    public var isEnabled:Boolean = false;

    public var label:String = "";

    public var newToysCount:String = "";

    public var tooltip:String = "";

    public function ChristmasButtonVO(param1:Object) {
        super(param1);
    }
}
}

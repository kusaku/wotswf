package net.wg.gui.lobby.christmas.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class EmptyListVO extends DAAPIDataClass {

    public var isVisible:Boolean = false;

    public var titleText:String = "";

    public var descrText:String = "";

    public function EmptyListVO(param1:Object) {
        super(param1);
    }
}
}

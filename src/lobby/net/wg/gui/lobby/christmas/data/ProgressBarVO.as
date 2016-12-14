package net.wg.gui.lobby.christmas.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ProgressBarVO extends DAAPIDataClass {

    public var levelText:String = "";

    public var progress:Number = 0;

    public var showFlash:Boolean = false;

    public function ProgressBarVO(param1:Object) {
        super(param1);
    }
}
}

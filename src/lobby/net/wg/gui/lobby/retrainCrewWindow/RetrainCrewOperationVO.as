package net.wg.gui.lobby.retrainCrewWindow {
import net.wg.data.daapi.base.DAAPIDataClass;

public class RetrainCrewOperationVO extends DAAPIDataClass {

    public var credits:int;

    public var gold:int;

    public var actionPrc:Array;

    public var tankmanCost:Array;

    public function RetrainCrewOperationVO(param1:Object) {
        super(param1);
    }
}
}

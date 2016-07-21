package net.wg.gui.lobby.battleResults.progressReport {
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.data.daapi.base.DAAPIDataClass;

public class BattleResultUnlockItemVO extends DAAPIDataClass {

    private static const FITTING_TYPE:String = "fittingType";

    public var vehicleIcon:String = "";

    public var tankmenIcon:String = "";

    public var fittingType:String = "";

    public var lvlIcon:String = "";

    public var title:String = "";

    public var description:String = "";

    public var price:String = "";

    public var linkEvent:String = "";

    public var linkId:int = -1;

    public var prediction:String = "";

    public function BattleResultUnlockItemVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Boolean = false;
        if (param1 == FITTING_TYPE) {
            _loc3_ = param1 == Values.EMPTY_STR || FITTING_TYPES.MANDATORY_SLOTS.indexOf(param2) > -1;
            App.utils.asserter.assert(_loc3_, "Unknown fitting: " + param2);
        }
        return super.onDataWrite(param1, param2);
    }
}
}

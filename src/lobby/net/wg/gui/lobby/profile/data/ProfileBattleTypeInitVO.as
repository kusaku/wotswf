package net.wg.gui.lobby.profile.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;

public class ProfileBattleTypeInitVO extends DAAPIDataClass {

    private static const DROP_DOWN_PROVIDER:String = "dropDownProvider";

    private static const SEASON_ITEMS:String = "seasonItems";

    private static const KEY:String = "key";

    private static const LABEL:String = "label";

    private static const MESSAGE:String = " item: property";

    public var dropDownProvider:Array = null;

    public var seasonItems:Array = null;

    public var seasonIndex:int = 0;

    public var seasonEnabled:Boolean = false;

    public function ProfileBattleTypeInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (DROP_DOWN_PROVIDER == param1) {
            this.dropDownProvider = param2 as Array;
            this.testData(this.dropDownProvider, DROP_DOWN_PROVIDER);
            return false;
        }
        if (SEASON_ITEMS == param1) {
            this.seasonItems = param2 as Array;
            this.testData(this.seasonItems, SEASON_ITEMS);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    private function testData(param1:Array, param2:String):void {
        var _loc3_:* = undefined;
        App.utils.asserter.assertNotNull(param1, param2 + Errors.CANT_NULL);
        for each(_loc3_ in param1) {
            App.utils.asserter.assert(_loc3_.hasOwnProperty(KEY), param2 + MESSAGE + KEY + Errors.WASNT_FOUND);
            App.utils.asserter.assert(_loc3_.hasOwnProperty(LABEL), param2 + MESSAGE + LABEL + Errors.WASNT_FOUND);
        }
    }
}
}

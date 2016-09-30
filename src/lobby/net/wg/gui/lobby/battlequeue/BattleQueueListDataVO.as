package net.wg.gui.lobby.battlequeue {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;

import scaleform.clik.data.DataProvider;

public class BattleQueueListDataVO extends DAAPIDataClass {

    private static const DATA:String = "data";

    public var title:String = "";

    private var _data:DataProvider;

    public function BattleQueueListDataVO(param1:Object) {
        this._data = new DataProvider();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == DATA) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, DATA + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this._data.push(new BattleQueueItemVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._data.cleanUp();
        this._data = null;
        super.onDispose();
    }

    public function get data():DataProvider {
        return this._data;
    }
}
}

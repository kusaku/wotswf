package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CombatReservesIntroVO extends DAAPIDataClass {

    private static const ITEMS_DATA:String = "items";

    public var windowTitle:String = "";

    public var title:String = "";

    public var description:String = "";

    public var buttonLabel:String = "";

    private var _items:Vector.<CombatReservesIntroItemVO>;

    public function CombatReservesIntroVO(param1:Object) {
        this._items = new Vector.<CombatReservesIntroItemVO>();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == ITEMS_DATA) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + ITEMS_DATA);
            for each(_loc4_ in _loc3_) {
                this._items.push(new CombatReservesIntroItemVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._items) {
            _loc1_.dispose();
        }
        this._items.splice(0, this._items.length);
        this._items = null;
        super.onDispose();
    }

    public function get items():Vector.<CombatReservesIntroItemVO> {
        return this._items;
    }
}
}

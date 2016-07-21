package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;

public class FortClanListWindowVO extends NormalSortingTableHeaderVO {

    private static const MEMBERS:String = "members";

    public var windowTitle:String = "";

    private var _members:DataProvider;

    public function FortClanListWindowVO(param1:Object) {
        this._members = new DataProvider();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == MEMBERS) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + MEMBERS);
            for each(_loc4_ in _loc3_) {
                this._members.push(new ClanListRendererVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._members) {
            _loc1_.dispose();
        }
        this._members.cleanUp();
        this._members = null;
    }

    public function get members():DataProvider {
        return this._members;
    }
}
}

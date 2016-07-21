package net.wg.gui.lobby.clans.profile.VOs {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ClanProfileFortificationViewInitVO extends DAAPIDataClass {

    private static const TAB_DATA_PROVIDER:String = "tabDataProvider";

    private var _tabDataProvider:Array = null;

    public function ClanProfileFortificationViewInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == TAB_DATA_PROVIDER) {
            this._tabDataProvider = [];
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_) {
                this._tabDataProvider.push(new ClanTabDataProviderVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._tabDataProvider) {
            _loc1_.dispose();
        }
        this._tabDataProvider.splice(0, this._tabDataProvider.length);
        this._tabDataProvider = null;
        super.onDispose();
    }

    public function get tabDataProvider():Array {
        return this._tabDataProvider;
    }
}
}

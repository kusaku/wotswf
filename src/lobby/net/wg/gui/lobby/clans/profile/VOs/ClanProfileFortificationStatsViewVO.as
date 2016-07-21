package net.wg.gui.lobby.clans.profile.VOs {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.components.data.DetailedStatisticsUnitVO;
import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IDataProvider;

public class ClanProfileFortificationStatsViewVO extends DAAPIDataClass {

    private static const HEADER_PARAMS:String = "headerParams";

    private static const BODY_PARAMS:String = "bodyParams";

    public var headerText:String = "";

    private var _bodyParams:DetailedStatisticsUnitVO = null;

    private var _headerParams:DataProvider = null;

    public function ClanProfileFortificationStatsViewVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == HEADER_PARAMS) {
            this._headerParams = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, HEADER_PARAMS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this._headerParams.push(new StatisticsHeaderVO(_loc4_));
            }
            return false;
        }
        if (param1 == BODY_PARAMS && param2) {
            this._bodyParams = new DetailedStatisticsUnitVO(param2.dataList);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this._bodyParams.dispose();
        this._bodyParams = null;
        for each(_loc1_ in this._headerParams) {
            _loc1_.dispose();
        }
        this._headerParams.cleanUp();
        this._headerParams = null;
        super.onDispose();
    }

    public function get headerParams():IDataProvider {
        return this._headerParams;
    }

    public function get bodyParams():DetailedStatisticsUnitVO {
        return this._bodyParams;
    }
}
}

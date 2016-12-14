package net.wg.gui.lobby.profile.pages.technique {
import net.wg.gui.components.controls.NormalSortingBtnVO;
import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;

import scaleform.clik.data.DataProvider;

public class TechStatisticsInitVO extends ProfileBattleTypeInitVO {

    private static const TABLE_HEADER:String = "tableHeader";

    public var tableHeader:DataProvider;

    public function TechStatisticsInitVO(param1:Object) {
        super(param1);
    }

    private static function getTypedDataProvider(param1:*, param2:Class):DataProvider {
        var _loc3_:DataProvider = new DataProvider();
        var _loc4_:int = param1.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc3_[_loc5_] = new param2(param1[_loc5_]);
            _loc5_++;
        }
        return _loc3_;
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == TABLE_HEADER) {
            this.tableHeader = getTypedDataProvider(param2, NormalSortingBtnVO);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:NormalSortingBtnVO = null;
        if (this.tableHeader != null) {
            for each(_loc1_ in this.tableHeader) {
                _loc1_.dispose();
            }
            this.tableHeader.cleanUp();
            this.tableHeader = null;
        }
        super.onDispose();
    }
}
}

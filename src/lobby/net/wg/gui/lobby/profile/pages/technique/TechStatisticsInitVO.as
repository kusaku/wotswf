package net.wg.gui.lobby.profile.pages.technique {
import net.wg.gui.components.controls.NormalSortingBtnVO;
import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;

public class TechStatisticsInitVO extends ProfileBattleTypeInitVO {

    private static const TABLE_HEADER:String = "tableHeader";

    public var tableHeader:Vector.<NormalSortingBtnVO> = null;

    public function TechStatisticsInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == TABLE_HEADER) {
            this.tableHeader = Vector.<NormalSortingBtnVO>(App.utils.data.convertVOArrayToVector(param1, param2, NormalSortingBtnVO));
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
            this.tableHeader.fixed = false;
            this.tableHeader.splice(0, this.tableHeader.length);
            this.tableHeader = null;
        }
        super.onDispose();
    }
}
}

package net.wg.gui.lobby.fortifications.data.battleRoom {
import net.wg.gui.rally.vo.RallyVO;

public class SortieVO extends RallyVO {

    private var _divisionLbl:String = "";

    public function SortieVO(param1:Object) {
        super(param1);
    }

    public function get divisionLbl():String {
        return this._divisionLbl;
    }

    public function set divisionLbl(param1:String):void {
        this._divisionLbl = param1;
    }
}
}

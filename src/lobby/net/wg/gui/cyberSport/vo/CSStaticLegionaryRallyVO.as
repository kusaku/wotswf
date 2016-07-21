package net.wg.gui.cyberSport.vo {
import net.wg.gui.cyberSport.controls.data.CSRallyInfoVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;

public class CSStaticLegionaryRallyVO extends LegionariesSortieVO {

    public var rallyInfo:CSRallyInfoVO;

    public var joinBtnLabel:String = "";

    public var joinInfo:String = "";

    public var joinBtnTooltip:String = "";

    public function CSStaticLegionaryRallyVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == "rallyInfo") {
            this.rallyInfo = new CSRallyInfoVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.rallyInfo != null) {
            this.rallyInfo.dispose();
            this.rallyInfo = null;
        }
        super.onDispose();
    }
}
}

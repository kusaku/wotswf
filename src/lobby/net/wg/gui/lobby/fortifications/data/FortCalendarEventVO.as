package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.fortifications.data.tankIcon.FortTankIconVO;

public class FortCalendarEventVO extends DAAPIDataClass {

    private static const TANK_ICON_VO:String = "tankIconVO";

    public var title:String = "";

    public var timeInfo:String = "";

    public var direction:String = "";

    public var result:String = "";

    public var icon:String = "";

    public var background:String = "";

    public var clanID:Number = -1;

    public var resultTTHeader:String = "";

    public var resultTTBody:String = "";

    public var tankIconVO:FortTankIconVO = null;

    public var showTankIcon:Boolean = false;

    public function FortCalendarEventVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (TANK_ICON_VO.indexOf(param1) >= 0 && param2) {
            this.tankIconVO = new FortTankIconVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        this.tankIconVO.dispose();
        this.tankIconVO = null;
        this.title = null;
        this.timeInfo = null;
        this.direction = null;
        this.result = null;
        this.icon = null;
        this.background = null;
        this.resultTTHeader = null;
        this.resultTTBody = null;
        super.onDispose();
    }
}
}

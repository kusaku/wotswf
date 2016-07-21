package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.fortifications.data.tankIcon.FortTankIconVO;

public class RosterIntroVO extends DAAPIDataClass {

    private static const DEFENCE_DIVISION_ICON:String = "defenceDivisionIcon";

    private static const CHAMPION_DIVISION_ICON:String = "championDivisionIcon";

    private static const ABSOLUTE_DIVISION_ICON:String = "absoluteDivisionIcon";

    private static const FORT_TANK_INFO_FIELDS:Vector.<String> = new <String>[DEFENCE_DIVISION_ICON, CHAMPION_DIVISION_ICON, ABSOLUTE_DIVISION_ICON];

    public var windowTitle:String = "";

    public var bgIcon:String = "";

    public var header:String = "";

    public var defenceTitle:String = "";

    public var defenceIcon:String = "";

    public var defenceDescription:String = "";

    public var defenceDivisionName:String = "";

    public var defenceDivisionIcon:FortTankIconVO;

    public var attackTitle:String = "";

    public var attackIcon:String = "";

    public var championDivisionDescription:String = "";

    public var championDivisionName:String = "";

    public var championDivisionIcon:FortTankIconVO;

    public var absoluteDivisionDescription:String = "";

    public var absoluteDivisionName:String = "";

    public var absoluteDivisionIcon:FortTankIconVO;

    public var acceptBtnLabel:String = "";

    public function RosterIntroVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (FORT_TANK_INFO_FIELDS.indexOf(param1) != -1) {
            this[param1] = new FortTankIconVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.defenceDivisionIcon.dispose();
        this.defenceDivisionIcon = null;
        this.championDivisionIcon.dispose();
        this.championDivisionIcon = null;
        this.absoluteDivisionIcon.dispose();
        this.absoluteDivisionIcon = null;
        super.onDispose();
    }
}
}

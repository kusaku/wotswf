package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationUnitViewHeaderVO extends DAAPIDataClass {

    public var clubId:Number = NaN;

    public var teamName:String = "";

    public var isRankedMode:Boolean = false;

    public var battles:String = "";

    public var winRate:String = "";

    public var enableWinRateTF:Boolean = true;

    public var leagueIcon:String = "";

    public var isFixedMode:Boolean = false;

    public var modeLabel:String = "";

    public var modeTooltip:String = "";

    public var modeTooltipType:String = "";

    public var isModeTooltip:Boolean = false;

    public var bgSource:String = "";

    public function StaticFormationUnitViewHeaderVO(param1:Object) {
        super(param1);
    }
}
}

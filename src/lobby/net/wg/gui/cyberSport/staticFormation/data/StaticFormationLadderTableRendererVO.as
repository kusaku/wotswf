package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationLadderTableRendererVO extends DAAPIDataClass {

    public var formationId:Number = NaN;

    public var place:String = "";

    public var placeSortValue:int = -1;

    public var points:String = "";

    public var pointsSortValue:Number = -1;

    public var formationName:String = "";

    public var formationNameSortValue:String = "";

    public var battlesCount:String = "";

    public var battlesCountSortValue:int = -1;

    public var winPercent:String = "";

    public var winPercentSortValue:Number = -1;

    public var showProfileBtnText:String = "";

    public var showProfileBtnTooltip:String = "";

    public var emblemIconPath:String = "";

    public var isCurrentTeam:Boolean = false;

    public var isMyClub:Boolean = false;

    public function StaticFormationLadderTableRendererVO(param1:Object) {
        super(param1);
    }
}
}

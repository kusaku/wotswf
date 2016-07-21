package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;

public class StaticFormationLadderViewHeaderVO extends NormalSortingTableHeaderVO {

    public var divisionName:String = "";

    public var divisionPositionText:String = "";

    public var formationIconPath:String = "";

    public var clubDBID:Number = NaN;

    public function StaticFormationLadderViewHeaderVO(param1:Object) {
        super(param1);
    }
}
}

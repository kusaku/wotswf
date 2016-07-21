package net.wg.gui.prebattle.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.prebattle.abstract.PrebattleWindowAbstract;

public class BattleSessionWindowMeta extends PrebattleWindowAbstract {

    public var requestToAssignMember:Function;

    public var requestToUnassignMember:Function;

    public var canMoveToAssigned:Function;

    public var canMoveToUnassigned:Function;

    public function BattleSessionWindowMeta() {
        super();
    }

    public function requestToAssignMemberS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.requestToAssignMember, "requestToAssignMember" + Errors.CANT_NULL);
        this.requestToAssignMember(param1);
    }

    public function requestToUnassignMemberS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.requestToUnassignMember, "requestToUnassignMember" + Errors.CANT_NULL);
        this.requestToUnassignMember(param1);
    }

    public function canMoveToAssignedS():Boolean {
        App.utils.asserter.assertNotNull(this.canMoveToAssigned, "canMoveToAssigned" + Errors.CANT_NULL);
        return this.canMoveToAssigned();
    }

    public function canMoveToUnassignedS():Boolean {
        App.utils.asserter.assertNotNull(this.canMoveToUnassigned, "canMoveToUnassigned" + Errors.CANT_NULL);
        return this.canMoveToUnassigned();
    }
}
}

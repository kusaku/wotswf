package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.prebattle.base.BasePrebattleRoomView;

public class CompanyRoomMeta extends BasePrebattleRoomView {

    public var requestToAssign:Function;

    public var requestToUnassign:Function;

    public var requestToChangeOpened:Function;

    public var requestToChangeComment:Function;

    public var requestToChangeDivision:Function;

    public var getCompanyName:Function;

    public var canMoveToAssigned:Function;

    public var canMoveToUnassigned:Function;

    public var canMakeOpenedClosed:Function;

    public var canChangeComment:Function;

    public var canChangeDivision:Function;

    public function CompanyRoomMeta() {
        super();
    }

    public function requestToAssignS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.requestToAssign, "requestToAssign" + Errors.CANT_NULL);
        this.requestToAssign(param1);
    }

    public function requestToUnassignS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.requestToUnassign, "requestToUnassign" + Errors.CANT_NULL);
        this.requestToUnassign(param1);
    }

    public function requestToChangeOpenedS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.requestToChangeOpened, "requestToChangeOpened" + Errors.CANT_NULL);
        this.requestToChangeOpened(param1);
    }

    public function requestToChangeCommentS(param1:String):void {
        App.utils.asserter.assertNotNull(this.requestToChangeComment, "requestToChangeComment" + Errors.CANT_NULL);
        this.requestToChangeComment(param1);
    }

    public function requestToChangeDivisionS(param1:uint):void {
        App.utils.asserter.assertNotNull(this.requestToChangeDivision, "requestToChangeDivision" + Errors.CANT_NULL);
        this.requestToChangeDivision(param1);
    }

    public function getCompanyNameS():String {
        App.utils.asserter.assertNotNull(this.getCompanyName, "getCompanyName" + Errors.CANT_NULL);
        return this.getCompanyName();
    }

    public function canMoveToAssignedS():Boolean {
        App.utils.asserter.assertNotNull(this.canMoveToAssigned, "canMoveToAssigned" + Errors.CANT_NULL);
        return this.canMoveToAssigned();
    }

    public function canMoveToUnassignedS():Boolean {
        App.utils.asserter.assertNotNull(this.canMoveToUnassigned, "canMoveToUnassigned" + Errors.CANT_NULL);
        return this.canMoveToUnassigned();
    }

    public function canMakeOpenedClosedS():Boolean {
        App.utils.asserter.assertNotNull(this.canMakeOpenedClosed, "canMakeOpenedClosed" + Errors.CANT_NULL);
        return this.canMakeOpenedClosed();
    }

    public function canChangeCommentS():Boolean {
        App.utils.asserter.assertNotNull(this.canChangeComment, "canChangeComment" + Errors.CANT_NULL);
        return this.canChangeComment();
    }

    public function canChangeDivisionS():Boolean {
        App.utils.asserter.assertNotNull(this.canChangeDivision, "canChangeDivision" + Errors.CANT_NULL);
        return this.canChangeDivision();
    }
}
}

package net.wg.gui.prebattle.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.prebattle.abstract.PrebattleWindowAbstract;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.data.DataProvider;

public class CompanyWindowMeta extends PrebattleWindowAbstract {

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

    private var _array:Array;

    private var _array1:Array;

    private var _dataProvider:DataProvider;

    public function CompanyWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        if (this._array1) {
            this._array1.splice(0, this._array1.length);
            this._array1 = null;
        }
        if (this._dataProvider) {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
        }
        super.onDispose();
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

    public final function as_setDivisionsList(param1:Array, param2:uint):void {
        var _loc3_:DataProvider = this._dataProvider;
        this._dataProvider = new DataProvider(param1);
        this.setDivisionsList(this._dataProvider, param2);
        if (_loc3_) {
            _loc3_.cleanUp();
        }
    }

    public final function as_setClassesLimits(param1:Array):void {
        var _loc2_:Array = this._array;
        this._array = param1;
        this.setClassesLimits(this._array);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    public final function as_setInvalidVehicles(param1:Array):void {
        var _loc2_:Array = this._array1;
        this._array1 = param1;
        this.setInvalidVehicles(this._array1);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setDivisionsList(param1:DataProvider, param2:uint):void {
        var _loc3_:String = "as_setDivisionsList" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function setClassesLimits(param1:Array):void {
        var _loc2_:String = "as_setClassesLimits" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setInvalidVehicles(param1:Array):void {
        var _loc2_:String = "as_setInvalidVehicles" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

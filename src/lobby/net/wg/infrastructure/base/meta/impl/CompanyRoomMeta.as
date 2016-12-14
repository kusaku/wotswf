package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.prebattle.base.BasePrebattleRoomView;
import net.wg.gui.prebattle.company.VO.CompanyRoomInvalidVehiclesVO;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.data.DataProvider;

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

    private var _dataProvider:DataProvider;

    private var _vectorCompanyRoomInvalidVehiclesVO:Vector.<CompanyRoomInvalidVehiclesVO>;

    public function CompanyRoomMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:CompanyRoomInvalidVehiclesVO = null;
        if (this._dataProvider) {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
        }
        if (this._vectorCompanyRoomInvalidVehiclesVO) {
            for each(_loc1_ in this._vectorCompanyRoomInvalidVehiclesVO) {
                _loc1_.dispose();
            }
            this._vectorCompanyRoomInvalidVehiclesVO.splice(0, this._vectorCompanyRoomInvalidVehiclesVO.length);
            this._vectorCompanyRoomInvalidVehiclesVO = null;
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

    public final function as_setInvalidVehicles(param1:Array):void {
        var _loc5_:CompanyRoomInvalidVehiclesVO = null;
        var _loc2_:Vector.<CompanyRoomInvalidVehiclesVO> = this._vectorCompanyRoomInvalidVehiclesVO;
        this._vectorCompanyRoomInvalidVehiclesVO = new Vector.<CompanyRoomInvalidVehiclesVO>(0);
        var _loc3_:uint = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._vectorCompanyRoomInvalidVehiclesVO[_loc4_] = new CompanyRoomInvalidVehiclesVO(param1[_loc4_]);
            _loc4_++;
        }
        this.setInvalidVehicles(this._vectorCompanyRoomInvalidVehiclesVO);
        if (_loc2_) {
            for each(_loc5_ in _loc2_) {
                _loc5_.dispose();
            }
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setDivisionsList(param1:DataProvider, param2:uint):void {
        var _loc3_:String = "as_setDivisionsList" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function setInvalidVehicles(param1:Vector.<CompanyRoomInvalidVehiclesVO>):void {
        var _loc2_:String = "as_setInvalidVehicles" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

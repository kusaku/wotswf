package net.wg.infrastructure.helpers.statisticsDataController {
import flash.display.DisplayObjectContainer;
import flash.events.Event;

import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
import net.wg.infrastructure.base.meta.IBattleStatisticDataControllerMeta;
import net.wg.infrastructure.base.meta.impl.BattleStatisticDataControllerMeta;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.exceptions.LifecycleException;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;
import net.wg.infrastructure.interfaces.IDAAPIModule;

public class BattleStatisticDataController extends BattleStatisticDataControllerMeta implements IBattleStatisticDataControllerMeta, IDAAPIModule {

    private var _componentControllers:Vector.<IBattleComponentDataController>;

    private var _container:DisplayObjectContainer;

    private var _isDisposed:Boolean = false;

    private var _isDAAPIInited:Boolean = false;

    public function BattleStatisticDataController(param1:DisplayObjectContainer) {
        this._componentControllers = new Vector.<IBattleComponentDataController>();
        super();
        this._container = param1;
    }

    public function as_setVehiclesData(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehiclesDataVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.setVehiclesData(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getVehiclesDataVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehiclesDataVO(param1);
    }

    public function as_addVehiclesInfo(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehiclesDataVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.addVehiclesInfo(_loc2_);
        }
        _loc2_.dispose();
    }

    public function as_updateVehiclesInfo(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehiclesDataVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updateVehiclesInfo(_loc2_);
        }
        _loc2_.dispose();
    }

    public function as_updateVehicleStatus(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehicleStatusVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updateVehicleStatus(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getVehicleStatusVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehicleStatusVO(param1);
    }

    public function as_setVehiclesStats(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehiclesStatsVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.setVehicleStats(_loc2_);
        }
        _loc2_.dispose();
    }

    public function as_updateVehiclesStats(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehiclesStatsVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updateVehiclesStats(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getVehiclesStatsVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehiclesStatsVO(param1);
    }

    public function as_updatePlayerStatus(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getPlayerStatusVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updatePlayerStatus(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getPlayerStatusVO(param1:Object):IDAAPIDataClass {
        return new DAAPIPlayerStatusVO(param1);
    }

    public function as_setArenaInfo(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getArenaInfoVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.setArenaInfo(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getArenaInfoVO(param1:Object):IDAAPIDataClass {
        return new DAAPIArenaInfoVO(param1);
    }

    public function as_setUserTags(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehiclesUserTagsVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.setUserTags(_loc2_);
        }
        _loc2_.dispose();
    }

    public function getVehiclesUserTagsVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehiclesUserTagsVO(param1);
    }

    public function as_updateUserTags(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getVehicleUserTagsVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updateUserTags(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getVehicleUserTagsVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehicleUserTagsVO(param1);
    }

    public function as_updateInvitationsStatuses(param1:Object):void {
        var _loc3_:IBattleComponentDataController = null;
        var _loc2_:IDAAPIDataClass = this.getInvitationStatusVO(param1);
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updateInvitationsStatuses(_loc2_);
        }
        _loc2_.dispose();
    }

    protected function getInvitationStatusVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehiclesInvitationStatusVO(param1);
    }

    public function as_setPersonalStatus(param1:uint):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.setPersonalStatus(param1);
        }
    }

    public function as_updatePersonalStatus(param1:uint, param2:uint):void {
        var _loc3_:IBattleComponentDataController = null;
        for each(_loc3_ in this._componentControllers) {
            _loc3_.updatePersonalStatus(param1, param2);
        }
    }

    public function registerComponentController(param1:IBattleComponentDataController):void {
        this._componentControllers.push(param1);
    }

    private function throwLifeCycleException():void {
        if (App.instance) {
            App.utils.asserter.assert(!this._isDisposed, "invoking component \'" + this + "\' after dispose!", LifecycleException);
        }
    }

    public final function as_dispose():void {
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
        this.dispose();
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
    }

    public final function dispose():void {
        App.utils.asserter.assert(!this._isDisposed, "(BattleStatisticsDataController) already disposed!");
        this.onDispose();
        this._isDisposed = true;
    }

    public function as_isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    public final function as_populate():void {
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
        this.onPopulate();
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
    }

    public function as_refresh():void {
        if (this.isOnStage()) {
            onRefreshCompleteS();
        }
        else {
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }
    }

    public function isOnStage():Boolean {
        return this._container != null ? this._container.stage != null : false;
    }

    private function onPopulate():void {
        this._isDAAPIInited = true;
    }

    private function onAddedToStage(param1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        onRefreshCompleteS();
    }

    public function get isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    public function get disposed():Boolean {
        return this._isDisposed;
    }

    private function onDispose():void {
        this._container = null;
        this._componentControllers.fixed = false;
        this._componentControllers.splice(0, this._componentControllers.length);
        this._componentControllers = null;
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
    }

    public function get componentControllers():Vector.<IBattleComponentDataController> {
        return this._componentControllers;
    }
}
}

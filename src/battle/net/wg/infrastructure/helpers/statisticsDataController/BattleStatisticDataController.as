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
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIModule;

public class BattleStatisticDataController extends BattleStatisticDataControllerMeta implements IBattleStatisticDataControllerMeta, IDAAPIModule {

    private var _componentControllers:Vector.<IBattleComponentDataController>;

    private var _container:DisplayObjectContainer;

    private var _isDAAPIInited:Boolean = false;

    public function BattleStatisticDataController(param1:DisplayObjectContainer) {
        this._componentControllers = new Vector.<IBattleComponentDataController>();
        super();
        this._container = param1;
    }

    override protected function setVehiclesData(param1:DAAPIVehiclesDataVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.setVehiclesData(param1);
        }
    }

    override protected function addVehiclesInfo(param1:DAAPIVehiclesDataVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.addVehiclesInfo(param1);
        }
    }

    override protected function updateVehiclesInfo(param1:DAAPIVehiclesDataVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.updateVehiclesData(param1);
        }
    }

    override protected function updateVehicleStatus(param1:DAAPIVehicleStatusVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.updateVehicleStatus(param1);
        }
    }

    override protected function setVehiclesStats(param1:DAAPIVehiclesStatsVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.setVehicleStats(param1);
        }
    }

    override protected function updateVehiclesStats(param1:DAAPIVehiclesStatsVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.updateVehiclesStat(param1);
        }
    }

    override protected function updatePlayerStatus(param1:DAAPIPlayerStatusVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.updatePlayerStatus(param1);
        }
    }

    override protected function setArenaInfo(param1:DAAPIArenaInfoVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.setArenaInfo(param1);
        }
    }

    override protected function setUserTags(param1:DAAPIVehiclesUserTagsVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.setUserTags(param1);
        }
    }

    override protected function updateUserTags(param1:DAAPIVehicleUserTagsVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.updateUserTags(param1);
        }
    }

    override protected function updateInvitationsStatuses(param1:DAAPIVehiclesInvitationStatusVO):void {
        var _loc2_:IBattleComponentDataController = null;
        for each(_loc2_ in this._componentControllers) {
            _loc2_.updateInvitationsStatuses(param1);
        }
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

    public function as_isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    override protected function onPopulate():void {
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
        this._isDAAPIInited = true;
        super.onPopulate();
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

    private function onAddedToStage(param1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        onRefreshCompleteS();
    }

    public function get isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    public function get disposed():Boolean {
        return _baseDisposed;
    }

    override protected function onDispose():void {
        this._container = null;
        this._componentControllers.fixed = false;
        this._componentControllers.splice(0, this._componentControllers.length);
        this._componentControllers = null;
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        super.onDispose();
    }

    public function get componentControllers():Vector.<IBattleComponentDataController> {
        return this._componentControllers;
    }
}
}

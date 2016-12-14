package net.wg.gui.battle.battleloading {
import net.wg.data.Aliases;
import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public class BattleLoading extends BaseBattleLoading {

    private static const FORM_VISIBLE_AREA_HEIGHT:int = 545;

    public var form:BattleLoadingForm;

    public function BattleLoading() {
        super();
    }

    override public function setVehiclesData(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleInfoVO = null;
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        var _loc3_:Array = [];
        for each(_loc4_ in _loc2_.leftVehicleInfos) {
            _loc3_.push(_loc4_);
        }
        this.form.setVehiclesData(false, _loc3_, _loc2_.leftVehiclesIDs);
        _loc3_ = [];
        for each(_loc4_ in _loc2_.rightVehicleInfos) {
            _loc3_.push(_loc4_);
        }
        this.form.setVehiclesData(true, _loc3_, _loc2_.rightVehiclesIDs);
    }

    override public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        this.form.addVehiclesInfo(false, _loc2_.leftVehicleInfos, _loc2_.leftVehiclesIDs);
        this.form.addVehiclesInfo(true, _loc2_.rightVehicleInfos, _loc2_.rightVehiclesIDs);
    }

    override public function updateVehiclesData(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        this.form.updateVehiclesInfo(false, _loc2_.leftVehicleInfos, _loc2_.leftVehiclesIDs);
        this.form.updateVehiclesInfo(true, _loc2_.rightVehicleInfos, _loc2_.rightVehiclesIDs);
    }

    override public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        this.form.setVehicleStatus(false, _loc2_.vehicleID, _loc2_.status, _loc2_.leftVehiclesIDs);
        this.form.setVehicleStatus(true, _loc2_.vehicleID, _loc2_.status, _loc2_.rightVehiclesIDs);
    }

    override public function updatePersonalStatus(param1:uint, param2:uint):void {
    }

    override public function setVehicleStats(param1:IDAAPIDataClass):void {
    }

    override public function updateVehiclesStat(param1:IDAAPIDataClass):void {
    }

    override public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        this.form.setPlayerStatus(_loc2_.isEnemy, _loc2_.vehicleID, _loc2_.status);
    }

    override public function setArenaInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIArenaInfoVO = DAAPIArenaInfoVO(param1);
        this.form.updateMapName(_loc2_.mapName);
        this.form.setBattleTypeName(_loc2_.battleTypeLocaleStr);
        this.form.updateWinText(_loc2_.winText);
        this.form.updateTeamsHeaders(_loc2_.allyTeamName, _loc2_.enemyTeamName);
        this.form.setBattleTypeFrameName(_loc2_.battleTypeFrameLabel);
    }

    override public function setUserTags(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
        this.form.setUserTags(false, _loc2_.leftUserTags);
        this.form.setUserTags(true, _loc2_.rightUserTags);
    }

    override public function updateUserTags(param1:IDAAPIDataClass):void {
    }

    override public function setPersonalStatus(param1:uint):void {
    }

    override public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
    }

    override public function as_setMapIcon(param1:String):void {
        var _loc2_:UILoaderAlt = this.form.getMapIconComponent();
        _loc2_.addEventListener(UILoaderEvent.COMPLETE, this.onMapIconCompleteHandler, false, 0, true);
        _loc2_.addEventListener(UILoaderEvent.IOERROR, this.onMapIconCompleteHandler, false, 0, true);
        this.form.setMapIcon(param1);
    }

    override public function as_setPlayerData(param1:Number, param2:Number):void {
        this.form.setPlayerInfo(param1, param2);
    }

    override public function as_setProgress(param1:Number):void {
        this.form.updateProgress(param1);
    }

    override public function as_setTip(param1:String):void {
        this.form.updateTipBody(param1);
    }

    override public function as_setTipTitle(param1:String):void {
        this.form.updateTipTitle(param1);
    }

    override public function toString():String {
        return "[WG BattleLoading " + name + "]";
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        this.form.x = param1 >> 1;
        this.form.y = param2 - FORM_VISIBLE_AREA_HEIGHT >> 1;
    }

    override protected function setVisualTipInfo(param1:VisualTipInfoVO):void {
        this.form.setFormDisplayData(param1);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.form.getMapComponent(), Aliases.MINIMAP_ON_BATTLE_LOADING);
    }

    override protected function setEventInfoPanelData(param1:EventInfoPanelVO):void {
    }

    override protected function onDispose():void {
        this.removeMapIconListeners();
        this.form.dispose();
        this.form = null;
        super.onDispose();
    }

    private function removeMapIconListeners():void {
        var _loc1_:UILoaderAlt = this.form.getMapIconComponent();
        _loc1_.removeEventListener(UILoaderEvent.COMPLETE, this.onMapIconCompleteHandler);
        _loc1_.removeEventListener(UILoaderEvent.IOERROR, this.onMapIconCompleteHandler);
    }

    private function onMapIconCompleteHandler(param1:UILoaderEvent):void {
        this.removeMapIconListeners();
        this.visible = true;
    }
}
}

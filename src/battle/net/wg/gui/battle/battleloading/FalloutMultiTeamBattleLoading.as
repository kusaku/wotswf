package net.wg.gui.battle.battleloading {
import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public class FalloutMultiTeamBattleLoading extends BaseBattleLoading {

    private static const FORM_HEIGHT_WITHOUT_SHADOW:int = 800;

    public var form:FalloutMultiTeamForm;

    public function FalloutMultiTeamBattleLoading() {
        super();
    }

    override public function updatePersonalStatus(param1:uint, param2:uint):void {
    }

    override public function setVehicleStats(param1:IDAAPIDataClass):void {
    }

    override public function updateVehiclesStat(param1:IDAAPIDataClass):void {
    }

    override public function setUserTags(param1:IDAAPIDataClass):void {
    }

    override public function updateUserTags(param1:IDAAPIDataClass):void {
    }

    override public function setPersonalStatus(param1:uint):void {
    }

    override public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
    }

    override public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        this.form.addVehiclesInfo(_loc2_.leftVehicleInfos.concat(_loc2_.rightVehicleInfos), _loc2_.leftVehiclesIDs.concat(_loc2_.rightVehiclesIDs));
    }

    override public function setVehiclesData(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleInfoVO = null;
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        var _loc3_:Array = [];
        for each(_loc4_ in _loc2_.leftVehicleInfos.concat(_loc2_.rightVehicleInfos)) {
            _loc3_.push(_loc4_);
        }
        this.form.setVehiclesData(_loc3_);
    }

    override public function setArenaInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIArenaInfoVO = DAAPIArenaInfoVO(param1);
        this.form.setBattleTypeName(_loc2_.battleTypeLocaleStr);
        this.form.updateWinText(_loc2_.winText);
        this.form.updateMapName(_loc2_.mapName);
        this.form.setBattleTypeFrameName(_loc2_.battleTypeFrameLabel);
    }

    override public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        this.form.setVehicleStatus(_loc2_.vehicleID, _loc2_.status, _loc2_.leftVehiclesIDs.concat(_loc2_.rightVehiclesIDs));
    }

    override public function updateVehiclesData(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        this.form.updateVehiclesInfo(_loc2_.leftVehicleInfos.concat(_loc2_.rightVehicleInfos), _loc2_.leftVehiclesIDs.concat(_loc2_.rightVehiclesIDs));
    }

    override public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        this.form.setPlayerStatus(_loc2_.vehicleID, _loc2_.status);
    }

    override public function as_setMapIcon(param1:String):void {
        this.form.setMapIcon(param1);
    }

    override public function as_setPlayerData(param1:Number, param2:Number):void {
        this.form.setPlayerInfo(param1, param2);
    }

    override public function as_setProgress(param1:Number):void {
        this.form.updateProgress(param1);
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        this.form.x = param1 >> 1;
        this.form.y = param2 - FORM_HEIGHT_WITHOUT_SHADOW >> 1;
        this.form.invalidateSize();
    }

    override protected function setEventInfoPanelData(param1:EventInfoPanelVO):void {
        this.form.setEventInfo(param1);
    }

    override protected function setVisualTipInfo(param1:VisualTipInfoVO):void {
    }

    override protected function onDispose():void {
        this.form.dispose();
        this.form = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.form.beforePopulateData();
    }
}
}

package net.wg.gui.battle.falloutClassic.components.fullStats {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.gui.battle.views.stats.BattleTipsController;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.meta.IFCStatsMeta;
import net.wg.infrastructure.base.meta.impl.FCStatsMeta;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

import scaleform.gfx.TextFieldEx;

public class FCFullStats extends FCStatsMeta implements IFCStatsMeta, IBattleComponentDataController {

    private static const HEIGHT:int = 660;

    public var table:FCStatsTable = null;

    public var mapIcon:UILoaderAlt = null;

    public var modalBgSpr:Sprite = null;

    public var mapTF:TextField = null;

    public var battleTF:TextField = null;

    public var winTF:TextField = null;

    public var team1TF:TextField = null;

    public var team2TF:TextField = null;

    public var titleTipTF:TextField = null;

    public var bodyTipLeftTF:TextField = null;

    public var bodyTipRightTF:TextField = null;

    public var bodyTipCenterTF:TextField = null;

    private var _tableCtrl:FCStatsTableController = null;

    private var _battleTips:BattleTipsController = null;

    public function FCFullStats() {
        super();
        this._battleTips = new BattleTipsController(this.titleTipTF, this.bodyTipLeftTF, this.bodyTipRightTF, this.bodyTipCenterTF);
        this._tableCtrl = new FCStatsTableController(this.table);
        TextFieldEx.setNoTranslate(this.mapTF, true);
        TextFieldEx.setNoTranslate(this.battleTF, true);
        TextFieldEx.setNoTranslate(this.winTF, true);
        TextFieldEx.setNoTranslate(this.team1TF, true);
        TextFieldEx.setNoTranslate(this.team2TF, true);
        visible = false;
    }

    public function updateStageSize(param1:Number, param2:Number):void {
        var _loc3_:Number = NaN;
        this.modalBgSpr.visible = false;
        _loc3_ = param1 - this.width >> 1;
        var _loc4_:Number = param2 - HEIGHT >> 1;
        this.x = _loc3_;
        this.y = _loc4_;
        this.modalBgSpr.x = -_loc3_;
        this.modalBgSpr.y = -_loc4_;
        this.modalBgSpr.width = param1;
        this.modalBgSpr.height = param2;
        this.modalBgSpr.visible = true;
    }

    public function setArenaInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIArenaInfoVO = DAAPIArenaInfoVO(param1);
        this.mapIcon.source = _loc2_.mapIcon;
        this.mapTF.text = _loc2_.mapName;
        this.battleTF.text = _loc2_.battleTypeLocaleStr;
        this.team1TF.text = _loc2_.allyTeamName;
        this.team2TF.text = _loc2_.enemyTeamName;
        var _loc3_:Number = this.winTF.y + (this.winTF.height >> 1);
        var _loc4_:Number = this.battleTF.y + (this.winTF.height >> 1);
        this.winTF.autoSize = TextFieldAutoSize.CENTER;
        this.winTF.text = _loc2_.winText;
        this.winTF.y = _loc3_ - (this.winTF.height >> 1);
        this.battleTF.y = _loc4_ - (this.winTF.height >> 1);
        if (_loc2_.getQuestTipsTitle()) {
            this._battleTips.setText(_loc2_.getQuestTipsTitle(), _loc2_.getQuestTipsMainCondition(), _loc2_.getQuestTipsAdditionalCondition());
        }
        else {
            this._battleTips.hide();
        }
    }

    public function setVehiclesData(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleInfoVO = null;
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        var _loc3_:Array = [];
        for each(_loc4_ in _loc2_.leftVehicleInfos) {
            _loc3_.push(_loc4_);
        }
        this._tableCtrl.setVehiclesData(_loc3_, _loc2_.leftVehiclesIDs, false);
        _loc3_ = [];
        for each(_loc4_ in _loc2_.rightVehicleInfos) {
            _loc3_.push(_loc4_);
        }
        this._tableCtrl.setVehiclesData(_loc3_, _loc2_.rightVehiclesIDs, true);
    }

    public function updateVehiclesData(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._tableCtrl.updateVehiclesData(_loc2_.leftVehicleInfos, _loc2_.leftVehiclesIDs, false);
        }
        if (_loc2_.rightVehicleInfos) {
            this._tableCtrl.updateVehiclesData(_loc2_.rightVehicleInfos, _loc2_.rightVehiclesIDs, false);
        }
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._tableCtrl.addVehiclesInfo(_loc2_.leftVehicleInfos, _loc2_.leftVehiclesIDs, false);
        }
        if (_loc2_.rightVehicleInfos) {
            this._tableCtrl.addVehiclesInfo(_loc2_.rightVehicleInfos, _loc2_.leftVehiclesIDs, true);
        }
    }

    public function updateVehiclesStat(param1:IDAAPIDataClass):void {
        this._tableCtrl.setVehiclesStats(DAAPIVehiclesInteractiveStatsVO(param1));
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        this._tableCtrl.setVehiclesStats(DAAPIVehiclesInteractiveStatsVO(param1));
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        this._tableCtrl.setVehicleStatus(false, _loc2_.vehicleID, _loc2_.status, _loc2_.leftVehiclesIDs);
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
    }

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        this._tableCtrl.setPlayerStatus(_loc2_.isEnemy, _loc2_.vehicleID, _loc2_.status);
    }

    public function setPersonalStatus(param1:uint):void {
    }

    public function updatePersonalStatus(param1:uint, param2:uint):void {
    }

    public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
    }

    override protected function onDispose():void {
        this.table.dispose();
        this.mapIcon.dispose();
        this._tableCtrl.dispose();
        this._battleTips.dispose();
        this.table = null;
        this.mapIcon = null;
        this.modalBgSpr = null;
        this.titleTipTF = null;
        this.bodyTipLeftTF = null;
        this.bodyTipRightTF = null;
        this.bodyTipCenterTF = null;
        this.mapTF = null;
        this.battleTF = null;
        this.winTF = null;
        this.team1TF = null;
        this.team2TF = null;
        this._tableCtrl = null;
        this._battleTips = null;
        super.onDispose();
    }
}
}

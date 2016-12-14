package net.wg.gui.battle.random.views.stats.components.fullStats {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
import net.wg.data.constants.PersonalStatus;
import net.wg.gui.battle.views.stats.BattleTipsController;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.meta.IFullStatsMeta;
import net.wg.infrastructure.base.meta.impl.FullStatsMeta;
import net.wg.infrastructure.events.ColorSchemeEvent;
import net.wg.infrastructure.events.VoiceChatEvent;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

import scaleform.gfx.TextFieldEx;

public class FullStats extends FullStatsMeta implements IFullStatsMeta, IBattleComponentDataController {

    private static const BATTLE_ICON_PREFIX:String = "battle_";

    private static const HEIGHT:int = 700;

    public var battleIcon:BattleIconView = null;

    public var statsTable:FullStatsTable = null;

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

    private var _tableCtrl:FullStatsTableCtrl = null;

    private var _battleTips:BattleTipsController = null;

    private var _personalStatus:uint = 0;

    private var _isInteractive:Boolean = false;

    public function FullStats() {
        super();
        this._battleTips = new BattleTipsController(this.titleTipTF, this.bodyTipLeftTF, this.bodyTipRightTF, this.bodyTipCenterTF);
        this._tableCtrl = new FullStatsTableCtrl(this.statsTable, this);
        TextFieldEx.setNoTranslate(this.mapTF, true);
        TextFieldEx.setNoTranslate(this.battleTF, true);
        TextFieldEx.setNoTranslate(this.winTF, true);
        TextFieldEx.setNoTranslate(this.team1TF, true);
        TextFieldEx.setNoTranslate(this.team2TF, true);
        visible = false;
    }

    public function as_setIsIntaractive(param1:Boolean):void {
        this._isInteractive = param1;
        this.applyInteractivity();
    }

    public function updateStageSize(param1:Number, param2:Number):void {
        var _loc3_:Number = NaN;
        this.modalBgSpr.visible = false;
        _loc3_ = param1 - initedWidth >> 1;
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
        var _loc4_:Number = NaN;
        var _loc2_:DAAPIArenaInfoVO = DAAPIArenaInfoVO(param1);
        this.battleIcon.showIcon(BATTLE_ICON_PREFIX + _loc2_.battleTypeFrameLabel);
        this.mapIcon.source = _loc2_.mapIcon;
        this.mapTF.text = _loc2_.mapName;
        this.battleTF.text = _loc2_.battleTypeLocaleStr;
        this.team1TF.text = _loc2_.allyTeamName;
        this.team2TF.text = _loc2_.enemyTeamName;
        var _loc3_:Number = this.winTF.y + (this.winTF.height >> 1);
        _loc4_ = this.battleTF.y + (this.winTF.height >> 1);
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
        this._tableCtrl.updateVehiclesData(_loc2_.leftVehicleInfos, _loc2_.leftVehiclesIDs, false);
        this._tableCtrl.updateVehiclesData(_loc2_.rightVehicleInfos, _loc2_.rightVehiclesIDs, true);
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        this._tableCtrl.addVehiclesInfo(_loc2_.leftVehicleInfos, _loc2_.leftVehiclesIDs, false);
        this._tableCtrl.addVehiclesInfo(_loc2_.rightVehicleInfos, _loc2_.rightVehiclesIDs, true);
    }

    public function updateVehiclesStat(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        this._tableCtrl.setVehiclesStats(_loc2_.leftFrags, _loc2_.rightFrags);
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        this._tableCtrl.setVehiclesStats(_loc2_.leftFrags, _loc2_.rightFrags);
    }

    override public function setCompVisible(param1:Boolean):void {
        super.setCompVisible(param1);
        this._tableCtrl.isRenderingAvailable = param1;
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        this._tableCtrl.setVehicleStatus(false, _loc2_.vehicleID, _loc2_.status, _loc2_.leftVehiclesIDs);
        this._tableCtrl.setVehicleStatus(true, _loc2_.vehicleID, _loc2_.status, _loc2_.rightVehiclesIDs);
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
        this._tableCtrl.setUserTags(false, _loc2_.leftUserTags);
        this._tableCtrl.setUserTags(true, _loc2_.rightUserTags);
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
        this._tableCtrl.setUserTags(_loc2_.isEnemy, new <DAAPIVehicleUserTagsVO>[_loc2_]);
    }

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        this._tableCtrl.setPlayerStatus(_loc2_.isEnemy, _loc2_.vehicleID, _loc2_.status);
    }

    public function setPersonalStatus(param1:uint):void {
        this._personalStatus = param1;
        this.applyPersonalStatus();
    }

    public function updatePersonalStatus(param1:uint, param2:uint):void {
        if (param1 > 0) {
            this._personalStatus = this._personalStatus | param1;
        }
        if (param2 > 0) {
            this._personalStatus = this._personalStatus & ~param2;
        }
        this.applyPersonalStatus();
    }

    public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
        this._tableCtrl.updateInvitationsStatuses(false, _loc2_.leftItems);
        this._tableCtrl.updateInvitationsStatuses(true, _loc2_.rightItems);
    }

    override protected function configUI():void {
        super.configUI();
        App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.onStartSpeakingHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.onStopSpeakingHandler);
        App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
    }

    override protected function onDispose():void {
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING, this.onStartSpeakingHandler);
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING, this.onStopSpeakingHandler);
        App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
        this.battleIcon.dispose();
        this.statsTable.dispose();
        this.mapIcon.dispose();
        this._tableCtrl.dispose();
        this._battleTips.dispose();
        this.battleIcon = null;
        this.statsTable = null;
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

    private function onStartSpeakingHandler(param1:VoiceChatEvent):void {
        this._tableCtrl.setSpeaking(param1.getAccountDBID(), true);
    }

    private function onStopSpeakingHandler(param1:VoiceChatEvent):void {
        this._tableCtrl.setSpeaking(param1.getAccountDBID(), false);
    }

    private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent):void {
        this._tableCtrl.updateColorBlind();
    }

    private function applyPersonalStatus():void {
        this._tableCtrl.setIsInviteShown(PersonalStatus.isShowAllyInvites(this._personalStatus), PersonalStatus.isShowEnemyInvites(this._personalStatus));
        this.applyInteractivity();
    }

    private function applyInteractivity():void {
        var _loc1_:Boolean = this._isInteractive && !PersonalStatus.isSquadRestrictions(this._personalStatus);
        var _loc2_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToAlly(this._personalStatus);
        var _loc3_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToEnemy(this._personalStatus);
        this._tableCtrl.setInteractive(_loc2_, _loc3_);
    }
}
}

package net.wg.gui.battle.random.views.stats.components.fullStats {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.VehicleStatusLightVO;
import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
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

    private var _leftVehiclesIDs:Vector.<Number> = null;

    private var _rightVehiclesIDs:Vector.<Number> = null;

    public var leftFrags:Vector.<DAAPIVehicleStatsVO>;

    public var rightFrags:Vector.<DAAPIVehicleStatsVO>;

    public var leftVehicleInfos:Vector.<DAAPIVehicleInfoVO>;

    public var rightVehicleInfos:Vector.<DAAPIVehicleInfoVO>;

    public var userTags:Vector.<DAAPIVehicleUserTagsVO>;

    public var vehicleStatus:Vector.<VehicleStatusLightVO>;

    public function FullStats() {
        this.leftFrags = new Vector.<DAAPIVehicleStatsVO>();
        this.rightFrags = new Vector.<DAAPIVehicleStatsVO>();
        this.leftVehicleInfos = new Vector.<DAAPIVehicleInfoVO>();
        this.rightVehicleInfos = new Vector.<DAAPIVehicleInfoVO>();
        this.userTags = new Vector.<DAAPIVehicleUserTagsVO>();
        this.vehicleStatus = new Vector.<VehicleStatusLightVO>();
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
        this.modalBgSpr.visible = false;
        var _loc3_:Number = param1 - initedWidth >> 1;
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
        this.battleIcon.showIcon(BATTLE_ICON_PREFIX + _loc2_.battleTypeFrameLabel);
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
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._tableCtrl.setTeamData(_loc2_.leftVehicleInfos, false);
        }
        if (_loc2_.rightVehicleInfos) {
            this._tableCtrl.setTeamData(_loc2_.rightVehicleInfos, true);
        }
        if (!_isCompVisible) {
            if (_loc2_.leftVehiclesIDs) {
                this._leftVehiclesIDs = _loc2_.leftVehiclesIDs;
            }
            if (_loc2_.rightVehiclesIDs) {
                this._rightVehiclesIDs = _loc2_.rightVehiclesIDs;
            }
        }
        else {
            if (_loc2_.leftVehiclesIDs) {
                this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs, false);
            }
            if (_loc2_.rightVehiclesIDs) {
                this._tableCtrl.updateOrder(_loc2_.rightVehiclesIDs, true);
            }
        }
    }

    public function updateVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc3_:DAAPIVehicleInfoVO = null;
        var _loc4_:Boolean = false;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:Vector.<DAAPIVehicleInfoVO> = null;
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (!_isCompVisible) {
            _loc5_ = this.leftVehicleInfos.length;
            _loc7_ = new Vector.<DAAPIVehicleInfoVO>();
            for each(_loc3_ in _loc2_.leftVehicleInfos) {
                _loc4_ = false;
                _loc6_ = 0;
                while (_loc6_ < _loc5_) {
                    if (this.leftVehicleInfos[_loc6_].vehicleID == _loc3_.vehicleID) {
                        this.leftVehicleInfos[_loc6_] = _loc3_.clone();
                        _loc4_ = true;
                    }
                    _loc6_++;
                }
                if (!_loc4_) {
                    _loc7_.push(_loc3_);
                }
            }
            _loc5_ = this.rightVehicleInfos.length;
            for each(_loc3_ in _loc2_.rightVehicleInfos) {
                _loc4_ = false;
                _loc6_ = 0;
                while (_loc6_ < _loc5_) {
                    if (this.rightVehicleInfos[_loc6_].vehicleID == _loc3_.vehicleID) {
                        this.rightVehicleInfos[_loc6_] = _loc3_.clone();
                        _loc4_ = true;
                    }
                    _loc6_++;
                }
                if (!_loc4_) {
                    _loc7_.push(_loc3_);
                }
            }
            if (_loc7_.length > 0) {
                this._tableCtrl.updateVehiclesData(_loc7_);
            }
        }
        else {
            if (_loc2_.leftVehicleInfos) {
                this._tableCtrl.updateVehiclesData(_loc2_.leftVehicleInfos);
            }
            if (_loc2_.rightVehicleInfos) {
                this._tableCtrl.updateVehiclesData(_loc2_.rightVehicleInfos);
            }
        }
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc3_:DAAPIVehicleInfoVO = null;
        var _loc4_:Boolean = false;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (!_isCompVisible) {
            _loc5_ = this.leftVehicleInfos.length;
            for each(_loc3_ in _loc2_.leftVehicleInfos) {
                _loc4_ = false;
                _loc6_ = 0;
                while (_loc6_ < _loc5_) {
                    if (this.leftVehicleInfos[_loc6_].vehicleID == _loc3_.vehicleID) {
                        this.leftVehicleInfos[_loc6_] = _loc3_.clone();
                        _loc4_ = true;
                    }
                    _loc6_++;
                }
                if (!_loc4_) {
                    this.leftVehicleInfos.push(_loc3_.clone());
                }
            }
            _loc5_ = this.rightVehicleInfos.length;
            for each(_loc3_ in _loc2_.rightVehicleInfos) {
                _loc4_ = false;
                _loc6_ = 0;
                while (_loc6_ < _loc5_) {
                    if (this.rightVehicleInfos[_loc6_].vehicleID == _loc3_.vehicleID) {
                        this.rightVehicleInfos[_loc6_] = _loc3_.clone();
                        _loc4_ = true;
                    }
                    _loc6_++;
                }
                if (!_loc4_) {
                    this.rightVehicleInfos.push(_loc3_.clone());
                }
            }
            if (_loc2_.leftVehiclesIDs) {
                this._leftVehiclesIDs = _loc2_.leftVehiclesIDs;
            }
            if (_loc2_.rightVehiclesIDs) {
                this._rightVehiclesIDs = _loc2_.rightVehiclesIDs;
            }
        }
        else {
            if (_loc2_.leftVehicleInfos) {
                this._tableCtrl.addVehiclesData(_loc2_.leftVehicleInfos, false);
            }
            if (_loc2_.rightVehicleInfos) {
                this._tableCtrl.addVehiclesData(_loc2_.rightVehicleInfos, true);
            }
            if (_loc2_.leftVehiclesIDs) {
                this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs, false);
            }
            if (_loc2_.rightVehiclesIDs) {
                this._tableCtrl.updateOrder(_loc2_.rightVehiclesIDs, true);
            }
        }
    }

    public function updateVehiclesStats(param1:IDAAPIDataClass):void {
        var _loc3_:DAAPIVehicleStatsVO = null;
        var _loc4_:DAAPIVehicleStatsVO = null;
        var _loc5_:Boolean = false;
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        if (!_isCompVisible) {
            for each(_loc3_ in _loc2_.leftFrags) {
                _loc5_ = false;
                for each(_loc4_ in this.leftFrags) {
                    if (_loc4_.vehicleID == _loc3_.vehicleID) {
                        _loc4_.frags = _loc3_.frags;
                        _loc5_ = true;
                    }
                }
                if (!_loc5_) {
                    this.leftFrags.push(_loc3_.clone());
                }
            }
            for each(_loc3_ in _loc2_.rightFrags) {
                _loc5_ = false;
                for each(_loc4_ in this.rightFrags) {
                    if (_loc4_.vehicleID == _loc3_.vehicleID) {
                        _loc4_.frags = _loc3_.frags;
                        _loc5_ = true;
                    }
                }
                if (!_loc5_) {
                    this.rightFrags.push(_loc3_.clone());
                }
            }
        }
        else {
            this._tableCtrl.setVehiclesStats(_loc2_.leftFrags, _loc2_.rightFrags);
        }
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        var _loc3_:DAAPIVehicleStatsVO = null;
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        if (!_isCompVisible) {
            this.leftFrags = new Vector.<DAAPIVehicleStatsVO>();
            this.rightFrags = new Vector.<DAAPIVehicleStatsVO>();
            for each(_loc3_ in _loc2_.leftFrags) {
                this.leftFrags.push(_loc3_.clone());
            }
            for each(_loc3_ in _loc2_.rightFrags) {
                this.rightFrags.push(_loc3_.clone());
            }
        }
        else {
            this._tableCtrl.setVehiclesStats(_loc2_.leftFrags, _loc2_.rightFrags);
        }
    }

    override public function setCompVisible(param1:Boolean):void {
        var _loc2_:VehicleStatusLightVO = null;
        var _loc3_:DAAPIVehicleUserTagsVO = null;
        super.setCompVisible(param1);
        if (param1) {
            if (this.leftVehicleInfos) {
                this._tableCtrl.addVehiclesData(this.leftVehicleInfos, false);
            }
            if (this.rightVehicleInfos) {
                this._tableCtrl.addVehiclesData(this.rightVehicleInfos, true);
            }
            this._tableCtrl.setVehiclesStats(this.leftFrags, this.rightFrags);
            for each(_loc2_ in this.vehicleStatus) {
                this._tableCtrl.setVehicleStatus(_loc2_.vehicleID, _loc2_.status);
            }
            for each(_loc3_ in this.userTags) {
                this._tableCtrl.setUserTags(_loc3_.vehicleID, _loc3_.userTags);
            }
            this._tableCtrl.updateOrder(this._leftVehiclesIDs, false);
            this._tableCtrl.updateOrder(this._rightVehiclesIDs, true);
            this.leftFrags.splice(0, this.leftFrags.length);
            this.rightFrags.splice(0, this.rightFrags.length);
            this.leftVehicleInfos.splice(0, this.leftVehicleInfos.length);
            this.rightVehicleInfos.splice(0, this.rightVehicleInfos.length);
            this.vehicleStatus.splice(0, this.vehicleStatus.length);
            this.userTags.splice(0, this.userTags.length);
            this._leftVehiclesIDs = null;
            this._rightVehiclesIDs = null;
        }
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc3_:VehicleStatusLightVO = null;
        var _loc4_:Boolean = false;
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        if (!_isCompVisible) {
            _loc4_ = false;
            for each(_loc3_ in this.vehicleStatus) {
                if (_loc3_.vehicleID == _loc2_.vehicleID) {
                    _loc3_.status = _loc2_.status;
                    _loc4_ = true;
                }
            }
            if (!_loc4_) {
                this.vehicleStatus.push(new VehicleStatusLightVO(_loc2_.vehicleID, _loc2_.status));
            }
            if (_loc2_.leftVehiclesIDs) {
                this._leftVehiclesIDs = _loc2_.leftVehiclesIDs;
            }
            if (_loc2_.rightVehiclesIDs) {
                this._rightVehiclesIDs = _loc2_.rightVehiclesIDs;
            }
        }
        else {
            this._tableCtrl.setVehicleStatus(_loc2_.vehicleID, _loc2_.status);
            if (_loc2_.leftVehiclesIDs) {
                this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs, false);
            }
            if (_loc2_.rightVehiclesIDs) {
                this._tableCtrl.updateOrder(_loc2_.rightVehiclesIDs, true);
            }
        }
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleUserTagsVO = null;
        var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
        var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = _loc2_.leftUserTags;
        for each(_loc4_ in _loc3_) {
            this._tableCtrl.setUserTags(_loc4_.vehicleID, _loc4_.userTags);
        }
        _loc3_ = _loc2_.rightUserTags;
        for each(_loc4_ in _loc3_) {
            this._tableCtrl.setUserTags(_loc4_.vehicleID, _loc4_.userTags);
        }
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
        var _loc3_:DAAPIVehicleUserTagsVO = null;
        var _loc4_:Boolean = false;
        var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
        if (!_isCompVisible) {
            _loc4_ = false;
            for each(_loc3_ in this.userTags) {
                if (_loc3_.vehicleID == _loc2_.vehicleID) {
                    _loc3_.isEnemy = _loc2_.isEnemy;
                    _loc3_.userTags = _loc2_.userTags;
                    _loc4_ = true;
                }
            }
            if (!_loc4_) {
                this.userTags.push(_loc2_.clone());
            }
        }
        else {
            this._tableCtrl.setUserTags(_loc2_.vehicleID, _loc2_.userTags);
        }
    }

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc3_:Vector.<DAAPIVehicleInfoVO> = null;
        var _loc4_:DAAPIVehicleInfoVO = null;
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        if (!_isCompVisible) {
            _loc3_ = !!_loc2_.isEnemy ? this.rightVehicleInfos : this.leftVehicleInfos;
            for each(_loc4_ in _loc3_) {
                if (_loc4_.vehicleID == _loc2_.vehicleID) {
                    _loc4_.playerStatus = _loc2_.status;
                }
            }
        }
        else {
            this._tableCtrl.setPlayerStatus(_loc2_.vehicleID, _loc2_.status);
        }
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
        var _loc4_:DAAPIInvitationStatusVO = null;
        var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
        var _loc3_:Vector.<DAAPIInvitationStatusVO> = _loc2_.leftItems;
        for each(_loc4_ in _loc3_) {
            this._tableCtrl.setInvitationStatus(_loc4_.vehicleID, _loc4_.status);
        }
        _loc3_ = _loc2_.rightItems;
        for each(_loc4_ in _loc3_) {
            this._tableCtrl.setInvitationStatus(_loc4_.vehicleID, _loc4_.status);
        }
    }

    override protected function configUI():void {
        super.configUI();
        App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.onStartSpeakingHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.onStopSpeakingHandler);
        App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
    }

    override protected function onDispose():void {
        var _loc1_:DAAPIVehicleStatsVO = null;
        var _loc2_:DAAPIVehicleInfoVO = null;
        var _loc3_:DAAPIVehicleUserTagsVO = null;
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
        while (this.leftFrags && this.leftFrags.length > 0) {
            _loc1_ = this.leftFrags.shift();
            _loc1_.dispose();
        }
        this.leftFrags = null;
        while (this.rightFrags && this.rightFrags.length > 0) {
            _loc1_ = this.rightFrags.shift();
            _loc1_.dispose();
        }
        this.rightFrags = null;
        this._leftVehiclesIDs = null;
        this._rightVehiclesIDs = null;
        while (this.leftVehicleInfos && this.leftVehicleInfos.length > 0) {
            _loc2_ = this.leftVehicleInfos.shift();
            _loc2_.dispose();
        }
        this.leftVehicleInfos = null;
        while (this.rightVehicleInfos && this.rightVehicleInfos.length > 0) {
            _loc2_ = this.rightVehicleInfos.shift();
            _loc2_.dispose();
        }
        this.rightVehicleInfos = null;
        while (this.userTags && this.userTags.length > 0) {
            _loc3_ = this.userTags.shift();
            _loc3_.dispose();
        }
        this.userTags = null;
        this.vehicleStatus = null;
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

    private function updateOrder(param1:Vector.<Number>, param2:Boolean):void {
        this._tableCtrl.updateOrder(param1, param2);
    }

    private function applyInteractivity():void {
        var _loc1_:Boolean = this._isInteractive && !PersonalStatus.isSquadRestrictions(this._personalStatus);
        var _loc2_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToAlly(this._personalStatus);
        var _loc3_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToEnemy(this._personalStatus);
        this._tableCtrl.setInteractive(_loc2_, _loc3_);
    }
}
}

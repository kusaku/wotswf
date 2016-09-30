package net.wg.gui.battle.random.views.stats.components.playersPanel {
import flash.events.MouseEvent;

import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
import net.wg.data.constants.PersonalStatus;
import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelListEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelList;
import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitch;
import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
import net.wg.infrastructure.base.meta.IPlayersPanelMeta;
import net.wg.infrastructure.base.meta.IStatsBaseMeta;
import net.wg.infrastructure.base.meta.impl.PlayersPanelMeta;
import net.wg.infrastructure.events.ColorSchemeEvent;
import net.wg.infrastructure.events.VoiceChatEvent;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public class PlayersPanel extends PlayersPanelMeta implements IBattleComponentDataController, IPlayersPanelMeta, IStatsBaseMeta {

    public var listLeft:PlayersPanelList = null;

    public var listRight:PlayersPanelList = null;

    public var panelSwitch:PlayersPanelSwitch = null;

    private var _state:int = 4;

    private var _expandState:int = 0;

    private var _isStateRequested:Boolean = false;

    private var _personalStatus:uint = 0;

    private var _isInteractive:Boolean = false;

    public function PlayersPanel() {
        super();
        this._expandState = PLAYERS_PANEL_STATE.NONE;
    }

    public function as_setIsIntaractive(param1:Boolean):void {
        this.panelSwitch.setIsInteractive(param1);
        this.listLeft.setIsCursorVisible(param1);
        this.listRight.setIsCursorVisible(param1);
        if (!param1) {
            App.toolTipMgr.hide();
            if (this._expandState != PLAYERS_PANEL_STATE.NONE) {
                this.setListsState(this._expandState);
                this._expandState = PLAYERS_PANEL_STATE.NONE;
            }
        }
        this._isInteractive = param1;
        this.applyListsInteractivity();
    }

    public function as_setPanelMode(param1:int):void {
        this._isStateRequested = false;
        if (this._expandState != PLAYERS_PANEL_STATE.NONE) {
            this._expandState = param1;
        }
        else if (this._state != param1) {
            this.setListsState(param1);
            this.panelSwitch.setState(param1);
        }
    }

    public function updateStageSize(param1:Number, param2:Number):void {
        this.listRight.x = param1;
    }

    public function setVehiclesData(param1:IDAAPIDataClass):void {
        this.applyVehicleData(DAAPIVehiclesDataVO(param1));
    }

    public function updateVehiclesInfo(param1:IDAAPIDataClass):void {
        this.applyVehicleData(DAAPIVehiclesDataVO(param1));
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        this.applyVehicleData(DAAPIVehiclesDataVO(param1));
    }

    public function setArenaInfo(param1:IDAAPIDataClass):void {
    }

    public function setPersonalStatus(param1:uint):void {
        this._personalStatus = param1;
        this.applyPersonalStatus();
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleUserTagsVO = null;
        var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
        var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = _loc2_.leftUserTags;
        for each(_loc4_ in _loc3_) {
            this.listLeft.setUserTags(_loc4_.vehicleID, _loc4_.userTags);
        }
        _loc3_ = _loc2_.rightUserTags;
        for each(_loc4_ in _loc3_) {
            this.listRight.setUserTags(_loc4_.vehicleID, _loc4_.userTags);
        }
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleStatsVO = null;
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        var _loc3_:Vector.<DAAPIVehicleStatsVO> = _loc2_.leftFrags;
        for each(_loc4_ in _loc3_) {
            this.listLeft.setFrags(_loc4_.vehicleID, _loc4_.frags);
        }
        _loc3_ = _loc2_.rightFrags;
        for each(_loc4_ in _loc3_) {
            this.listRight.setFrags(_loc4_.vehicleID, _loc4_.frags);
        }
    }

    public function updateVehiclesStats(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleStatsVO = null;
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        var _loc3_:Vector.<DAAPIVehicleStatsVO> = _loc2_.leftFrags;
        for each(_loc4_ in _loc3_) {
            this.listLeft.setFrags(_loc4_.vehicleID, _loc4_.frags);
        }
        _loc3_ = _loc2_.rightFrags;
        for each(_loc4_ in _loc3_) {
            this.listRight.setFrags(_loc4_.vehicleID, _loc4_.frags);
        }
    }

    public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIInvitationStatusVO = null;
        var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
        var _loc3_:Vector.<DAAPIInvitationStatusVO> = _loc2_.leftItems;
        for each(_loc4_ in _loc3_) {
            this.listLeft.setInvitationStatus(_loc4_.vehicleID, _loc4_.status);
        }
        _loc3_ = _loc2_.rightItems;
        for each(_loc4_ in _loc3_) {
            this.listRight.setInvitationStatus(_loc4_.vehicleID, _loc4_.status);
        }
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

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        if (_loc2_.isEnemy) {
            this.listRight.setPlayerStatus(_loc2_.vehicleID, _loc2_.status);
        }
        else {
            this.listLeft.setPlayerStatus(_loc2_.vehicleID, _loc2_.status);
        }
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
        if (_loc2_.isEnemy) {
            this.listRight.setUserTags(_loc2_.vehicleID, _loc2_.userTags);
        }
        else {
            this.listLeft.setUserTags(_loc2_.vehicleID, _loc2_.userTags);
        }
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        if (_loc2_.isEnemy) {
            this.listRight.setVehicleStatus(_loc2_.vehicleID, _loc2_.status);
            if (_loc2_.rightVehiclesIDs) {
                this.listRight.updateOrder(_loc2_.rightVehiclesIDs);
            }
        }
        else {
            this.listLeft.setVehicleStatus(_loc2_.vehicleID, _loc2_.status);
            if (_loc2_.leftVehiclesIDs) {
                this.listLeft.updateOrder(_loc2_.leftVehiclesIDs);
            }
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.listLeft.addEventListener(PlayersPanelListEvent.ITEM_SELECTED, this.onListItemSelectedHandler);
        this.listLeft.addEventListener(MouseEvent.ROLL_OVER, this.onListRollOverHandler);
        this.listLeft.addEventListener(MouseEvent.ROLL_OUT, this.onListRollOutHandler);
        this.listRight.addEventListener(PlayersPanelListEvent.ITEM_SELECTED, this.onListItemSelectedHandler);
        this.listRight.addEventListener(PlayersPanelListEvent.ITEMS_COUNT_CHANGE, this.onListItemsCountChangeHandler);
        this.listRight.addEventListener(MouseEvent.ROLL_OVER, this.onListRollOverHandler);
        this.listRight.addEventListener(MouseEvent.ROLL_OUT, this.onListRollOutHandler);
        this.panelSwitch.addEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED, this.onSwitchStateRequestedHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.onStartSpeakingHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.onStopSpeakingHandler);
        App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
        addEventListener(DynamicSquadEvent.ACCEPT, this.onDynamicSquadAcceptHandler);
        addEventListener(DynamicSquadEvent.ADD, this.onDynamicSquadAddHandler);
    }

    public function get panelHeight():Number {
        return this.y + this.listRight.y + this.listRight.height;
    }

    override protected function onDispose():void {
        this.listLeft.removeEventListener(PlayersPanelListEvent.ITEM_SELECTED, this.onListItemSelectedHandler);
        this.listLeft.removeEventListener(MouseEvent.ROLL_OVER, this.onListRollOverHandler);
        this.listLeft.removeEventListener(MouseEvent.ROLL_OUT, this.onListRollOutHandler);
        this.listRight.removeEventListener(PlayersPanelListEvent.ITEM_SELECTED, this.onListItemSelectedHandler);
        this.listRight.removeEventListener(PlayersPanelListEvent.ITEMS_COUNT_CHANGE, this.onListItemsCountChangeHandler);
        this.listRight.removeEventListener(MouseEvent.ROLL_OVER, this.onListRollOverHandler);
        this.listRight.removeEventListener(MouseEvent.ROLL_OUT, this.onListRollOutHandler);
        this.panelSwitch.removeEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED, this.onSwitchStateRequestedHandler);
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING, this.onStartSpeakingHandler);
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING, this.onStopSpeakingHandler);
        App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
        removeEventListener(DynamicSquadEvent.ACCEPT, this.onDynamicSquadAcceptHandler);
        removeEventListener(DynamicSquadEvent.ADD, this.onDynamicSquadAddHandler);
        this.listLeft.dispose();
        this.listRight.dispose();
        this.panelSwitch.dispose();
        this.listLeft = null;
        this.listRight = null;
        this.panelSwitch = null;
        super.onDispose();
    }

    private function onListItemsCountChangeHandler(param1:PlayersPanelListEvent):void {
        dispatchEvent(new PlayersPanelEvent(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE));
    }

    private function onSwitchStateRequestedHandler(param1:PlayersPanelSwitchEvent):void {
        this.requestState(param1.state);
    }

    private function onStartSpeakingHandler(param1:VoiceChatEvent):void {
        this.listLeft.setSpeaking(param1.getAccountDBID(), true);
        this.listRight.setSpeaking(param1.getAccountDBID(), true);
    }

    private function onStopSpeakingHandler(param1:VoiceChatEvent):void {
        this.listLeft.setSpeaking(param1.getAccountDBID(), false);
        this.listRight.setSpeaking(param1.getAccountDBID(), false);
    }

    private function onListItemSelectedHandler(param1:PlayersPanelListEvent):void {
        switchToOtherPlayerS(param1.vehicleID);
    }

    private function onDynamicSquadAcceptHandler(param1:DynamicSquadEvent):void {
        acceptSquadS(param1.uid);
    }

    private function onDynamicSquadAddHandler(param1:DynamicSquadEvent):void {
        addToSquadS(param1.uid);
    }

    private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent):void {
        this.listLeft.updateColorBlind();
        this.listRight.updateColorBlind();
    }

    private function onListRollOverHandler(param1:MouseEvent):void {
        if (this._isInteractive && !this._isStateRequested && this._expandState == PLAYERS_PANEL_STATE.NONE) {
            if (this._state != PLAYERS_PANEL_STATE.FULL) {
                this._expandState = this._state;
                this.setListsState(PLAYERS_PANEL_STATE.FULL);
            }
        }
    }

    private function onListRollOutHandler(param1:MouseEvent):void {
        if (this._isInteractive && !this._isStateRequested && this._expandState != PLAYERS_PANEL_STATE.NONE) {
            if (this._state == PLAYERS_PANEL_STATE.FULL) {
                this.setListsState(this._expandState);
                this._expandState = PLAYERS_PANEL_STATE.NONE;
            }
        }
    }

    private function applyVehicleData(param1:DAAPIVehiclesDataVO):void {
        if (param1.leftVehicleInfos) {
            this.listLeft.setVehicleData(param1.leftVehicleInfos);
            this.listLeft.updateOrder(param1.leftVehiclesIDs);
        }
        if (param1.rightVehicleInfos) {
            this.listRight.setVehicleData(param1.rightVehicleInfos);
            this.listRight.updateOrder(param1.rightVehiclesIDs);
        }
    }

    private function setListsState(param1:int):void {
        if (this._state == param1) {
            return;
        }
        this.listLeft.state = param1;
        this.listRight.state = param1;
        this._state = param1;
    }

    private function requestState(param1:int):void {
        if (this._state == param1) {
            return;
        }
        this._isStateRequested = true;
        tryToSetPanelModeByMouseS(param1);
    }

    private function applyPersonalStatus():void {
        var _loc1_:Boolean = PersonalStatus.isVehicleLevelShown(this._personalStatus);
        this.listLeft.setIsInviteShown(PersonalStatus.isShowAllyInvites(this._personalStatus));
        this.listRight.setIsInviteShown(PersonalStatus.isShowEnemyInvites(this._personalStatus));
        this.listLeft.setVehicleLevelVisible(_loc1_);
        this.listRight.setVehicleLevelVisible(_loc1_);
        this.applyListsInteractivity();
    }

    private function applyListsInteractivity():void {
        var _loc1_:Boolean = this._isInteractive && !PersonalStatus.isSquadRestrictions(this._personalStatus);
        this.listLeft.setIsInteractive(_loc1_ && PersonalStatus.isCanSendInviteToAlly(this._personalStatus));
        this.listRight.setIsInteractive(_loc1_ && PersonalStatus.isCanSendInviteToEnemy(this._personalStatus));
    }
}
}

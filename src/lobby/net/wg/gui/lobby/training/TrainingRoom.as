package net.wg.gui.lobby.training {
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.VO.TrainingRoomInfoVO;
import net.wg.data.VO.TrainingRoomRendererVO;
import net.wg.data.VO.TrainingRoomTeamVO;
import net.wg.data.VO.UserVO;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.components.icons.BattleTypeIcon;
import net.wg.gui.components.minimap.MinimapPresentation;
import net.wg.gui.events.ArenaVoipSettingsEvent;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.infrastructure.base.meta.ITrainingRoomMeta;
import net.wg.infrastructure.base.meta.impl.TrainingRoomMeta;
import net.wg.infrastructure.events.DropEvent;
import net.wg.infrastructure.events.VoiceChatEvent;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.managers.IVoiceChatManager;
import net.wg.utils.IScheduler;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.CoreList;
import scaleform.clik.controls.ListItemRenderer;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.interfaces.IDataProvider;

public class TrainingRoom extends TrainingRoomMeta implements ITrainingRoomMeta {

    public static const TRAINING:String = "training";

    private static const SUB_VIEW_MARGIN:Number = 120;

    public var team1Label:TextField;

    public var team2Label:TextField;

    public var otherLabel:TextField;

    public var titleField:TextField;

    public var typeField:TextField;

    public var comment:TextField;

    public var map:TextField;

    public var arenaVOIPLabel:TextField;

    public var swapButton:IButtonIconLoader;

    public var closeButton:SoundButtonEx;

    public var settingsButton:SoundButtonEx;

    public var startButton:SoundButtonEx;

    public var inviteButton:SoundButtonEx;

    public var minimap:MinimapPresentation;

    public var owner:UserNameField;

    public var timeout:TextFieldShort;

    public var maxPlayers:TextFieldShort;

    public var description:TextAreaSimple;

    public var battleIcon:BattleTypeIcon;

    public var team1:DropList;

    public var team2:DropList;

    public var other:DropTileList;

    public var arenaVoipSettings:ArenaVoipSettings;

    public var observerButton:ObserverButtonComponent;

    private var _team1LabelText:String = "";

    private var _team2LabelText:String = "";

    private var _otherLabelText:String = "";

    private var _isCreator:Boolean;

    private var _slots:Vector.<InteractiveObject> = null;

    private var _maxPlayersCount:Number = 0;

    private var _curPlayersCount:Number = 0;

    private var _dragDropListDelegateCtrl:IDisposable = null;

    private var _myWidth:Number = 0;

    private var _voiceChatMgr:IVoiceChatManager;

    public function TrainingRoom() {
        this._voiceChatMgr = App.voiceChatMgr;
        super();
        _deferredDispose = true;
        this._slots = Vector.<InteractiveObject>([this.other, this.team1, this.team2]);
    }

    private static function startDisableCoolDown(param1:Function, param2:Number, param3:UIComponent):void {
        var _loc4_:IScheduler = App.utils.scheduler;
        _loc4_.cancelTask(param1);
        param3.enabled = false;
        _loc4_.scheduleTask(param1, param2 * 1000);
    }

    private static function checkStatus(param1:CoreList, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int):void {
        var _loc9_:TrainingRoomRendererVO = null;
        var _loc8_:IDataProvider = param1.dataProvider;
        for each(_loc9_ in _loc8_) {
            if (_loc9_.dbID == param2) {
                _loc9_.stateString = param3;
                _loc9_.icon = param4;
                _loc9_.vShortName = param5;
                _loc9_.vLevel = param6;
                _loc9_.igrType = param7;
                param1.invalidateData();
                break;
            }
        }
    }

    private static function checkUserTags(param1:CoreList, param2:Number, param3:Array):void {
        var _loc5_:TrainingRoomRendererVO = null;
        var _loc4_:IDataProvider = param1.dataProvider;
        for each(_loc5_ in _loc4_) {
            if (_loc5_.dbID == param2) {
                _loc5_.tags = param3;
                param1.invalidateData();
                break;
            }
        }
    }

    override public final function setViewSize(param1:Number, param2:Number):void {
        this._myWidth = param1;
        invalidateSize();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.setViewSize(param1, param2);
    }

    override protected function configUI():void {
        super.configUI();
        this.updateStage(App.appWidth, App.appHeight);
        this.addListeners();
        this.battleIcon.gotoAndStop(TrainingRoom.TRAINING);
        this.description.autoScroll = false;
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.handleEscape, true);
        this.swapButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP;
        this.timeout.buttonMode = false;
        this.timeout.autoSize = this.maxPlayers.autoSize = TextFieldAutoSize.LEFT;
        this.maxPlayers.buttonMode = false;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        if (canAssignToTeamS(1) || canAssignToTeamS(2) || canChangePlayerTeamS()) {
            this.createDragController();
        }
        else if (this._dragDropListDelegateCtrl) {
            this._dragDropListDelegateCtrl.dispose();
            this._dragDropListDelegateCtrl = null;
        }
        registerFlashComponentS(this.minimap, Aliases.LOBBY_MINIMAP);
        this.setTeamsInfo();
        var _loc1_:Boolean = this._voiceChatMgr.getYY();
        this.arenaVoipSettings.visible = this._voiceChatMgr.isVOIPEnabledS() || _loc1_;
        this.arenaVOIPLabel.text = this._voiceChatMgr.isVOIPEnabledS() || _loc1_ ? MENU.TRAINING_INFO_VOICECHAT : "";
    }

    override protected function onBeforeDispose():void {
        this.removeListeners();
        var _loc1_:IScheduler = App.utils.scheduler;
        _loc1_.cancelTask(this.finishDisable_swapButton_CoolDownHandler);
        _loc1_.cancelTask(this.finishDisable_settingsButton_CoolDownHandler);
        _loc1_.cancelTask(this.finishDisable_observerButton_CoolDownHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.disposeComponents();
        if (this._dragDropListDelegateCtrl) {
            this._dragDropListDelegateCtrl.dispose();
            this._dragDropListDelegateCtrl = null;
        }
        if (this._slots) {
            this._slots.splice(0, this._slots.length);
            this._slots = null;
        }
        this._voiceChatMgr = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            x = this._myWidth - _originalWidth >> 1;
            y = -SUB_VIEW_MARGIN;
        }
        if (isInvalid(InvalidationType.STATE)) {
            this.inviteButton.visible = canSendInviteS();
            this.swapButton.visible = canChangePlayerTeamS();
            this.settingsButton.visible = canChangeSettingS();
            this.startButton.visible = canStartBattleS();
            if (!canDestroyRoomS()) {
                this.closeButton.label = MENU.TRAINING_INFO_EXITBUTTON;
            }
        }
        if (isInvalid(InvalidationType.DATA)) {
            this.team1Label.htmlText = this._team1LabelText;
            this.team2Label.htmlText = this._team2LabelText;
            this.otherLabel.htmlText = this._otherLabelText;
        }
    }

    public function as_disableControls(param1:Boolean):void {
        this.disableControls(param1);
    }

    public function as_disableStartButton(param1:Boolean):void {
        this.startButton.enabled = !param1;
    }

    public function as_enabledCloseButton(param1:Boolean):void {
        this.closeButton.enabled = param1;
    }

    public function as_setArenaVoipChannels(param1:Number):void {
        this.arenaVoipSettings.setUseArenaVoip(param1);
    }

    override protected function setInfo(param1:TrainingRoomInfoVO):void {
        this._isCreator = param1.isCreator;
        this.comment.text = param1.comment;
        this.timeout.label = param1.roundLenString;
        this._maxPlayersCount = param1.maxPlayersCount;
        this.maxPlayers.label = this._curPlayersCount + "/" + this._maxPlayersCount;
        this.map.htmlText = param1.arenaName;
        this.titleField.htmlText = param1.title;
        this.typeField.htmlText = param1.arenaSubType;
        this.owner.userVO = new UserVO({
            "accID": -1,
            "dbID": -1,
            "fullName": param1.creatorFullName,
            "userName": param1.creator,
            "clanAbbrev": param1.creatorClan,
            "region": param1.creatorRegion,
            "igrType": param1.creatorIgrType
        });
        this.minimap.setMapS(param1.arenaTypeID);
        this.description.position = 0;
        this.description.htmlText = param1.description;
        this.arenaVoipSettings.setUseArenaVoip(param1.arenaVoipChannels);
        this.arenaVoipSettings.setCanChangeArenaVOIP(param1.canChangeArenaVOIP);
        invalidate(InvalidationType.STATE);
        this.observerButton.visible = param1.isObserverModeEnabled;
        if (param1.isObserverModeEnabled) {
            this.observerButton.addEventListener(ObserverButtonComponent.SELECTED, this.onObserverButtonSelectedHandler, false, 0, true);
        }
    }

    public function as_setObserver(param1:Boolean):void {
        this.observerButton.selected = param1;
    }

    override protected function setOther(param1:TrainingRoomTeamVO):void {
        this.other.dataProvider = param1.listData;
        this._otherLabelText = param1.teamLabel;
        this.countPlayers();
        invalidateData();
    }

    public function as_setPlayerStateInOther(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int):void {
        checkStatus(this.other, param1, param2, param3, param4, param5, param6);
    }

    public function as_setPlayerStateInTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int):void {
        checkStatus(this.team1, param1, param2, param3, param4, param5, param6);
    }

    public function as_setPlayerStateInTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int):void {
        checkStatus(this.team2, param1, param2, param3, param4, param5, param6);
    }

    override protected function setPlayerTagsInOther(param1:Number, param2:Array):void {
        checkUserTags(this.other, param1, param2);
    }

    override protected function setPlayerTagsInTeam1(param1:Number, param2:Array):void {
        checkUserTags(this.team1, param1, param2);
    }

    override protected function setPlayerTagsInTeam2(param1:Number, param2:Array):void {
        checkUserTags(this.team2, param1, param2);
    }

    override protected function setTeam1(param1:TrainingRoomTeamVO):void {
        this.team1.dataProvider = param1.listData;
        this._team1LabelText = param1.teamLabel;
        this.countPlayers();
        invalidateData();
    }

    override protected function setTeam2(param1:TrainingRoomTeamVO):void {
        this.team2.dataProvider = param1.listData;
        this._team2LabelText = param1.teamLabel;
        this.countPlayers();
        invalidateData();
    }

    public function as_startCoolDownObserver(param1:Number):void {
        startDisableCoolDown(this.finishDisable_observerButton_CoolDownHandler, param1, this.observerButton);
    }

    public function as_startCoolDownSetting(param1:Number):void {
        startDisableCoolDown(this.finishDisable_settingsButton_CoolDownHandler, param1, this.settingsButton);
    }

    public function as_startCoolDownSwapButton(param1:Number):void {
        startDisableCoolDown(this.finishDisable_swapButton_CoolDownHandler, param1, UIComponent(this.swapButton));
    }

    public function as_startCoolDownVoiceChat(param1:Number):void {
        this.arenaVoipSettings.startCoolDownUseCommonVoiceChat(param1);
    }

    public function as_updateComment(param1:String):void {
        this.comment.text = param1;
    }

    public function as_updateMap(param1:Number, param2:Number, param3:String, param4:String, param5:String, param6:String):void {
        this.minimap.setMapS(param1);
        this.maxPlayers.label = this._curPlayersCount + "/" + param2;
        this.map.htmlText = param3;
        this.titleField.htmlText = param4;
        this.typeField.htmlText = param5;
        this.description.position = 0;
        this.description.htmlText = param6;
    }

    public function as_updateTimeout(param1:String):void {
        this.timeout.label = param1;
    }

    private function finishDisable_settingsButton_CoolDownHandler():void {
        this.settingsButton.enabled = true;
    }

    private function finishDisable_swapButton_CoolDownHandler():void {
        this.swapButton.enabled = true;
    }

    private function finishDisable_observerButton_CoolDownHandler():void {
        this.observerButton.enabled = true;
    }

    private function createDragController():void {
        var _loc1_:Class = App.utils.classFactory.getClass(Linkages.TRAINING_DRAG_DELEGATE);
        assertNull(this._dragDropListDelegateCtrl, "_dragDropListDelegateCtrl");
        this._dragDropListDelegateCtrl = new TrainingDragController(this._slots, _loc1_, Linkages.PLAYER_ELEMENT_UI, this.isSlotDroppable);
    }

    private function addListeners():void {
        this.settingsButton.addEventListener(ButtonEvent.CLICK, this.onSettingsButtonClickHandler);
        this.startButton.addEventListener(ButtonEvent.CLICK, this.onStartButtonClickHandler);
        this.closeButton.addEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.inviteButton.addEventListener(ButtonEvent.CLICK, this.onInviteButtonClickHandler);
        this.swapButton.addEventListener(ButtonEvent.CLICK, this.onSwapButtonClickHandler);
        this.other.addEventListener(DropEvent.END_DROP, this.onEndDropHandler);
        this.team1.addEventListener(DropEvent.END_DROP, this.onEndDropHandler);
        this.team2.addEventListener(DropEvent.END_DROP, this.onEndDropHandler);
        this.arenaVoipSettings.addEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT, this.onArenaVoipSettingsSelectHandler);
        this._voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.onVoiceChatMgrStartSpeakHandler);
        this._voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.onVoiceChatMgrStopSpeakHandler);
    }

    private function disposeComponents():void {
        this.team1Label = null;
        this.team2Label = null;
        this.otherLabel = null;
        this.titleField = null;
        this.typeField = null;
        this.comment = null;
        this.map = null;
        this.arenaVOIPLabel = null;
        this.swapButton.dispose();
        this.swapButton = null;
        this.observerButton.dispose();
        this.observerButton = null;
        this.closeButton.dispose();
        this.closeButton = null;
        this.settingsButton.dispose();
        this.settingsButton = null;
        this.startButton.dispose();
        this.startButton = null;
        this.inviteButton.dispose();
        this.inviteButton = null;
        this.owner.dispose();
        this.owner = null;
        this.timeout.dispose();
        this.timeout = null;
        this.maxPlayers.dispose();
        this.maxPlayers = null;
        this.description.dispose();
        this.description = null;
        this.battleIcon.dispose();
        this.battleIcon = null;
        this.team1.dispose();
        this.team1 = null;
        this.team2.dispose();
        this.team2 = null;
        this.other.dispose();
        this.other = null;
        this.arenaVoipSettings.dispose();
        this.arenaVoipSettings = null;
    }

    private function removeListeners():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this.observerButton.removeEventListener(ObserverButtonComponent.SELECTED, this.onObserverButtonSelectedHandler);
        this.other.removeEventListener(DropEvent.END_DROP, this.onEndDropHandler);
        this.team1.removeEventListener(DropEvent.END_DROP, this.onEndDropHandler);
        this.team2.removeEventListener(DropEvent.END_DROP, this.onEndDropHandler);
        this.settingsButton.removeEventListener(ButtonEvent.CLICK, this.onSettingsButtonClickHandler);
        this.startButton.removeEventListener(ButtonEvent.CLICK, this.onStartButtonClickHandler);
        this.closeButton.removeEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.inviteButton.removeEventListener(ButtonEvent.CLICK, this.onInviteButtonClickHandler);
        this.swapButton.removeEventListener(ButtonEvent.CLICK, this.onSwapButtonClickHandler);
        this.arenaVoipSettings.removeEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT, this.onArenaVoipSettingsSelectHandler);
        this._voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING, this.onVoiceChatMgrStartSpeakHandler);
        this._voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING, this.onVoiceChatMgrStopSpeakHandler);
    }

    private function setSpeaking(param1:Boolean, param2:Number):void {
        var _loc3_:CoreList = null;
        var _loc4_:IDataProvider = null;
        var _loc5_:TrainingRoomRendererVO = null;
        for each(_loc3_ in this._slots) {
            _loc4_ = _loc3_.dataProvider;
            for each(_loc5_ in _loc4_) {
                if (_loc5_.dbID == param2) {
                    _loc5_.isPlayerSpeaking = param1;
                    _loc3_.invalidateData();
                }
            }
        }
    }

    private function disableControls(param1:Boolean):void {
        this.swapButton.enabled = !param1;
        this.closeButton.enabled = !param1;
        this.settingsButton.enabled = !param1;
        this.startButton.enabled = !param1;
        this.inviteButton.enabled = !param1;
        this.arenaVoipSettings.enabled = !param1;
        this.observerButton.enabled = !param1;
        if (param1) {
            if (this._dragDropListDelegateCtrl) {
                this._dragDropListDelegateCtrl.dispose();
                this._dragDropListDelegateCtrl = null;
            }
        }
        else if (!this._dragDropListDelegateCtrl && (canAssignToTeamS(1) || canAssignToTeamS(2) || canChangePlayerTeamS())) {
            this.createDragController();
        }
    }

    private function isSlotDroppable(param1:uint, param2:uint):Boolean {
        var _loc3_:uint = getPlayerTeamS(param1);
        return _loc3_ == param2 || param2 == 0 && canAssignToTeamS(_loc3_) || param2 != 0 && canChangePlayerTeamS();
    }

    private function setTeamsInfo():void {
        this.team1Label.htmlText = MENU.TRAINING_INFO_TEAM1LABEL;
        this.team2Label.htmlText = MENU.TRAINING_INFO_TEAM2LABEL;
        this.otherLabel.htmlText = MENU.TRAINING_INFO_OTHERLABEL;
    }

    private function countPlayers():void {
        var _loc1_:CoreList = null;
        this._curPlayersCount = 0;
        for each(_loc1_ in this._slots) {
            this._curPlayersCount = this._curPlayersCount + _loc1_.dataProvider.length;
        }
        this.maxPlayers.label = this._curPlayersCount + "/" + this._maxPlayersCount;
        App.toolTipMgr.hide();
        App.contextMenuMgr.hide();
    }

    private function onObserverButtonSelectedHandler(param1:Event):void {
        selectObserverS(this.observerButton.selected);
    }

    private function handleEscape(param1:InputEvent):void {
        onEscapeS();
    }

    private function onVoiceChatMgrStartSpeakHandler(param1:VoiceChatEvent):void {
        this.setSpeaking(true, param1.getAccountDBID());
    }

    private function onVoiceChatMgrStopSpeakHandler(param1:VoiceChatEvent):void {
        this.setSpeaking(false, param1.getAccountDBID());
    }

    private function onEndDropHandler(param1:DropEvent):void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        if (param1.sender != param1.receiver) {
            _loc2_ = ListItemRenderer(param1.draggedItem).data.accID;
            _loc3_ = this._slots.indexOf(param1.receiver);
            if (this.isSlotDroppable(_loc2_, _loc3_)) {
                changeTeamS(_loc2_, _loc3_);
            }
        }
    }

    private function onArenaVoipSettingsSelectHandler(param1:ArenaVoipSettingsEvent):void {
        selectCommonVoiceChatS(param1.index);
    }

    private function onSettingsButtonClickHandler(param1:ButtonEvent):void {
        showTrainingSettingsS();
    }

    private function onStartButtonClickHandler(param1:ButtonEvent):void {
        startTrainingS();
    }

    private function onCloseButtonClickHandler(param1:ButtonEvent):void {
        closeTrainingRoomS();
    }

    private function onInviteButtonClickHandler(param1:ButtonEvent):void {
        showPrebattleInvitationsFormS();
    }

    private function onSwapButtonClickHandler(param1:ButtonEvent):void {
        swapTeamsS();
    }
}
}

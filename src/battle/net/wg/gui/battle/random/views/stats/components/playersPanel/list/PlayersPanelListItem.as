package net.wg.gui.battle.random.views.stats.components.playersPanel.list {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
import net.wg.gui.battle.views.stats.SpeakAnimation;
import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
import net.wg.infrastructure.interfaces.IColorScheme;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.gfx.TextFieldEx;

public class PlayersPanelListItem extends BattleUIComponent {

    private static const ICONS_AREA_WIDTH:Number = 63;

    private static const SQUAD_ITEMS_AREA_WIDTH:Number = 25;

    private static const WIDTH:Number = 339;

    private static const PLAYER_NAME_MARGIN:Number = 8;

    private static const VEHICLE_TF_RIGHT_X:int = -WIDTH + ICONS_AREA_WIDTH;

    private static const VEHICLE_TF_LEFT_X:int = WIDTH - ICONS_AREA_WIDTH;

    private static const UNKNOWN_VEHICLE_LEVEL:int = -1;

    public var fragsTF:TextField = null;

    public var playerNameFullTF:TextField = null;

    public var playerNameCutTF:TextField = null;

    public var vehicleTF:TextField = null;

    public var dynamicSquad:PlayersPanelDynamicSquad;

    public var icoIGR:BattleAtlasSprite = null;

    public var vehicleLevel:BattleAtlasSprite = null;

    public var vehicleIcon:BattleAtlasSprite = null;

    public var mute:BattleAtlasSprite = null;

    public var speakAnimation:SpeakAnimation = null;

    public var selfBg:BattleAtlasSprite = null;

    public var bg:BattleAtlasSprite = null;

    public var deadBg:BattleAtlasSprite = null;

    public var actionMarker:BattleAtlasSprite = null;

    public var hit:Sprite = null;

    public var holderItemID:Number = -1;

    public var disableCommunication:BattleAtlasSprite = null;

    private var _state:int = 0;

    private var _playerNameFullWidth:Number = NaN;

    private var _maxPlayerNameWidth:Number = NaN;

    private var _vehicleName:String = null;

    private var _frags:int = 0;

    private var _isMute:Boolean = false;

    private var _isSpeaking:Boolean = false;

    private var _isAlive:Boolean = true;

    private var _isOffline:Boolean = false;

    private var _isSquadPersonal:Boolean = false;

    private var _isTeamKiller:Boolean = false;

    private var _isIGR:Boolean = false;

    private var _vehicleImage:String = null;

    private var _vehicleLevel:int = 0;

    private var _isSelected:Boolean = false;

    private var _isCurrentPlayer:Boolean = false;

    private var _isRightAligned:Boolean = false;

    private var _isIgnoredTmp:Boolean = false;

    public function PlayersPanelListItem() {
        super();
        this._maxPlayerNameWidth = WIDTH - ICONS_AREA_WIDTH - this.vehicleTF.width - this.fragsTF.width - SQUAD_ITEMS_AREA_WIDTH;
        this._state = PLAYERS_PANEL_STATE.NONE;
        this.setState(PLAYERS_PANEL_STATE.FULL);
        this.fragsTF.mouseEnabled = false;
        this.playerNameFullTF.mouseEnabled = false;
        this.playerNameCutTF.mouseEnabled = false;
        this.vehicleTF.mouseEnabled = false;
        this.icoIGR.mouseEnabled = false;
        this.vehicleLevel.mouseEnabled = false;
        this.vehicleLevel.isCetralize = true;
        this.vehicleIcon.mouseEnabled = false;
        this.mute.mouseEnabled = false;
        this.speakAnimation.mouseEnabled = false;
        this.speakAnimation.mouseChildren = false;
        this.actionMarker.mouseEnabled = false;
        TextFieldEx.setNoTranslate(this.fragsTF, true);
        TextFieldEx.setNoTranslate(this.playerNameFullTF, true);
        TextFieldEx.setNoTranslate(this.playerNameCutTF, true);
        TextFieldEx.setNoTranslate(this.vehicleTF, true);
        this.hitArea = this.hit;
        addEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.dynamicSquad.dispose();
        this.speakAnimation.dispose();
        this.disableCommunication = null;
        this.fragsTF = null;
        this.playerNameFullTF = null;
        this.playerNameCutTF = null;
        this.vehicleTF = null;
        this.dynamicSquad = null;
        this.icoIGR = null;
        this.vehicleLevel = null;
        this.vehicleIcon = null;
        this.mute = null;
        this.speakAnimation = null;
        this.selfBg = null;
        this.bg = null;
        this.deadBg = null;
        this.actionMarker = null;
        this.hit = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.icoIGR.visible = false;
        this.icoIGR.imageName = BattleAtlasItem.ICO_IGR;
        this.mute.visible = false;
        this.mute.imageName = !!this._isRightAligned ? BattleAtlasItem.RIGHT_STATS_MUTE : BattleAtlasItem.LEFT_STATS_MUTE;
        if (this.disableCommunication) {
            this.disableCommunication.visible = false;
            this.disableCommunication.imageName = BattleAtlasItem.ICON_TOXIC_CHAT_OFF;
        }
        this.bg.imageName = BattleAtlasItem.PLAYERS_PANEL_BG;
        this.selfBg.visible = false;
        this.selfBg.imageName = BattleAtlasItem.PLAYERS_PANEL_SELF_BG;
        this.deadBg.visible = false;
        this.deadBg.imageName = BattleAtlasItem.PLAYERS_PANEL_DEAD_BG;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(PlayersPanelInvalidationType.PLAYER_NAME_FULL_WIDTH)) {
            if (this.playerNameFullTF.width != this._playerNameFullWidth) {
                this.playerNameFullTF.width = this._playerNameFullWidth;
            }
            if (!isInvalid(InvalidationType.STATE)) {
                this.updatePositions();
            }
        }
        if (isInvalid(PlayersPanelInvalidationType.VEHILCE_NAME)) {
            App.utils.commons.truncateTextFieldText(this.vehicleTF, this._vehicleName);
        }
        if (isInvalid(PlayersPanelInvalidationType.FRAGS)) {
            this.fragsTF.text = !!this._frags ? this._frags.toString() : "";
        }
        if (isInvalid(PlayersPanelInvalidationType.MUTE)) {
            this.mute.visible = this._isMute;
            if (this._isSpeaking) {
                if (this._isMute) {
                    this.speakAnimation.reset();
                }
                else {
                    this.speakAnimation.speaking = true;
                }
            }
            if (this.disableCommunication) {
                this.disableCommunication.visible = this._isIgnoredTmp;
            }
        }
        if (isInvalid(PlayersPanelInvalidationType.IS_SPEAKING)) {
            if (!this._isMute) {
                this.speakAnimation.speaking = this._isSpeaking;
            }
        }
        if (isInvalid(PlayersPanelInvalidationType.SELECTED)) {
            this.selfBg.visible = this._isSelected;
        }
        if (isInvalid(PlayersPanelInvalidationType.ALIVE)) {
            this.bg.visible = this._isAlive;
            this.deadBg.visible = !this._isAlive;
        }
        if (isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME)) {
            this.updateColors();
        }
        if (isInvalid(PlayersPanelInvalidationType.IGR_CHANGED)) {
            this.icoIGR.visible = this._isIGR && this.vehicleTF.visible;
        }
        if (isInvalid(InvalidationType.STATE)) {
            this.applyState();
        }
    }

    public function getPlayerNameFullWidth():Number {
        return Math.floor(this.playerNameFullTF.textWidth) + PLAYER_NAME_MARGIN;
    }

    public function isIgnoredTmp(param1:Boolean):void {
        if (this._isIgnoredTmp == param1 || this.disableCommunication == null) {
            return;
        }
        this._isIgnoredTmp = param1;
        invalidate(PlayersPanelInvalidationType.MUTE);
    }

    public function setFrags(param1:int):void {
        if (this._frags == param1) {
            return;
        }
        this._frags = param1;
        invalidate(PlayersPanelInvalidationType.FRAGS);
    }

    public function setIsAlive(param1:Boolean):void {
        if (this._isAlive == param1) {
            return;
        }
        this._isAlive = param1;
        invalidate(PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
    }

    public function setIsCurrentPlayer(param1:Boolean):void {
        if (this._isCurrentPlayer == param1) {
            return;
        }
        this._isCurrentPlayer = param1;
        invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
    }

    public function setIsIGR(param1:Boolean):void {
        if (this._isIGR == param1) {
            return;
        }
        this._isIGR = param1;
        invalidate(PlayersPanelInvalidationType.IGR_CHANGED);
    }

    public function setIsInteractive(param1:Boolean):void {
        this.dynamicSquad.setIsInteractive(param1);
    }

    public function setIsInviteShown(param1:Boolean):void {
        this.dynamicSquad.setIsInviteShown(param1);
    }

    public function setIsMute(param1:Boolean):void {
        if (this._isMute == param1) {
            return;
        }
        this._isMute = param1;
        invalidate(PlayersPanelInvalidationType.MUTE);
    }

    public function setIsOffline(param1:Boolean):void {
        if (this._isOffline == param1) {
            return;
        }
        this._isOffline = param1;
        invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
    }

    public function setIsRightAligned(param1:Boolean):void {
        if (this._isRightAligned == param1) {
            return;
        }
        this._isRightAligned = param1;
        this.dynamicSquad.setIsEnemy(param1);
        invalidateState();
    }

    public function setIsSelected(param1:Boolean):void {
        if (this._isSelected == param1) {
            return;
        }
        this._isSelected = param1;
        invalidate(PlayersPanelInvalidationType.SELECTED);
    }

    public function setIsSpeaking(param1:Boolean):void {
        if (this._isSpeaking == param1) {
            return;
        }
        this._isSpeaking = param1;
        invalidate(PlayersPanelInvalidationType.IS_SPEAKING);
    }

    public function setIsTeamKiller(param1:Boolean):void {
        if (this._isTeamKiller == param1) {
            return;
        }
        this._isTeamKiller = param1;
        invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
    }

    public function setPlayerNameFullWidth(param1:Number):void {
        param1 = Math.min(this._maxPlayerNameWidth, param1);
        if (this._playerNameFullWidth == param1) {
            return;
        }
        this._playerNameFullWidth = param1;
        invalidate(PlayersPanelInvalidationType.PLAYER_NAME_FULL_WIDTH);
    }

    public function setPlayerNameProps(param1:IUserProps):void {
        App.utils.commons.truncateTextFieldText(this.playerNameCutTF, param1.userName);
        App.utils.commons.formatPlayerName(this.playerNameFullTF, param1);
    }

    public function setSquad(param1:Boolean, param2:int):void {
        this.dynamicSquad.setCurrentSquad(param1, param2);
        if (this._isSquadPersonal != param1) {
            this._isSquadPersonal = param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
        }
    }

    public function setSquadNoSound(param1:Boolean):void {
        this.dynamicSquad.setNoSound(param1);
    }

    public function setSquadState(param1:int):void {
        this.dynamicSquad.setState(param1);
    }

    public function setState(param1:int):void {
        if (this._state == param1) {
            return;
        }
        this._state = param1;
        invalidateState();
    }

    public function setVehicleAction(param1:int):void {
        this.actionMarker.imageName = BattleAtlasItem.getVehicleActionName(VehicleActions.getActionName(param1));
        this.actionMarker.visible = true;
    }

    public function setVehicleIcon(param1:String):void {
        if (this._vehicleImage == param1) {
            return;
        }
        this._vehicleImage = param1;
        this.vehicleIcon.setImageNames(BattleAtlasItem.getVehicleIconName(param1), BattleAtlasItem.VEHICLE_TYPE_UNKNOWN);
    }

    public function setVehicleLevel(param1:int):void {
        if (this._vehicleLevel == param1 || param1 == UNKNOWN_VEHICLE_LEVEL) {
            return;
        }
        this._vehicleLevel = param1;
        this.vehicleLevel.imageName = BattleAtlasItem.getVehicleLevelName(this._vehicleLevel);
    }

    public function setVehicleLevelVisible(param1:Boolean):void {
        this.vehicleLevel.visible = param1;
    }

    public function setVehicleName(param1:String):void {
        if (this._vehicleName == param1) {
            return;
        }
        this._vehicleName = param1;
        invalidate(PlayersPanelInvalidationType.VEHILCE_NAME);
    }

    public function updateColorBlind():void {
        invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
    }

    private function updatePositions():void {
        if (this._isRightAligned) {
            if (this._state == PLAYERS_PANEL_STATE.FULL) {
                if (this.vehicleTF.x != VEHICLE_TF_RIGHT_X) {
                    this.vehicleTF.x = VEHICLE_TF_RIGHT_X;
                }
                if (this.playerNameFullTF.x != this.vehicleTF.x + this.vehicleTF.width) {
                    this.playerNameFullTF.x = this.vehicleTF.x + this.vehicleTF.width;
                }
                if (this.fragsTF.x != this.playerNameFullTF.x + this.playerNameFullTF.width) {
                    this.fragsTF.x = this.playerNameFullTF.x + this.playerNameFullTF.width;
                }
            }
            else if (this._state == PLAYERS_PANEL_STATE.LONG) {
                if (this.vehicleTF.x != VEHICLE_TF_RIGHT_X) {
                    this.vehicleTF.x = VEHICLE_TF_RIGHT_X;
                }
                if (this.fragsTF.x != this.vehicleTF.x + this.vehicleTF.width) {
                    this.fragsTF.x = this.vehicleTF.x + this.vehicleTF.width;
                }
            }
            else if (this._state == PLAYERS_PANEL_STATE.MEDIUM) {
                if (this.playerNameCutTF.x != VEHICLE_TF_RIGHT_X) {
                    this.playerNameCutTF.x = VEHICLE_TF_RIGHT_X;
                }
                if (this.fragsTF.x != this.playerNameCutTF.x + this.playerNameCutTF.width) {
                    this.fragsTF.x = this.playerNameCutTF.x + this.playerNameCutTF.width;
                }
            }
            else if (this._state == PLAYERS_PANEL_STATE.SHORT) {
                if (this.fragsTF.x != VEHICLE_TF_RIGHT_X) {
                    this.fragsTF.x = VEHICLE_TF_RIGHT_X;
                }
            }
            x = -(this.fragsTF.x + this.fragsTF.width + SQUAD_ITEMS_AREA_WIDTH);
            this.dynamicSquad.x = this.fragsTF.x + this.fragsTF.width + SQUAD_ITEMS_AREA_WIDTH;
        }
        else {
            if (this._state == PLAYERS_PANEL_STATE.FULL) {
                if (this.vehicleTF.x != VEHICLE_TF_LEFT_X - this.vehicleTF.width) {
                    this.vehicleTF.x = VEHICLE_TF_LEFT_X - this.vehicleTF.width;
                }
                if (this.playerNameFullTF.x != this.vehicleTF.x - this.playerNameFullTF.width) {
                    this.playerNameFullTF.x = this.vehicleTF.x - this.playerNameFullTF.width;
                }
                if (this.fragsTF.x != this.playerNameFullTF.x - this.fragsTF.width) {
                    this.fragsTF.x = this.playerNameFullTF.x - this.fragsTF.width;
                }
            }
            else if (this._state == PLAYERS_PANEL_STATE.LONG) {
                if (this.vehicleTF.x != VEHICLE_TF_LEFT_X - this.vehicleTF.width) {
                    this.vehicleTF.x = VEHICLE_TF_LEFT_X - this.vehicleTF.width;
                }
                if (this.fragsTF.x != this.vehicleTF.x - this.fragsTF.width) {
                    this.fragsTF.x = this.vehicleTF.x - this.fragsTF.width;
                }
            }
            else if (this._state == PLAYERS_PANEL_STATE.MEDIUM) {
                if (this.playerNameCutTF.x != VEHICLE_TF_LEFT_X - this.playerNameCutTF.width) {
                    this.playerNameCutTF.x = VEHICLE_TF_LEFT_X - this.playerNameCutTF.width;
                }
                if (this.fragsTF.x != this.playerNameCutTF.x - this.fragsTF.width) {
                    this.fragsTF.x = this.playerNameCutTF.x - this.fragsTF.width;
                }
            }
            else if (this._state == PLAYERS_PANEL_STATE.SHORT) {
                if (this.fragsTF.x != VEHICLE_TF_LEFT_X - this.fragsTF.width) {
                    this.fragsTF.x = VEHICLE_TF_LEFT_X - this.fragsTF.width;
                }
            }
            x = -(this.fragsTF.x - SQUAD_ITEMS_AREA_WIDTH);
            this.dynamicSquad.x = this.fragsTF.x - SQUAD_ITEMS_AREA_WIDTH;
        }
    }

    private function applyState():void {
        if (this._state == PLAYERS_PANEL_STATE.FULL) {
            if (!this.vehicleTF.visible) {
                this.vehicleTF.visible = true;
            }
            if (!this.playerNameFullTF.visible) {
                this.playerNameFullTF.visible = true;
            }
            if (this.playerNameCutTF.visible) {
                this.playerNameCutTF.visible = false;
            }
            this.icoIGR.visible = this._isIGR;
        }
        else if (this._state == PLAYERS_PANEL_STATE.LONG) {
            if (!this.vehicleTF.visible) {
                this.vehicleTF.visible = true;
            }
            if (this.playerNameFullTF.visible) {
                this.playerNameFullTF.visible = false;
            }
            if (this.playerNameCutTF.visible) {
                this.playerNameCutTF.visible = false;
            }
            this.icoIGR.visible = this._isIGR;
        }
        else if (this._state == PLAYERS_PANEL_STATE.MEDIUM) {
            if (this.vehicleTF.visible) {
                this.vehicleTF.visible = false;
            }
            if (this.playerNameFullTF.visible) {
                this.playerNameFullTF.visible = false;
            }
            if (!this.playerNameCutTF.visible) {
                this.playerNameCutTF.visible = true;
            }
            this.icoIGR.visible = false;
        }
        else if (this._state == PLAYERS_PANEL_STATE.SHORT) {
            if (this.vehicleTF.visible) {
                this.vehicleTF.visible = false;
            }
            if (this.playerNameFullTF.visible) {
                this.playerNameFullTF.visible = false;
            }
            if (this.playerNameCutTF.visible) {
                this.playerNameCutTF.visible = false;
            }
            this.icoIGR.visible = false;
        }
        if (this._state == PLAYERS_PANEL_STATE.HIDEN) {
            visible = false;
        }
        else {
            visible = true;
            this.updatePositions();
        }
    }

    private function updateColors():void {
        var _loc1_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(this._isCurrentPlayer, this._isSquadPersonal, this._isTeamKiller, !this._isAlive, this._isOffline);
        var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(_loc1_);
        if (_loc2_) {
            this.vehicleIcon.transform.colorTransform = _loc2_.colorTransform;
        }
        _loc1_ = PlayerStatusSchemeName.getSchemeForVehicleLevel(!this._isAlive);
        _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
        if (_loc2_) {
            this.vehicleLevel.transform.colorTransform = _loc2_.colorTransform;
        }
        _loc1_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this._isCurrentPlayer, this._isSquadPersonal, this._isTeamKiller, !this._isAlive, this._isOffline);
        _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
        if (_loc2_) {
            if (this.fragsTF.textColor != _loc2_.rgb) {
                this.fragsTF.textColor = _loc2_.rgb;
            }
            if (this.playerNameFullTF.textColor != _loc2_.rgb) {
                this.playerNameFullTF.textColor = _loc2_.rgb;
            }
            if (this.playerNameCutTF.textColor != _loc2_.rgb) {
                this.playerNameCutTF.textColor = _loc2_.rgb;
            }
            if (this.vehicleTF.textColor != _loc2_.rgb) {
                this.vehicleTF.textColor = _loc2_.rgb;
            }
        }
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OVER, this, this.holderItemID, param1);
        dispatchEvent(_loc2_);
        this.dynamicSquad.onItemOver();
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OUT, this, this.holderItemID, param1);
        dispatchEvent(_loc2_);
        this.dynamicSquad.onItemOut();
    }

    private function onMouseClickHandler(param1:MouseEvent):void {
        var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_CLICK, this, this.holderItemID, param1);
        dispatchEvent(_loc2_);
    }
}
}

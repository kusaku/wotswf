package net.wg.gui.lobby.battleloading {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.VoiceWave;
import net.wg.gui.components.icons.PlayerActionMarker;
import net.wg.gui.components.icons.SquadIcon;
import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;
import net.wg.infrastructure.events.VoiceChatEvent;
import net.wg.infrastructure.interfaces.IColorScheme;
import net.wg.infrastructure.managers.IColorSchemeManager;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.controls.ListItemRenderer;

public class PlayerItemRenderer extends ListItemRenderer {

    private static const UNKNOWN_VEHICLE_CLASS_NAME:String = "unknown";

    private static const AVAILABLE_TEXT_COLOR:int = 16777215;

    private static const NOT_AVAILABLE_TEXT_COLOR:int = 5130300;

    private static const ACTION_MARKER_MYTEAM:String = "myteam";

    private static const ACTION_MARKER_ENEMY:String = "enemy";

    private static const DEF_PLAYER_ACTION:int = 0;

    public var selfBg:Image;

    public var vehicleField:TextField;

    public var vehicleIconLoader:UILoaderAlt;

    public var vehicleTypeIcon:MovieClip;

    public var vehicleLevelIcon:MovieClip;

    public var squad:SquadIcon;

    public var voiceWave:VoiceWave;

    public var playerActionMarker:PlayerActionMarker;

    private var _model:VehicleInfoVO;

    public function PlayerItemRenderer() {
        constraintsDisabled = true;
        preventAutosizing = true;
        super();
        this.visible = false;
    }

    override public function setData(param1:Object):void {
        this._model = null;
        if (param1 != null) {
            this._model = VehicleInfoVO(param1);
        }
        invalidate();
    }

    override public function toString():String {
        return "[WG PlayerItemRenderer " + name + "]";
    }

    override protected function configUI():void {
        super.configUI();
        mouseEnabled = false;
        App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.onVoiceChatMgrStartStopSpeakingHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.onVoiceChatMgrStartStopSpeakingHandler);
    }

    override protected function onDispose():void {
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING, this.onVoiceChatMgrStartStopSpeakingHandler);
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING, this.onVoiceChatMgrStartStopSpeakingHandler);
        if (this.selfBg != null) {
            this.selfBg.dispose();
            this.selfBg = null;
        }
        this.vehicleField = null;
        this.vehicleTypeIcon = null;
        this.vehicleLevelIcon = null;
        this.vehicleIconLoader.dispose();
        this.vehicleIconLoader = null;
        this.squad.dispose();
        this.squad = null;
        this.voiceWave.dispose();
        this.voiceWave = null;
        this.playerActionMarker.dispose();
        this.playerActionMarker = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        this.update();
        super.draw();
    }

    override protected function setState(param1:String):void {
    }

    override protected function updateText():void {
    }

    public function onPlayerSpeak(param1:Number, param2:Boolean):void {
        if (this._model != null && this.voiceWave != null && param1 == this._model.accountDBID) {
            this.voiceWave.setSpeaking(param2);
        }
    }

    private function update():void {
        if (this._model != null && initialized) {
            if (this.selfBg != null) {
                this.selfBg.visible = this._model.isCurrentPlayer;
                if (this.selfBg.visible && StringUtils.isNotEmpty(this._model.selfBgSource)) {
                    this.selfBg.source = this._model.selfBgSource;
                }
            }
            textField.visible = true;
            App.utils.commons.formatPlayerName(textField, App.utils.commons.getUserProps(this._model.playerName, this._model.clanAbbrev, this._model.region, this._model.igrType));
            this.vehicleField.visible = true;
            this.vehicleField.htmlText = this._model.vehicleGuiName;
            this.setVehicleIcon();
            this.setVehicleType();
            this.setVehicleLevel();
            this.setSquadState();
            if (!this._model.isNotAvailable()) {
                enabled = this._model.isAlive() && this._model.isReady();
            }
            this.setVoiceState(true);
            this.setPlayerActionMarkerState();
            this.updateState();
            this.visible = true;
        }
        else {
            if (this.selfBg != null) {
                this.selfBg.visible = false;
            }
            textField.visible = false;
            this.vehicleField.visible = false;
            this.vehicleIconLoader.visible = false;
            this.vehicleTypeIcon.visible = false;
            this.vehicleLevelIcon.visible = false;
            enabled = false;
            this.setVoiceState(false);
            if (this.playerActionMarker != null) {
                this.playerActionMarker.action = DEF_PLAYER_ACTION;
            }
        }
    }

    private function setPlayerActionMarkerState():void {
        if (this.playerActionMarker != null && this._model.vehicleAction) {
            this.playerActionMarker.action = this._model.vehicleAction;
            this.playerActionMarker.team = !!this._model.isPlayerTeam ? ACTION_MARKER_MYTEAM : ACTION_MARKER_ENEMY;
        }
    }

    private function setVoiceState(param1:Boolean):void {
        if (this.voiceWave != null) {
            if (param1) {
                if (this._model.isSpeaking) {
                    this.voiceWave.setSpeaking(true);
                }
                this.voiceWave.setMuted(this._model.isMuted);
                if (this._model.isMuted) {
                    this.voiceWave.setSpeaking(false);
                    this.voiceWave.validateNow();
                }
            }
            else {
                this.voiceWave.setSpeaking(false, true);
                this.voiceWave.setMuted(false);
            }
        }
    }

    private function setSquadState():void {
        if (this.squad != null) {
            if (this._model.isSquadMan()) {
                this.squad.show(this._model.isCurrentSquad, this._model.squadIndex);
            }
            else {
                this.squad.hide();
            }
        }
    }

    private function setVehicleLevel():void {
        if (this.vehicleLevelIcon != null) {
            this.vehicleLevelIcon.visible = this._model.vLevel > 0;
            if (this.vehicleLevelIcon.visible) {
                this.vehicleLevelIcon.gotoAndStop(this._model.vLevel);
            }
        }
    }

    private function setVehicleType():void {
        if (this.vehicleTypeIcon != null) {
            this.vehicleTypeIcon.visible = this._model.vehicleType != Values.EMPTY_STR && this._model.vehicleType != UNKNOWN_VEHICLE_CLASS_NAME;
            if (this.vehicleTypeIcon.visible) {
                this.vehicleTypeIcon.gotoAndStop(BattleLoadingHelper.instance.getVehicleTypeIconId(this._model));
            }
        }
    }

    private function setVehicleIcon():void {
        if (this.vehicleIconLoader != null) {
            this.vehicleIconLoader.visible = true;
            if (this.vehicleIconLoader.source != this._model.vehicleIcon) {
                this.vehicleIconLoader.source = this._model.vehicleIcon;
            }
        }
    }

    private function updateState():void {
        var _loc1_:String = null;
        var _loc2_:String = null;
        var _loc8_:Number = NaN;
        var _loc3_:IColorSchemeManager = App.colorSchemeMgr;
        var _loc4_:Boolean = this._model.isAlive();
        var _loc5_:Boolean = true;
        if (!this._model.isNotAvailable()) {
            _loc5_ = _loc4_ && this._model.isReady();
        }
        _loc1_ = BattleLoadingHelper.instance.getColorSchemeName(this._model, _loc5_);
        _loc2_ = _loc1_;
        var _loc6_:IColorScheme = _loc3_.getScheme(_loc1_);
        var _loc7_:IColorScheme = _loc3_.getScheme(_loc2_);
        if (_loc6_) {
            textField.textColor = _loc6_.rgb;
            this.vehicleField.textColor = _loc6_.rgb;
        }
        else {
            DebugUtils.LOG_ERROR("Color of text not found", this._model);
            _loc8_ = !!_loc5_ ? Number(AVAILABLE_TEXT_COLOR) : Number(NOT_AVAILABLE_TEXT_COLOR);
            textField.textColor = _loc8_;
            this.vehicleField.textColor = _loc8_;
        }
        if (_loc7_) {
            this.vehicleIconLoader.transform.colorTransform = _loc7_.colorTransform;
        }
        else {
            DebugUtils.LOG_ERROR("Color of icon not found", this._model);
            this.vehicleIconLoader.transform.colorTransform = _loc7_.colorTransform;
        }
    }

    private function onVoiceChatMgrStartStopSpeakingHandler(param1:VoiceChatEvent):void {
        this.onPlayerSpeak(param1.getAccountDBID(), param1.type == VoiceChatEvent.START_SPEAKING);
    }
}
}

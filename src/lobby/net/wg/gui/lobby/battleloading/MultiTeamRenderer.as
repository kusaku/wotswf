package net.wg.gui.lobby.battleloading {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.VoiceWave;
import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;
import net.wg.infrastructure.events.VoiceChatEvent;
import net.wg.infrastructure.interfaces.IColorScheme;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ListItemRenderer;

public class MultiTeamRenderer extends ListItemRenderer {

    public static const DEFAULT_RENDERER_HEIGHT:int = 25;

    public var playerNameTF:TextField;

    public var vehicleNameTF:TextField;

    public var selfBg:Image;

    public var voiceWave:VoiceWave;

    public var vehicleTypeIcon:MovieClip;

    public function MultiTeamRenderer() {
        super();
        preventAutosizing = true;
    }

    override protected function configUI():void {
        super.configUI();
        App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.voiceChatMgrSpeakingHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.voiceChatMgrSpeakingHandler);
    }

    override protected function draw():void {
        var _loc1_:VehicleInfoVO = null;
        var _loc2_:String = null;
        var _loc3_:IColorScheme = null;
        super.draw();
        visible = data != null;
        if (isInvalid(InvalidationType.DATA) && data != null) {
            _loc1_ = VehicleInfoVO(data);
            App.utils.commons.formatPlayerName(this.playerNameTF, App.utils.commons.getUserProps(_loc1_.playerName, _loc1_.clanAbbrev, _loc1_.region, _loc1_.igrType));
            this.vehicleNameTF.htmlText = _loc1_.vehicleGuiName;
            this.selfBg.visible = _loc1_.isCurrentPlayer;
            if (this.selfBg.visible) {
                this.selfBg.source = _loc1_.selfBgSource;
            }
            this.voiceWave.setSpeaking(_loc1_.isSpeaking);
            this.voiceWave.setMuted(_loc1_.isMuted);
            this.vehicleTypeIcon.gotoAndStop(BattleLoadingHelper.instance.getVehicleTypeIconId(_loc1_));
            _loc2_ = BattleLoadingHelper.instance.getColorSchemeName(_loc1_, true);
            _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
            this.playerNameTF.textColor = _loc3_.rgb;
            this.vehicleNameTF.textColor = _loc3_.rgb;
        }
    }

    override protected function onDispose():void {
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING, this.voiceChatMgrSpeakingHandler);
        App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING, this.voiceChatMgrSpeakingHandler);
        this.playerNameTF = null;
        this.vehicleNameTF = null;
        this.selfBg.dispose();
        this.selfBg = null;
        this.voiceWave.dispose();
        this.voiceWave = null;
        this.vehicleTypeIcon = null;
        this.vehicleTypeIcon = null;
        super.onDispose();
    }

    private function onPlayerSpeak(param1:Number, param2:Boolean):void {
        if (data && param1 == VehicleInfoVO(data).accountDBID && this.voiceWave) {
            this.voiceWave.setSpeaking(param2);
        }
    }

    private function voiceChatMgrSpeakingHandler(param1:VoiceChatEvent):void {
        this.onPlayerSpeak(param1.getAccountDBID(), param1.type == VoiceChatEvent.START_SPEAKING);
    }
}
}

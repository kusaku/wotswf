package net.wg.gui.battle.battleloading.renderers {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.UserTags;
import net.wg.gui.battle.battleloading.BattleLoadingHelper;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.VoiceWave;
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

    public var icoIGR:BattleAtlasSprite;

    public function MultiTeamRenderer() {
        super();
        preventAutosizing = true;
    }

    override protected function configUI():void {
        super.configUI();
        this.icoIGR.visible = false;
        App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING, this.voiceChatMgrSpeakingHandler);
        App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING, this.voiceChatMgrSpeakingHandler);
    }

    override protected function draw():void {
        var _loc1_:DAAPIVehicleInfoVO = null;
        var _loc2_:String = null;
        var _loc3_:String = null;
        var _loc4_:IColorScheme = null;
        super.draw();
        visible = data != null;
        if (isInvalid(InvalidationType.DATA) && data != null) {
            _loc1_ = DAAPIVehicleInfoVO(data);
            App.utils.commons.formatPlayerName(this.playerNameTF, App.utils.commons.getUserProps(_loc1_.playerName, _loc1_.clanAbbrev, _loc1_.region, 0, _loc1_.userTags));
            this.vehicleNameTF.text = _loc1_.vehicleName;
            this.icoIGR.visible = _loc1_.isIGR;
            if (this.icoIGR.visible) {
                this.icoIGR.imageName = BattleAtlasItem.ICO_IGR;
                if (this.vehicleNameTF.getTextFormat().align == TextFormatAlign.RIGHT) {
                    this.vehicleNameTF.x = this.icoIGR.x - this.vehicleNameTF.width >> 0;
                }
                else {
                    this.icoIGR.x = this.vehicleNameTF.x;
                    this.vehicleNameTF.x = this.icoIGR.x + this.icoIGR.width >> 0;
                }
            }
            else if (this.vehicleNameTF.getTextFormat().align != TextFormatAlign.RIGHT) {
                this.vehicleNameTF.x = this.icoIGR.x;
            }
            this.selfBg.visible = _loc1_.isCurrentPlayer;
            if (this.selfBg.visible) {
                this.selfBg.source = _loc1_.selfBgSource;
            }
            this.voiceWave.setSpeaking(_loc1_.isSpeaking);
            this.voiceWave.setMuted(UserTags.isMuted(_loc1_.userTags));
            _loc2_ = BattleLoadingHelper.instance.getVehicleTypeIconId(_loc1_);
            if (_loc2_) {
                this.vehicleTypeIcon.gotoAndStop(_loc2_);
                this.vehicleTypeIcon.visible = true;
            }
            else {
                this.vehicleTypeIcon.visible = false;
            }
            _loc3_ = BattleLoadingHelper.instance.getColorSchemeName(_loc1_, true);
            _loc4_ = App.colorSchemeMgr.getScheme(_loc3_);
            this.playerNameTF.textColor = _loc4_.rgb;
            this.vehicleNameTF.textColor = _loc4_.rgb;
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
        this.icoIGR = null;
        super.onDispose();
    }

    private function onPlayerSpeak(param1:Number, param2:Boolean):void {
        if (data && param1 == DAAPIVehicleInfoVO(data).accountDBID && this.voiceWave) {
            this.voiceWave.setSpeaking(param2);
        }
    }

    private function voiceChatMgrSpeakingHandler(param1:VoiceChatEvent):void {
        this.onPlayerSpeak(param1.getAccountDBID(), param1.type == VoiceChatEvent.START_SPEAKING);
    }
}
}

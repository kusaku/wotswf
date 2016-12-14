package net.wg.gui.messenger.controls {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.constants.UserTags;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.VoiceWave;
import net.wg.gui.messenger.data.ChannelMemberVO;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.clik.constants.InvalidationType;

public class MemberItemRenderer extends SoundListItemRenderer {

    private static const STATUS_ONLINE:String = "online";

    private static const STATUS_OFFLINE:String = "offline";

    private static const STATUS_IGNORED:String = "ignored";

    private static const STATUS_HIMSELF:String = "himself";

    public var status:MovieClip;

    public var voiceWave:VoiceWave;

    protected var model:ChannelMemberVO;

    protected var tooltip:String;

    public function MemberItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        if (param1 == null) {
            visible = false;
            this.model = null;
            return;
        }
        visible = true;
        this.model = new ChannelMemberVO(param1);
        this.tooltip = this.model.userName;
        invalidate(InvalidationType.DATA, InvalidationType.STATE);
    }

    override protected function onDispose():void {
        if (this.model != null) {
            this.model.dispose();
            this.model = null;
        }
        if (this.voiceWave != null) {
            this.voiceWave.dispose();
            this.voiceWave = null;
        }
        this.status = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
        setState("out");
    }

    override protected function draw():void {
        var _loc1_:Point = null;
        if (isInvalid(InvalidationType.DATA) && this.model) {
            this.status.gotoAndPlay(this.getStatusFrame());
            this.voiceWave.setMuted(UserTags.isMuted(this.model.tags));
            this.setSpeaking(this.model.isPlayerSpeaking, true);
            if (enabled) {
                _loc1_ = new Point(mouseX, mouseY);
                _loc1_ = localToGlobal(_loc1_);
                if (hitTestPoint(_loc1_.x, _loc1_.y, true)) {
                    setState("over");
                    App.soundMgr.playControlsSnd(state, soundType, soundId);
                    dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                }
            }
        }
        super.draw();
    }

    override protected function updateText():void {
        var _loc1_:IUserProps = null;
        if (textField != null && this.model != null && this.model.userName) {
            _loc1_ = App.utils.commons.getUserProps(this.model.userName, "", "", 0, this.model.tags);
            _loc1_.rgb = this.model.color;
            App.utils.commons.formatPlayerName(textField, _loc1_);
        }
    }

    private function getStatusFrame():String {
        var _loc1_:Array = this.model.tags;
        var _loc2_:String = !!UserTags.isIgnored(_loc1_) ? STATUS_IGNORED : !!UserTags.isCurrentPlayer(_loc1_) ? STATUS_HIMSELF : !!this.model.isOnline ? STATUS_ONLINE : STATUS_OFFLINE;
        return _loc2_;
    }

    private function setSpeaking(param1:Boolean, param2:Boolean = false):void {
        if (param1) {
            param2 = false;
        }
        if (this.voiceWave is VoiceWave) {
            this.voiceWave.setSpeaking(param1, param2);
        }
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (this.tooltip) {
            App.toolTipMgr.show(this.tooltip);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
        if (enabled) {
            if (!_focused && !_displayFocus || focusIndicator != null) {
                setState("out");
            }
        }
    }
}
}

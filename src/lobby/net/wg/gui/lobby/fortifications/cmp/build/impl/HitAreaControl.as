package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;

import net.wg.data.constants.SoundManagerStates;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.interfaces.entity.ISoundable;

public class HitAreaControl extends MovieClip implements ISoundable, IDisposable {

    private var _soundId:String = "";

    private var _soundType:String = "normal";

    public function HitAreaControl() {
        super();
        App.soundMgr.addSoundsHdlrs(this);
    }

    public function canPlaySound(param1:String):Boolean {
        return this.enabled && this.buttonMode && this.useHandCursor;
    }

    public function dispose():void {
        App.soundMgr.removeSoundHdlrs(this);
    }

    public function getSoundId():String {
        return this._soundId;
    }

    public function getSoundType():String {
        return this._soundType;
    }

    public function getStateOutSnd():String {
        return SoundManagerStates.SND_OUT;
    }

    public function getStateOverSnd():String {
        return SoundManagerStates.SND_OVER;
    }

    public function getStatePressSnd():String {
        return SoundManagerStates.SND_PRESS;
    }

    public function get soundType():String {
        return this._soundType;
    }

    public function set soundType(param1:String):void {
        if (param1 && param1 != this._soundType) {
            this._soundType = param1;
        }
    }
}
}

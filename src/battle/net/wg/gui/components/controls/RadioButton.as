package net.wg.gui.components.controls {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;

import net.wg.data.constants.SoundManagerStates;
import net.wg.infrastructure.interfaces.entity.ISoundable;

import scaleform.clik.controls.RadioButton;
import scaleform.clik.events.InputEvent;

public class RadioButton extends scaleform.clik.controls.RadioButton implements ISoundable {

    private var _soundType:String = "radioButton";

    public var soundId:String = "";

    public function RadioButton() {
        super();
    }

    public function get soundType():String {
        return this._soundType;
    }

    public function set soundType(param1:String):void {
        if (param1 && param1 != this._soundType) {
            this._soundType = param1;
        }
    }

    override protected function initialize():void {
        super.initialize();
        _label = "";
        toggle = true;
        allowDeselect = false;
        buttonMode = true;
        if (_group == null) {
            groupName = null;
        }
    }

    override protected function configUI():void {
        super.configUI();
        App.soundMgr.addSoundsHdlrs(this);
    }

    override protected function updateText():void {
        if (_label != null && textField != null) {
            textField.htmlText = _label;
        }
    }

    public final function getSoundType():String {
        return this.soundType;
    }

    public final function getSoundId():String {
        return this.soundId;
    }

    public final function getStateOverSnd():String {
        return SoundManagerStates.SND_OVER;
    }

    public final function getStateOutSnd():String {
        return SoundManagerStates.SND_OUT;
    }

    public final function getStatePressSnd():String {
        return SoundManagerStates.SND_PRESS;
    }

    override protected function onDispose():void {
        removeEventListener(Event.ADDED, addToAutoGroup, false);
        removeEventListener(Event.REMOVED, addToAutoGroup, false);
        removeEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver, false);
        removeEventListener(MouseEvent.ROLL_OUT, handleMouseRollOut, false);
        removeEventListener(MouseEvent.MOUSE_DOWN, handleMousePress, false);
        removeEventListener(MouseEvent.CLICK, handleMouseRelease, false);
        removeEventListener(MouseEvent.DOUBLE_CLICK, handleMouseRelease, false);
        removeEventListener(InputEvent.INPUT, handleInput, false);
        if (_repeatTimer) {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, beginRepeat, false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER, handleRepeat, false);
        }
        if (App.soundMgr) {
            App.soundMgr.removeSoundHdlrs(this);
        }
        super.onDispose();
    }

    public function canPlaySound(param1:String):Boolean {
        return this.enabled;
    }
}
}

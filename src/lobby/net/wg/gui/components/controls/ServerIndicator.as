package net.wg.gui.components.controls {
import flash.display.Sprite;

import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.components.controls.helpers.ServerPingState;
import net.wg.gui.components.controls.interfaces.IServerIndicator;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class ServerIndicator extends UIComponentEx implements IServerIndicator {

    public var waiting:InviteIndicator;

    public var pingNone:Sprite;

    public var pingLow:Sprite;

    public var pingLowColorBlind:Sprite;

    public var pingNormal:Sprite;

    public var pingHigh:Sprite;

    private var _states:Vector.<Sprite>;

    private var _currentPingState:int = -1;

    private var _colorBlind:Boolean = false;

    public function ServerIndicator() {
        super();
        this._states = new <Sprite>[this.pingNone, this.pingLow, this.pingNormal, this.pingHigh];
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE)) {
            this.updateState();
        }
    }

    override protected function onDispose():void {
        this._states.splice(0, this._states.length);
        this._states = null;
        this.waiting.dispose();
        this.waiting = null;
        this.pingNone = null;
        this.pingLow = null;
        this.pingLowColorBlind = null;
        this.pingNormal = null;
        this.pingHigh = null;
        super.onDispose();
    }

    public function setColorBlindMode(param1:Boolean):void {
        this._colorBlind = param1;
        invalidate(InvalidationType.STATE);
    }

    public function setPingState(param1:int):void {
        if (this._currentPingState == param1) {
            return;
        }
        this._currentPingState = param1;
        invalidate(InvalidationType.STATE);
    }

    private function updateState():void {
        var _loc1_:int = this._currentPingState;
        this.waiting.visible = _loc1_ == ServerPingState.UNDEFINED;
        if (this._colorBlind && _loc1_ == ServerPingState.HIGH) {
            _loc1_ = -1;
            this.pingLowColorBlind.visible = true;
        }
        else {
            this.pingLowColorBlind.visible = false;
        }
        var _loc2_:uint = this._states.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this._states[_loc3_].visible = _loc3_ == _loc1_;
            _loc3_++;
        }
    }
}
}

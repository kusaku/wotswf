package net.wg.gui.components.crosshairPanel {
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairPostmortem extends SimpleContainer implements ICrosshair {

    public var playerInfo:TextField = null;

    public var ammoInfo:TextField = null;

    private var _playerInfoStr:String = "";

    private const AMMO_INFO_VERTICAL_OFFSET:int = 4;

    private const AMMO_STATE_VALIDATION:String = "ammoState";

    private const PLAYER_INFO_VALIDATION:String = "playerInfo";

    private var _strAmmoState:String = "";

    public function CrosshairPostmortem() {
        super();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(this.AMMO_STATE_VALIDATION)) {
            this.ammoInfo.text = this._strAmmoState;
            if (this._strAmmoState != Values.EMPTY_STR) {
                this.ammoInfo.y = this.playerInfo.y + this.playerInfo.textHeight + this.AMMO_INFO_VERTICAL_OFFSET | 0;
            }
        }
        if (isInvalid(this.PLAYER_INFO_VALIDATION)) {
            this.playerInfo.htmlText = this._playerInfoStr;
        }
    }

    public function updateAmmoState(param1:String):void {
        if (this._strAmmoState != param1) {
            this._strAmmoState = param1;
            invalidate(this.AMMO_STATE_VALIDATION);
        }
    }

    public function updatePlayerInfo(param1:String):void {
        this._playerInfoStr = param1;
        invalidate(this.PLAYER_INFO_VALIDATION);
    }

    override protected function onDispose():void {
        this.playerInfo = null;
        this.ammoInfo = null;
        super.onDispose();
    }

    public function setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean = false):void {
    }

    public function setClipsParam(param1:Number, param2:Number):void {
    }

    public function setDistance(param1:String):void {
    }

    public function setHealth(param1:Number):void {
    }

    public function setNetType(param1:Number):void {
    }

    public function setZoom(param1:String):void {
    }

    public function setReloadingAsPercent(param1:Number):void {
    }

    public function setReloadingState(param1:String):void {
    }

    public function setReloadingTime(param1:Number):void {
    }

    public function setCenterType(param1:Number):void {
    }

    public function showReloadingTimeField(param1:Boolean):void {
    }

    public function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number):void {
    }

    public function clearDistance(param1:Boolean):void {
    }

    public function setDistanceVisibility(param1:Boolean):void {
    }

    public function setInfo(param1:Number, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:String, param11:Number, param12:Number, param13:Boolean, param14:String, param15:Boolean = false):void {
        this.updatePlayerInfo(param7);
        this.updateAmmoState(param10);
    }
}
}

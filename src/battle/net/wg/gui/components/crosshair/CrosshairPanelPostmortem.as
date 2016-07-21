package net.wg.gui.components.crosshair {
import fl.motion.AdjustColor;

import flash.events.Event;
import flash.external.ExternalInterface;
import flash.filters.ColorMatrixFilter;
import flash.text.TextField;

public class CrosshairPanelPostmortem extends CrosshairPanelBase {

    public var playerInfo:TextField = null;

    public var ammoInfo:TextField = null;

    private const DAAPI_INIT_CALLBACK_ID:String = "registerPostmortemAimPanel";

    private const AMMO_INFO_VERTICAL_OFFSET:int = 4;

    public function CrosshairPanelPostmortem() {
        super();
        addEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        this.ammoInfo.text = INGAME_GUI.PLAYER_MESSAGES_POSTMORTEM_USERNOHASAMMO;
    }

    override protected function initFrameWalkers():void {
    }

    override protected function onSetHealth(param1:Number):void {
    }

    override protected function onSetReloading(param1:Number, param2:Number, param3:Boolean, param4:Number, param5:Number):void {
    }

    override protected function onSetReloadingAsPercent(param1:Number, param2:Boolean):void {
    }

    override protected function onSetReloadingTimeWithCorrection(param1:Number, param2:Number, param3:Boolean):void {
    }

    override protected function onClearFadingTarget(param1:Number):void {
    }

    override protected function onSetFadingTarget(param1:String, param2:String, param3:Number):void {
    }

    private function callExternalInterface(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        ExternalInterface.call(this.DAAPI_INIT_CALLBACK_ID);
    }

    override public function as_setTarget(param1:String, param2:String, param3:Number):void {
    }

    override public function as_clearTarget(param1:Number):void {
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.as_updatePlayerInfo("");
        this.as_updateAmmoState(true);
    }

    override public function as_updatePlayerInfo(param1:String):void {
        this.playerInfo.htmlText = param1;
        this.as_updateAmmoInfoPos();
    }

    override public function as_updateAmmoState(param1:Boolean):void {
        this.ammoInfo.visible = !param1;
        this.as_updateAmmoInfoPos();
    }

    override public function as_updateAmmoInfoPos():void {
        if (this.ammoInfo.visible) {
            this.ammoInfo.y = Math.round(this.playerInfo.y + this.playerInfo.textHeight + this.AMMO_INFO_VERTICAL_OFFSET);
        }
    }

    override public function as_updateAdjust(param1:Number, param2:Number, param3:Number, param4:Number):void {
        var _loc5_:AdjustColor = null;
        var _loc6_:ColorMatrixFilter = null;
        if (param1 != 0 || param2 != 0 || param3 != 0 || param4 != 0) {
            _loc5_ = new AdjustColor();
            _loc5_.brightness = param1;
            _loc5_.contrast = param2;
            _loc5_.saturation = param3;
            _loc5_.hue = param4;
            _loc6_ = new ColorMatrixFilter(_loc5_.CalculateFinalFlatArray());
            this.playerInfo.filters = [_loc6_];
            this.ammoInfo.filters = [_loc6_];
        }
        else {
            this.playerInfo.filters = [];
            this.ammoInfo.filters = [];
        }
    }

    override protected function onDispose():void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        super.onDispose();
    }
}
}

package net.wg.gui.battle.views.debugPanel {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.InvalidationType;
import net.wg.infrastructure.base.meta.IDebugPanelMeta;
import net.wg.infrastructure.base.meta.impl.DebugPanelMeta;

import scaleform.gfx.TextFieldEx;

public class DebugPanel extends DebugPanelMeta implements IDebugPanelMeta {

    private static const POS_X_0:int = 0;

    private static const POS_X_1:int = -23;

    private static const INVALID_FPS_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALID_PING_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const INVALID_LAG_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    public var fpsTF:TextField = null;

    public var pingTF:TextField = null;

    public var lagOnlineSpr:Sprite = null;

    public var lagOfflineSpr:Sprite = null;

    private var _fpsFieldLength:int = -1;

    private var _isLagging:Boolean = false;

    private var _fpsStr:String = "";

    private var _pingStr:String = "";

    public function DebugPanel() {
        super();
        TextFieldEx.setNoTranslate(this.fpsTF, true);
        TextFieldEx.setNoTranslate(this.pingTF, true);
    }

    public function as_updatePingInfo(param1:String):void {
        this.updatePingInfo(param1);
    }

    public function as_updateFPSInfo(param1:String):void {
        this.updateFPSInfo(param1);
    }

    public function as_updateLagInfo(param1:Boolean):void {
        this.updateLagInfo(param1);
    }

    public function as_updatePingFPSInfo(param1:String, param2:String):void {
        this.updatePingInfo(param1);
        this.updateFPSInfo(param2);
    }

    public function as_updatePingFPSLagInfo(param1:String, param2:String, param3:Boolean):void {
        this.updatePingInfo(param1);
        this.updateFPSInfo(param2);
        this.updateLagInfo(param3);
    }

    private function updatePingInfo(param1:String):void {
        if (this._pingStr != param1) {
            this._pingStr = param1;
            invalidate(INVALID_PING_TF);
        }
    }

    private function updateFPSInfo(param1:String):void {
        if (this._fpsStr != param1) {
            this._fpsStr = param1;
            this._fpsFieldLength = param1.length;
            invalidate(INVALID_FPS_TF);
        }
    }

    private function updateLagInfo(param1:Boolean):void {
        if (this._isLagging != param1) {
            this._isLagging = param1;
            invalidate(INVALID_LAG_VISIBILITY);
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_FPS_TF)) {
            this.fpsTF.text = this._fpsStr;
            if (this._fpsFieldLength > 4) {
                x = POS_X_0;
            }
            else {
                x = POS_X_1;
            }
        }
        if (isInvalid(INVALID_PING_TF)) {
            this.pingTF.text = this._pingStr;
        }
        if (isInvalid(INVALID_LAG_VISIBILITY)) {
            this.lagOnlineSpr.visible = !this._isLagging;
            this.lagOfflineSpr.visible = this._isLagging;
        }
    }

    override protected function onDispose():void {
        this.lagOnlineSpr = null;
        this.lagOfflineSpr = null;
        this.fpsTF = null;
        this.pingTF = null;
        super.onDispose();
    }
}
}

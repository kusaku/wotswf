package net.wg.gui.battle.views.siegeModePanel {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.utils.clearInterval;
import flash.utils.getTimer;
import flash.utils.setInterval;

import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.data.constants.VehicleModules;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.components.HintPanel;
import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
import net.wg.infrastructure.base.meta.ISiegeModeIndicatorMeta;
import net.wg.infrastructure.base.meta.impl.SiegeModeIndicatorMeta;
import net.wg.infrastructure.managers.IAtlasManager;

public class SiegeModePanel extends SiegeModeIndicatorMeta implements ISiegeModeIndicatorMeta {

    private static const STATE_VISIBLE_TIMER:String = "visibleTimer";

    private static const STATE_INVISIBLE_TIMER:String = "invisibleTimer";

    private static const STATE_SHOW_TIMER:String = "showTimer";

    private static const STATE_HIDE_TIMER:String = "hideTimer";

    private static const VISIBLE_FRAME:String = "visible";

    private static const ROTATION_NORMAL:Number = -45;

    private static const MS_IN_S:Number = 1000;

    private static const PRECISION:int = 1;

    private static const CRITICAL_TIME:int = 3000;

    private static const DESTROYED_TIME:int = 5000;

    private static const NO_TIME:String = "- -";

    private static const DELIMITER:String = "_";

    private static const CRITICAL_COMPLETE_FRAME:int = 39;

    private static const SIEGE_SWITCHING_ON:int = 1;

    private static const SIEGE_SWITCHING_OFF:int = 3;

    private static const HINT_Y:int = 120;

    private static const STATES:Vector.<String> = new <String>["base", "base", "siege", "siege"];

    public var changeTimeContainer:MovieClip = null;

    public var statusSiegeIcon:MovieClip = null;

    public var switchIndicatorContainer:MovieClip = null;

    public var deviceIconContainer:MovieClip = null;

    public var damagedContainer:MovieClip = null;

    private var _startTime:Number = 0;

    private var _totalTime:Number = 0;

    private var _switchIntervalId:int = 0;

    private var _deviceIntervalId:int = 0;

    private var _isSwitchPlay:Boolean = false;

    private var _isDevicePlay:Boolean = false;

    private var _siegeState:int = -1;

    private var _colorByEngineState:Object;

    private var _deviceStatus:String = null;

    private var _deviceState:String = null;

    private var _changeTimeTF:TextField = null;

    private var _switchIndicator:MovieClip = null;

    private var _deviceStatusIcon:MovieClip = null;

    private var _hintPanel:HintPanel = null;

    private var _atlasManager:IAtlasManager;

    public function SiegeModePanel() {
        this._colorByEngineState = {};
        this._atlasManager = App.atlasMgr;
        super();
    }

    override protected function initialize():void {
        super.initialize();
        this._colorByEngineState[BATTLE_ITEM_STATES.NORMAL] = 13434777;
        this._colorByEngineState[BATTLE_ITEM_STATES.CRITICAL] = 16744192;
        this._colorByEngineState[BATTLE_ITEM_STATES.DESTROYED] = 16711680;
        this._changeTimeTF = this.changeTimeContainer.changeTimeTF;
        this._switchIndicator = this.switchIndicatorContainer.switchIndicator;
        this._deviceStatusIcon = this.deviceIconContainer.deviceStatusIcon;
    }

    override protected function configUI():void {
        super.configUI();
        this.deviceIconContainer.stop();
        this.damagedContainer.stop();
        gotoAndStop(STATE_INVISIBLE_TIMER);
        this.deviceIconContainer.visible = false;
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, BattleAtlasItem.SWITCH_SIEGE_DAMAGED, this.damagedContainer.damagedIcon.graphics, Values.EMPTY_STR, false, false, true);
        this.damagedContainer.visible = false;
        this.deviceIconContainer.addFrameScript(CRITICAL_COMPLETE_FRAME, this.onLoopAnimation);
        this.deviceIconContainer.addFrameScript(this.deviceIconContainer.totalFrames - 1, this.onLoopAnimation);
        this.damagedContainer.addFrameScript(this.damagedContainer.totalFrames - 1, this.onDamagedAnimationComplete);
    }

    override protected function onDispose():void {
        this.changeTimeContainer = null;
        this.statusSiegeIcon = null;
        this.switchIndicatorContainer = null;
        this.deviceIconContainer = null;
        this.damagedContainer = null;
        this._changeTimeTF = null;
        this._switchIndicator = null;
        this._deviceStatusIcon = null;
        this._atlasManager = null;
        this._hintPanel.dispose();
        this._hintPanel = null;
        App.utils.data.cleanupDynamicObject(this._colorByEngineState);
        this._colorByEngineState = null;
        super.onDispose();
    }

    public function as_hideHint():void {
        this._hintPanel.visible = false;
    }

    public function as_setVisible(param1:Boolean):void {
        this.visible = param1;
    }

    public function as_showHint(param1:String, param2:String, param3:String):void {
        if (this._hintPanel == null) {
            this._hintPanel = App.utils.classFactory.getComponent(Linkages.BATTLE_HINT_PANEL, HintPanel);
            this._hintPanel.y = HINT_Y;
            addChild(this._hintPanel);
        }
        this._hintPanel.visible = true;
        this._hintPanel.show(param1, param2, param3);
        this._hintPanel.x = -(this._hintPanel.width >> 1);
    }

    public function as_switchSiegeState(param1:Number, param2:Number, param3:int, param4:String):void {
        if (this._isSwitchPlay) {
            clearInterval(this._switchIntervalId);
            this._isSwitchPlay = false;
        }
        this.setEngineAndTime(param4, param2);
        if (param3 == SIEGE_SWITCHING_ON || param3 == SIEGE_SWITCHING_OFF) {
            if (param1 - param2 > 0) {
                this.switchIndicatorContainer.gotoAndStop(STATE_VISIBLE_TIMER);
                gotoAndStop(STATE_VISIBLE_TIMER);
            }
            else {
                this.switchIndicatorContainer.gotoAndPlay(STATE_SHOW_TIMER);
                gotoAndPlay(STATE_SHOW_TIMER);
            }
            this._totalTime = param1 * MS_IN_S;
            this._startTime = getTimer() - (this._totalTime - param2 * MS_IN_S);
            if (param3 == SIEGE_SWITCHING_ON) {
                this.switchIndicatorContainer.rotation = ROTATION_NORMAL * (param2 / param1);
                if (param4 != BATTLE_ITEM_STATES.DESTROYED) {
                    this._switchIntervalId = setInterval(this.siegeOnTicking, CrosshairConsts.COUNTER_UPDATE_TICK);
                    this._isSwitchPlay = true;
                }
            }
            else {
                this.switchIndicatorContainer.rotation = ROTATION_NORMAL * (1 - param2 / param1);
                if (param4 != BATTLE_ITEM_STATES.DESTROYED) {
                    this._switchIntervalId = setInterval(this.siegeOffTicking, CrosshairConsts.COUNTER_UPDATE_TICK);
                    this._isSwitchPlay = true;
                }
            }
        }
        else {
            this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, param4 + DELIMITER + STATES[param3], this.statusSiegeIcon.graphics);
            this.switchIndicatorContainer.gotoAndStop(STATE_INVISIBLE_TIMER);
            if (this._siegeState == SIEGE_SWITCHING_ON || this._siegeState == SIEGE_SWITCHING_OFF) {
                this.switchIndicatorContainer.gotoAndPlay(STATE_HIDE_TIMER);
                gotoAndPlay(STATE_HIDE_TIMER);
            }
            else {
                gotoAndStop(STATE_INVISIBLE_TIMER);
            }
        }
        this._siegeState = param3;
    }

    public function as_switchSiegeStateSnapshot(param1:Number, param2:Number, param3:int, param4:String):void {
        this.setEngineAndTime(param4, param2);
        if (param3 == SIEGE_SWITCHING_ON || param3 == SIEGE_SWITCHING_OFF) {
            if (param1 - param2 > 0) {
                this.switchIndicatorContainer.gotoAndStop(STATE_VISIBLE_TIMER);
                gotoAndStop(STATE_VISIBLE_TIMER);
            }
            else {
                this.switchIndicatorContainer.gotoAndPlay(STATE_SHOW_TIMER);
                gotoAndPlay(STATE_SHOW_TIMER);
            }
            if (param3 == SIEGE_SWITCHING_ON) {
                this.switchIndicatorContainer.rotation = ROTATION_NORMAL * (param2 / param1);
            }
            else {
                this.switchIndicatorContainer.rotation = ROTATION_NORMAL * (1 - param2 / param1);
            }
        }
        else {
            this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, param4 + DELIMITER + STATES[param3], this.statusSiegeIcon.graphics);
            this.switchIndicatorContainer.gotoAndStop(STATE_INVISIBLE_TIMER);
            if (this._siegeState == SIEGE_SWITCHING_ON || this._siegeState == SIEGE_SWITCHING_OFF) {
                this.switchIndicatorContainer.gotoAndPlay(STATE_HIDE_TIMER);
                gotoAndPlay(STATE_HIDE_TIMER);
            }
            else {
                gotoAndStop(STATE_INVISIBLE_TIMER);
            }
        }
        this._siegeState = param3;
    }

    public function as_updateDeviceState(param1:String, param2:String):void {
        var _loc3_:String = param1 + DELIMITER + param2;
        if (this._deviceStatus != _loc3_) {
            this._deviceStatus = _loc3_;
            this._deviceState = param2;
            if (this._isDevicePlay) {
                clearInterval(this._deviceIntervalId);
                this._isDevicePlay = false;
            }
            this.deviceIconContainer.visible = this._deviceState != BATTLE_ITEM_STATES.NORMAL;
            if (this.deviceIconContainer.visible) {
                this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, this._deviceStatus, this._deviceStatusIcon.graphics);
                this.deviceIconContainer.gotoAndPlay(this._deviceState);
                this._deviceIntervalId = setInterval(this.onAnimationComplete, this._deviceState == BATTLE_ITEM_STATES.CRITICAL ? Number(CRITICAL_TIME) : Number(DESTROYED_TIME));
                this._isDevicePlay = true;
                this.damagedContainer.visible = this._isSwitchPlay && param1 == VehicleModules.ENGINE;
                if (this.damagedContainer.visible) {
                    this.damagedContainer.gotoAndPlay(1);
                }
            }
        }
    }

    public function as_updateLayout(param1:Number, param2:Number):void {
        this.x = param1;
        this.y = param2;
    }

    private function setEngineAndTime(param1:String, param2:Number):void {
        if (param1 != BATTLE_ITEM_STATES.DESTROYED && param2 > 0) {
            this._changeTimeTF.text = param2.toFixed(PRECISION);
        }
        else {
            this._changeTimeTF.text = NO_TIME;
        }
        this._changeTimeTF.textColor = this._colorByEngineState[param1];
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, param1, this._switchIndicator.graphics, Values.EMPTY_STR, true, false, true);
    }

    private function onAnimationComplete():void {
        this.deviceIconContainer.gotoAndStop(this._deviceState + DELIMITER + VISIBLE_FRAME);
        clearInterval(this._deviceIntervalId);
        this._isDevicePlay = false;
    }

    private function siegeOnTicking():void {
        var _loc1_:Number = getTimer() - this._startTime;
        var _loc2_:Number = (this._totalTime - _loc1_) / MS_IN_S;
        this._changeTimeTF.text = _loc2_.toFixed(PRECISION);
        this.switchIndicatorContainer.rotation = ROTATION_NORMAL * (1 - _loc1_ / this._totalTime);
    }

    private function siegeOffTicking():void {
        var _loc1_:Number = getTimer() - this._startTime;
        var _loc2_:Number = (this._totalTime - _loc1_) / MS_IN_S;
        this._changeTimeTF.text = _loc2_.toFixed(PRECISION);
        this.switchIndicatorContainer.rotation = ROTATION_NORMAL * (_loc1_ / this._totalTime);
    }

    private function onLoopAnimation():void {
        this.deviceIconContainer.gotoAndPlay(this._deviceState);
    }

    private function onDamagedAnimationComplete():void {
        this.damagedContainer.visible = false;
    }
}
}

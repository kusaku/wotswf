package net.wg.gui.battle.views.consumablesPanel {
import flash.display.MovieClip;
import flash.geom.ColorTransform;
import flash.text.TextField;

import net.wg.data.constants.InteractiveStates;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.components.CoolDownTimer;
import net.wg.gui.battle.components.buttons.BattleToolTipButton;
import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleOrderButton;
import net.wg.gui.components.controls.UILoaderAlt;

import scaleform.gfx.TextFieldEx;

public class BattleOrderButton extends BattleToolTipButton implements IBattleOrderButton {

    private static const FIRST_FRAME:int = 0;

    private static const START_FRAME:int = 51;

    private static const END_FRAME:int = 101;

    private static const DEFAULT_TIME_COEF:Number = 1;

    private static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const QUANTITY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    private var _isReloading:Boolean;

    private var _bindSfKeyCode:Number;

    private var _quantity:int = -1;

    private var _isEmpty:Boolean;

    private var _available:Boolean;

    private var _isOrderReadyAnimationActive:Boolean = false;

    private var _isActivated:Boolean;

    private var _coolDownTimer:CoolDownTimer = null;

    private var _consumablesVO:ConsumablesVO = null;

    public var quantityField:TextField = null;

    public var orderReadyAnimation:MovieClip = null;

    public var iconLoader:UILoaderAlt = null;

    public var bindKeyField:TextField = null;

    public var bindKeyFieldHighlight:TextField = null;

    public function BattleOrderButton() {
        super();
        this._coolDownTimer = new CoolDownTimer(this);
        this._coolDownTimer.setFrames(START_FRAME, END_FRAME);
        this._consumablesVO = new ConsumablesVO();
        isAllowedToShowToolTipOnDisabledState = true;
        this.orderReadyAnimation.addFrameScript(this.orderReadyAnimation.totalFrames - 1, this.readyAnimationEnd);
        TextFieldEx.setNoTranslate(this.bindKeyField, true);
        TextFieldEx.setNoTranslate(this.quantityField, true);
        TextFieldEx.setNoTranslate(this.bindKeyFieldHighlight, true);
    }

    private function readyAnimationEnd():void {
        this._isOrderReadyAnimationActive = false;
        this.updateBindTF();
    }

    public function get consumablesVO():ConsumablesVO {
        return this._consumablesVO;
    }

    public function set icon(param1:String):void {
        this.iconLoader.source = param1;
    }

    public function set key(param1:Number):void {
        if (this._bindSfKeyCode == param1) {
            return;
        }
        this._bindSfKeyCode = param1;
        invalidate(KEY_VALIDATION);
    }

    public function set quantity(param1:int):void {
        if (this._quantity == param1) {
            return;
        }
        if (this._quantity == 0 && param1 > 0) {
            this.empty = false;
        }
        this._quantity = param1;
        if (this._quantity == 0) {
            this.empty = true;
        }
        invalidate(QUANTITY_VALIDATION);
    }

    public function set quantityVisible(param1:Boolean):void {
        if (this.quantityField) {
            this.quantityField.visible = param1;
        }
    }

    public function setCoolDownTime(param1:Number):void {
        this._isActivated = false;
        if (param1 > 0) {
            if (this._isReloading) {
                this._coolDownTimer.restartFromCurrentFrame(param1);
            }
            else {
                this.state = BATTLE_ITEM_STATES.COOLDOWN;
                this._isReloading = true;
                this._coolDownTimer.start(param1, this, this._consumablesVO.customCoolDownFrame > FIRST_FRAME ? int(this._consumablesVO.customCoolDownFrame) : int(FIRST_FRAME), DEFAULT_TIME_COEF);
            }
        }
        else {
            this._coolDownTimer.end();
            this._isReloading = false;
            this._consumablesVO.customCoolDownFrame = FIRST_FRAME;
            this._coolDownTimer.moveToFrame(FIRST_FRAME);
        }
    }

    public function setCoolDownPosAsPercent(param1:Number):void {
        if (param1 < 100) {
            this._coolDownTimer.setPositionAsPercent(param1);
        }
        else {
            this.setCoolDownTime(0);
        }
    }

    public function setColorTransform(param1:ColorTransform):void {
        if (param1) {
            this.iconLoader.transform.colorTransform = param1;
        }
    }

    public function clearColorTransform():void {
        this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
    }

    public function onCoolDownComplete():void {
        this._isReloading = false;
    }

    public function clearCoolDownTime():void {
        this._isActivated = false;
        this._isReloading = false;
        this._coolDownTimer.end();
        this.state = InteractiveStates.UP;
    }

    public function set empty(param1:Boolean):void {
        if (this._isEmpty == param1) {
            return;
        }
        this._isEmpty = param1;
        if (param1) {
            enabled = false;
            this.state = InteractiveStates.EMPTY_UP;
            this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
        }
        else {
            enabled = true;
            this.state = InteractiveStates.UP;
            this.setColorTransform(COLOR_STATES.NORMAL_COLOR_TRANSFORM);
        }
    }

    public function get empty():Boolean {
        return this._isEmpty;
    }

    public function set available(param1:Boolean):void {
        var _loc2_:* = this._available != param1;
        this._available = param1;
        if (this._available) {
            this.clearCoolDownTime();
        }
        if (_loc2_) {
            if (this._available) {
                this.orderReadyAnimation.gotoAndPlay(BATTLE_ITEM_STATES.SHOW);
                this._isOrderReadyAnimationActive = true;
            }
            else {
                this.orderReadyAnimation.gotoAndStop(BATTLE_ITEM_STATES.HIDE);
                this._isOrderReadyAnimationActive = false;
            }
            invalidate(KEY_VALIDATION);
        }
    }

    public function setActivated():void {
        this.state = BATTLE_ITEM_STATES.RELOADED;
        this._isActivated = true;
    }

    private function updateBindTF():void {
        this.bindKeyFieldHighlight.text = this.bindKeyField.text;
        this.bindKeyField.visible = !this._isOrderReadyAnimationActive;
        this.bindKeyFieldHighlight.visible = this._isOrderReadyAnimationActive;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(KEY_VALIDATION)) {
            this.bindKeyField.text = App.utils.commons.keyToString(this._bindSfKeyCode).keyName;
            this.updateBindTF();
        }
        if (isInvalid(QUANTITY_VALIDATION)) {
            if (this.quantityField) {
                this.quantityField.text = this._quantity.toString();
            }
        }
    }

    override protected function onDispose():void {
        this.iconLoader.dispose();
        this.iconLoader = null;
        this._coolDownTimer.dispose();
        this._coolDownTimer = null;
        this.bindKeyField = null;
        this.quantityField = null;
        this._consumablesVO = null;
        this.orderReadyAnimation = null;
        this.bindKeyFieldHighlight = null;
        super.onDispose();
    }

    override public function set state(param1:String):void {
        if (!this._isReloading && !this._isActivated) {
            super.state = param1;
        }
    }
}
}

package net.wg.gui.battle.views.consumablesPanel {
import flash.geom.ColorTransform;
import flash.text.TextField;

import net.wg.data.constants.InteractiveStates;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.components.buttons.BattleToolTipButton;
import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
import net.wg.gui.components.controls.UILoaderAlt;

import scaleform.gfx.TextFieldEx;

public class BattleEquipmentButton extends BattleToolTipButton implements IConsumablesButton {

    private static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private var _lockColorTransform:Boolean = false;

    private var _isPermanent:Boolean;

    private var _bindSfKeyCode:Number;

    private var _isEmpty:Boolean;

    private var _delayColorTransform:ColorTransform = null;

    private var _consumablesVO:ConsumablesVO = null;

    public var iconLoader:UILoaderAlt = null;

    public var bindKeyField:TextField = null;

    public function BattleEquipmentButton() {
        super();
        isAllowedToShowToolTipOnDisabledState = true;
        this._consumablesVO = new ConsumablesVO();
        TextFieldEx.setNoTranslate(this.bindKeyField, true);
    }

    public function startCoolDownAnimation():void {
        gotoAndPlay(BATTLE_ITEM_STATES.ACTIVATED);
        this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
        this._lockColorTransform = true;
    }

    public function get consumablesVO():ConsumablesVO {
        return this._consumablesVO;
    }

    public function set icon(param1:String):void {
        this.iconLoader.source = param1;
    }

    public function get icon():String {
        return this.iconLoader.source;
    }

    public function set quantity(param1:int):void {
        if (param1 == 0) {
            this.empty = true;
        }
    }

    public function set key(param1:Number):void {
        if (this._bindSfKeyCode == param1) {
            return;
        }
        this._bindSfKeyCode = param1;
        invalidate(KEY_VALIDATION);
    }

    public function setCoolDownTime(param1:Number):void {
        this._isPermanent = false;
        if (param1 > 0) {
            this.startCoolDownAnimation();
        }
        else {
            this.flushColorTransform();
            if (param1 == -1) {
                gotoAndStop(BATTLE_ITEM_STATES.PERMANENT);
                this._isPermanent = true;
            }
            else if (param1 == 0) {
                this.clearCoolDownTime();
            }
        }
    }

    public function setCoolDownPosAsPercent(param1:Number):void {
    }

    public function setColorTransform(param1:ColorTransform):void {
        if (this._lockColorTransform) {
            this._delayColorTransform = param1;
            return;
        }
        if (param1) {
            this.iconLoader.transform.colorTransform = param1;
        }
    }

    public function clearColorTransform():void {
        this._delayColorTransform = null;
        if (this._lockColorTransform) {
            return;
        }
        this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
    }

    public function clearCoolDownTime():void {
        if (!this._isEmpty) {
            this.state = InteractiveStates.UP;
        }
    }

    public function set empty(param1:Boolean):void {
        this._isEmpty = param1;
        enabled = !param1;
        if (param1) {
            this.state = InteractiveStates.EMPTY_UP;
            if (this.icon) {
                this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
                this._lockColorTransform = true;
            }
        }
        else {
            this.state = InteractiveStates.UP;
            if (this.icon) {
                this.flushColorTransform();
            }
        }
    }

    public function get empty():Boolean {
        return this._isEmpty;
    }

    public function flushColorTransform():void {
        this._lockColorTransform = this._isEmpty;
        if (this._delayColorTransform) {
            if (!this._lockColorTransform) {
                this.setColorTransform(this._delayColorTransform);
                this._delayColorTransform = null;
            }
        }
        else {
            this.clearColorTransform();
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(KEY_VALIDATION)) {
            this.bindKeyField.text = App.utils.commons.keyToString(this._bindSfKeyCode).keyName;
        }
    }

    override protected function onDispose():void {
        this.iconLoader.dispose();
        this.iconLoader = null;
        this.bindKeyField = null;
        this._delayColorTransform = null;
        this._consumablesVO = null;
        super.onDispose();
    }

    override public function set state(param1:String):void {
        if (!this._isPermanent) {
            super.state = param1;
        }
    }
}
}

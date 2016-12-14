package net.wg.gui.battle.views.consumablesPanel {
import flash.geom.ColorTransform;

import net.wg.data.constants.InteractiveStates;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.components.buttons.BattleToolTipButton;
import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
import net.wg.gui.components.controls.UILoaderAlt;

public class BattleOptionalDeviceButton extends BattleToolTipButton implements IConsumablesButton {

    private var _isEmpty:Boolean = false;

    private var _consumablesVO:ConsumablesVO = null;

    public var iconLoader:UILoaderAlt = null;

    public function BattleOptionalDeviceButton() {
        super();
        isAllowedToShowToolTipOnDisabledState = true;
        this._consumablesVO = new ConsumablesVO();
        enabled = false;
        state = InteractiveStates.UP;
    }

    public function get consumablesVO():ConsumablesVO {
        return this._consumablesVO;
    }

    public function set icon(param1:String):void {
        this.iconLoader.source = param1;
    }

    public function set key(param1:Number):void {
    }

    public function set quantity(param1:int):void {
    }

    public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:Boolean):void {
        if (param1 > 0) {
            this.clearCoolDownTime();
        }
        else if (param1 == -1) {
            state = BATTLE_ITEM_STATES.PERMANENT;
        }
        else if (param1 == 0) {
            this.clearCoolDownTime();
        }
    }

    public function setCoolDownPosAsPercent(param1:Number):void {
    }

    public function setColorTransform(param1:ColorTransform):void {
        if (param1) {
            this.iconLoader.transform.colorTransform = param1;
        }
    }

    public function clearColorTransform():void {
        this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
    }

    public function clearCoolDownTime():void {
        state = InteractiveStates.UP;
    }

    public function get empty():Boolean {
        return this._isEmpty;
    }

    public function set empty(param1:Boolean):void {
        if (this._isEmpty == param1) {
            return;
        }
        this._isEmpty = param1;
        if (this._isEmpty) {
            state = InteractiveStates.EMPTY_UP;
        }
        else {
            state = InteractiveStates.UP;
        }
    }

    override protected function onDispose():void {
        this.iconLoader.dispose();
        this.iconLoader = null;
        this._consumablesVO = null;
        super.onDispose();
    }
}
}

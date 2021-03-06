package net.wg.gui.battle.views.consumablesPanel.interfaces {
import flash.geom.ColorTransform;

import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;

public interface IConsumablesButton extends IBattleToolTipButton {

    function get consumablesVO():ConsumablesVO;

    function set icon(param1:String):void;

    function set key(param1:Number):void;

    function set quantity(param1:int):void;

    function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:Boolean):void;

    function setCoolDownPosAsPercent(param1:Number):void;

    function setColorTransform(param1:ColorTransform):void;

    function clearColorTransform():void;

    function clearCoolDownTime():void;
}
}

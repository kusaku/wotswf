package net.wg.gui.battle.components.buttons.interfaces {
public interface IBattleToolTipButton extends IBattleButton, ITooltipTarget {

    function get isAllowedToShowToolTipOnDisabledState():Boolean;

    function set isAllowedToShowToolTipOnDisabledState(param1:Boolean):void;
}
}

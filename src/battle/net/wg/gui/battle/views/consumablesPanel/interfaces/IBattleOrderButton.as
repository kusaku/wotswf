package net.wg.gui.battle.views.consumablesPanel.interfaces {
import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;

public interface IBattleOrderButton extends IConsumablesButton, ICoolDownCompleteHandler {

    function set empty(param1:Boolean):void;

    function get empty():Boolean;

    function set available(param1:Boolean):void;

    function setActivated():void;
}
}

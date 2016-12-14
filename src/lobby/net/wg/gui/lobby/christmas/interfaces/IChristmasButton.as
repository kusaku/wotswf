package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.interfaces.ISoundButtonEx;

public interface IChristmasButton extends ISoundButtonEx {

    function updateLayout(param1:int, param2:int):void;

    function setCounter(param1:String):void;
}
}

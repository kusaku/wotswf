package net.wg.gui.components.controls.interfaces {
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IServerIndicator extends IUIComponentEx {

    function setPingState(param1:int):void;

    function setColorBlindMode(param1:Boolean):void;
}
}

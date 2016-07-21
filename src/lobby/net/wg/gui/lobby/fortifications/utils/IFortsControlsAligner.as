package net.wg.gui.lobby.fortifications.utils {
import flash.display.DisplayObject;

import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IFortsControlsAligner {

    function centerControl(param1:IUIComponentEx, param2:Boolean):void;

    function rightControl(param1:DisplayObject, param2:Number):void;
}
}

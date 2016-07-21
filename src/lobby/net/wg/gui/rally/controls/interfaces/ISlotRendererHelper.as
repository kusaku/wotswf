package net.wg.gui.rally.controls.interfaces {
import flash.display.InteractiveObject;

import net.wg.gui.rally.interfaces.IRallySlotVO;

public interface ISlotRendererHelper {

    function initControlsState(param1:IRallySimpleSlotRenderer):void;

    function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO):void;

    function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null):void;
}
}
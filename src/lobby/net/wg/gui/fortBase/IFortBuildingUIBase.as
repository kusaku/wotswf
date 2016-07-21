package net.wg.gui.fortBase {
import net.wg.infrastructure.interfaces.IClosePopoverCallback;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IFortBuildingUIBase extends IUIComponentEx, IClosePopoverCallback, ITransportModeClient, IDirectionModeClient, ICommonModeClient {

    function get exportArrow():IArrowWithNut;

    function set exportArrow(param1:IArrowWithNut):void;

    function get importArrow():IArrowWithNut;

    function set importArrow(param1:IArrowWithNut):void;
}
}

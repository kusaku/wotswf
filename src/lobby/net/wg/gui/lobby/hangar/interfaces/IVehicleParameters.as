package net.wg.gui.lobby.hangar.interfaces {
import net.wg.infrastructure.base.meta.IVehicleParametersMeta;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.utils.helpLayout.IHelpLayoutComponent;

public interface IVehicleParameters extends IVehicleParametersMeta, IUIComponentEx, IDAAPIModule, IHelpLayoutComponent {

    function getHelpLayoutWidth():Number;

    function showHelpLayoutEx(param1:Number, param2:Number):void;
}
}

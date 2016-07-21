package net.wg.gui.fortBase {
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

public interface IFortDirectionsContainer extends IUIComponentEx, ITransportModeClient, IDirectionModeClient, IFocusContainer {

    function update(param1:Vector.<IBuildingVO>):void;

    function updateBattleDirectionNotifiers(param1:Vector.<IBattleNotifierVO>):void;
}
}

package net.wg.gui.fortBase {
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IFortBuildingsContainer extends IUIComponentEx, IDirectionModeClient, ICommonModeClient {

    function update(param1:Vector.<IBuildingVO>, param2:Boolean):void;

    function setBuildingData(param1:IBuildingVO, param2:Boolean):void;

    function get buildings():Vector.<IFortBuilding>;
}
}

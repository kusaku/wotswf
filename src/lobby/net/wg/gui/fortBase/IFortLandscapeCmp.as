package net.wg.gui.fortBase {
import net.wg.gui.lobby.profile.components.SimpleLoader;
import net.wg.infrastructure.base.meta.IFortBuildingComponentMeta;
import net.wg.infrastructure.interfaces.IDAAPIComponent;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

public interface IFortLandscapeCmp extends IDAAPIComponent, IFortBuildingComponentMeta, ITransportingHandler, IUIComponentEx, ICommonModeClient, ITransportModeClient, IDirectionModeClient, IFocusContainer, IBuildingToolTipDataProvider {

    function updateControlPositions():void;

    function setInitialData(param1:IBuildingsComponentVO):void;

    function get buildingContainer():IFortBuildingsContainer;

    function set buildingContainer(param1:IFortBuildingsContainer):void;

    function get directionsContainer():IFortDirectionsContainer;

    function set directionsContainer(param1:IFortDirectionsContainer):void;

    function get landscapeBG():SimpleLoader;

    function set landscapeBG(param1:SimpleLoader):void;
}
}

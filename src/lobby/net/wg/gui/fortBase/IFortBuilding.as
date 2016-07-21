package net.wg.gui.fortBase {
import flash.display.InteractiveObject;
import flash.events.IEventDispatcher;

import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;

public interface IFortBuilding extends IFortBuildingUIBase, ITransportingStepper, IPopOverCaller, IEventDispatcher, ITweenAnimatorHandler {

    function setData(param1:IBuildingVO):void;

    function getCustomHitArea():InteractiveObject;

    function isAvailable():Boolean;

    function isExportAvailable():Boolean;

    function isImportAvailable():Boolean;

    function setToolTipData(param1:String, param2:String, param3:String, param4:String = ""):void;

    function setIsInOverviewMode(param1:Boolean):void;

    function setEmptyPlace():void;

    function get uid():String;

    function set uid(param1:String):void;

    function get buildingLevel():int;

    function set userCanAddBuilding(param1:Boolean):void;

    function set forceSelected(param1:Boolean):void;

    function get selected():Boolean;

    function set toolTipDataProvider(param1:IBuildingToolTipDataProvider):void;
}
}

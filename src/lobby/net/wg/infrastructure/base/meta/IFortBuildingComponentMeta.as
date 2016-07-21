package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFortBuildingComponentMeta extends IEventDispatcher {

    function onTransportingRequestS(param1:String, param2:String):void;

    function requestBuildingProcessS(param1:int, param2:int):void;

    function upgradeVisitedBuildingS(param1:String):void;

    function requestBuildingToolTipDataS(param1:String, param2:String):void;

    function as_setData(param1:Object):void;

    function as_setBuildingData(param1:Object):void;

    function as_setBuildingToolTipData(param1:String, param2:String, param3:String, param4:String):void;

    function as_refreshTransporting():void;
}
}

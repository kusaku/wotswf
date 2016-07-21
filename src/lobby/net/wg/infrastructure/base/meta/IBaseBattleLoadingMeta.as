package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IBaseBattleLoadingMeta extends IEventDispatcher {

    function as_setProgress(param1:Number):void;

    function as_setTip(param1:String):void;

    function as_setTipTitle(param1:String):void;

    function as_setEventInfoPanelData(param1:Object):void;

    function as_setArenaInfo(param1:Object):void;

    function as_setMapIcon(param1:String):void;

    function as_setVisualTipInfo(param1:Object):void;

    function as_setPlayerData(param1:Number, param2:Number):void;

    function as_setVehiclesData(param1:Object):void;

    function as_addVehicleInfo(param1:Object):void;

    function as_updateVehicleInfo(param1:Object):void;

    function as_setVehicleStatus(param1:Object):void;

    function as_setPlayerStatus(param1:Object):void;
}
}

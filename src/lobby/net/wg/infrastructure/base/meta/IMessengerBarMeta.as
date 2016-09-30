package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IMessengerBarMeta extends IEventDispatcher {

    function channelButtonClickS():void;

    function as_setInitData(param1:Object):void;

    function as_setVehicleCompareCartButtonVisible(param1:Boolean):void;

    function as_openVehicleCompareCartPopover(param1:Boolean):void;

    function as_showAddVehicleCompareAnim(param1:Object):void;
}
}

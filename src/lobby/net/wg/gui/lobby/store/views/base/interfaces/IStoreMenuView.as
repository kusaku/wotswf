package net.wg.gui.lobby.store.views.base.interfaces {
import flash.events.IEventDispatcher;

import net.wg.data.VO.ShopSubFilterData;
import net.wg.infrastructure.interfaces.IViewStackContent;

public interface IStoreMenuView extends IViewStackContent, IEventDispatcher {

    function setViewData(param1:Array):void;

    function setSubFilterData(param1:int, param2:ShopSubFilterData):void;

    function updateSubFilter(param1:int):void;

    function getFilter():Array;

    function resetTemporaryHandlers():void;

    function setUIName(param1:String, param2:Function):void;

    function get fittingType():String;
}
}

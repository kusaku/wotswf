package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICyberSportRespawnViewMeta extends IEventDispatcher {

    function as_setMapBG(param1:String):void;

    function as_changeAutoSearchState(param1:Object):void;

    function as_hideAutoSearch():void;
}
}

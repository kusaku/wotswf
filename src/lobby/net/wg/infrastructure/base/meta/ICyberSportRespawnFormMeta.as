package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICyberSportRespawnFormMeta extends IEventDispatcher {

    function as_updateEnemyStatus(param1:String, param2:String):void;

    function as_setTeamName(param1:String):void;

    function as_setTeamEmblem(param1:String):void;

    function as_setArenaTypeId(param1:String, param2:Number):void;

    function as_timerUpdate(param1:String):void;

    function as_statusUpdate(param1:String, param2:String, param3:String):void;

    function as_setTotalLabel(param1:Boolean, param2:String, param3:int):void;
}
}

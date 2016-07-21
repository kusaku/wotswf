package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IBattleResultsMeta extends IEventDispatcher {

    function saveSortingS(param1:String, param2:String, param3:int):void;

    function showEventsWindowS(param1:String, param2:int):void;

    function getClanEmblemS(param1:String, param2:Number):void;

    function getTeamEmblemS(param1:String, param2:Number, param3:Boolean):void;

    function startCSAnimationSoundS():void;

    function onResultsSharingBtnPressS():void;

    function onTeamCardClickS(param1:Number):void;

    function showUnlockWindowS(param1:int, param2:String):void;

    function as_setData(param1:Object):void;

    function as_setClanEmblem(param1:String, param2:String):void;

    function as_setTeamInfo(param1:String, param2:String, param3:String):void;

    function as_setAnimation(param1:Object):void;
}
}

package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFalloutBattlePageMeta extends IEventDispatcher {

    function as_setPostmortemGasAtackInfo(param1:String, param2:String, param3:Boolean):void;

    function as_hidePostmortemGasAtackInfo():void;
}
}

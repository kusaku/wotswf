package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IRibbonsPanelMeta extends IEventDispatcher {

    function onShowS():void;

    function onChangeS():void;

    function onIncCountS():void;

    function onHideS():void;

    function as_setup(param1:Boolean, param2:Boolean):void;

    function as_addBattleEfficiencyEvent(param1:String, param2:String, param3:int):void;

    function as_setOffsetX(param1:int):void;
}
}

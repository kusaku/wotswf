package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IRibbonsPanelMeta extends IEventDispatcher {

    function onShowS():void;

    function onChangeS():void;

    function onHideS(param1:String):void;

    function as_setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean):void;

    function as_addBattleEfficiencyEvent(param1:String, param2:String, param3:String, param4:String, param5:String):void;

    function as_setSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void;
}
}

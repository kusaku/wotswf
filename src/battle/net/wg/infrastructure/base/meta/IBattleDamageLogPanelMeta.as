package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IBattleDamageLogPanelMeta extends IEventDispatcher {

    function as_showDamageLogComponent(param1:Boolean):void;

    function as_summaryStats(param1:String, param2:String, param3:String):void;

    function as_updateSummaryDamageValue(param1:String):void;

    function as_updateSummaryBlockedValue(param1:String):void;

    function as_updateSummaryAssistValue(param1:String):void;

    function as_detailStats(param1:Boolean, param2:Array):void;

    function as_addDetailMessage(param1:uint, param2:String, param3:String, param4:String, param5:String):void;

    function as_isDownCtrlButton(param1:Boolean):void;

    function as_isDownAltButton(param1:Boolean):void;
}
}

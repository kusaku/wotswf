package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFalloutConsumablesPanelMeta extends IEventDispatcher {

    function as_initializeRageProgress(param1:Boolean, param2:Object):void;

    function as_updateProgressBarValueByDelta(param1:Number):void;

    function as_updateProgressBarValue(param1:Number):void;
}
}

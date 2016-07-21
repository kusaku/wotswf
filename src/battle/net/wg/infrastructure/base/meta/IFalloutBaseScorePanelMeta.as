package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFalloutBaseScorePanelMeta extends IEventDispatcher {

    function as_init(param1:int, param2:int):void;

    function as_playScoreHighlightAnim():void;

    function as_stopScoreHighlightAnim():void;
}
}

package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IAwardWindowMeta extends IEventDispatcher {

    function onOKClickS():void;

    function onTakeNextClickS():void;

    function onCloseClickS():void;

    function onCheckBoxSelectS(param1:Boolean):void;

    function onWarningHyperlinkClickS():void;

    function onAnimationStartS():void;

    function as_setData(param1:Object):void;

    function as_setTakeNextBtn(param1:Object):void;

    function as_startAnimation():void;

    function as_endAnimation():void;
}
}

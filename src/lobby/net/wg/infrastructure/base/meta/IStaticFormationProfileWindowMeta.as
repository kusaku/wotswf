package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStaticFormationProfileWindowMeta extends IEventDispatcher {

    function actionBtnClickHandlerS(param1:String):void;

    function onClickHyperLinkS(param1:String):void;

    function as_setWindowSize(param1:int, param2:int):void;

    function as_setData(param1:Object):void;

    function as_setFormationEmblem(param1:String):void;

    function as_updateFormationInfo(param1:Object):void;

    function as_updateActionButton(param1:Object):void;

    function as_showView(param1:int):void;
}
}

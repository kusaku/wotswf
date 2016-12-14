package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IChristmasChestsViewMeta extends IEventDispatcher {

    function onOpenBtnClickS():void;

    function onCloseWindowS():void;

    function onPlaySoundS(param1:String):void;

    function as_setInitData(param1:Object):void;

    function as_setOpenBtnEnabled(param1:Boolean):void;

    function as_showAwardRibbon(param1:Boolean):void;

    function as_setAwardData(param1:Array):void;

    function as_setBottomTexts(param1:String, param2:String):void;

    function as_setControlsEnabled(param1:Boolean):void;
}
}

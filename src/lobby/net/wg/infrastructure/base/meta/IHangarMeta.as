package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IHangarMeta extends IEventDispatcher {

    function onEscapeS():void;

    function showHelpLayoutS():void;

    function closeHelpLayoutS():void;

    function as_setCrewEnabled(param1:Boolean):void;

    function as_setCarouselEnabled(param1:Boolean):void;

    function as_setupAmmunitionPanel(param1:Boolean, param2:String, param3:Boolean, param4:String):void;

    function as_setControlsVisible(param1:Boolean):void;

    function as_setVisible(param1:Boolean):void;

    function as_showHelpLayout():void;

    function as_closeHelpLayout():void;

    function as_showMiniClientInfo(param1:String, param2:String):void;

    function as_show3DSceneTooltip(param1:String, param2:Array):void;

    function as_hide3DSceneTooltip():void;

    function as_setCarousel(param1:String, param2:String):void;
}
}

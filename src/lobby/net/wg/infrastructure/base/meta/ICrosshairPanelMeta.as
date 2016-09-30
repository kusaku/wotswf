package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICrosshairPanelMeta extends IEventDispatcher {

    function as_populate():void;

    function as_dispose():void;

    function as_setSettings(param1:Object):void;

    function as_setView(param1:Number):void;

    function as_recreateDevice(param1:Number, param2:Number):void;

    function as_setReloadingCounterShown(param1:Boolean):void;

    function as_setReloading(param1:Number, param2:Number, param3:Number, param4:Boolean):void;

    function as_setReloadingAsPercent(param1:Number, param2:Boolean):void;

    function as_setHealth(param1:Number):void;

    function as_setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean):void;

    function as_setClipParams(param1:Number, param2:Number):void;

    function as_setDistance(param1:String):void;

    function as_clearDistance(param1:Boolean):void;

    function as_updatePlayerInfo(param1:String):void;

    function as_updateAmmoState(param1:String):void;

    function as_setZoom(param1:String):void;
}
}

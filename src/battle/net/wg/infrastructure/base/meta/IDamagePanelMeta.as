package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IDamagePanelMeta extends IEventDispatcher {

    function clickToTankmanIconS(param1:String):void;

    function clickToDeviceIconS(param1:String):void;

    function clickToFireIconS():void;

    function getTooltipDataS(param1:String, param2:String):String;

    function as_setPlayerInfo(param1:String, param2:String, param3:String, param4:String):void;

    function as_setup(param1:String, param2:int, param3:String, param4:Array, param5:Array, param6:Boolean, param7:Boolean):void;

    function as_updateHealth(param1:String, param2:int):void;

    function as_updateSpeed(param1:int):void;

    function as_setMaxSpeed(param1:int):void;

    function as_setRpmVibration(param1:int):void;

    function as_playEngineStartAnim():void;

    function as_startVehicleStartAnim():void;

    function as_finishVehicleStartAnim():void;

    function as_setNormalizedEngineRpm(param1:Number):void;

    function as_setCruiseMode(param1:int):void;

    function as_setAutoRotation(param1:Boolean):void;

    function as_updateDeviceState(param1:String, param2:String):void;

    function as_updateRepairingDevice(param1:String, param2:int, param3:Number):void;

    function as_setVehicleDestroyed():void;

    function as_setCrewDeactivated():void;

    function as_show(param1:Boolean):void;

    function as_setFireInVehicle(param1:Boolean):void;

    function as_setStaticData(param1:String):void;

    function as_reset():void;

    function as_setPlaybackSpeed(param1:Number):void;
}
}

package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IConsumablesPanelMeta extends IEventDispatcher {

    function onClickedToSlotS(param1:Number):void;

    function onPopUpClosedS():void;

    function as_setKeysToSlots(param1:Array):void;

    function as_setItemQuantityInSlot(param1:int, param2:int):void;

    function as_setItemTimeQuantityInSlot(param1:int, param2:int, param3:Number, param4:Number):void;

    function as_setCoolDownTime(param1:int, param2:Number):void;

    function as_setCoolDownPosAsPercent(param1:int, param2:Number):void;

    function as_addShellSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:String, param7:String, param8:String):void;

    function as_setNextShell(param1:int):void;

    function as_setCurrentShell(param1:int):void;

    function as_addEquipmentSlot(param1:int, param2:Number, param3:Number, param4:String, param5:int, param6:Number, param7:String, param8:String):void;

    function as_showEquipmentSlots(param1:Boolean):void;

    function as_expandEquipmentSlot(param1:int, param2:Array):void;

    function as_collapseEquipmentSlot():void;

    function as_addOptionalDeviceSlot(param1:int, param2:Number, param3:String, param4:String):void;

    function as_addOrderSlot(param1:int, param2:Number, param3:Number, param4:int, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Number, param10:Number):void;

    function as_setOrderAvailable(param1:int, param2:Boolean):void;

    function as_setOrderActivated(param1:int):void;

    function as_showOrdersSlots(param1:Boolean):void;

    function as_isVisible():Boolean;

    function as_reset():void;

    function as_switchToPosmortem():void;

    function as_updateEntityState(param1:String, param2:String):void;
}
}

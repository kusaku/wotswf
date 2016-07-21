package net.wg.gui.lobby.vehicleCustomization {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

public interface ISlotsPanelRenderer extends IUIComponentEx, IUpdatable {

    function setData(param1:DAAPIDataClass):void;

    function show():void;

    function hide():void;

    function showPartly():void;

    function set id(param1:int):void;

    function get id():int;

    function set ownerId(param1:int):void;

    function get ownerId():int;

    function set selectId(param1:int):void;

    function get selectId():int;

    function setState(param1:String):void;
}
}

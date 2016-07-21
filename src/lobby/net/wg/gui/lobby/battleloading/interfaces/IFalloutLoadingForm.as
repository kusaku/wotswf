package net.wg.gui.lobby.battleloading.interfaces {
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;

public interface IFalloutLoadingForm extends IBaseLoadingForm {

    function beforePopulateData():void;

    function invalidateSize():void;

    function addVehicleInfo(param1:Object, param2:Array):void;

    function setPlayerInfo(param1:Number, param2:Number):void;

    function setPlayerStatus(param1:Number, param2:uint):void;

    function setVehicleStatus(param1:Number, param2:uint, param3:Array):void;

    function setVehiclesData(param1:Array):void;

    function updateVehicleInfo(param1:Object, param2:Array):void;

    function setEventInfo(param1:EventInfoPanelVO):void;
}
}

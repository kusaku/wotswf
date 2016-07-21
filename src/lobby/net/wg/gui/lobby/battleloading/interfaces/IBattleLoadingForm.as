package net.wg.gui.lobby.battleloading.interfaces {
import net.wg.gui.lobby.components.MinimapLobby;

public interface IBattleLoadingForm extends ITipLoadingForm {

    function addVehicleInfo(param1:Boolean, param2:Object, param3:Array):void;

    function setPlayerInfo(param1:Number, param2:Number):void;

    function setPlayerStatus(param1:Boolean, param2:Number, param3:uint):void;

    function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Array):void;

    function setVehiclesData(param1:Boolean, param2:Array):void;

    function updateVehicleInfo(param1:Boolean, param2:Object, param3:Array):void;

    function updateTeamsHeaders(param1:String, param2:String):void;

    function setFormDisplayData(param1:String, param2:String, param3:int, param4:int, param5:Boolean):void;

    function getMapComponent():MinimapLobby;
}
}

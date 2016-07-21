package net.wg.gui.battle.views.stats.fullStats.interfaces {
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;

public interface IStatsTableItemHolderBase {

    function setDAAPIVehicleData(param1:DAAPIVehicleInfoVO):void;

    function get vehicleID():Number;

    function get accountID():Number;

    function get containsData():Boolean;

    function get isCurrentPlayer():Boolean;

    function get isSelected():Boolean;

    function setVehicleStatus(param1:uint):void;

    function setPlayerStatus(param1:uint):void;

    function setUserTags(param1:Array):void;
}
}

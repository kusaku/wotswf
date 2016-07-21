package net.wg.gui.fortBase {
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public interface IBuildingsComponentVO extends IDAAPIDataClass {

    function get canAddBuilding():Boolean;

    function set canAddBuilding(param1:Boolean):void;

    function get buildingData():Vector.<IBuildingVO>;

    function set buildingData(param1:Vector.<IBuildingVO>):void;
}
}

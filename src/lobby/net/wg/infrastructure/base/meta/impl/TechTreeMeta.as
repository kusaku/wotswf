package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;

public class TechTreeMeta extends ResearchViewMeta {

    public var requestNationTreeData:Function;

    public var getNationTreeData:Function;

    public var goToNextVehicle:Function;

    public var onCloseTechTree:Function;

    public var request4VehCompare:Function;

    public function TechTreeMeta() {
        super();
    }

    public function requestNationTreeDataS():void {
        App.utils.asserter.assertNotNull(this.requestNationTreeData, "requestNationTreeData" + Errors.CANT_NULL);
        this.requestNationTreeData();
    }

    public function getNationTreeDataS(param1:String):Object {
        App.utils.asserter.assertNotNull(this.getNationTreeData, "getNationTreeData" + Errors.CANT_NULL);
        return this.getNationTreeData(param1);
    }

    public function goToNextVehicleS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.goToNextVehicle, "goToNextVehicle" + Errors.CANT_NULL);
        this.goToNextVehicle(param1);
    }

    public function onCloseTechTreeS():void {
        App.utils.asserter.assertNotNull(this.onCloseTechTree, "onCloseTechTree" + Errors.CANT_NULL);
        this.onCloseTechTree();
    }

    public function request4VehCompareS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.request4VehCompare, "request4VehCompare" + Errors.CANT_NULL);
        this.request4VehCompare(param1);
    }
}
}

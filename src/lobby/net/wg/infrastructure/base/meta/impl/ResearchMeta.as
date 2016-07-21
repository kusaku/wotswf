package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;

public class ResearchMeta extends ResearchViewMeta {

    public var requestNationData:Function;

    public var getResearchItemsData:Function;

    public var onResearchItemsDrawn:Function;

    public var goToTechTree:Function;

    public var exitFromResearch:Function;

    public var goToVehicleView:Function;

    public function ResearchMeta() {
        super();
    }

    public function requestNationDataS():Boolean {
        App.utils.asserter.assertNotNull(this.requestNationData, "requestNationData" + Errors.CANT_NULL);
        return this.requestNationData();
    }

    public function getResearchItemsDataS(param1:Number, param2:Boolean):Object {
        App.utils.asserter.assertNotNull(this.getResearchItemsData, "getResearchItemsData" + Errors.CANT_NULL);
        return this.getResearchItemsData(param1, param2);
    }

    public function onResearchItemsDrawnS():void {
        App.utils.asserter.assertNotNull(this.onResearchItemsDrawn, "onResearchItemsDrawn" + Errors.CANT_NULL);
        this.onResearchItemsDrawn();
    }

    public function goToTechTreeS(param1:String):void {
        App.utils.asserter.assertNotNull(this.goToTechTree, "goToTechTree" + Errors.CANT_NULL);
        this.goToTechTree(param1);
    }

    public function exitFromResearchS():void {
        App.utils.asserter.assertNotNull(this.exitFromResearch, "exitFromResearch" + Errors.CANT_NULL);
        this.exitFromResearch();
    }

    public function goToVehicleViewS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.goToVehicleView, "goToVehicleView" + Errors.CANT_NULL);
        this.goToVehicleView(param1);
    }
}
}

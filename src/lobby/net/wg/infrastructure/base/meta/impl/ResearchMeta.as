package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.exceptions.AbstractException;

public class ResearchMeta extends ResearchViewMeta {

    public var requestNationData:Function;

    public var getResearchItemsData:Function;

    public var onResearchItemsDrawn:Function;

    public var goToTechTree:Function;

    public var exitFromResearch:Function;

    public var goToVehicleView:Function;

    public var compareVehicle:Function;

    private var _array:Array;

    public function ResearchMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        super.onDispose();
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

    public function compareVehicleS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.compareVehicle, "compareVehicle" + Errors.CANT_NULL);
        this.compareVehicle(param1);
    }

    public final function as_setInstalledItems(param1:Array):void {
        var _loc2_:Array = this._array;
        this._array = param1;
        this.setInstalledItems(this._array);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setInstalledItems(param1:Array):void {
        var _loc2_:String = "as_setInstalledItems" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

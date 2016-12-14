package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.data.DataProvider;

public class TechTreeMeta extends ResearchViewMeta {

    public var requestNationTreeData:Function;

    public var getNationTreeData:Function;

    public var goToNextVehicle:Function;

    public var onCloseTechTree:Function;

    public var request4VehCompare:Function;

    private var _array:Array;

    private var _dataProvider:DataProvider;

    public function TechTreeMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        if (this._dataProvider) {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
        }
        super.onDispose();
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

    public final function as_setAvailableNations(param1:Array):void {
        var _loc2_:DataProvider = this._dataProvider;
        this._dataProvider = new DataProvider(param1);
        this.setAvailableNations(this._dataProvider);
        if (_loc2_) {
            _loc2_.cleanUp();
        }
    }

    public final function as_setUnlockProps(param1:Array):void {
        var _loc2_:Array = this._array;
        this._array = param1;
        this.setUnlockProps(this._array);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setAvailableNations(param1:DataProvider):void {
        var _loc2_:String = "as_setAvailableNations" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setUnlockProps(param1:Array):void {
        var _loc2_:String = "as_setUnlockProps" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

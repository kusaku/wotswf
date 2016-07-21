package net.wg.gui.lobby.fortifications.data.buildingProcess {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;

public class BuildingProcessVO extends DAAPIDataClass {

    private static const LIST_ITEMS:String = "listItems";

    public var windowTitle:String = "";

    public var availableCount:String = "";

    public var textInfo:String = "";

    private var _listItems:DataProvider;

    public function BuildingProcessVO(param1:Object) {
        this._listItems = new DataProvider();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == LIST_ITEMS) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + LIST_ITEMS);
            for each(_loc4_ in _loc3_) {
                this._listItems.push(new BuildingProcessListItemVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._listItems) {
            _loc1_.dispose();
        }
        this._listItems.cleanUp();
        this._listItems = null;
        this.windowTitle = null;
        this.availableCount = null;
        super.onDispose();
    }

    public function get listItems():DataProvider {
        return this._listItems;
    }
}
}

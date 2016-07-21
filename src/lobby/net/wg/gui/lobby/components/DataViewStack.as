package net.wg.gui.lobby.components {
import flash.display.MovieClip;

import net.wg.gui.components.advanced.ViewStack;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;

public class DataViewStack extends ViewStack {

    protected var _dataForUpdate:Object = null;

    public function DataViewStack() {
        super();
    }

    override public function show(param1:String):MovieClip {
        var _loc2_:MovieClip = super.show(param1);
        this.applyDataToViewObject(IViewStackContent(_loc2_), this._dataForUpdate);
        return _loc2_;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._dataForUpdate) {
            this.applyData();
        }
    }

    override protected function onDispose():void {
        this._dataForUpdate = null;
        super.onDispose();
    }

    public function updateData(param1:Object):void {
        this._dataForUpdate = param1;
        invalidateData();
    }

    protected function applyData():void {
        var _loc1_:IUpdatable = null;
        for each(_loc1_ in cachedViews) {
            this.applyDataToViewObject(_loc1_, this._dataForUpdate);
        }
    }

    protected function applyDataToViewObject(param1:IUpdatable, param2:Object):void {
        param1.update(param2);
    }
}
}

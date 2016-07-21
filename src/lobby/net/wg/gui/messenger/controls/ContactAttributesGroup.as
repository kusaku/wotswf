package net.wg.gui.messenger.controls {
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.utils.Dictionary;

import net.wg.gui.components.common.containers.Group;
import net.wg.gui.components.controls.Image;

import scaleform.clik.constants.InvalidationType;

public class ContactAttributesGroup extends Group {

    private var _dataProvider:Vector.<String> = null;

    private var _created:Dictionary = null;

    public function ContactAttributesGroup() {
        this._created = new Dictionary();
        super();
    }

    override public function removeAllChildren(param1:Boolean = false):void {
        var _loc4_:DisplayObject = null;
        var _loc2_:int = numChildren;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = getChildAt(_loc3_);
            if (_loc4_ is Bitmap) {
                Bitmap(_loc4_).bitmapData = null;
            }
            _loc3_++;
        }
        super.removeAllChildren(param1);
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.DATA) && this._dataProvider) {
            this.applyNewChildren();
        }
        super.draw();
    }

    override protected function onDispose():void {
        this.clearData();
        App.utils.data.cleanupDynamicObject(this._created);
        this._created = null;
        super.onDispose();
    }

    public function setDataProvider(param1:Vector.<String>):void {
        this.clearData();
        this._dataProvider = param1;
        invalidateData();
    }

    private function clearData():void {
        if (this._dataProvider) {
            this._dataProvider.splice(0, this._dataProvider.length);
            this._dataProvider = null;
        }
    }

    private function applyNewChildren():void {
        var _loc1_:String = null;
        var _loc2_:Image = null;
        this.removeAllChildren();
        for each(_loc1_ in this._dataProvider) {
            _loc2_ = new Image();
            _loc2_.source = _loc1_;
            addChild(_loc2_);
        }
        invalidateLayout();
    }
}
}

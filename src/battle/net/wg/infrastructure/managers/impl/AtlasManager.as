package net.wg.infrastructure.managers.impl {
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.events.EventDispatcher;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.infrastructure.interfaces.IAtlas;
import net.wg.infrastructure.interfaces.IAtlasItemVO;
import net.wg.infrastructure.managers.IAtlasManager;

public class AtlasManager extends EventDispatcher implements IAtlasManager {

    private var _atlasesDict:Dictionary = null;

    private var _isDisposed:Boolean = false;

    private var _lastAtlas:IAtlas = null;

    public function AtlasManager() {
        super();
        this._atlasesDict = new Dictionary(true);
    }

    public function dispose():void {
        App.utils.asserter.assert(!this._isDisposed, "AtlasManager " + Errors.ALREADY_DISPOSED);
        this._isDisposed = true;
        App.utils.data.cleanupDynamicObject(this._atlasesDict);
        this._atlasesDict = null;
        if (this._lastAtlas) {
            this._lastAtlas.dispose();
            this._lastAtlas = null;
        }
    }

    public function getNewBitmapData(param1:String, param2:String, param3:String = ""):BitmapData {
        var _loc7_:Rectangle = null;
        var _loc4_:IAtlas = this.getAtlas(param1);
        App.utils.asserter.assertNotNull(_loc4_, "AtlasManager atlas \'" + param1 + Errors.CANT_NULL);
        var _loc5_:IAtlasItemVO = this.getAtlasItem(_loc4_, param2, param3);
        var _loc6_:BitmapData = new BitmapData(_loc5_.width, _loc5_.height);
        if (_loc5_) {
            _loc7_ = new Rectangle(_loc5_.x, _loc5_.y, _loc5_.width, _loc5_.height);
            _loc6_.copyPixels(_loc4_.atlasBitmapData, _loc7_, new Point());
        }
        return _loc6_;
    }

    public function drawGraphics(param1:String, param2:String, param3:Graphics, param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false):void {
        var _loc10_:Number = NaN;
        var _loc11_:Number = NaN;
        var _loc12_:Matrix = null;
        var _loc8_:IAtlas = this.getAtlas(param1);
        App.utils.asserter.assertNotNull(_loc8_, "AtlasManager atlas \'" + param1 + Errors.CANT_NULL);
        var _loc9_:IAtlasItemVO = this.getAtlasItem(_loc8_, param2, param4);
        if (_loc9_) {
            _loc10_ = 0;
            _loc11_ = 0;
            if (param7) {
                _loc10_ = -(_loc9_.width >> 1);
                _loc11_ = -(_loc9_.height >> 1);
            }
            _loc12_ = new Matrix();
            _loc12_.translate(-_loc9_.x + _loc10_, -_loc9_.y + _loc11_);
            param3.clear();
            param3.beginBitmapFill(_loc8_.atlasBitmapData, _loc12_, param6, param5);
            param3.drawRect(_loc10_, _loc11_, _loc9_.width, _loc9_.height);
            param3.endFill();
        }
        else {
            param3.clear();
            param3.beginFill(16711680, 0.5);
            param3.drawRect(0, 0, 10, 10);
            param3.endFill();
        }
    }

    private function getAtlasItem(param1:IAtlas, param2:String, param3:String):IAtlasItemVO {
        var _loc4_:IAtlasItemVO = param1.getAtlasItemVOByName(param2);
        if (!_loc4_ && param3 != "") {
            _loc4_ = param1.getAtlasItemVOByName(param3);
        }
        return _loc4_;
    }

    public function isAtlasInitialized(param1:String):Boolean {
        var _loc2_:IAtlas = this.getAtlas(param1);
        App.utils.asserter.assertNotNull(_loc2_, "AtlasManager atlas \'" + param1 + Errors.CANT_NULL);
        return _loc2_.isAtlasInitialized;
    }

    public function registerAtlas(param1:String):void {
        var _loc2_:IAtlas = this.getAtlas(param1);
        App.utils.asserter.assertNull(_loc2_, "AtlasManager \'" + param1 + Errors.ALREADY_REGISTERED);
        var _loc3_:Class = App.utils.classFactory.getClass(Linkages.ATLAS_CLASS_NAME);
        _loc2_ = new _loc3_();
        _loc2_.initResources(param1);
        this._atlasesDict[param1] = _loc2_;
        this._lastAtlas = _loc2_;
    }

    private function getAtlas(param1:String):IAtlas {
        if (this._lastAtlas && this._lastAtlas.atlasName == param1) {
            return this._lastAtlas;
        }
        this._lastAtlas = this._atlasesDict[param1];
        return this._lastAtlas;
    }
}
}

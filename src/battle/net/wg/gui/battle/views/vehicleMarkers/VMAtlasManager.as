package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.Graphics;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.wg.gui.components.containers.Atlas;
import net.wg.infrastructure.events.AtlasEvent;
import net.wg.infrastructure.interfaces.IAtlas;
import net.wg.infrastructure.interfaces.IAtlasItemVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class VMAtlasManager implements IDisposable {

    private static const ATLAS_NAME:String = "vehicleMarkerAtlas";

    private static var _instance:VMAtlasManager;

    private var _atlas:IAtlas = null;

    private var _isInitialized:Boolean = false;

    private var _itemsToDraw:Vector.<AtlasItemData> = null;

    public function VMAtlasManager() {
        super();
        this._atlas = new Atlas();
        this._atlas.addEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitializedHandler);
        this._atlas.initResources(ATLAS_NAME);
    }

    public static function get instance():VMAtlasManager {
        if (!_instance) {
            _instance = new VMAtlasManager();
        }
        return _instance;
    }

    private function onAtlasInitializedHandler(param1:AtlasEvent):void {
        var _loc2_:AtlasItemData = null;
        this._isInitialized = true;
        if (this._itemsToDraw) {
            while (this._itemsToDraw.length) {
                _loc2_ = this._itemsToDraw.shift();
                this.drawGraphics(_loc2_.name, _loc2_.graphics, _loc2_.position);
            }
            this._itemsToDraw = null;
        }
        this._atlas.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitializedHandler);
    }

    public function dispose():void {
        if (!this._isInitialized) {
            this._atlas.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitializedHandler);
            if (this._itemsToDraw) {
                while (this._itemsToDraw.length) {
                    this._itemsToDraw.shift().dispose();
                }
                this._itemsToDraw = null;
            }
        }
        this._atlas.dispose();
        this._atlas = null;
        _instance = null;
    }

    public function drawGraphics(param1:String, param2:Graphics, param3:Point = null):void {
        var _loc4_:IAtlasItemVO = null;
        var _loc5_:Matrix = null;
        if (this._isInitialized) {
            _loc4_ = this._atlas.getAtlasItemVOByName(param1);
            if (_loc4_) {
                _loc5_ = new Matrix();
                if (!param3) {
                    param3 = new Point(0, 0);
                }
                _loc5_.translate(-_loc4_.x + param3.x, -_loc4_.y + param3.y);
                param2.clear();
                param2.beginBitmapFill(this._atlas.atlasBitmapData, _loc5_, false, true);
                param2.drawRect(param3.x, param3.y, _loc4_.width, _loc4_.height);
                param2.endFill();
            }
        }
        else {
            if (!this._itemsToDraw) {
                this._itemsToDraw = new Vector.<VMAtlasManager>();
            }
            this._itemsToDraw.push(new AtlasItemData(param1, param2, param3));
        }
    }

    public function drawWithCenterAlign(param1:String, param2:Graphics, param3:Boolean, param4:Boolean):void {
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        var _loc5_:IAtlasItemVO = this._atlas.getAtlasItemVOByName(param1);
        if (_loc5_) {
            _loc6_ = !!param3 ? Number(-_loc5_.width >> 1) : Number(0);
            _loc7_ = !!param4 ? Number(-_loc5_.height >> 1) : Number(0);
            this.drawGraphics(param1, param2, new Point(_loc6_, _loc7_));
        }
    }

    public function getAtlasItemBounds(param1:String):Rectangle {
        var _loc2_:IAtlasItemVO = this._atlas.getAtlasItemVOByName(param1);
        return !!_loc2_ ? new Rectangle(_loc2_.x, _loc2_.y, _loc2_.width, _loc2_.height) : null;
    }
}
}

import flash.display.Graphics;
import flash.geom.Point;

import net.wg.infrastructure.interfaces.entity.IDisposable;

class AtlasItemData implements IDisposable {

    public var name:String = null;

    public var graphics:Graphics = null;

    public var position:Point = null;

    function AtlasItemData(param1:String, param2:Graphics, param3:Point) {
        super();
        this.name = param1;
        this.graphics = param2;
        this.position = param3;
    }

    public function dispose():void {
        this.name = null;
        this.graphics = null;
        this.position = null;
    }
}

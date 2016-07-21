package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.getDefinitionByName;

import net.wg.gui.battle.components.BattleUIComponent;

import scaleform.clik.motion.Tween;
import scaleform.gfx.TextFieldEx;

public class StaticObjectMarker extends BattleUIComponent {

    private static const ALPHA_SPEED:int = 1;

    private static const SHAPE_XY:Point = new Point(-145, -178);

    private static const METERS_STRING:String = "m";

    public var marker:MovieClip = null;

    public var distanceField:TextField = null;

    public var bgShadow:Sprite = null;

    private var _shapeName:String = "arrow";

    private var _minDistance:Number = 0;

    private var _alphaZone:Number = 0;

    private var _distance:Number = 120;

    private var _isShow:Boolean = false;

    private var _tween:Tween = null;

    private var _shapeBitmap:Bitmap = null;

    public function StaticObjectMarker() {
        super();
        TextFieldEx.setNoTranslate(this.distanceField, true);
    }

    override protected function onDispose():void {
        this._shapeBitmap.bitmapData.dispose();
        this._shapeBitmap.bitmapData = null;
        this._shapeBitmap = null;
        this.marker = null;
        this.distanceField = null;
        this.bgShadow = null;
        this._tween = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.setShape();
        this.setInitialAlpha();
        this.setDistanceText();
    }

    public function doAlphaAnimation():void {
        var _loc1_:int = 0;
        if (this._alphaZone > 0) {
            _loc1_ = this._distance - this._minDistance;
            if (this._isShow && _loc1_ <= 0) {
                this._tween = new Tween(ALPHA_SPEED, this, {"alpha": 0});
                this._isShow = false;
            }
            else if (!this._isShow && _loc1_ >= this._alphaZone) {
                this._tween = new Tween(ALPHA_SPEED, this, {"alpha": 1});
                this._isShow = true;
            }
        }
    }

    public function init(param1:String, param2:Number, param3:Number, param4:Number):void {
        this._shapeName = param1;
        this._minDistance = param2;
        this._alphaZone = param3 - param2;
        this._distance = !isNaN(param4) ? Number(Math.round(param4)) : Number(-1);
        if (initialized) {
            this.setShape();
            this.setInitialAlpha();
            this.setDistanceText();
        }
    }

    public function setDistance(param1:Number):void {
        var _loc2_:Number = !isNaN(param1) ? Number(Math.round(param1)) : Number(-1);
        if (this._distance == _loc2_) {
            return;
        }
        this._distance = _loc2_;
        this.doAlphaAnimation();
        this.setDistanceText();
    }

    private function setInitialAlpha():void {
        if (this._alphaZone > 0) {
            if (this._distance - this._minDistance <= 0) {
                alpha = 0;
                this._isShow = false;
            }
            else {
                alpha = 1;
                this._isShow = true;
            }
        }
    }

    private function setDistanceText():void {
        if (this._distance > -1) {
            this.distanceField.text = this._distance.toString() + METERS_STRING;
        }
        else {
            this.distanceField.text = "";
        }
    }

    private function setShape():void {
        if (this._shapeBitmap != null) {
            this.marker.removeChild(this._shapeBitmap);
            this._shapeBitmap.bitmapData.dispose();
            this._shapeBitmap.bitmapData = null;
        }
        var _loc1_:Class = getDefinitionByName(this._shapeName) as Class;
        this._shapeBitmap = new Bitmap(new _loc1_());
        this._shapeBitmap.x = SHAPE_XY.x;
        this._shapeBitmap.y = SHAPE_XY.y;
        this.marker.addChild(this._shapeBitmap);
    }
}
}

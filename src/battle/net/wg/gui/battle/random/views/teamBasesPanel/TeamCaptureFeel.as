package net.wg.gui.battle.random.views.teamBasesPanel {
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.data.constants.Values;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class TeamCaptureFeel extends MovieClip implements IDisposable {

    public static var COLOR_TYPE_GREEN:String = "green";

    public static var COLOR_TYPE_RED:String = "red";

    public static var COLOR_TYPE_PURPLE:String = "purple";

    public static const BITMAP_SRC_BG:String = "CaptureBaseBg_";

    public static const BITMAP_SRC_CAPTURE_LINE:String = "CaptureBaseLine_";

    private var _colorType:String = "";

    private var _bitmapSrcPrefix:String = "";

    private var _fillTarget:Sprite = null;

    public function TeamCaptureFeel() {
        super();
        this._fillTarget = this.getFillTarget();
        this._bitmapSrcPrefix = this.getBitmapSrcPrefix();
        this.updateFeel();
    }

    public function dispose():void {
        this._colorType = null;
        this.clearGraphic();
    }

    protected function getBitmapSrcPrefix():String {
        return BITMAP_SRC_BG;
    }

    protected function getFillTarget():Sprite {
        return this;
    }

    private function updateFeel():void {
        this.clearGraphic();
        this.drawGraphic();
    }

    private function clearGraphic():void {
        this._fillTarget.graphics.clear();
    }

    private function drawGraphic():void {
        var _loc3_:Number = NaN;
        var _loc6_:Number = NaN;
        if (this._bitmapSrcPrefix == Values.EMPTY_STR || this._colorType == Values.EMPTY_STR) {
            return;
        }
        var _loc1_:String = this._bitmapSrcPrefix + this._colorType;
        var _loc2_:BitmapData = App.utils.classFactory.getObject(_loc1_) as BitmapData;
        if (!_loc2_) {
            return;
        }
        this._fillTarget.graphics.beginFill(13762560);
        this._fillTarget.graphics.beginBitmapFill(_loc2_);
        _loc3_ = _loc2_.width;
        var _loc4_:Number = _loc2_.height;
        var _loc5_:Number = 0;
        _loc6_ = 0;
        this.x = -_loc3_ >> 1;
        this._fillTarget.graphics.lineTo(_loc5_, _loc6_);
        this._fillTarget.graphics.lineTo(_loc5_ + _loc3_, _loc6_);
        this._fillTarget.graphics.lineTo(_loc5_ + _loc3_, _loc6_ + _loc4_);
        this._fillTarget.graphics.lineTo(_loc5_, _loc6_ + _loc4_);
        this._fillTarget.graphics.lineTo(_loc5_, _loc6_);
        this._fillTarget.graphics.endFill();
    }

    public function get colorType():String {
        return this._colorType;
    }

    public function set colorType(param1:String):void {
        if (this._colorType == param1) {
            return;
        }
        this._colorType = param1;
        this.updateFeel();
    }
}
}

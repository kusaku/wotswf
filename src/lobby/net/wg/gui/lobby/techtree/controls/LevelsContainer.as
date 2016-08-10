package net.wg.gui.lobby.techtree.controls {
import flash.display.Sprite;
import flash.geom.Rectangle;

import net.wg.data.constants.Values;
import net.wg.gui.lobby.techtree.helpers.Distance;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class LevelsContainer extends Sprite implements IDisposable {

    public var oddLevelRenderer:String = "OddLevelDelimiter";

    public var evenLevelRenderer:String = "EvenLevelDelimiter";

    private var delimiters:Vector.<LevelDelimiter>;

    private var _uiid:uint = 4.294967295E9;

    public function LevelsContainer() {
        super();
        scale9Grid = new Rectangle(0, 0, 1, 1);
        tabEnabled = mouseChildren = mouseEnabled = false;
        this.delimiters = new Vector.<LevelDelimiter>();
    }

    private static function updateLevelDelimiter(param1:LevelDelimiter, param2:Number, param3:Number, param4:Number, param5:Number):void {
        param1.x = param2;
        param1.y = param3;
        param1.setSize(param4, param5);
    }

    public function dispose():void {
        var _loc1_:LevelDelimiter = null;
        while (this.delimiters.length) {
            _loc1_ = this.delimiters.pop();
            if (_loc1_) {
                _loc1_.dispose();
            }
        }
        while (numChildren > 0) {
            removeChildAt(0);
        }
    }

    public function updateLevels(param1:Vector.<Distance>, param2:Number, param3:Number):Number {
        var _loc5_:Distance = null;
        var _loc6_:LevelDelimiter = null;
        var _loc9_:Number = NaN;
        var _loc10_:Number = NaN;
        var _loc4_:Number = param1.length;
        var _loc7_:Number = 0;
        var _loc8_:Number = 0;
        var _loc11_:Boolean = false;
        while (this.delimiters.length > _loc4_) {
            this.removeLevelDelimiter(this.delimiters.pop());
        }
        var _loc12_:Number = 0;
        while (_loc12_ < _loc4_) {
            _loc5_ = param1[_loc12_];
            _loc6_ = null;
            _loc11_ = false;
            if (_loc12_ >= this.delimiters.length) {
                this.delimiters.push(null);
            }
            if (!_loc5_) {
                if (this.delimiters[_loc12_] != null) {
                    if (this.removeLevelDelimiter(this.delimiters[_loc12_])) {
                        this.delimiters[_loc12_] = null;
                    }
                }
            }
            else {
                if (_loc12_ == 0) {
                    if (param1[_loc12_ + 1] != null) {
                        _loc7_ = _loc8_ = param1[_loc12_ + 1].start - _loc5_.end - param3 >> 1;
                    }
                    else {
                        _loc7_ = _loc8_ = _loc5_.start;
                    }
                }
                else {
                    if (param1[_loc12_ - 1] != null) {
                        _loc7_ = _loc5_.start - param3 - param1[_loc12_ - 1].end >> 1;
                    }
                    if (_loc12_ < _loc4_ - 1 && param1[_loc12_ + 1] != null) {
                        _loc8_ = param1[_loc12_ + 1].start - _loc5_.end - param3 >> 1;
                    }
                    else {
                        _loc8_ = _loc7_;
                    }
                }
                _loc10_ = _loc5_.start - _loc7_;
                _loc9_ = _loc5_.end - _loc5_.start + param3 + _loc7_ + _loc8_;
                _loc6_ = this.delimiters[_loc12_];
                if (_loc6_ != null) {
                    updateLevelDelimiter(_loc6_, _loc10_, 0, _loc9_, param2);
                }
                else {
                    _loc6_ = this.createLevelDelimiter(_loc12_ + 1, _loc10_, 0, _loc9_, param2);
                    _loc11_ = true;
                }
                if (_loc6_ != null) {
                    _loc6_.validateNow();
                    if (_loc11_) {
                        addChild(_loc6_);
                        this.delimiters[_loc12_] = _loc6_;
                    }
                }
            }
            _loc12_++;
        }
        return _loc8_;
    }

    private function createLevelDelimiter(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number):LevelDelimiter {
        return App.utils.classFactory.getComponent(!!(param1 % 2) ? this.oddLevelRenderer : this.evenLevelRenderer, LevelDelimiter, {
            "x": param2,
            "y": param3,
            "width": param4,
            "height": param5,
            "levelNumber": param1
        });
    }

    private function removeLevelDelimiter(param1:LevelDelimiter):Boolean {
        var _loc2_:Boolean = false;
        if (contains(param1)) {
            removeChild(param1);
            _loc2_ = true;
        }
        return _loc2_;
    }

    public function get UIID():uint {
        return this._uiid;
    }

    public function set UIID(param1:uint):void {
        var _loc2_:String = null;
        if (this._uiid != Values.EMPTY_UIID) {
            _loc2_ = "UIID is unique value and can not be modified.";
            App.utils.asserter.assert(this._uiid == param1, _loc2_);
        }
        this._uiid = param1;
    }
}
}

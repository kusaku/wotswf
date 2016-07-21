package net.wg.gui.lobby.hangar.tcarousel {
import flash.text.TextField;

import net.wg.infrastructure.base.UIComponentEx;

public class ClanLockUI extends UIComponentEx {

    private static const ZERO_STR:String = "0";

    private static const SIXTY:int = 60;

    private static const TEN:int = 10;

    public var textField:TextField;

    private var _timer:Number;

    public function ClanLockUI() {
        super();
    }

    override public function toString():String {
        return "[WG ClanLockUI " + name + "]";
    }

    override protected function onDispose():void {
        this.textField = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        this.textField.text = this.updateClanLock();
    }

    private function updateClanLock():String {
        var _loc1_:String = "";
        var _loc2_:Date = new Date();
        var _loc3_:Number = Math.round(this._timer - _loc2_.valueOf() / 1000);
        if (_loc3_ > 0) {
            _loc1_ = this.calcLockTime(_loc3_);
            this.visible = true;
        }
        else {
            this.visible = false;
        }
        return _loc1_;
    }

    private function calcLockTime(param1:Number):String {
        var _loc2_:String = "";
        param1 = Math.ceil(param1 / SIXTY);
        var _loc3_:Number = param1 / SIXTY ^ 0;
        var _loc4_:Number = param1 - _loc3_ * SIXTY ^ 0;
        var _loc5_:String = _loc3_ < TEN ? ZERO_STR + _loc3_ : _loc3_.toString();
        var _loc6_:String = _loc4_ < TEN ? ZERO_STR + _loc4_ : _loc4_.toString();
        _loc2_ = _loc5_ + ":" + _loc6_;
        return _loc2_;
    }

    public function get timer():Number {
        return this._timer;
    }

    public function set timer(param1:Number):void {
        if (param1 > 0) {
            this._timer = param1;
            invalidate();
        }
        else {
            visible = false;
        }
    }
}
}

package net.wg.gui.lobby.vehicleBuyWindow {
import fl.transitions.easing.Strong;

import flash.display.DisplayObject;
import flash.display.MovieClip;

import net.wg.gui.utils.ExcludeTweenManager;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.motion.Tween;

public class VehicleBuyWindowAnimManager implements IDisposable {

    private static const DEF_CLOSED_HEIGHT_MARGIN:uint = 2;

    private static const DEF_TWEEN_DURATION:uint = 400;

    private var _animTarget:VehicleBuyWindow;

    private var _footerOpenedY:int;

    private var _footerClosedY:int;

    private var _windowClosedHeight:uint;

    private var _windowOpenedHeight:uint;

    private var _darkBackgroundCloseHeight:uint;

    private var _darkBackgroundOpenHeight:uint;

    private var _maskCloseHeight:uint;

    private var _maskOpenHeight:uint;

    private var _initialized:Boolean;

    private var _excludeTween:ExcludeTweenManager;

    public function VehicleBuyWindowAnimManager(param1:VehicleBuyWindow) {
        super();
        this._animTarget = param1;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function launch(param1:Boolean, param2:Boolean):void {
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        if (!this._initialized) {
            this.initialize();
            this._initialized = true;
        }
        if (param1) {
            _loc3_ = Math.round((App.appHeight - this._windowOpenedHeight) / 2);
            this.tweenToY(this._animTarget.footerMc, this._footerOpenedY, param2);
            this.tweenToY(MovieClip(this._animTarget.window), _loc3_, param2);
            this.tweenToAlpha(this._animTarget.bodyMc, 1, param2);
            this.tweenToHeight(this._animTarget.window.getBackground(), this._windowOpenedHeight, param2);
            this.tweenToHeight(this._animTarget.backgroundMc, this._darkBackgroundOpenHeight, param2);
            this.tweenToHeight(this._animTarget.bodyMaskMc, this._maskOpenHeight, param2);
        }
        else {
            _loc4_ = Math.round((App.appHeight - this._windowClosedHeight) / 2);
            this.tweenToY(this._animTarget.footerMc, this._footerClosedY, param2);
            this.tweenToY(MovieClip(this._animTarget.window), _loc4_, param2);
            this.tweenToAlpha(this._animTarget.bodyMc, 0, param2);
            this.tweenToHeight(this._animTarget.window.getBackground(), this._windowClosedHeight, param2);
            this.tweenToHeight(this._animTarget.backgroundMc, this._darkBackgroundCloseHeight, param2);
            this.tweenToHeight(this._animTarget.bodyMaskMc, this._maskCloseHeight, param2);
        }
    }

    protected function onDispose():void {
        if (this._excludeTween) {
            this._excludeTween.dispose();
            this._excludeTween = null;
        }
        this._animTarget = null;
    }

    private function initialize():void {
        var _loc1_:FooterMc = this._animTarget.footerMc;
        this._footerOpenedY = _loc1_.y;
        this._footerClosedY = this._animTarget.bodyMc.y;
        var _loc2_:IWindow = IWindow(this._animTarget.window);
        this._darkBackgroundOpenHeight = this._animTarget.backgroundMc.height;
        this._darkBackgroundCloseHeight = this._footerClosedY + _loc1_.submitBtn.y;
        this._windowOpenedHeight = _loc2_.getBackground().height;
        this._windowClosedHeight = this._footerClosedY + _loc1_.height + _loc2_.sourceView.y + (_loc2_.getBackground().height - _loc2_.sourceView.y - _loc2_.sourceView.height) + DEF_CLOSED_HEIGHT_MARGIN;
        this._maskCloseHeight = 1;
        this._maskOpenHeight = this._animTarget.bodyMaskMc.height;
        this._excludeTween = new ExcludeTweenManager();
    }

    private function tweenToY(param1:MovieClip, param2:int, param3:Boolean):void {
        var _loc4_:Object = null;
        if (param3) {
            param1.y = param2;
        }
        else {
            _loc4_ = {};
            _loc4_.y = param2;
            this._excludeTween.registerAndLaunch(DEF_TWEEN_DURATION, param1, _loc4_, this.getDefaultTweenSet());
        }
    }

    private function tweenToAlpha(param1:MovieClip, param2:Number, param3:Boolean):void {
        var _loc4_:Object = null;
        if (param3) {
            param1.alpha = param2;
        }
        else {
            _loc4_ = {};
            _loc4_.alpha = param2;
            this._excludeTween.registerAndLaunch(DEF_TWEEN_DURATION, param1, _loc4_, this.getDefaultTweenSet());
        }
    }

    private function tweenToHeight(param1:DisplayObject, param2:Number, param3:Boolean):void {
        var _loc4_:Object = null;
        if (param3) {
            param1.height = param2;
        }
        else {
            _loc4_ = {};
            _loc4_.height = param2;
            this._excludeTween.registerAndLaunch(DEF_TWEEN_DURATION, param1, _loc4_, this.getDefaultTweenSet());
        }
    }

    private function onTweenComplete(param1:Tween):void {
        this._excludeTween.unregister(param1);
    }

    private function getDefaultTweenSet():Object {
        var _loc1_:Object = {};
        _loc1_.ease = Strong.easeOut;
        _loc1_.onComplete = this.onTweenComplete;
        return _loc1_;
    }
}
}

package net.wg.gui.components.advanced.tutorial {
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.gui.components.advanced.interfaces.ITutorialHintAnimation;

public class TutorialHintAnimation extends Sprite implements ITutorialHintAnimation {

    public var showAnimation:MovieClip = null;

    public var hideAnimation:MovieClip = null;

    private var _animations:Vector.<MovieClip> = null;

    public function TutorialHintAnimation() {
        super();
        this.getAnimations();
        this.hideAndStopAnimations();
    }

    public final function dispose():void {
        this.hideAndStopAnimations();
        this.onDispose();
    }

    public function hide():void {
        this.hideAndStopAnimations();
        this.hideAnimation.visible = true;
        this.hideAnimation.play();
    }

    public function setSize(param1:Number, param2:Number = NaN):void {
        var _loc3_:int = this._animations.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._animations[_loc4_].width = param1;
            if (!isNaN(param2)) {
                this._animations[_loc4_].height = param2;
            }
            _loc4_++;
        }
    }

    public function show():void {
        this.showAnimation.visible = true;
        this.showAnimation.play();
    }

    protected function getAnimations():void {
        this._animations = new <MovieClip>[this.showAnimation, this.hideAnimation];
    }

    protected function onDispose():void {
        this._animations.splice(0, this._animations.length);
        this._animations = null;
        this.showAnimation = null;
        this.hideAnimation = null;
    }

    protected function hideAndStopAnimations():void {
        var _loc1_:int = this._animations.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._animations[_loc2_].visible = false;
            this._animations[_loc2_].gotoAndStop(0);
            _loc2_++;
        }
    }

    public function get animations():Vector.<MovieClip> {
        return this._animations;
    }
}
}

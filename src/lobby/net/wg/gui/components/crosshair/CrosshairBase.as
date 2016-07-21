package net.wg.gui.components.crosshair {
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.filters.ColorMatrixFilter;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CrosshairBase extends MovieClip implements IDisposable {

    protected var devModeFilterMatrix:Array;

    protected var devModeColorFilter:ColorMatrixFilter;

    protected var _inited:Boolean = false;

    public function CrosshairBase() {
        this.devModeFilterMatrix = [2, 0.2, 0.2, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.3, 2, 0.8, 0, 0, 0, 1, 1, 0];
        this.devModeColorFilter = new ColorMatrixFilter(this.devModeFilterMatrix);
        super();
        if (stage) {
            this.init();
        }
        else {
            addEventListener(Event.ADDED_TO_STAGE, this.init);
        }
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function setAsDebug():void {
    }

    public function setFilter():void {
    }

    public function setReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0):void {
    }

    public function setReloadingAsPercent(param1:Number, param2:Boolean):void {
    }

    public function setScale(param1:Number):void {
        stage.scaleX = stage.scaleY = param1;
    }

    protected function onDispose():void {
        removeEventListener(Event.ADDED_TO_STAGE, this.init);
        this.devModeFilterMatrix.splice(0);
        this.devModeFilterMatrix = null;
    }

    protected function init(param1:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.init);
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        this._inited = true;
    }
}
}

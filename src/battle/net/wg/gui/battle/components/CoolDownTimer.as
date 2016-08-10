package net.wg.gui.battle.components {
import flash.display.MovieClip;

import net.wg.data.constants.Time;
import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CoolDownTimer implements IDisposable {

    private var _totalFrames:int;

    private var _currentFrame:int;

    private var _progressValues:Vector.<int>;

    private var _context:MovieClip;

    private var _coolDownHandler:ICoolDownCompleteHandler;

    public function CoolDownTimer(param1:MovieClip) {
        super();
        this._context = param1;
    }

    public function setFrames(param1:Number, param2:Number):void {
        this._totalFrames = param2 - param1;
        this._progressValues = new Vector.<int>(this._totalFrames + 1, true);
        var _loc3_:uint = 0;
        while (_loc3_ <= this._totalFrames) {
            this._progressValues[_loc3_] = param1 + _loc3_;
            _loc3_++;
        }
    }

    public function start(param1:Number, param2:ICoolDownCompleteHandler, param3:int, param4:Number):void {
        this._currentFrame = param3;
        this._coolDownHandler = param2;
        this.end();
        App.utils.scheduler.scheduleRepeatableTask(this.run, param1 / (this._totalFrames - this._currentFrame) * Time.MILLISECOND_IN_SECOND * param4, int.MAX_VALUE);
    }

    public function restartFromCurrentFrame(param1:Number):void {
        this.end();
        App.utils.scheduler.scheduleRepeatableTask(this.run, param1 / (this._progressValues.length - this._currentFrame) * Time.MILLISECOND_IN_SECOND, int.MAX_VALUE);
    }

    public function setPositionAsPercent(param1:Number):void {
        this.end();
        this._currentFrame = Math.floor(this._progressValues.length * 0.01 * param1);
        this.moveToFrame(this._currentFrame);
    }

    public function end():void {
        App.utils.scheduler.cancelTask(this.run);
    }

    private function run():void {
        this._currentFrame++;
        if (this._currentFrame >= this._progressValues.length) {
            this.end();
            this._coolDownHandler.onCoolDownComplete();
        }
        else {
            this.moveToFrame(this._currentFrame);
        }
    }

    public function moveToFrame(param1:int):void {
        this._context.gotoAndStop(this._progressValues[param1]);
    }

    public function get currentFrame():int {
        return this._currentFrame;
    }

    public function dispose():void {
        App.utils.scheduler.cancelTask(this.run);
        this._context.stop();
        this._context = null;
        this._progressValues = null;
        this._coolDownHandler = null;
    }
}
}

package net.wg.infrastructure.managers.utils.impl {
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

import net.wg.utils.IScheduler;

public class Scheduler implements IScheduler {

    public static const GLOBAL_FRAME_TICK:int = 50;

    public static const CONCURRENT_FRAME_TICK:int = GLOBAL_FRAME_TICK >> 1;

    private var _timer:Timer = null;

    private var _taskStack:TimedTaskStack = null;

    private var _nextFrameTasks:NextFrameTasks = null;

    private var _disposed:Boolean = false;

    public function Scheduler() {
        super();
        this._taskStack = new TimedTaskStack();
        this._nextFrameTasks = new NextFrameTasks();
        this._timer = new Timer(CONCURRENT_FRAME_TICK);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimerHandler, false, 0, true);
    }

    public function cancelAll():void {
        var _loc1_:TimedTask = null;
        while (!this._taskStack.isEmpty()) {
            _loc1_ = this._taskStack.popTask();
            _loc1_.dispose();
        }
        this._nextFrameTasks.cancelAll();
        this.updateTimer();
    }

    public function cancelTask(param1:Function):void {
        var _loc2_:Boolean = this._taskStack.removeTaskByHandler(param1);
        if (!_loc2_) {
            this._nextFrameTasks.removeTaskByHandler(param1);
        }
        this.updateTimer();
    }

    public function dispose():void {
        this.cancelAll();
        this._taskStack = null;
        this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerHandler);
        this._timer.stop();
        this._timer = null;
        this._nextFrameTasks.dispose();
        this._nextFrameTasks = null;
        this._disposed = true;
    }

    public function isEmpty():Boolean {
        return this._taskStack.isEmpty() && this._nextFrameTasks.isEmpty();
    }

    public function scheduleNonCancelableTask(param1:Function, param2:Number, ...rest):void {
        this.addTask(param2, param1, true, rest);
    }

    public function scheduleOnNextFrame(param1:Function, ...rest):void {
        this._nextFrameTasks.pushTask(new Task(param1, rest));
    }

    public function scheduleRepeatableTask(param1:Function, param2:Number, param3:int = 1, ...rest):void {
        var _loc5_:TimedTask = this.addTask(param2, param1, false, rest);
        _loc5_.repeat(param2, param3);
    }

    public function scheduleTask(param1:Function, param2:Number, ...rest):void {
        this.addTask(param2, param1, false, rest);
    }

    private function addTask(param1:Number, param2:Function, param3:Boolean, param4:Array):TimedTask {
        var _loc5_:Number = getTimer() + param1;
        var _loc6_:TimedTask = new TimedTask(_loc5_, param2, param4);
        this._taskStack.pushTask(_loc6_, param3);
        this.updateTimer();
        return _loc6_;
    }

    private function processFrame():void {
        var _loc1_:TimedTask = this._taskStack.popTask();
        _loc1_.invoke();
        if (_loc1_.count > 1) {
            _loc1_.reset();
            this._taskStack.pushTask(_loc1_);
        }
        else {
            _loc1_.dispose();
        }
        if (!this._disposed) {
            this.updateTimer();
        }
    }

    private function updateTimer():void {
        var _loc1_:Number = NaN;
        if (this._taskStack.isEmpty()) {
            this._timer.stop();
        }
        else {
            _loc1_ = this._taskStack.top().finishTime - getTimer();
            if (_loc1_ > 0) {
                this._timer.delay = _loc1_;
                this._timer.reset();
                this._timer.start();
            }
            else {
                this.processFrame();
            }
        }
    }

    private function onTimerHandler(param1:TimerEvent):void {
        this.processFrame();
    }
}
}

import flash.display.Sprite;
import flash.events.Event;

import net.wg.infrastructure.interfaces.entity.ICallable;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class Task implements ICallable, IDisposable {

    private var _handler:Function = null;

    private var _args:Array = null;

    function Task(param1:Function, param2:Array) {
        super();
        this._handler = param1;
        this._args = param2;
    }

    public function get handler():Function {
        return this._handler;
    }

    public function invoke():void {
        if (this._args.length > 0) {
            this._handler.apply(null, this._args);
        }
        else {
            this._handler();
        }
    }

    public function dispose():void {
        this._handler = null;
        this._args.splice(0, this._args.length);
        this._args = null;
    }
}

class TimedTask extends Task {

    private var _finishTime:Number = 0;

    private var _interval:int = 0;

    private var _count:int = 0;

    private var _maxCount:int = 0;

    private var _startTime:int = 0;

    function TimedTask(param1:Number, param2:Function, param3:Array) {
        super(param2, param3);
        this._finishTime = param1;
    }

    public function get finishTime():Number {
        return this._finishTime;
    }

    public function repeat(param1:int, param2:int):void {
        this._interval = param1;
        this._maxCount = this._count = param2;
        this._startTime = this._finishTime - this._interval;
    }

    public function reset():Boolean {
        this._count--;
        if (this._interval != 0) {
            this._finishTime = this._startTime + this._interval * (this._maxCount - this._count + 1);
            return true;
        }
        return false;
    }

    public function get count():int {
        return this._count;
    }

    public function get interval():int {
        return this._interval;
    }
}

class TimedTaskStack implements IDisposable {

    private var _tasks:Vector.<TimedTask> = null;

    function TimedTaskStack() {
        super();
        this._tasks = new Vector.<TimedTask>();
    }

    public function dispose():void {
        this._tasks.splice(0, this._tasks.length);
        this._tasks = null;
    }

    public function pushTask(param1:TimedTask, param2:Boolean = false):void {
        var _loc3_:Number = this._tasks.length - 1;
        var _loc4_:Number = -1;
        var _loc5_:Number = -1;
        while (_loc3_ >= 0) {
            if (this._tasks[_loc3_].finishTime > param1.finishTime && _loc4_ == -1) {
                _loc4_ = _loc3_ + 1;
            }
            if (!param2 && this._tasks[_loc3_].handler == param1.handler) {
                _loc5_ = _loc3_;
            }
            if (_loc4_ != -1 && _loc5_ != -1) {
                break;
            }
            _loc3_--;
        }
        if (_loc4_ == -1) {
            _loc4_ = 0;
        }
        if (_loc5_ < _loc4_ && _loc5_ != -1) {
            _loc4_--;
        }
        if (_loc5_ != -1) {
            this._tasks.splice(_loc5_, 1);
        }
        this._tasks.splice(_loc4_, 0, param1);
    }

    public function removeTaskByHandler(param1:Function):Boolean {
        var _loc4_:TimedTask = null;
        var _loc2_:int = 0;
        var _loc3_:Boolean = false;
        while (_loc2_ < this._tasks.length) {
            _loc4_ = this._tasks[_loc2_];
            if (_loc4_.handler == param1) {
                this._tasks.splice(_loc2_, 1);
                _loc3_ = true;
            }
            else {
                _loc2_++;
            }
        }
        return _loc3_;
    }

    public function popTask():TimedTask {
        return this._tasks.pop();
    }

    public function top():TimedTask {
        return this._tasks[this._tasks.length - 1];
    }

    public function isEmpty():Boolean {
        return this._tasks.length == 0;
    }
}

class NextFrameTasks implements IDisposable {

    private var _tasks:Vector.<TimedTask> = null;

    private var _nextFrameListener:Sprite = null;

    function NextFrameTasks() {
        super();
        this._tasks = new Vector.<TimedTask>();
        this._nextFrameListener = new Sprite();
    }

    public function pushTask(param1:Task):void {
        if (this._tasks.length == 0) {
            this._nextFrameListener.addEventListener(Event.ENTER_FRAME, this.onNextFrameListenerEnterFrameHandler);
        }
        this._tasks.push(param1);
    }

    public function removeTaskByHandler(param1:Function):Boolean {
        var _loc5_:TimedTask = null;
        var _loc2_:int = this._tasks.length;
        var _loc3_:Boolean = false;
        var _loc4_:int = this._tasks.length - 1;
        while (_loc4_ >= 0) {
            _loc5_ = this._tasks[_loc4_];
            if (_loc5_.handler == param1) {
                this._tasks.splice(_loc4_, 1);
                if (_loc2_ == 1) {
                    this._nextFrameListener.removeEventListener(Event.ENTER_FRAME, this.onNextFrameListenerEnterFrameHandler);
                }
                _loc3_ = true;
            }
            _loc4_--;
        }
        return _loc3_;
    }

    public function cancelAll():void {
        var _loc2_:int = 0;
        var _loc1_:int = this._tasks.length;
        if (_loc1_ > 0) {
            _loc2_ = 0;
            while (_loc2_ < _loc1_) {
                this._tasks[_loc2_].dispose();
                _loc2_++;
            }
            this._tasks.splice(0, _loc1_);
            this._nextFrameListener.removeEventListener(Event.ENTER_FRAME, this.onNextFrameListenerEnterFrameHandler);
        }
    }

    public function dispose():void {
        this.cancelAll();
        this._tasks = null;
        this._nextFrameListener = null;
    }

    public function isEmpty():Boolean {
        return this._tasks.length == 0;
    }

    private function onNextFrameListenerEnterFrameHandler(param1:Event):void {
        this._nextFrameListener.removeEventListener(Event.ENTER_FRAME, this.onNextFrameListenerEnterFrameHandler);
        var _loc2_:Vector.<TimedTask> = this._tasks;
        this._tasks = new Vector.<TimedTask>();
        var _loc3_:int = _loc2_.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_[_loc4_].invoke();
            _loc2_[_loc4_].dispose();
            _loc4_++;
        }
        _loc2_.splice(0, _loc3_);
    }
}

package net.wg.infrastructure.base {
import flash.display.MovieClip;
import flash.events.Event;

import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.utils.IUtils;

import scaleform.clik.constants.InvalidationType;

public class SimpleContainer extends MovieClip {

    public var initialized:Boolean = false;

    private var _invalid:Boolean = false;

    private var _invalidHash:Object;

    private var _listenerFlag:Boolean = true;

    public function SimpleContainer() {
        super();
        this._invalidHash = {};
        this.invalidate();
    }

    public final function dispose():void {
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
        this.onDispose();
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
    }

    protected function onDispose():void {
        this.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrameValidation, false);
        this.removeEventListener(Event.ADDED_TO_STAGE, this.handleStageChange, false);
        this.removeEventListener(Event.RENDER, this.validateNow, false);
    }

    protected function invalidate(...rest):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (rest.length == 0) {
            this._invalidHash[InvalidationType.ALL] = true;
        }
        else {
            _loc2_ = rest.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this._invalidHash[rest[_loc3_]] = true;
                _loc3_++;
            }
        }
        if (!this._invalid) {
            this._invalid = true;
            if (stage == null) {
                this.addEventListener(Event.ADDED_TO_STAGE, this.handleStageChange, false, 0, true);
            }
            else {
                this.addEventListener(Event.ENTER_FRAME, this.handleEnterFrameValidation, false, 0, true);
                this.addEventListener(Event.RENDER, this.validateNow, false, 0, true);
                stage.invalidate();
            }
        }
        else if (stage != null) {
            stage.invalidate();
        }
    }

    public function validateNow(param1:Event = null):void {
        if (!this.initialized) {
            this.initialized = true;
            this.configUI();
        }
        this.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrameValidation, false);
        this.removeEventListener(Event.RENDER, this.validateNow, false);
        if (!this._invalid) {
            return;
        }
        this.draw();
        this._invalidHash = {};
        this._invalid = false;
    }

    override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        var _loc6_:IUtils = !!App.instance ? App.utils : null;
        if (_loc6_ && _loc6_.events && this._listenerFlag) {
            this._listenerFlag = false;
            _loc6_.events.addEvent(this, param1, param2, param3, param4, param5);
            this._listenerFlag = true;
        }
        else {
            this.addSuperEventListener(param1, param2, param3, param4, param5);
        }
    }

    override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        var _loc4_:IUtils = !!App.instance ? App.utils : null;
        if (_loc4_ && _loc4_.events && this._listenerFlag) {
            this._listenerFlag = false;
            _loc4_.events.removeEvent(this, param1, param2, param3);
            this._listenerFlag = true;
        }
        else {
            this.removeSuperEventListener(param1, param2, param3);
        }
    }

    public function removeSuperEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        super.removeEventListener(param1, param2, param3);
    }

    public function addSuperEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        super.addEventListener(param1, param2, param3, param4, param5);
    }

    protected function isInvalid(...rest):Boolean {
        if (!this._invalid) {
            return false;
        }
        var _loc2_:uint = rest.length;
        if (_loc2_ == 0) {
            return this._invalid;
        }
        if (this._invalidHash[InvalidationType.ALL]) {
            return true;
        }
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            if (this._invalidHash[rest[_loc3_]]) {
                return true;
            }
            _loc3_++;
        }
        return false;
    }

    public function invalidateSize():void {
        this.invalidate(InvalidationType.SIZE);
    }

    public function invalidateData():void {
        this.invalidate(InvalidationType.DATA);
    }

    public function invalidateState():void {
        this.invalidate(InvalidationType.STATE);
    }

    protected function handleStageChange(param1:Event):void {
        if (param1.type == Event.ADDED_TO_STAGE) {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.handleStageChange, false);
            this.addEventListener(Event.RENDER, this.validateNow, false, 0, true);
            if (stage != null) {
                stage.invalidate();
            }
        }
    }

    protected function handleEnterFrameValidation(param1:Event):void {
        this.validateNow();
    }

    protected function draw():void {
    }

    protected function configUI():void {
    }
}
}

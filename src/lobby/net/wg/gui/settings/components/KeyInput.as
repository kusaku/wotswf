package net.wg.gui.settings.components {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.ui.Keyboard;
import flash.utils.Timer;

import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.KeyProps;
import net.wg.data.managers.ITooltipProps;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.controls.SoundButton;
import net.wg.gui.components.tooltips.helpers.Utils;
import net.wg.gui.settings.components.evnts.KeyInputEvents;

import scaleform.clik.constants.InputValue;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;
import scaleform.gfx.MouseEventEx;

public class KeyInput extends SoundButton {

    public var alert:UIComponent;

    public var bg:MovieClip;

    public var border:MovieClip;

    private var _keys:Array;

    private var _keyCode:Number;

    private var _keyString:String;

    private var _keyDefault:Number;

    public function KeyInput() {
        super();
    }

    override public function toString():String {
        return "[WG KeyInput " + name + "]";
    }

    override protected function onDispose():void {
        this.clearEventListeners();
        if (this.hasEventListener(Event.SELECT)) {
            this.removeEventListener(Event.SELECT, this.onButtonSelect);
        }
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        stage.doubleClickEnabled = true;
        toggle = true;
        this.addEventListener(Event.SELECT, this.onButtonSelect);
        buttonMode = enabled;
        mouseEnabled = true;
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.DATA)) {
            textField.text = this._keyString || "";
            this.alert.visible = this._keyCode == KeyProps.KEY_NONE && !selected;
        }
        super.draw();
    }

    private function __keysToUpperCase():void {
        var _loc1_:uint = 0;
        while (_loc1_ < this._keys.length) {
            this._keys[_loc1_] = App.utils.toUpperOrLowerCase(String(this._keys[_loc1_]), true);
            _loc1_++;
        }
    }

    private function addEventListeners():void {
        this.addEventListener(ButtonEvent.PRESS, this.onKeyDown);
        App.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleReleaseOutside, false, 0, true);
        this.addEventListener(ButtonEvent.RELEASE_OUTSIDE, this.onKeyDown);
    }

    private function clearEventListeners():void {
        if (this.hasEventListener(ButtonEvent.PRESS)) {
            this.removeEventListener(ButtonEvent.PRESS, this.onKeyDown);
        }
        if (this.hasEventListener(ButtonEvent.RELEASE_OUTSIDE)) {
            this.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, this.onKeyDown);
        }
        if (App.stage.hasEventListener(MouseEvent.MOUSE_DOWN)) {
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleReleaseOutside, false);
        }
    }

    private function __processCode(param1:Number):void {
        var _loc3_:Point = null;
        var _loc4_:ITooltipProps = null;
        var _loc5_:String = null;
        var _loc6_:* = null;
        if (param1 == Keyboard.ESCAPE) {
            this.__inputClose();
            return;
        }
        var _loc2_:KeyProps = App.utils.commons.keyToString(param1);
        if (this.__isInKeySet(_loc2_.keyCommand)) {
            this.key = param1;
            dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE, this.key));
            this.__inputClose();
        }
        else {
            _loc3_ = new Point(x + width, y - height - 7);
            _loc3_ = parent.localToGlobal(_loc3_);
            _loc4_ = new TooltipProps(BaseTooltips.TYPE_WARNING, _loc3_.x, _loc3_.y, 0, 0, 1500);
            _loc5_ = App.utils.locale.makeString(TOOLTIPS.SETTING_WINDOW_CONTROLS_KEY_INPUT_WARNING, {"keyName": _loc2_.keyCommand});
            _loc6_ = "<font color=\"" + Utils.instance.COLOR_ALERT + "\">" + _loc5_ + "</font>";
            App.toolTipMgr.show(_loc6_, _loc4_);
            this.__inputClose();
        }
    }

    private function __isInKeySet(param1:String):Boolean {
        return this._keys.indexOf(param1, 0) > -1;
    }

    private function __inputClose():void {
        selected = false;
        invalidate();
    }

    override public function set enabled(param1:Boolean):void {
        if (param1 == enabled) {
            return;
        }
        buttonMode = param1;
        super.enabled = param1;
    }

    public function get keyCode():Number {
        return this._keyCode;
    }

    public function get keyString():String {
        return this._keyString;
    }

    public function get keyDefault():Number {
        return this._keyDefault;
    }

    public function set keyDefault(param1:Number):void {
        this._keyDefault = param1;
    }

    public function get key():Number {
        return this._keyCode;
    }

    public function set key(param1:Number):void {
        if (this._keyCode == param1) {
            return;
        }
        if (param1 == KeyProps.KEY_NONE) {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE, KeyProps.KEY_NONE));
        }
        this._keyCode = param1;
        this._keyString = App.utils.commons.keyToString(this._keyCode).keyName;
        invalidateData();
    }

    public function get keys():Array {
        return this._keys;
    }

    public function set keys(param1:Array):void {
        this._keys = param1;
        this.__keysToUpperCase();
    }

    override public function handleInput(param1:InputEvent):void {
        var _loc2_:InputDetails = null;
        if (selected) {
            if (param1.isDefaultPrevented()) {
                return;
            }
            _loc2_ = param1.details;
            if (_loc2_.value == InputValue.KEY_DOWN && selected) {
                this.__processCode(_loc2_.code);
            }
            return;
        }
        super.handleInput(param1);
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        var _loc5_:ButtonEvent = null;
        var _loc2_:MouseEventEx = param1 as MouseEventEx;
        var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
        var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
        _mouseDown = _mouseDown | 1 << _loc3_;
        if (enabled) {
            setState("down");
            if (autoRepeat && _repeatTimer == null) {
                _autoRepeatEvent = new ButtonEvent(ButtonEvent.CLICK, true, false, _loc3_, _loc4_, false, true);
                _repeatTimer = new Timer(repeatDelay, 1);
                _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE, beginRepeat, false, 0, true);
                _repeatTimer.start();
            }
            _loc5_ = new ButtonEvent(ButtonEvent.PRESS, true, false, _loc3_, _loc4_, false, false);
            dispatchEvent(_loc5_);
            callLogEvent(param1);
        }
        else {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.DISABLE_PRESS, NaN, true, false));
        }
    }

    override protected function handleReleaseOutside(param1:MouseEvent):void {
        var _loc4_:uint = 0;
        _autoRepeatEvent = null;
        if (contains(param1.target as DisplayObject)) {
            return;
        }
        var _loc2_:MouseEventEx = param1 as MouseEventEx;
        var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
        _loc4_ = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleReleaseOutside, false);
        _mouseDown = _mouseDown ^ 1 << _loc3_;
        dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true, false, _loc3_, _loc4_, false, false));
        if (!enabled) {
            return;
        }
        if (lockDragStateChange) {
            if (_focused || _displayFocus) {
                setState(focusIndicator == null ? "release" : "kb_release");
            }
            else {
                setState("kb_release");
            }
        }
        callLogEvent(param1);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        if (!enabled) {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.DISABLE_OVER, NaN, true, false));
        }
        super.handleMouseRollOver(param1);
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        if (!enabled) {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.DISABLE_OUT, NaN, true, false));
        }
        super.handleMouseRollOut(param1);
    }

    private function onButtonSelect(param1:Event):void {
        if (this.selected) {
            this.addEventListeners();
        }
        else {
            this.clearEventListeners();
        }
    }

    private function onKeyDown(param1:ButtonEvent):void {
        this.__processCode(!!param1.isKeyboard ? Number(param1.controllerIdx) : Number(param1.buttonIdx));
    }
}
}

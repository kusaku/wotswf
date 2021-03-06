package scaleform.clik.core {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.utils.getQualifiedClassName;

import net.wg.data.constants.Values;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.events.TutorialEvent;
import net.wg.infrastructure.exceptions.AssertionException;
import net.wg.infrastructure.exceptions.InfrastructureException;
import net.wg.infrastructure.exceptions.LifecycleException;
import net.wg.utils.IFocusHandler;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ComponentEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.interfaces.IUIComponent;
import scaleform.clik.layout.LayoutData;
import scaleform.clik.utils.Constraints;
import scaleform.gfx.Extensions;
import scaleform.gfx.FocusManager;
import scaleform.gfx.MouseEventEx;

public class UIComponent extends MovieClip implements IUIComponent {

    protected static var tutorialFunctionPointer:Function = checkTutorialFucntionType;

    public var initialized:Boolean = false;

    protected var _invalidHash:Object;

    protected var _invalid:Boolean = false;

    protected var _width:Number = 0;

    protected var _height:Number = 0;

    protected var _originalWidth:Number = 0;

    protected var _originalHeight:Number = 0;

    protected var _focusTarget:UIComponent;

    protected var _focusable:Boolean = true;

    protected var _focused:Number = 0;

    protected var _displayFocus:Boolean = false;

    protected var _mouseWheelEnabled:Boolean = true;

    protected var _inspector:Boolean = false;

    protected var _labelHash:Object;

    protected var _layoutData:LayoutData;

    protected var _enableInitCallback:Boolean = false;

    private var _uiid:uint = 4.294967295E9;

    public var constraints:Constraints;

    protected var _deferredDispose:Boolean = false;

    protected var _baseDisposed:Boolean = false;

    public function UIComponent() {
        this.preInitialize();
        super();
        this._invalidHash = {};
        this.initialize();
        addEventListener(Event.ADDED_TO_STAGE, this.addedToStage, false, 0, true);
    }

    public static function generateLabelHash(param1:MovieClip):Object {
        var _loc2_:Object = {};
        if (!param1) {
            return _loc2_;
        }
        var _loc3_:Array = param1.currentLabels;
        var _loc4_:uint = _loc3_.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc4_) {
            _loc2_[_loc3_[_loc5_].name] = true;
            _loc5_++;
        }
        return _loc2_;
    }

    private static function checkTutorialFucntionType(param1:DisplayObject):void {
        if (App.tutorialMgr.isSystemEnabled) {
            tutorialFunctionPointer = onReadyForTutorial;
            onReadyForTutorial(param1);
        }
        else if (App.tutorialMgr.isSystemEnabled != null) {
            tutorialFunctionPointer = onReadyForTutorialFake;
        }
    }

    private static function onReadyForTutorial(param1:DisplayObject):void {
        var _loc2_:TutorialEvent = new TutorialEvent(TutorialEvent.VIEW_READY_FOR_TUTORIAL);
        _loc2_.addPathPoint(param1, param1.name);
        param1.dispatchEvent(_loc2_);
    }

    private static function onReadyForTutorialFake(param1:DisplayObject):void {
    }

    protected function preInitialize():void {
    }

    protected function initialize():void {
        this._labelHash = UIComponent.generateLabelHash(this);
        this._originalWidth = super.width / super.scaleX;
        this._originalHeight = super.height / super.scaleY;
        if (this._width == 0) {
            this._width = super.width;
        }
        if (this._height == 0) {
            this._height = super.height;
        }
        this.invalidate();
    }

    protected function addedToStage(param1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage, false);
        if (!CLIK.initialized) {
            CLIK.initialize(stage, this);
        }
        if (this._enableInitCallback && Extensions.CLIK_addedToStageCallback != null) {
            CLIK.queueInitCallback(this);
        }
    }

    public function get componentInspectorSetting():Boolean {
        return this._inspector;
    }

    public function set componentInspectorSetting(param1:Boolean):void {
        this._inspector = param1;
        if (param1) {
            this.beforeInspectorParams();
        }
        else {
            this.afterInspectorParams();
        }
    }

    override public function get width():Number {
        return this._width;
    }

    override public function set width(param1:Number):void {
        this.setSize(param1, this._height);
    }

    override public function get height():Number {
        return this._height;
    }

    override public function set height(param1:Number):void {
        this.setSize(this._width, param1);
    }

    override public function get scaleX():Number {
        return this._width / this._originalWidth;
    }

    override public function set scaleX(param1:Number):void {
        if (super.scaleX != param1) {
            super.scaleX = param1;
        }
        if (this._width != super.width && rotation == 0) {
            this.width = super.width;
        }
    }

    override public function get scaleY():Number {
        return this._height / this._originalHeight;
    }

    override public function set scaleY(param1:Number):void {
        if (super.scaleY != param1) {
            super.scaleY = param1;
        }
        if (this._height != super.height && rotation == 0) {
            this.height = super.height;
        }
    }

    override public function get enabled():Boolean {
        return super.enabled;
    }

    override public function set enabled(param1:Boolean):void {
        if (param1 == super.enabled) {
            return;
        }
        super.enabled = param1;
        tabEnabled = !this.enabled ? false : Boolean(this._focusable);
        mouseEnabled = param1;
    }

    override public function get visible():Boolean {
        return super.visible;
    }

    override public function set visible(param1:Boolean):void {
        if (this.visible == param1) {
            return;
        }
        super.visible = param1;
        dispatchEvent(new ComponentEvent(!!param1 ? ComponentEvent.SHOW : ComponentEvent.HIDE));
    }

    public function get hasFocus():Boolean {
        return this._focused > 0;
    }

    public function get focusable():Boolean {
        return this._focusable;
    }

    public function set focusable(param1:Boolean):void {
        if (this._focusable == param1) {
            return;
        }
        this._focusable = param1;
        if (!this._focusable && this.enabled) {
            tabEnabled = tabChildren = false;
        }
        else if (this._focusable && this.enabled) {
            tabEnabled = true;
        }
        this.changeFocus();
    }

    public function get focused():Number {
        return this._focused;
    }

    public function set focused(param1:Number):void {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        var _loc4_:Number = NaN;
        var _loc5_:* = false;
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        var _loc8_:* = false;
        this.throwLifeCycleException();
        if (param1 == this._focused || !this._focusable) {
            return;
        }
        this._focused = param1;
        if (Extensions.isScaleform) {
            _loc2_ = FocusManager.numFocusGroups;
            _loc3_ = Extensions.numControllers;
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc5_ = (this._focused >> _loc4_ & 1) != 0;
                if (_loc5_) {
                    _loc6_ = FocusManager.getControllerMaskByFocusGroup(_loc4_);
                    _loc7_ = 0;
                    while (_loc7_ < _loc3_) {
                        _loc8_ = (_loc6_ >> _loc7_ & 1) != 0;
                        if (_loc8_ && FocusManager.getFocus(_loc7_) != this) {
                            FocusManager.setFocus(this, _loc7_);
                        }
                        _loc7_++;
                    }
                }
                _loc4_++;
            }
        }
        else if (stage != null && this._focused > 0) {
            stage.focus = this;
        }
        this.changeFocus();
    }

    public function get displayFocus():Boolean {
        return this._displayFocus;
    }

    public function set displayFocus(param1:Boolean):void {
        if (param1 == this._displayFocus) {
            return;
        }
        this._displayFocus = param1;
        this.changeFocus();
    }

    public function get focusTarget():UIComponent {
        return this._focusTarget;
    }

    public function set focusTarget(param1:UIComponent):void {
        this._focusTarget = param1;
    }

    public function get layoutData():LayoutData {
        return this._layoutData;
    }

    public function set layoutData(param1:LayoutData):void {
        this._layoutData = param1;
    }

    public function get enableInitCallback():Boolean {
        return this._enableInitCallback;
    }

    public function set enableInitCallback(param1:Boolean):void {
        if (param1 == this._enableInitCallback) {
            return;
        }
        this._enableInitCallback = param1;
        if (this._enableInitCallback && stage != null && Extensions.CLIK_addedToStageCallback != null) {
            if (!CLIK.initialized) {
                CLIK.initialize(stage, this);
            }
            CLIK.queueInitCallback(this);
        }
    }

    public final function get actualWidth():Number {
        return super.width;
    }

    public final function get actualHeight():Number {
        return super.height;
    }

    public final function get actualScaleX():Number {
        return super.scaleX;
    }

    public final function get actualScaleY():Number {
        return super.scaleY;
    }

    public function setSize(param1:Number, param2:Number):void {
        if (this._width == param1 && this._height == param2) {
            return;
        }
        this._width = param1;
        this._height = param2;
        this.invalidateSize();
    }

    public function setActualSize(param1:Number, param2:Number):void {
        if (super.width != param1 || this._width != param1) {
            super.width = this._width = param1;
        }
        if (super.height != param2 || this._height != param2) {
            super.height = this._height = param2;
        }
    }

    public final function setActualScale(param1:Number, param2:Number):void {
        var _loc3_:Boolean = false;
        if (super.scaleX != param1) {
            super.scaleX = param1;
            _loc3_ = true;
        }
        if (super.scaleY != param2) {
            super.scaleY = param2;
            _loc3_ = true;
        }
        if (this._width != this._originalWidth * param1) {
            this._width = this._originalWidth * param1;
            _loc3_ = true;
        }
        if (this._height != this._originalHeight * param2) {
            this._height = this._originalHeight * param2;
            _loc3_ = true;
        }
        if (_loc3_) {
            this.invalidateSize();
        }
    }

    public function handleInput(param1:InputEvent):void {
    }

    public function isReadyForTutorialByDefault():Boolean {
        return App.instance != null;
    }

    public function dispatchEventToGame(param1:Event):void {
        ExternalInterface.call("__handleEvent", name, param1);
    }

    protected function configUI():void {
        if (this.isReadyForTutorialByDefault()) {
            tutorialFunctionPointer(this);
        }
        addEventListener(MouseEvent.DOUBLE_CLICK, this.onPreventDoubleRightClickHandler, false, int.MAX_VALUE);
    }

    protected function draw():void {
    }

    protected function changeFocus():void {
    }

    protected function beforeInspectorParams():void {
    }

    protected function afterInspectorParams():void {
    }

    protected function initSize():void {
        var _loc1_:Number = this._width == 0 ? Number(this.actualWidth) : Number(this._width);
        var _loc2_:Number = this._height == 0 ? Number(this.actualHeight) : Number(this._height);
        super.scaleX = super.scaleY = 1;
        this.setSize(_loc1_, _loc2_);
    }

    public function invalidate(...rest):void {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        this.throwLifeCycleException();
        if (!this._baseDisposed) {
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
                    addEventListener(Event.ADDED_TO_STAGE, this.handleStageChange, false, 0, true);
                }
                else {
                    addEventListener(Event.ENTER_FRAME, this.handleEnterFrameValidation, false, 0, true);
                    addEventListener(Event.RENDER, this.validateNow, false, 0, true);
                    stage.invalidate();
                }
            }
            else if (stage != null) {
                stage.invalidate();
            }
        }
    }

    protected final function cancelValidation(param1:String):void {
        if (this._invalidHash != null) {
            delete this._invalidHash[param1];
        }
    }

    public function validateNow(param1:Event = null):void {
        if (!this.initialized) {
            this.initialized = true;
            this.configUI();
        }
        removeEventListener(Event.ENTER_FRAME, this.handleEnterFrameValidation, false);
        removeEventListener(Event.RENDER, this.validateNow, false);
        if (!this._invalid) {
            return;
        }
        this.draw();
        this._invalidHash = {};
        this._invalid = false;
    }

    protected function isInvalid(...rest):Boolean {
        if (!this._invalid) {
            return false;
        }
        this.throwLifeCycleException();
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
            removeEventListener(Event.ADDED_TO_STAGE, this.handleStageChange, false);
            addEventListener(Event.RENDER, this.validateNow, false, 0, true);
            if (stage != null) {
                stage.invalidate();
            }
        }
    }

    protected function handleEnterFrameValidation(param1:Event):void {
        this.throwLifeCycleException();
        this.validateNow();
    }

    private function onPreventDoubleRightClickHandler(param1:MouseEvent):void {
        if (param1 is MouseEventEx && MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            param1.stopImmediatePropagation();
        }
    }

    protected function getInvalid():String {
        var _loc4_:* = null;
        var _loc1_:Array = [];
        var _loc2_:Array = [InvalidationType.ALL, InvalidationType.DATA, InvalidationType.RENDERERS, InvalidationType.SIZE, InvalidationType.STATE];
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_.length) {
            _loc1_.push("* " + _loc2_[_loc3_] + ": " + (this._invalidHash[_loc2_[_loc3_]] == true));
            _loc3_++;
        }
        for (_loc4_ in this._invalidHash) {
            if (!_loc2_.indexOf(_loc4_)) {
                _loc1_.push("* " + _loc4_ + ": true");
            }
        }
        return "Invalid " + this + ": \n" + _loc1_.join("\n");
    }

    public function dispatchEventAndSound(param1:Event):Boolean {
        var _loc2_:Boolean = super.dispatchEvent(param1);
        return _loc2_;
    }

    public final function dispose():void {
        var _loc1_:IFocusHandler = App.utils.focusHandler;
        if (_loc1_ && _loc1_.getFocus(0) == this) {
            this.forcedResetFocus();
        }
        if (this._deferredDispose) {
            this.onBeforeDispose();
            App.utils.scheduler.scheduleNonCancelableTask(this.doDispose, 100);
        }
        else {
            this.onBeforeDispose();
            this.doDispose();
        }
    }

    protected function onBeforeDispose():void {
        var _loc1_:* = null;
        removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage, false);
        removeEventListener(Event.ENTER_FRAME, this.handleEnterFrameValidation, false);
        removeEventListener(Event.ADDED_TO_STAGE, this.handleStageChange, false);
        removeEventListener(Event.RENDER, this.validateNow, false);
        removeEventListener(MouseEvent.DOUBLE_CLICK, this.onPreventDoubleRightClickHandler);
        this._focusTarget = null;
        this._invalid = false;
        for (_loc1_ in this._invalidHash) {
            delete this._invalidHash[_loc1_];
        }
        for (_loc1_ in this._labelHash) {
            delete this._labelHash[_loc1_];
        }
    }

    protected function onDispose():void {
        if (this.constraints) {
            this.constraints.removeAllElements();
            this.constraints.dispose();
            this.constraints = null;
        }
        this._invalidHash = null;
        this._labelHash = null;
        this._layoutData = null;
    }

    private function doDispose():void {
        if (this._baseDisposed) {
            App.utils.asserter.assert(false, name + "(" + getQualifiedClassName(this) + ") already disposed!");
        }
        this._baseDisposed = true;
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
        this.onDispose();
        dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
        while (numChildren > 0) {
            removeChildAt(0);
        }
    }

    private function forcedResetFocus():void {
        var _loc1_:Boolean = CLIK.disableNullFocusMoves;
        CLIK.disableNullFocusMoves = false;
        App.utils.focusHandler.setFocus(null);
        CLIK.disableNullFocusMoves = _loc1_;
    }

    private function simpleAssert(param1:Boolean, param2:String, param3:Class = null):void {
        if (!param1) {
            if (param3 == null) {
                param3 = AssertionException;
            }
            throw new param3(param2);
        }
    }

    private function throwLifeCycleException():void {
        var _loc1_:* = null;
        if (this._baseDisposed && App.instance) {
            _loc1_ = "invoking component \'" + this + "\' after dispose!\nMay be you can find a custom override method Draw and place after each gotoAnd... " + "method next code block:if (_baseDisposed){return;}";
            App.utils.asserter.assert(false, _loc1_, LifecycleException);
        }
    }

    public function get UIID():uint {
        return this._uiid;
    }

    public function set UIID(param1:uint):void {
        var _loc2_:String = null;
        if (this._uiid != Values.EMPTY_UIID) {
            _loc2_ = "UIID is unique value and can not be modified.";
            this.simpleAssert(this._uiid == param1, _loc2_, InfrastructureException);
        }
        this._uiid = param1;
    }
}
}

package net.wg.gui.components.controls {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.ComponentState;
import net.wg.data.constants.Values;
import net.wg.data.managers.IToolTipParams;
import net.wg.gui.events.StateManagerEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.utils.helpLayout.HelpLayoutVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ComponentEvent;
import scaleform.clik.utils.ConstrainedElement;
import scaleform.clik.utils.Constraints;
import scaleform.clik.utils.Padding;

public class SoundButtonEx extends SoundButton implements ISoundButtonEx {

    public var blurTextField:TextField;

    public var disableMc:net.wg.gui.components.controls.BitmapFill;

    public var bgMc:MovieClip;

    public var textField1:TextField;

    public var filtersMC:MovieClip;

    public var _textColor:Number;

    protected var _tooltip:String = "";

    protected var _paddingHorizontal:Number = 5;

    protected var _helpText:String = "";

    protected var _helpDirection:String = "T";

    private var _tooltipParams:IToolTipParams = null;

    private var _disabledFillPadding:Padding;

    private var _helpLayoutId:String = "";

    private var _minWidth:Number = NaN;

    private var _isTooltipShown:Boolean = false;

    private var _dynamicSizeByText:Boolean = false;

    private var _usePreventUpdateDisable:Boolean = false;

    public function SoundButtonEx() {
        this._disabledFillPadding = new Padding(0, 0, 0, 0);
        super();
    }

    override public function toString():String {
        return "[WG SoundButtonEx " + name + "]";
    }

    override protected function configUI():void {
        super.configUI();
        if (!constraintsDisabled) {
            if (this.textField1 != null) {
                constraints.addElement(this.textField1.name, this.textField1, Constraints.ALL);
            }
        }
        if (this.textField1) {
            this.textField1.mouseEnabled = false;
        }
        addEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        if (focusIndicator != null && !_focused && focusIndicator.totalFrames == 1) {
            focusIndicator.visible = false;
        }
        if (this._helpText.length > 0) {
            App.utils.helpLayout.registerComponent(this);
        }
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        if (this._tooltipParams) {
            this._tooltipParams.dispose();
            this._tooltipParams = null;
        }
        this._helpLayoutId = null;
        this.blurTextField = null;
        this.textField1 = null;
        if (this.disableMc) {
            this.disableMc.dispose();
            this.disableMc = null;
        }
        this.bgMc = null;
        this.filtersMC = null;
        this._disabledFillPadding = null;
        super.onDispose();
    }

    override protected function updateText():void {
        super.updateText();
        if (_label != null) {
            if (this.textField1 != null) {
                this.textField1.text = _label;
            }
        }
    }

    override protected function updateAfterStateChange():void {
        if (!initialized) {
            return;
        }
        if (constraints != null && !constraintsDisabled) {
            if (textField != null) {
                constraints.updateElement(textField.name, textField);
            }
            if (this.textField1 != null) {
                constraints.updateElement(this.textField1.name, this.textField1);
            }
        }
        dispatchEvent(new StateManagerEvent(ComponentEvent.STATE_CHANGE, state));
    }

    override protected function calculateWidth():Number {
        var _loc2_:Number = NaN;
        var _loc3_:ConstrainedElement = null;
        var _loc1_:Number = actualWidth;
        if (!constraintsDisabled) {
            _loc2_ = 0;
            if (autoSize != "none") {
                _loc2_ = this._paddingHorizontal;
            }
            _loc3_ = constraints.getElement("textField");
            _loc1_ = Math.ceil(textField.textWidth + _loc3_.left + _loc3_.right + 5 + _loc2_ * 2);
        }
        if (!isNaN(this._minWidth)) {
            _loc1_ = Math.max(_loc1_, this._minWidth);
        }
        return _loc1_;
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.STATE)) {
            if (_newFrame) {
                gotoAndPlay(_newFrame);
                if (_baseDisposed) {
                    return;
                }
                _newFrame = null;
            }
            if (focusIndicator && _newFocusIndicatorFrame) {
                focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                _newFocusIndicatorFrame = null;
            }
            if (_baseDisposed) {
                return;
            }
            this.updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA, InvalidationType.SIZE);
        }
        if (isInvalid(InvalidationType.DATA)) {
            this.updateText();
            if (this._dynamicSizeByText) {
                this.updateDynamicSizeByText();
            }
            if (autoSize != TextFieldAutoSize.NONE) {
                invalidateSize();
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            if (this._usePreventUpdateDisable) {
                this.updateDisable();
            }
            if (!preventAutosizing) {
                alignForAutoSize();
                setActualSize(_width, _height);
            }
            if (!constraintsDisabled) {
                constraints.update(_width, _height);
            }
        }
        this.updateDisable();
    }

    override protected function setState(param1:String):void {
        if (!visible) {
            return;
        }
        super.setState(param1);
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (!this._helpLayoutId) {
            this._helpLayoutId = name + "_" + Math.random();
        }
        var _loc1_:HelpLayoutVO = new HelpLayoutVO();
        _loc1_.x = 0;
        _loc1_.y = 0;
        _loc1_.width = width;
        _loc1_.height = height;
        _loc1_.extensibilityDirection = this._helpDirection;
        _loc1_.message = this._helpText;
        _loc1_.id = this._helpLayoutId;
        _loc1_.scope = this;
        return new <HelpLayoutVO>[_loc1_];
    }

    protected function updateDynamicSizeByText():void {
        var _loc1_:Number = NaN;
        if (textField && textField.text != Values.EMPTY_STR) {
            _loc1_ = textField.textWidth + (this._paddingHorizontal << 1) ^ 0;
            if (actualWidth != _loc1_) {
                setActualSize(_loc1_, _height);
                invalidateSize();
                dispatchEvent(new Event(Event.RESIZE, true));
            }
        }
    }

    protected function showTooltip():void {
        if (this._tooltip && App.toolTipMgr) {
            this._isTooltipShown = true;
            if (this._tooltipParams) {
                App.toolTipMgr.showComplexWithParams(this._tooltip, this._tooltipParams);
            }
            else {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }
    }

    protected function updateDisable():void {
        if (this.disableMc != null) {
            this.disableMc.x = this.disabledFillPadding.left;
            this.disableMc.y = this.disabledFillPadding.top;
            this.disableMc.scaleX = 1 / this.scaleX;
            this.disableMc.scaleY = 1 / this.scaleY;
            this.disableMc.widthFill = Math.round(this.bgMc.width * this.scaleX) - this.disabledFillPadding.horizontal;
            this.disableMc.heightFill = Math.round(this.bgMc.height * this.scaleY) - this.disabledFillPadding.vertical;
            this.disableMc.visible = !enabled;
        }
    }

    protected function canShowTooltipByHover():Boolean {
        return true;
    }

    private function hideTooltip():void {
        if (App.toolTipMgr) {
            this._isTooltipShown = false;
            App.toolTipMgr.hide();
        }
    }

    private function initState(param1:String):void {
        if (_state == param1) {
            return;
        }
        var _loc2_:Array = _stateMap[param1];
        if (_loc2_ == null || _loc2_.length == 0) {
            return;
        }
        this.setState(param1);
    }

    override public function set visible(param1:Boolean):void {
        if (visible == param1) {
            return;
        }
        if (!param1 && !toggle) {
            this.initState(ComponentState.UP);
        }
        super.visible = param1;
    }

    public function get helpText():String {
        return this._helpText;
    }

    public function set helpText(param1:String):void {
        this._helpText = param1;
    }

    public function get helpDirection():String {
        return this._helpDirection;
    }

    public function set helpDirection(param1:String):void {
        this._helpDirection = param1;
    }

    public function get textColor():Number {
        return this._textColor;
    }

    public function set textColor(param1:Number):void {
        if (this._textColor == param1) {
            return;
        }
        this._textColor = param1;
        invalidate();
    }

    public function get tooltip():String {
        return this._tooltip;
    }

    public function set tooltip(param1:String):void {
        if (this._tooltip == param1) {
            return;
        }
        this._tooltip = param1;
        if (App.toolTipMgr && this._isTooltipShown) {
            this.hideTooltip();
        }
    }

    public function get tooltipParams():IToolTipParams {
        return this._tooltipParams;
    }

    public function set tooltipParams(param1:IToolTipParams):void {
        this._tooltipParams = param1;
    }

    public function set inspectableDisabledFillPadding(param1:Object):void {
        if (!componentInspectorSetting) {
            return;
        }
        this.disabledFillPadding = new Padding(param1.top, param1.right, param1.bottom, param1.left);
    }

    public function get disabledFillPadding():Padding {
        return this._disabledFillPadding;
    }

    public function set disabledFillPadding(param1:Padding):void {
        this._disabledFillPadding = param1;
    }

    public function get paddingHorizontal():Number {
        return this._paddingHorizontal;
    }

    public function set paddingHorizontal(param1:Number):void {
        this._paddingHorizontal = param1;
        if (autoSize != "none" && textField != null && initialized) {
            _width = width = this.calculateWidth();
        }
        this.updateAfterStateChange();
    }

    public function get minWidth():Number {
        return this._minWidth;
    }

    public function set minWidth(param1:Number):void {
        this._minWidth = param1;
        invalidateSize();
    }

    public function get dynamicSizeByText():Boolean {
        return this._dynamicSizeByText;
    }

    public function set dynamicSizeByText(param1:Boolean):void {
        this._dynamicSizeByText = param1;
    }

    public function get usePreventUpdateDisable():Boolean {
        return this._usePreventUpdateDisable;
    }

    public function set usePreventUpdateDisable(param1:Boolean):void {
        if (this._usePreventUpdateDisable != param1) {
            this._usePreventUpdateDisable = param1;
            invalidateSize();
        }
    }

    protected function onMouseDownHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    protected function onMouseRollOverHandler(param1:MouseEvent):void {
        if (this.canShowTooltipByHover()) {
            this.showTooltip();
        }
    }

    protected function onMouseRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }
}
}

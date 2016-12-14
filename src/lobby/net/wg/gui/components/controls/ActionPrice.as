package net.wg.gui.components.controls {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.constants.Errors;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.ITextContainer;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.Button;
import scaleform.clik.controls.ListItemRenderer;
import scaleform.clik.core.UIComponent;

public class ActionPrice extends UIComponentEx implements ITextContainer {

    public static const TEXT_COLOR_TYPE_ICON:String = "iconColor";

    public static const TEXT_COLOR_TYPE_DISABLE:String = "disable";

    public static const TEXT_COLOR_TYPE_ERROR:String = "error";

    public static const INVALID_POSITION:String = "invalidPosition";

    public static const ALERT_ICO_MARGIN:Number = 5;

    public static const WHITE_COLOR:Number = 16777215;

    public static const HIT_DEFAULT_X_MIN:Number = -55;

    public static const TEXT_DEFAULT_Y:int = -1;

    public static const TEXT_FIELD_LEFT_PADDING:int = -2;

    public static const TEXT_FIELD_ALERT_LEFT_PADDING:int = 1;

    public static const TEXT_FIELD_BORDERS_WIDTH:int = 3;

    private static const LEFT_LBL:String = "left";

    private static const RIGHT_LBL:String = "right";

    private static const ENABLE_ALPHA:Number = 1;

    private static const DISABLE_ALPHA:Number = 0.8;

    private static const ALERT_ICON_Y_SHIFT:int = 2;

    private static const COLOR_GOLD:uint = 16761699;

    private static const COLOR_CREDITS:uint = 13556185;

    private static const COLOR_ELITE_XP:uint = 16498786;

    private static const COLOR_FREE_XP:uint = 16498786;

    private static const COLOR_DISABLE:uint = 7435380;

    private static const COLOR_ERROR:uint = 11993088;

    public var iconText:net.wg.gui.components.controls.IconText = null;

    public var textField:TextField = null;

    public var alertIco:AlertIco = null;

    public var hitMc:Sprite = null;

    public var bg:ActionPriceBg = null;

    protected var _textFont:String = "$FieldFont";

    private var _owner:UIComponent;

    private var _alertVisibleInNextStates:Array;

    private var _defIconPos:Number = 0;

    private var _defTextFieldXPos:Number = 0;

    private var _defMarginBetweenTextAndBg:Number = 0;

    private var _defBgPos:Number = 0;

    private var _vo:ActionPriceVO = null;

    private var _textFieldYStartPos:Number = -1;

    private var _textColors:Object;

    private var _state:String = "camouflage";

    private var _iconPosition:String = "right";

    private var _tooltipEnabled:Boolean = true;

    private var _textColorType:String = "iconColor";

    private var _textSize:Number = 12;

    private var _textYOffset:Number = 0;

    public function ActionPrice() {
        this._alertVisibleInNextStates = [];
        this._textColors = {
            "error": COLOR_ERROR,
            "disable": COLOR_DISABLE
        };
        super();
        this._alertVisibleInNextStates = [ACTION_PRICE_CONSTANTS.STATE_ALIGN_MIDDLE, ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP, ACTION_PRICE_CONSTANTS.STATE_ALIGN_MIDDLE_SMALL];
    }

    override public function toString():String {
        return "[WG ActionPrice " + name + "]";
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        this.iconText.dispose();
        this.iconText = null;
        this.alertIco.dispose();
        this.alertIco = null;
        this.textField = null;
        this.hitMc = null;
        this.bg = null;
        this._owner = null;
        this._vo = null;
        this._textColors = App.utils.data.cleanupDynamicObject(this._textColors);
        this._alertVisibleInNextStates.splice(0, this._alertVisibleInNextStates.length);
        this._alertVisibleInNextStates = null;
        super.onDispose();
    }

    override protected function configUI():void {
        var _loc3_:DisplayObject = null;
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        var _loc1_:int = this.numChildren;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this.getChildAt(_loc2_);
            if (_loc3_ != this.hitMc && _loc3_ is InteractiveObject) {
                InteractiveObject(_loc3_).mouseEnabled = false;
            }
            _loc2_++;
        }
        this.hitMc.mouseEnabled = true;
        this.hitArea = this.hitMc;
        this.updateEnabledMode();
    }

    override protected function draw():void {
        if (!initialized) {
            return;
        }
        super.draw();
        if (isInvalid(InvalidationType.STATE)) {
            this.updateState();
            this.updateData();
            this.updatePositions();
        }
        if (isInvalid(InvalidationType.DATA)) {
            this.updateData();
            this.updatePositions();
        }
        if (isInvalid(INVALID_POSITION)) {
            this.updatePositions();
        }
    }

    public function getData():ActionPriceVO {
        return this._vo;
    }

    public function hideTooltip():void {
        App.toolTipMgr.hide();
    }

    public function setData(param1:ActionPriceVO):void {
        if (param1 == null) {
            this.visible = false;
            return;
        }
        if (!param1.useAction) {
            this.visible = false;
            return;
        }
        this.visible = true;
        this._vo = param1;
        if (this.visible) {
            invalidateData();
        }
    }

    public function setup(param1:UIComponent):void {
        this._owner = param1;
        this._owner.mouseChildren = true;
        if (param1 is ListItemRenderer) {
            focusable = false;
            focusTarget = param1;
        }
        this.updateEnabledMode();
    }

    public function showTooltip():void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE, null, this._vo.type, this._vo.key, this._vo.newPrices, this._vo.oldPrices, this._vo.isBuying, this._vo.forCredits, this._vo.rentPackage);
    }

    private function checkHitTest(param1:InteractiveObject):Boolean {
        var _loc3_:Point = null;
        var _loc2_:Boolean = false;
        if (param1) {
            _loc3_ = new Point(param1.mouseX, param1.mouseY);
            _loc3_ = param1.localToGlobal(_loc3_);
            _loc2_ = param1.hitTestPoint(_loc3_.x, _loc3_.y);
        }
        return _loc2_;
    }

    private function getTextColor(param1:String):uint {
        var _loc2_:uint = WHITE_COLOR;
        switch (param1) {
            case IconsTypes.GOLD:
                _loc2_ = COLOR_GOLD;
                break;
            case IconsTypes.CREDITS:
                _loc2_ = COLOR_CREDITS;
                break;
            case IconsTypes.ELITE_XP:
                _loc2_ = COLOR_ELITE_XP;
                break;
            case IconsTypes.FREE_XP:
                _loc2_ = COLOR_FREE_XP;
        }
        return _loc2_;
    }

    private function updateState():void {
        gotoAndStop(this._state);
        if (this.bg) {
            this.bg.state = this._state;
        }
        if (_baseDisposed) {
            return;
        }
        if (this._textFieldYStartPos < 0) {
            this._textFieldYStartPos = this.textField.y;
        }
        this._defMarginBetweenTextAndBg = this.bg.x - (this.textField.x + this.textField.width);
        this._defIconPos = 0;
        this._defTextFieldXPos = 0;
        this._defBgPos = 0;
        this.iconText.mouseEnabled = this.iconText.mouseChildren = false;
    }

    private function updatePositions():void {
        if (!this._vo) {
            return;
        }
        if (this._defIconPos == 0) {
            this._defIconPos = this.iconText.x;
        }
        if (this._defTextFieldXPos == 0) {
            this._defTextFieldXPos = this.textField.x;
        }
        if (this._defBgPos == 0) {
            this._defBgPos = this.bg.x;
        }
        var _loc1_:Boolean = this._vo.state == ActionPriceVO.STATE_PENALTY && this._alertVisibleInNextStates.indexOf(this._state) != -1;
        if (this._iconPosition == LEFT_LBL) {
            this.iconText.x = 0;
            this.textField.x = this.iconText.width + this._vo.valuePadding;
            this.bg.x = Math.abs(this.textField.x + this.textField.textWidth + this._defMarginBetweenTextAndBg);
            if (_loc1_) {
                this.alertIco.x = this.bg.x + ALERT_ICO_MARGIN;
            }
        }
        else if (_loc1_) {
            this.iconText.x = -this.iconText.width;
            this.textField.x = this.iconText.x - this.textField.textWidth + this._vo.valuePadding + TEXT_FIELD_ALERT_LEFT_PADDING ^ 0;
            this.alertIco.x = this.textField.x - this.alertIco.width + -ALERT_ICO_MARGIN;
        }
        else {
            this.iconText.x = this._defIconPos;
            if (this.textField.text && this.textField.text.length > 0) {
                this.textField.x = this.iconText.x - this.textField.textWidth + this._vo.valuePadding + TEXT_FIELD_LEFT_PADDING ^ 0;
            }
            this.bg.x = this._defBgPos;
        }
        this.bg.visible = !_loc1_;
        this.alertIco.visible = _loc1_;
        if (_loc1_) {
            this.alertIco.y = this.textField.y + (this.textField.textHeight - this.alertIco.height >> 1) + ALERT_ICON_Y_SHIFT;
        }
        this.updateHitArea(this._state);
    }

    private function updateData():void {
        var _loc2_:ILocale = null;
        var _loc3_:String = null;
        var _loc4_:TextFormat = null;
        if (!this._vo) {
            return;
        }
        if (this._vo.ico != "" && this.iconText) {
            this.iconText.icon = this._vo.ico;
            this.iconText.validateNow();
        }
        var _loc1_:uint = 0;
        if (this._textColorType == TEXT_COLOR_TYPE_ICON) {
            _loc1_ = this.getTextColor(this._vo.ico);
        }
        else {
            _loc1_ = this._textColors[this._textColorType];
        }
        if (this._state == ACTION_PRICE_CONSTANTS.STATE_TECH_TREE_VEHICLE || this._state == ACTION_PRICE_CONSTANTS.STATE_TECH_TREE_MODULE) {
            this.textField.text = "";
        }
        else {
            _loc2_ = App.utils.locale;
            _loc3_ = "";
            if (this._vo.useSign) {
                if (this._vo.externalSign == "") {
                    _loc3_ = this._vo.newPrice > 0 ? "+" : "";
                }
                else {
                    _loc3_ = this._vo.externalSign;
                }
            }
            this.textField.text = _loc3_ + (this._vo.ico == IconsTypes.GOLD ? _loc2_.gold(this._vo.newPrice) : _loc2_.integer(this._vo.newPrice));
            _loc4_ = this.textField.getTextFormat();
            _loc4_.font = this._textFont;
            _loc4_.size = this._textSize;
            this.textField.setTextFormat(_loc4_);
            this.textField.textColor = _loc1_;
            this.textField.width = this.textField.textWidth + TEXT_FIELD_BORDERS_WIDTH;
            if (this._textFieldYStartPos != -1) {
                this.textField.y = this._textFieldYStartPos + this.textYOffset;
            }
        }
    }

    private function updateHitArea(param1:String):void {
        if (!this.tooltipEnabled) {
            param1 = ACTION_PRICE_CONSTANTS.STATE_TECH_TREE_VEHICLE;
        }
        var _loc2_:Number = 0;
        switch (param1) {
            case ACTION_PRICE_CONSTANTS.STATE_CAMOUFLAGE:
                _loc2_ = !!this.alertIco.visible ? Number(this.alertIco.x) : Number(this.textField.x + this.textField.width - this.textField.textWidth + TEXT_FIELD_LEFT_PADDING);
                this.hitMc.x = Math.min(_loc2_, HIT_DEFAULT_X_MIN);
                this.hitMc.y = this.textField.y;
                this.hitMc.width = this.hitMc.x;
                this.hitMc.height = this.textField.textHeight;
                this.hitMc.visible = true;
                break;
            case ACTION_PRICE_CONSTANTS.STATE_ALIGN_MIDDLE:
            case ACTION_PRICE_CONSTANTS.STATE_ALIGN_MIDDLE_SMALL:
            case ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP:
                if (this._iconPosition == RIGHT_LBL) {
                    if (this.alertIco.visible) {
                        _loc2_ = this.alertIco.x;
                    }
                    else {
                        _loc2_ = this.textField.x + this.textField.width - this.textField.textWidth - TEXT_FIELD_BORDERS_WIDTH;
                    }
                }
                else {
                    _loc2_ = 0;
                }
                this.hitMc.x = _loc2_;
                this.hitMc.y = this.textField.y;
                if (this.alertIco.visible) {
                    this.hitMc.width = this._iconPosition == RIGHT_LBL ? Number(Math.abs(this.hitMc.x)) : Number(Math.abs(this.hitMc.x - this.bg.x));
                }
                else {
                    this.hitMc.width = this._iconPosition == RIGHT_LBL ? Number(Math.abs(this.hitMc.x)) : Number(Math.abs(this.bg.x));
                }
                this.hitMc.height = this.textField.textHeight + TEXT_FIELD_BORDERS_WIDTH;
                this.hitMc.visible = true;
                break;
            case ACTION_PRICE_CONSTANTS.STATE_TECH_TREE_VEHICLE:
            case ACTION_PRICE_CONSTANTS.STATE_TECH_TREE_MODULE:
                this.hitMc.x = -1;
                this.hitMc.y = 0;
                this.hitMc.width = 1;
                this.hitMc.height = 1;
                this.hitMc.visible = false;
        }
        this.updateEnabledMode();
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function updateEnabledMode():void {
        var _loc1_:Boolean = false;
        if (this._owner && this._owner.enabled && this.enabled && this._owner is Button) {
            _loc1_ = true;
        }
        useHandCursor = _loc1_;
        buttonMode = _loc1_;
        this.hitMc.buttonMode = _loc1_;
    }

    override public function set enabled(param1:Boolean):void {
        if (param1 == super.enabled) {
            return;
        }
        super.enabled = param1;
        this.alpha = !!param1 ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
        this.updateEnabledMode();
        tabEnabled = !enabled ? false : Boolean(_focusable);
        invalidateData();
    }

    public function get textFont():String {
        return this._textFont;
    }

    public function set textFont(param1:String):void {
        if (this._textFont == param1) {
            return;
        }
        this._textFont = param1;
        invalidateData();
    }

    public function get state():String {
        return this._state;
    }

    public function set state(param1:String):void {
        if (this._state == param1) {
            return;
        }
        this._state = param1;
        this._textFieldYStartPos = TEXT_DEFAULT_Y;
        invalidateState();
    }

    public function get iconPosition():String {
        return this._iconPosition;
    }

    public function set iconPosition(param1:String):void {
        if (param1 == this._iconPosition) {
            return;
        }
        this._iconPosition = param1;
        invalidate(INVALID_POSITION);
    }

    public function get tooltipEnabled():Boolean {
        return this._tooltipEnabled;
    }

    public function set tooltipEnabled(param1:Boolean):void {
        if (param1 == this._tooltipEnabled) {
            return;
        }
        this._tooltipEnabled = param1;
        invalidateData();
    }

    public function get textColorType():String {
        return this._textColorType;
    }

    public function set textColorType(param1:String):void {
        if (this._textColorType == param1) {
            return;
        }
        this._textColorType = param1;
        invalidateData();
    }

    public function get textSize():Number {
        return this._textSize;
    }

    public function set textSize(param1:Number):void {
        if (this._textSize == param1) {
            return;
        }
        this._textSize = param1;
        invalidateData();
    }

    public function get textYOffset():Number {
        return this._textYOffset;
    }

    public function set textYOffset(param1:Number):void {
        if (this._textYOffset == param1) {
            return;
        }
        this._textYOffset = param1;
        invalidateData();
    }

    public function get textAlign():String {
        return this.textField.getTextFormat().align;
    }

    public function set textAlign(param1:String):void {
        throw new AbstractException("setter CheckBox::textAlign" + Errors.ABSTRACT_INVOKE);
    }

    public function get ico():String {
        if (!this._vo) {
            return "";
        }
        return this._vo.ico;
    }

    public function set ico(param1:String):void {
        if (!this._vo || this._vo.ico == param1) {
            return;
        }
        this._vo.ico = param1;
        invalidateData();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        if (this._owner && this.checkHitTest(this._owner)) {
            this._owner.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
        }
        this.showTooltip();
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
        if (this._owner && this.checkHitTest(this._owner)) {
            this._owner.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
        }
    }

    private function onMouseDownHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }
}
}

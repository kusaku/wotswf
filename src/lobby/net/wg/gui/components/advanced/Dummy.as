package net.wg.gui.components.advanced {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.events.DummyEvent;
import net.wg.gui.components.advanced.interfaces.IDummy;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.gui.components.controls.Image;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IImage;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Constraints;
import scaleform.clik.utils.Padding;

public class Dummy extends UIComponentEx implements IDummy {

    private static const ICON_OFFSET_X:int = -5;

    private static const ICON_OFFSET_Y:int = -2;

    private static const INV_LAYOUT:String = "InvLayout";

    private static const DEFAULT_PADDING:Number = 0.25;

    private static const BUTTON_GAP:int = 13;

    public var bg:MovieClip = null;

    public var text:TextField = null;

    private var _icon:IImage = null;

    private var _button:ISoundButtonEx = null;

    private var _padding:Padding = null;

    private var _commons:ICommons = null;

    private var _data:DummyVO = null;

    private var _textFormat:TextFormat = null;

    public function Dummy() {
        super();
        this.text.multiline = true;
        this._textFormat = this.text.getTextFormat();
        this._commons = App.utils.commons;
        this._padding = new Padding(DEFAULT_PADDING);
    }

    override protected function onDispose():void {
        if (this._icon) {
            this._icon.removeEventListener(Event.CHANGE, this.onIconChangeHandler);
            removeChild(DisplayObject(this._icon));
            this._icon.dispose();
            this._icon = null;
        }
        if (this._button) {
            this._button.removeEventListener(ButtonEvent.PRESS, this.onButtonPressHandler);
            removeChild(DisplayObject(this._button));
            this._button.dispose();
            this._button = null;
        }
        this.text = null;
        this.bg = null;
        this._commons = null;
        this._padding = null;
        this._textFormat = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            this.text.htmlText = this._data.htmlText;
            this.updateIcon();
            this.updateButton();
        }
        if (isInvalid(INV_LAYOUT)) {
            this.updateLayout();
        }
        if (isInvalid(InvalidationType.SIZE)) {
            constraints.update(_width, _height);
            this.updateLayout();
        }
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(this.bg.name, this.bg, Constraints.ALL);
        initSize();
        this.bg.visible = false;
        this.text.autoSize = TextFieldAutoSize.NONE;
    }

    override protected function preInitialize():void {
        constraints = new Constraints(this, ConstrainMode.REFLOW);
    }

    private function createIcon():void {
        this._icon = new Image();
        addChild(DisplayObject(this._icon));
        this._icon.addEventListener(Event.CHANGE, this.onIconChangeHandler);
    }

    private function createButton():void {
        this._button = ISoundButtonEx(App.utils.classFactory.getComponent(Linkages.BUTTON_BLACK, ISoundButtonEx));
        addChild(DisplayObject(this._button));
        this._button.addEventListener(ButtonEvent.PRESS, this.onButtonPressHandler);
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    private function onButtonPressHandler(param1:ButtonEvent):void {
        dispatchEvent(new DummyEvent(DummyEvent.BUTTON_PRESS));
    }

    private function updateIcon():void {
        var _loc1_:Boolean = StringUtils.isNotEmpty(this._data.iconSource);
        if (_loc1_ && this._icon == null) {
            this.createIcon();
        }
        if (this._icon) {
            this._icon.visible = _loc1_;
            if (_loc1_) {
                this._icon.source = this._data.iconSource;
            }
        }
    }

    private function updateButton():void {
        var _loc1_:Boolean = this._data.btnVisible;
        if (this._button == null && _loc1_) {
            this.createButton();
        }
        if (this._button) {
            this._button.visible = _loc1_;
            if (_loc1_) {
                this._button.label = this._data.btnLabel;
                this._button.tooltip = this._data.btnTooltip;
            }
        }
    }

    private function updateLayout():void {
        if (this._data == null) {
            return;
        }
        this._textFormat.align = !!this._data.alignCenter ? TextFormatAlign.CENTER : TextFormatAlign.LEFT;
        this.text.setTextFormat(this._textFormat);
        this.text.wordWrap = false;
        var _loc1_:int = _width * (1 - this._padding.horizontal);
        if (this.text.textWidth > _loc1_) {
            this.text.wordWrap = true;
            this.text.width = _loc1_;
        }
        this._commons.updateTextFieldSize(this.text, !this.text.wordWrap, true);
        var _loc2_:int = _height * (1 - this._padding.vertical);
        if (this._data.alignCenter) {
            this.layoutCenter(_loc1_, _loc2_);
        }
        else {
            this.layoutLeft(_loc1_, _loc2_);
        }
    }

    private function layoutLeft(param1:int, param2:int):void {
        var _loc3_:int = 0;
        if (this._button) {
            _loc3_ = this._button.height + BUTTON_GAP;
        }
        var _loc4_:* = param2 - this.text.height - _loc3_ >> 1;
        this.text.x = (param1 - this.text.textWidth >> 1) + this._padding.left * _width >> 0;
        this.text.y = _loc4_ + this._padding.top * _height >> 0;
        if (this._icon) {
            this._icon.x = this.text.x - this._icon.width + ICON_OFFSET_X;
            this._icon.y = this.text.y + ICON_OFFSET_Y;
        }
        if (this._button) {
            this._button.x = this.text.x;
            this._button.y = this.text.y + this.text.height + BUTTON_GAP;
        }
    }

    private function layoutCenter(param1:int, param2:int):void {
        var _loc5_:* = 0;
        var _loc3_:int = 0;
        if (this._icon) {
            _loc3_ = this._icon.height;
        }
        var _loc4_:int = 0;
        if (this._button) {
            _loc4_ = this._button.height + BUTTON_GAP;
        }
        _loc5_ = param2 - this.text.height - _loc3_ - _loc4_ >> 1;
        this.text.x = (param1 - this.text.width >> 1) + this._padding.left * _width >> 0;
        this.text.y = _loc5_ + this._padding.top * _height + _loc3_ >> 0;
        if (this._icon) {
            this._icon.x = _width - this._icon.width >> 1;
            this._icon.y = this.text.y - this._icon.height;
        }
        if (this._button) {
            this._button.x = _width - this._button.width >> 1;
            this._button.y = this.text.y + this.text.height + BUTTON_GAP;
        }
    }

    public function get padding():Padding {
        return this._padding;
    }

    public function set padding(param1:Padding):void {
        this._padding = param1;
        invalidate(INV_LAYOUT);
    }

    private function onIconChangeHandler(param1:Event):void {
        invalidate(INV_LAYOUT);
    }

    public function setData(param1:DummyVO):void {
        this._data = param1;
        invalidateData();
        invalidate(INV_LAYOUT);
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        if (this._button) {
            _loc1_.push(this._button);
        }
        return _loc1_;
    }
}
}

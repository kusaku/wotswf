package net.wg.gui.components.advanced {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.geom.Point;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.Button;
import scaleform.clik.core.UIComponent;

public class ContentTabBar extends ButtonBarEx {

    private static const INVALID_LAYOUT:String = "invalidLayout";

    private static const INVALID_SEPARATOR_VISIBLE:String = "invalidSeparatorVisible";

    public var selectionBg:MovieClip;

    public var selectionArrow:MovieClip;

    public var lineMC:MovieClip;

    private var _textPadding:Number = 20;

    private var _minRendererWidth:Number = 40;

    private var _showSeparator:Boolean = false;

    private var _centerTabs:Boolean = true;

    private var _originalSelectionBgWidth:int = -1;

    public function ContentTabBar() {
        super();
        this.selectionBg.visible = false;
        this.selectionArrow.visible = false;
        this._originalSelectionBgWidth = this.selectionBg.width;
    }

    override protected function configUI():void {
        super.configUI();
        this.selectionBg.mouseChildren = this.selectionBg.mouseEnabled = false;
        this.selectionArrow.mouseChildren = this.selectionArrow.mouseEnabled = false;
        if (selectedIndex == -1) {
            this.selectedIndex = 0;
        }
    }

    override protected function draw():void {
        var _loc2_:int = 0;
        var _loc1_:Boolean = isInvalid(InvalidationType.RENDERERS) || isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SETTINGS) || isInvalid(InvalidationType.SIZE);
        if (_loc1_) {
            this.calculateRendererWidth();
            if (_buttonWidth > 0) {
                _loc2_ = _buttonWidth / scaleX;
                this.selectionBg.width = Math.min(this._originalSelectionBgWidth, _loc2_);
            }
            else {
                this.selectionBg.scaleX = 1 / scaleX;
            }
        }
        super.draw();
        if (isInvalid(INVALID_SEPARATOR_VISIBLE)) {
            this.lineMC.visible = this._showSeparator;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.lineMC.width = _originalWidth;
            this.selectionArrow.scaleX = 1 / scaleX;
        }
        if (_loc1_ || isInvalid(INVALID_LAYOUT)) {
            if (this._centerTabs) {
                this.doCenterTabs();
            }
            else {
                container.x = 0;
            }
            this.updateSelectionIndicator();
        }
    }

    override protected function populateRendererData(param1:Button, param2:uint):void {
        if (param1.hasOwnProperty("isFirst") && param2 == 0) {
            param1["isFirst"] = true;
        }
        if (param1.hasOwnProperty("isLast") && _dataProvider && param2 == _dataProvider.length - 1) {
            param1["isLast"] = true;
        }
        var _loc3_:Object = _dataProvider.requestItemAt(param2);
        if (_loc3_ && _loc3_.hasOwnProperty("enabled")) {
            param1.enabled = _loc3_.enabled;
        }
        super.populateRendererData(param1, param2);
    }

    override protected function updateRenderers():void {
        super.updateRenderers();
    }

    override protected function onDispose():void {
        this.lineMC = null;
        this.selectionBg = null;
        this.selectionArrow = null;
        super.onDispose();
    }

    private function doCenterTabs():void {
        container.x = _originalWidth - container.width >> 1;
    }

    private function updateSelectionIndicator():void {
        var _loc1_:UIComponent = null;
        var _loc2_:Point = null;
        var _loc3_:Point = null;
        var _loc4_:* = 0;
        if (_selectedIndex >= 0 && _renderers.length > 0) {
            _loc1_ = _renderers[_selectedIndex];
            this.selectionBg.visible = _loc1_.enabled;
            this.selectionArrow.visible = _loc1_.enabled;
            if (_loc1_.enabled) {
                this.moveItemToTop(this.selectionBg);
                this.moveItemToTop(this.selectionArrow);
                _loc2_ = _loc1_.localToGlobal(new Point(0, 0));
                _loc3_ = globalToLocal(_loc2_);
                _loc4_ = _loc3_.x + _loc1_.width * container.scaleX / 2 ^ 0;
                this.selectionBg.x = _loc4_;
                this.selectionArrow.x = _loc4_;
            }
        }
        else {
            this.selectionBg.visible = false;
            this.selectionArrow.visible = false;
        }
    }

    private function moveItemToTop(param1:DisplayObject):void {
        if (getChildIndex(param1) != numChildren - 1) {
            removeChild(param1);
            addChild(param1);
        }
    }

    private function calculateRendererWidth():void {
        var _loc1_:Button = null;
        var _loc2_:Number = 0;
        var _loc3_:uint = _dataProvider.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc1_ = Button(App.utils.classFactory.getComponent(_itemRenderer, Button));
            this.populateRendererData(_loc1_, _loc4_);
            _loc1_.validateNow();
            _loc2_ = Math.max(_loc2_, _loc1_.textField.textWidth);
            _loc1_ = null;
            _loc4_++;
        }
        _buttonWidth = _loc2_ + this._textPadding * 2 ^ 0;
        _buttonWidth = Math.max(_buttonWidth, this._minRendererWidth);
    }

    override public function set selectedIndex(param1:int):void {
        super.selectedIndex = param1;
        this.updateSelectionIndicator();
    }

    public function get textPadding():Number {
        return this._textPadding;
    }

    public function set textPadding(param1:Number):void {
        this._textPadding = param1;
        invalidate(InvalidationType.RENDERERS);
    }

    public function get minRendererWidth():Number {
        return this._minRendererWidth;
    }

    public function set minRendererWidth(param1:Number):void {
        this._minRendererWidth = param1;
        invalidate(InvalidationType.RENDERERS);
    }

    public function get showSeparator():Boolean {
        return this._showSeparator;
    }

    public function set showSeparator(param1:Boolean):void {
        this._showSeparator = param1;
        invalidate(INVALID_SEPARATOR_VISIBLE);
    }

    public function get centerTabs():Boolean {
        return this._centerTabs;
    }

    public function set centerTabs(param1:Boolean):void {
        this._centerTabs = param1;
        invalidate(INVALID_LAYOUT);
    }
}
}

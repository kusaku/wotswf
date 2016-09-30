package net.wg.gui.lobby.header.mainMenuButtonBar {
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.MainMenuButton;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.Button;
import scaleform.clik.controls.ButtonBar;
import scaleform.clik.events.InputEvent;

public class MainMenuButtonBar extends ButtonBar {

    private static const MAX_WIDTH:Number = 1024;

    private static const PREBATTLE:String = "prebattle";

    public var paddingTop:Number = 0;

    public var paddingLeft:Number = 0;

    public var paddingRight:Number = 0;

    private var _disableNav:Boolean = false;

    private var _subItemSelectedIndex:Number = -1;

    public function MainMenuButtonBar() {
        super();
        this.visible = false;
        this.selectedIndex = -1;
    }

    override protected function updateRenderers():void {
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:Button = null;
        var _loc8_:Boolean = false;
        var _loc1_:Number = this.paddingLeft + this.paddingRight;
        var _loc2_:int = -1;
        if (_renderers[0] is Class(_itemRendererClass)) {
            _loc5_ = _dataProvider.length;
            while (_renderers.length > _loc5_) {
                _loc6_ = _renderers.length - 1;
                if (container.contains(_renderers[_loc6_])) {
                    container.removeChild(_renderers[_loc6_]);
                }
                _renderers.splice(_loc6_--, 1);
            }
        }
        else {
            while (container.numChildren > 0) {
                container.removeChildAt(0);
            }
            _renderers.length = 0;
        }
        var _loc3_:uint = _dataProvider.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_ && _loc2_ == -1) {
            _loc8_ = false;
            if (_loc4_ < _renderers.length) {
                _loc7_ = _renderers[_loc4_];
            }
            else {
                _loc7_ = Button(App.utils.classFactory.getComponent(_itemRenderer, Button));
                this.setupRenderer(_loc7_, _loc4_);
                _loc8_ = true;
            }
            this.populateRendererData(_loc7_, _loc4_);
            if (_autoSize == TextFieldAutoSize.NONE && _buttonWidth > 0) {
                _loc7_.width = Math.round(_buttonWidth);
            }
            else if (_autoSize != TextFieldAutoSize.NONE) {
                _loc7_.autoSize = _autoSize;
            }
            _loc7_.validateNow();
            if (_loc1_ > MAX_WIDTH) {
                _loc7_.dispose();
                break;
            }
            if (_loc8_) {
                _loc7_.x = _loc1_ ^ 0;
                _loc7_.y = this.paddingTop ^ 0;
                _loc7_.group = _group;
                container.addChild(_loc7_);
                _renderers.push(_loc7_);
            }
            _loc1_ = _loc1_ + (_loc7_.width + spacing);
            _loc4_++;
        }
        this.updateLayout(_loc1_);
        this.selectedIndex = Math.min(_dataProvider.length - 1, _selectedIndex);
        App.tutorialMgr.dispatchEventForCustomComponent(this);
    }

    override protected function populateRendererData(param1:Button, param2:uint):void {
        param1.label = itemToLabel(_dataProvider.requestItemAt(param2));
        param1.data = _dataProvider.requestItemAt(param2);
        param1.selected = param2 == selectedIndex;
        var _loc3_:HangarMenuTabItemVO = HangarMenuTabItemVO(_dataProvider[param2]);
        param1.enabled = _loc3_.enabled;
        if (_loc3_.textColor) {
            MainMenuButton(param1).textColor = _loc3_.textColor;
        }
        if (_loc3_.textColorOver) {
            MainMenuButton(param1).textColorOver = _loc3_.textColorOver;
        }
        if (_loc3_.tooltip) {
            MainMenuButton(param1).tooltip = _loc3_.tooltip;
        }
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.RENDERERS) || isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SETTINGS) || isInvalid(InvalidationType.SIZE)) {
            this.visible = true;
            removeChild(container);
            addChild(container);
            this.updateRenderers();
        }
    }

    override protected function setupRenderer(param1:Button, param2:uint):void {
        super.setupRenderer(param1, param2);
        ISoundButtonEx(param1).mouseEnabledOnDisabled = true;
    }

    public function getButtonByValue(param1:String):Button {
        var _loc2_:FindData = this.findButtonIndex(param1);
        var _loc3_:int = _loc2_.index >= 0 ? int(_loc2_.index) : _loc2_.subIndex >= 0 ? int(_loc2_.subIndex) : -1;
        if (_loc3_ >= 0) {
            return getButtonAt(_loc3_);
        }
        return null;
    }

    public function setCurrent(param1:String):void {
        this.selectedIndex = -1;
        this.enabled = param1 != PREBATTLE;
        var _loc2_:FindData = this.findButtonIndex(param1);
        if (_loc2_.index >= 0) {
            this.selectedIndex = _loc2_.index;
        }
        else if (_loc2_.subIndex >= 0) {
            this.subItemSelectedIndex = _loc2_.subIndex;
        }
    }

    public function setDisableNav(param1:Boolean):void {
        this._disableNav = param1;
        this.enabled = !param1;
    }

    private function findButtonIndex(param1:String):FindData {
        var _loc3_:HangarMenuTabItemVO = null;
        var _loc4_:int = 0;
        var _loc5_:Array = null;
        var _loc7_:uint = 0;
        var _loc2_:int = _dataProvider.length;
        var _loc6_:uint = 0;
        while (_loc6_ < _loc2_) {
            _loc3_ = HangarMenuTabItemVO(_dataProvider[_loc6_]);
            if (param1 == _loc3_.value) {
                return new FindData(_loc6_);
            }
            if (_loc3_.subValues != null) {
                _loc5_ = _loc3_.subValues;
                _loc4_ = _loc5_.length;
                _loc7_ = 0;
                while (_loc7_ < _loc4_) {
                    if (param1 == _loc5_[_loc7_]) {
                        return new FindData(-1, _loc6_);
                    }
                    _loc7_++;
                }
            }
            _loc6_++;
        }
        return new FindData();
    }

    private function updateLayout(param1:Number):void {
        var _loc2_:Button = null;
        var _loc3_:Number = 0;
        var _loc4_:Number = this.paddingLeft;
        switch (_autoSize) {
            case TextFieldAutoSize.NONE:
            case TextFieldAutoSize.LEFT:
                _loc3_ = 0;
                break;
            case TextFieldAutoSize.CENTER:
                _loc3_ = -(param1 >> 1);
                break;
            case TextFieldAutoSize.RIGHT:
                _loc3_ = -param1;
        }
        _loc4_ = _loc4_ + _loc3_;
        var _loc5_:int = _renderers.length;
        var _loc6_:Number = 0;
        while (_loc6_ < _loc5_) {
            _loc2_ = _renderers[_loc6_];
            _loc2_.x = _loc4_ | 0;
            _loc4_ = _loc4_ + (_loc2_.width + spacing);
            _loc6_++;
        }
    }

    private function updateSubItem(param1:Number, param2:String):void {
        if (param1 >= 0) {
            MainMenuButton(_renderers[this.subItemSelectedIndex]).setExternalState(param2);
            if (param2 == Values.EMPTY_STR) {
                this._subItemSelectedIndex = -1;
            }
        }
    }

    override public function set selectedIndex(param1:int):void {
        super.selectedIndex = param1;
        this.updateSubItem(this.subItemSelectedIndex, Values.EMPTY_STR);
    }

    public function get subItemSelectedIndex():int {
        return this._subItemSelectedIndex;
    }

    public function set subItemSelectedIndex(param1:int):void {
        this.updateSubItem(this._subItemSelectedIndex, Values.EMPTY_STR);
        this._subItemSelectedIndex = param1;
        this.updateSubItem(this._subItemSelectedIndex, MainMenuButton.SUB_SELECTED);
    }

    override public function handleInput(param1:InputEvent):void {
        if (!this._disableNav) {
            super.handleInput(param1);
        }
    }
}
}

class FindData {

    private var _index:int = -1;

    private var _subIndex:int = -1;

    function FindData(param1:int = -1, param2:int = -1) {
        super();
        this._index = param1;
        this._subIndex = param2;
    }

    public function get index():int {
        return this._index;
    }

    public function get subIndex():int {
        return this._subIndex;
    }
}

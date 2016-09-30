package net.wg.gui.lobby.header.headerButtonBar {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.interfaces.IHeaderButtonContentItem;
import net.wg.gui.lobby.header.events.HeaderEvents;
import net.wg.gui.lobby.header.vo.HBC_AbstractVO;
import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
import net.wg.gui.lobby.header.vo.HeaderButtonVo;
import net.wg.infrastructure.interfaces.IClosePopoverCallback;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.helpLayout.HelpLayoutVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class HeaderButton extends SoundButtonEx implements IPopOverCaller, IClosePopoverCallback {

    private static const _ALL_HELP_LAYOUT_ITEMS:Vector.<String> = new <String>[HeaderButtonsHelper.ITEM_ID_ACCOUNT, HeaderButtonsHelper.ITEM_ID_PREM, HeaderButtonsHelper.ITEM_ID_SQUAD, HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR];

    private static const BTN_CONTENT_INVALID:String = "button_content_invalid";

    private static const BTN_DATA_INVALID:String = "button_data_invalid";

    private static const ALPHA_ENABLED:Number = 1;

    private static const ALPHA_DISABLED:Number = 0.4;

    public var separator:Sprite;

    public var container:Sprite;

    public var states:MovieClip;

    public var bounds:Sprite;

    private var _dataVo:HeaderButtonVo = null;

    private var _content:IHeaderButtonContentItem = null;

    private var _upperContent:IHeaderButtonContentItem = null;

    private var _screen:String = "";

    private var _wideScreenPrc:Number = 0;

    private var _maxScreenPrc:Number = 0;

    private var _isShowSeparator:Boolean = false;

    private var _helpLayoutId:String = "";

    public function HeaderButton() {
        super();
    }

    override public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (!this._helpLayoutId) {
            this._helpLayoutId = name + "_" + Math.random();
        }
        var _loc1_:int = 3;
        var _loc2_:int = 2;
        var _loc3_:HelpLayoutVO = new HelpLayoutVO();
        _loc3_.x = _loc1_;
        _loc3_.y = _loc2_;
        _loc3_.width = this.bounds.width - _loc1_;
        _loc3_.height = this.bounds.height - (_loc2_ << 1);
        _loc3_.extensibilityDirection = helpDirection;
        _loc3_.message = helpText;
        _loc3_.id = this._helpLayoutId;
        _loc3_.scope = this;
        return new <HelpLayoutVO>[_loc3_];
    }

    override public function gotoAndPlay(param1:Object, param2:String = null):void {
        this.states.gotoAndPlay(param1);
    }

    override public function gotoAndStop(param1:Object, param2:String = null):void {
        this.states.gotoAndStop(param1);
    }

    override public function toString():String {
        return "[WG HeaderButton " + name + "]";
    }

    override protected function configUI():void {
        constraintsDisabled = true;
        preventAutosizing = true;
        disabledFillPadding.left = 2;
        super.configUI();
    }

    override protected function initialize():void {
        super.initialize();
        _labelHash = UIComponent.generateLabelHash(this.states);
    }

    override protected function draw():void {
        if (isInvalid(BTN_DATA_INVALID)) {
            this.removeItems();
            this.addItem();
            invalidate(BTN_CONTENT_INVALID);
        }
        if (isInvalid(BTN_CONTENT_INVALID)) {
            this.updateContentData();
        }
        super.draw();
    }

    override protected function onDispose():void {
        this.removeItems();
        this._dataVo = null;
        this.separator = null;
        this.container = null;
        this.states = null;
        this.bounds = null;
        this._content = null;
        if (this._upperContent != null) {
            this._upperContent.dispose();
            this._upperContent = null;
        }
        super.onDispose();
    }

    override protected function showTooltip():void {
        switch (this._dataVo.data.tooltipType) {
            case HBC_AbstractVO.TOOLTIP_COMPLEX:
                App.toolTipMgr.showComplex(this._dataVo.data.tooltip);
                break;
            case HBC_AbstractVO.TOOLTIP_SPECIAL:
                App.toolTipMgr.showSpecial(this._dataVo.data.tooltip, null);
                break;
            default:
                super.showTooltip();
        }
    }

    override protected function updateDisable():void {
        if (disableMc != null) {
            disableMc.x = disabledFillPadding.left;
            disableMc.y = disabledFillPadding.top;
            disableMc.scaleX = 1 / this.scaleX;
            disableMc.scaleY = 1 / this.scaleY;
            disableMc.widthFill = (this.bounds.width * this.scaleX | 0) - disabledFillPadding.horizontal;
            disableMc.heightFill = (this.bounds.height * this.scaleY | 0) - disabledFillPadding.vertical;
            disableMc.visible = this.disableMcVisible;
        }
    }

    public function getHitArea():DisplayObject {
        return this;
    }

    public function getTargetButton():DisplayObject {
        return hitMc;
    }

    public function onPopoverClose():void {
        this._content.onPopoverClose();
    }

    public function onPopoverOpen():void {
        this._content.onPopoverOpen();
    }

    public function updateContentData():void {
        var _loc1_:HBC_AccountDataVo = null;
        this.helpDirection = this._dataVo.helpDirection;
        this.helpText = this._dataVo.helpText;
        this.enabled = this._dataVo.enabled;
        this._content.data = this._dataVo.data;
        if (this._upperContent != null) {
            _loc1_ = HBC_AccountDataVo(this._dataVo.data);
            if (_loc1_ != null) {
                this._upperContent.data = _loc1_;
                this._upperContent.visible = _loc1_.hasActiveBooster || _loc1_.hasAvailableBoosters;
                this._upperContent.invalidate([InvalidationType.DATA, InvalidationType.SIZE]);
            }
        }
        this.separator.visible = this.isShowSeparator;
        this.updateScreen(this._screen, this._wideScreenPrc, this._maxScreenPrc);
    }

    public function updateScreen(param1:String, param2:Number, param3:Number):void {
        if (param1 != this._screen || this._wideScreenPrc != param2 || this._maxScreenPrc != param3) {
            if (this._content != null) {
                this._screen = param1;
                this._wideScreenPrc = param2;
                this._maxScreenPrc = param3;
                this._content.updateScreen(this._screen, this._wideScreenPrc, this._maxScreenPrc);
            }
        }
    }

    private function addItem():void {
        this._content = App.utils.classFactory.getComponent(this._dataVo.linkage, IHeaderButtonContentItem);
        this._content.visible = false;
        this._content.addEventListener(HeaderEvents.HBC_SIZE_UPDATED, this.onContentUpdateHandler);
        this.container.addChild(DisplayObject(this._content));
        if (this._dataVo.upperLinkage != Values.EMPTY_STR) {
            this._upperContent = App.utils.classFactory.getComponent(this._dataVo.upperLinkage, IHeaderButtonContentItem);
            this._upperContent.visible = false;
            addChildAt(DisplayObject(this._upperContent), getChildIndex(this.states));
        }
    }

    private function removeItems():void {
        var _loc1_:IHeaderButtonContentItem = null;
        while (this.container.numChildren > 0) {
            _loc1_ = IHeaderButtonContentItem(this.container.removeChildAt(0));
            _loc1_.removeEventListener(HeaderEvents.HBC_SIZE_UPDATED, this.onContentUpdateHandler);
            if (_loc1_ is IDisposable) {
                IDisposable(_loc1_).dispose();
            }
        }
    }

    private function getContentBounds():Rectangle {
        var _loc1_:DisplayObject = DisplayObject(this._content);
        var _loc2_:Point = new Point(this.bounds.x, this.bounds.y);
        var _loc3_:Point = new Point(this.bounds.x + this.bounds.width, this.bounds.y + this.bounds.height);
        _loc2_ = localToGlobal(_loc2_);
        _loc2_ = _loc1_.globalToLocal(_loc2_);
        _loc3_ = localToGlobal(_loc3_);
        _loc3_ = _loc1_.globalToLocal(_loc3_);
        var _loc4_:Rectangle = new Rectangle(_loc2_.x, _loc2_.y, _loc3_.x - _loc2_.x, _loc3_.y - _loc2_.y);
        return _loc4_;
    }

    override public function set data(param1:Object):void {
        super.data = param1;
        var _loc2_:String = BTN_DATA_INVALID;
        if (this._dataVo != null && this._dataVo.linkage != data.linkage) {
            _loc2_ = BTN_CONTENT_INVALID;
        }
        this._dataVo = HeaderButtonVo(data);
        this._dataVo.headerButton = this;
        if (_ALL_HELP_LAYOUT_ITEMS.indexOf(this._dataVo.id) != -1) {
            App.utils.helpLayout.registerComponent(this);
        }
        else {
            App.utils.helpLayout.unregisterComponent(this);
        }
        mouseEnabledOnDisabled = this._dataVo.id == HeaderButtonsHelper.ITEM_ID_PREM;
        invalidate(_loc2_);
    }

    override public function set enabled(param1:Boolean):void {
        if (this._dataVo.id == HeaderButtonsHelper.ITEM_ID_SQUAD || this._dataVo.id == HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR) {
            this.alpha = !!param1 ? Number(ALPHA_ENABLED) : Number(ALPHA_DISABLED);
        }
        super.enabled = param1;
    }

    public function get headerButtonData():HeaderButtonVo {
        return this._dataVo;
    }

    public function get isReadyToShow():Boolean {
        return this._content != null ? Boolean(this._content.readyToShow) : false;
    }

    public function get isShowSeparator():Boolean {
        return this._isShowSeparator;
    }

    public function set isShowSeparator(param1:Boolean):void {
        if (this._isShowSeparator == param1) {
            return;
        }
        this._isShowSeparator = param1;
        isInvalid(BTN_CONTENT_INVALID);
    }

    public function get content():IHeaderButtonContentItem {
        return this._content;
    }

    private function get disableMcVisible():Boolean {
        return !enabled && this._dataVo.id != HeaderButtonsHelper.ITEM_ID_SQUAD && this._dataVo.id != HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR;
    }

    private function onContentUpdateHandler(param1:HeaderEvents):void {
        this._content.visible = true;
        this.visible = this._content.readyToShow;
        this._content.x = param1.leftPadding;
        hitMc.width = param1.contentWidth;
        this.states.width = param1.contentWidth;
        this.bounds.width = param1.contentWidth;
        this._content.updateButtonBounds(this.getContentBounds());
        if (this._upperContent != null) {
            this._upperContent.setAvailableWidth(this.bounds.width);
        }
        this.updateDisable();
        this.separator.x = this._dataVo.direction == TextFieldAutoSize.LEFT ? Number(param1.contentWidth) : Number(0);
        dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, this.bounds.width));
    }
}
}

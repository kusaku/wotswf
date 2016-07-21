package net.wg.gui.components.controls {
import fl.transitions.easing.Strong;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.VO.SeparateItem;
import net.wg.data.constants.ContextMenuConstants;
import net.wg.data.constants.Linkages;
import net.wg.gui.utils.ExcludeTweenManager;
import net.wg.infrastructure.interfaces.IContextItem;
import net.wg.infrastructure.interfaces.IContextMenu;
import net.wg.utils.IClassFactory;

import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.motion.Tween;
import scaleform.clik.utils.Padding;

public class ContextMenu extends UIComponent implements IContextMenu {

    private static const TWEEN_DURATION:Number = 200;

    public var bgMc:MovieClip;

    public var groupItemSelected:ContextMenuItem;

    public var hit:MovieClip = null;

    private var MARGIN:Number = 0;

    private var _data:Vector.<IContextItem> = null;

    private var _bgShadowBorder:Padding;

    private var _hitAreMargin:Padding;

    private var startX:Number;

    private var startY:Number;

    private var showHideSubTween:Tween;

    private var expandTween:Tween;

    private var items:Array;

    private var _memberItemData:Object;

    private var tweenManager:ExcludeTweenManager;

    private const FIRST_ELEM_TOP_PADDING:Number = 9;

    private const LAST_ELEM_BOTTOM_PADDING:Number = 9;

    private var _padding:Padding;

    private var _clickPoint:Point;

    private var _onItemSelectCallback:Function;

    private var _onReleaseOutsideCallback:Function;

    public function ContextMenu() {
        this._bgShadowBorder = new Padding(8, 37, 16, 35);
        this._hitAreMargin = new Padding(3, 3, 3, 3);
        this._memberItemData = {};
        this.tweenManager = new ExcludeTweenManager();
        this._padding = new Padding();
        super();
        this.padding = new Padding(0, 0, 0, 0);
    }

    override public function toString():String {
        return "[Wargaming ContextMenu " + name + "]";
    }

    override protected function configUI():void {
        super.configUI();
        App.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
        if (this.hit) {
            hitArea = this.hit;
        }
        if (this.bgMc) {
            this.bgMc.mouseEnabled = false;
            this.bgMc.mouseChildren = false;
            this.bgMc.tabEnabled = false;
            this.bgMc.tabChildren = false;
        }
    }

    override protected function onDispose():void {
        if (App.instance.stage.hasEventListener(MouseEvent.MOUSE_DOWN)) {
            App.instance.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
        }
        this.tweenManager.unregisterAll();
        this._onItemSelectCallback = null;
        this._onReleaseOutsideCallback = null;
        this.clearItems();
        super.onDispose();
    }

    public function build(param1:Vector.<IContextItem>, param2:Point):void {
        var _loc5_:Vector.<IContextItem> = null;
        var _loc6_:uint = 0;
        var _loc7_:uint = 0;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc10_:Number = NaN;
        var _loc11_:Number = NaN;
        var _loc12_:uint = 0;
        var _loc13_:uint = 0;
        var _loc14_:IClassFactory = null;
        var _loc15_:Number = NaN;
        var _loc16_:ContextMenuItem = null;
        var _loc17_:ContextMenuItem = null;
        var _loc18_:UIComponent = null;
        var _loc19_:ContextMenuItemSeparate = null;
        var _loc20_:IContextItem = null;
        var _loc21_:Number = NaN;
        this._clickPoint = param2;
        var _loc3_:Number = param2.x;
        var _loc4_:Number = param2.y;
        this.clearItems();
        this._data = param1;
        if (this._data) {
            _loc5_ = this._data;
            _loc8_ = this.MARGIN + this._bgShadowBorder.left;
            _loc9_ = this.MARGIN + this._bgShadowBorder.top + this.FIRST_ELEM_TOP_PADDING;
            _loc10_ = _loc8_;
            _loc11_ = _loc9_;
            _loc12_ = 0;
            _loc13_ = 0;
            this.items = [];
            _loc14_ = App.utils.classFactory;
            _loc15_ = _loc5_.length;
            _loc16_ = null;
            _loc17_ = null;
            _loc6_ = 0;
            while (_loc6_ < _loc15_) {
                _loc19_ = null;
                _loc20_ = _loc5_[_loc6_];
                if (_loc20_.id == ContextMenuConstants.SEPARATE) {
                    _loc19_ = _loc14_.getComponent(Linkages.CONTEXT_MENU_SEPARATE, ContextMenuItemSeparate);
                    _loc19_.index = _loc6_;
                    _loc19_.id = _loc20_.id;
                    _loc19_.x = _loc10_;
                    _loc19_.y = _loc11_;
                    _loc11_ = _loc11_ + (_loc19_.height + this.padding.bottom + this.padding.top);
                    this.items.push(_loc19_);
                }
                else {
                    _loc16_ = _loc14_.getComponent(Linkages.CONTEXT_MENU_ITEM, ContextMenuItem, _loc20_.initData);
                    _loc16_.index = _loc6_;
                    _loc16_.items = !!_loc5_[_loc6_].submenu ? _loc5_[_loc6_].submenu.slice(0, _loc5_[_loc6_].submenu.length) : new Vector.<IContextItem>();
                    _loc16_.addEventListener(ButtonEvent.CLICK, this.onItemClick);
                    _loc16_.id = _loc20_.id;
                    _loc16_.label = _loc20_.label;
                    _loc16_.invalidWidth();
                    _loc12_ = Math.max(_loc12_, _loc16_.width);
                    _loc16_.x = _loc10_;
                    _loc16_.y = _loc11_;
                    _loc11_ = _loc11_ + (_loc16_.height + this.padding.bottom + this.padding.top);
                    if (_loc16_.items.length > 0) {
                        _loc12_ = Math.max(_loc12_, this.createSubItems(_loc16_));
                    }
                    this.items.push(_loc16_);
                }
                this.addChild(_loc19_ != null ? _loc19_ : _loc16_);
                _loc6_++;
            }
            _loc15_ = this.items.length;
            _loc6_ = 0;
            while (_loc6_ < _loc15_) {
                _loc18_ = this.items[_loc6_];
                _loc18_.width = _loc12_;
                _loc16_ = _loc18_ as ContextMenuItem;
                if (_loc16_) {
                    _loc21_ = _loc16_.subItems.length;
                    _loc7_ = 0;
                    while (_loc7_ < _loc21_) {
                        _loc17_ = _loc16_.subItems[_loc7_];
                        _loc17_.width = _loc12_;
                        _loc7_++;
                    }
                }
                _loc6_++;
            }
            _loc13_ = _loc11_ - this.MARGIN - this.padding.bottom - this.padding.top - this._bgShadowBorder.top - this.FIRST_ELEM_TOP_PADDING;
            this.bgMc.width = _loc12_ + this.MARGIN * 2 + this._bgShadowBorder.left + this._bgShadowBorder.right ^ 0;
            this.bgMc.height = _loc13_ + this.MARGIN * 2 + this._bgShadowBorder.top + this._bgShadowBorder.bottom + this.FIRST_ELEM_TOP_PADDING + this.LAST_ELEM_BOTTOM_PADDING ^ 0;
            this.hit.x = _loc8_ - this._hitAreMargin.left;
            this.hit.y = _loc9_ - this.FIRST_ELEM_TOP_PADDING - this._hitAreMargin.top;
            this.hit.width = this.bgMc.width - (this._bgShadowBorder.horizontal + this.MARGIN * 2) + this._hitAreMargin.horizontal;
            this.updateHitHeight(this.bgMc.height);
            this.x = _loc3_ - this._bgShadowBorder.left;
            this.y = _loc4_ - this._bgShadowBorder.top;
            if (this.y + this.bgMc.height > App.instance.appHeight) {
                this.y = this.y - this.hit.height + this._hitAreMargin.vertical ^ 0;
            }
            if (this.y < 0) {
                this.y = this._bgShadowBorder.top;
            }
            if (this.x + this.bgMc.width > App.instance.appWidth) {
                this.x = this.x - this.hit.width + this._hitAreMargin.horizontal ^ 0;
            }
            if (this.x < 0) {
                this.x = this._bgShadowBorder.left;
            }
            this.startX = this.x;
            this.startY = this.y;
        }
    }

    public function setMemberItemData(param1:Object):void {
        this._memberItemData = param1;
    }

    protected function clearItems():void {
        var _loc1_:uint = 0;
        var _loc2_:uint = 0;
        if (this.items) {
            _loc1_ = 0;
            while (_loc1_ < this.items.length) {
                if (this.items[_loc1_].subItems) {
                    _loc2_ = 0;
                    while (_loc2_ < this.items[_loc1_].subItems.length) {
                        if (this.items[_loc1_].subItems[_loc2_].hasEventListener(ButtonEvent.CLICK)) {
                            this.items[_loc1_].subItems[_loc2_].removeEventListener(ButtonEvent.CLICK, this.onItemClick);
                        }
                        this.removeChild(this.items[_loc1_].subItems[_loc2_]);
                        _loc2_++;
                    }
                }
                if (this.items[_loc1_].hasEventListener(ButtonEvent.CLICK)) {
                    this.items[_loc1_].removeEventListener(ButtonEvent.CLICK, this.onItemClick);
                }
                this.removeChild(this.items[_loc1_]);
                _loc1_++;
            }
            this.items.splice();
            this.items = null;
        }
    }

    private function updateHitHeight(param1:int):void {
        this.hit.height = param1 - (this._bgShadowBorder.vertical + this.MARGIN * 2) + this._hitAreMargin.vertical;
    }

    private function createSubItems(param1:ContextMenuItem):Number {
        var _loc8_:IContextItem = null;
        var _loc9_:ContextMenuItem = null;
        var _loc2_:Number = param1.x;
        var _loc3_:Number = param1.y + param1.height + this.padding.top + this.padding.bottom - this.FIRST_ELEM_TOP_PADDING;
        var _loc4_:Number = param1.items.length;
        var _loc5_:IClassFactory = App.utils.classFactory;
        var _loc6_:Number = 0;
        var _loc7_:uint = 0;
        while (_loc7_ < _loc4_) {
            if (!(param1.items[_loc7_] is SeparateItem)) {
                _loc8_ = param1.items[_loc7_];
                _loc9_ = _loc5_.getComponent(Linkages.CONTEXT_MENU_ITEM, ContextMenuItem, _loc8_.initData);
                _loc9_.index = _loc7_;
                _loc9_.type = _loc9_.CONTEXT_MENU_ITEM_SUB;
                _loc9_.id = _loc8_.id;
                _loc9_.label = _loc8_.label;
                _loc9_.invalidWidth();
                _loc6_ = Math.max(_loc6_, _loc9_.width);
                _loc9_.addEventListener(ButtonEvent.CLICK, this.onItemClick);
                _loc9_.x = _loc2_;
                _loc9_.y = _loc3_;
                _loc3_ = _loc3_ + (_loc9_.height + this.padding.top + this.padding.bottom);
                _loc9_.visible = false;
                _loc9_.alpha = 0;
                param1.subItems.push(_loc9_);
                this.addChild(_loc9_);
            }
            _loc7_++;
        }
        return _loc6_;
    }

    private function beginAnimExpand(param1:ContextMenuItem):void {
        this.tweenManager.unregisterAll();
        if (this.groupItemSelected && this.groupItemSelected == param1) {
            if (this.groupItemSelected.isOpened) {
                this.hideSub(this.groupItemSelected);
            }
            else {
                this.showSub(this.groupItemSelected);
            }
        }
        else {
            if (this.groupItemSelected && this.groupItemSelected.isOpened) {
                this.hideSub(this.groupItemSelected);
            }
            this.groupItemSelected = param1;
            this.showSub(this.groupItemSelected);
        }
        this.expand(this.groupItemSelected);
    }

    private function expand(param1:ContextMenuItem):void {
        var _loc2_:uint = param1.index;
        var _loc3_:uint = 0;
        var _loc4_:uint = 0;
        var _loc5_:Function = Strong.easeInOut;
        var _loc6_:Number = this.MARGIN + this._bgShadowBorder.top;
        if (param1.isOpened) {
            _loc3_ = 0;
            while (_loc3_ < param1.subItems.length) {
                _loc4_ = _loc4_ + (param1.subItems[_loc3_].height + this.padding.top + this.padding.bottom);
                _loc3_++;
            }
        }
        var _loc7_:Number = 0;
        var _loc8_:Number = _loc4_;
        _loc3_ = 0;
        while (_loc3_ < this.items.length) {
            _loc8_ = _loc8_ + (this.items[_loc3_].height + this.padding.top + this.padding.bottom);
            _loc3_++;
        }
        if (this.startY + _loc8_ + this.MARGIN + this._bgShadowBorder.top + this._bgShadowBorder.bottom > App.appHeight) {
            _loc7_ = App.appHeight - (this.startY + _loc8_ + this.MARGIN + this._bgShadowBorder.top + this._bgShadowBorder.bottom);
        }
        _loc3_ = 0;
        while (_loc3_ < this.items.length) {
            this.tweenManager.registerAndLaunch(TWEEN_DURATION, this.items[_loc3_], {"y": _loc6_}, {
                "paused": false,
                "onComplete": this.onHideTweenComplete,
                "ease": _loc5_
            });
            if (_loc3_ == _loc2_) {
                _loc6_ = _loc6_ + _loc4_;
            }
            _loc6_ = _loc6_ + (this.items[_loc3_].height + this.padding.top + this.padding.bottom);
            _loc3_++;
        }
        var _loc9_:Number = _loc6_ + this.MARGIN + this._bgShadowBorder.bottom - this.padding.bottom - this.padding.top ^ 0;
        this.tweenManager.registerAndLaunch(TWEEN_DURATION, this.bgMc, {"height": _loc9_}, {
            "paused": false,
            "onComplete": this.onHideTweenComplete,
            "ease": _loc5_
        });
        this.tweenManager.registerAndLaunch(TWEEN_DURATION, this, {"y": this.startY + _loc7_}, {
            "paused": false,
            "onComplete": this.onHideTweenComplete,
            "ease": _loc5_
        });
    }

    private function showSub(param1:ContextMenuItem):void {
        var _loc3_:ContextMenuItem = null;
        param1.isOpened = true;
        var _loc2_:uint = 0;
        while (_loc2_ < param1.subItems.length) {
            _loc3_ = ContextMenuItem(param1.subItems[_loc2_]);
            _loc3_.visible = true;
            this.showHideSubTween = this.tweenManager.registerAndLaunch(TWEEN_DURATION, _loc3_, {"alpha": 1}, {
                "paused": false,
                "onComplete": this.fSubAnimComplete,
                "ease": Strong.easeIn
            });
            _loc2_++;
        }
    }

    private function hideSub(param1:ContextMenuItem):void {
        var _loc3_:ContextMenuItem = null;
        param1.isOpened = false;
        var _loc2_:uint = 0;
        while (_loc2_ < param1.subItems.length) {
            _loc3_ = ContextMenuItem(param1.subItems[_loc2_]);
            this.showHideSubTween = this.tweenManager.registerAndLaunch(TWEEN_DURATION, _loc3_, {"alpha": 0}, {
                "paused": false,
                "onComplete": this.fSubAnimComplete,
                "ease": Strong.easeOut
            });
            _loc2_++;
        }
    }

    private function onHideTweenComplete(param1:Tween):void {
        if (param1.target == this.bgMc) {
            this.updateHitHeight(this.bgMc.height);
        }
        this.tweenManager.unregister(param1);
    }

    private function fSubAnimComplete(param1:Tween):void {
        var _loc2_:ContextMenuItem = ContextMenuItem(param1.target);
        if (_loc2_.alpha == 0) {
            _loc2_.visible = false;
        }
        this.tweenManager.unregister(param1);
    }

    public function get padding():Padding {
        return this._padding;
    }

    public function set padding(param1:Padding):void {
        this._padding = new Padding(param1.top, param1.right, param1.bottom, param1.left);
    }

    public function get clickPoint():Point {
        return this._clickPoint;
    }

    public function set onItemSelectCallback(param1:Function):void {
        this._onItemSelectCallback = param1;
    }

    public function set onReleaseOutsideCallback(param1:Function):void {
        this._onReleaseOutsideCallback = param1;
    }

    private function mouseDownHandler(param1:MouseEvent):void {
        if (!this.hit.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
            if (this._onReleaseOutsideCallback != null) {
                this._onReleaseOutsideCallback();
            }
        }
    }

    private function onItemClick(param1:ButtonEvent):void {
        var _loc2_:ContextMenuItem = ContextMenuItem(param1.target);
        this.beginAnimExpand(_loc2_);
        if (_loc2_.type != _loc2_.CONTEXT_MENU_ITEM_GROUP) {
            if (this._onItemSelectCallback != null) {
                this._onItemSelectCallback(_loc2_.id);
            }
        }
    }
}
}

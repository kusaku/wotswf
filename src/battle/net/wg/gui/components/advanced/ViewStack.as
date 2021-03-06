package net.wg.gui.components.advanced {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
import net.wg.gui.events.ViewStackContentEvent;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.interfaces.IGroupedControl;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.exceptions.ArgumentException;
import net.wg.infrastructure.exceptions.InfrastructureException;
import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IAssertable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.IndexEvent;

public class ViewStack extends UIComponentEx implements ITutorialCustomComponent {

    public var cache:Boolean = false;

    public var cachedViews:Object;

    private var _container:Sprite;

    private var _targetGroup:IGroupedControl = null;

    private var _currentView:MovieClip;

    private var _currentLinkage:String;

    private var _settedLinkage:String;

    public function ViewStack() {
        App.tutorialMgr.addListenersToCustomTutorialComponent(this);
        super();
        this.cachedViews = {};
        this._container = new Sprite();
        this.addChild(this._container);
    }

    override public function isReadyForTutorialByDefault():Boolean {
        return false;
    }

    override public function toString():String {
        return "[WG ViewStack " + name + "]";
    }

    override protected function configUI():void {
        super.configUI();
        tabEnabled = false;
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = 5;
            this._container.width = this._container.height = _loc1_;
            width = _width;
            height = _height;
        }
        this._container.scaleX = 1 / scaleX;
        this._container.scaleY = 1 / scaleY;
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        var _loc2_:String = null;
        var _loc3_:int = 0;
        var _loc4_:Array = null;
        var _loc5_:* = null;
        App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
        if (this._targetGroup != null) {
            this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE, this.onChangeViewHandler);
            this._targetGroup = null;
        }
        if (this._container) {
            if (this.cache) {
                _loc4_ = [];
                for (_loc5_ in this.cachedViews) {
                    _loc4_.push(_loc5_);
                }
                for each(_loc2_ in _loc4_) {
                    if (this.cachedViews[_loc2_] is IDisposable) {
                        IDisposable(this.cachedViews[_loc2_]).dispose();
                    }
                    else {
                        this.clearSubView(this.cachedViews[_loc2_]);
                    }
                }
                App.utils.data.cleanupDynamicObject(this.cachedViews);
                this.cachedViews = null;
                _loc4_.length = 0;
                _loc4_ = null;
            }
            _loc3_ = this._container.numChildren - 1;
            while (_loc3_ >= 0) {
                _loc1_ = IDisposable(this._container.getChildAt(0));
                if (!(_loc1_ is IDAAPIEntity)) {
                    _loc1_.dispose();
                }
                _loc3_--;
            }
            removeChild(this._container);
            this._container = null;
        }
        this._currentView = null;
        super.onDispose();
    }

    public function generatedUnstoppableEvents():Boolean {
        return true;
    }

    public function getTutorialDescriptionName():String {
        return name + ":" + this._settedLinkage;
    }

    public function needPreventInnerEvents():Boolean {
        return false;
    }

    public function show(param1:String):MovieClip {
        this._settedLinkage = param1;
        var _loc2_:MovieClip = this.createView(param1);
        this.setCurrentView(_loc2_, param1, true);
        if (_loc2_ != null) {
            if (IViewStackContent(_loc2_).canShowAutomatically()) {
                _loc2_.visible = true;
            }
        }
        App.tutorialMgr.dispatchEventForCustomComponent(this);
        invalidate();
        return _loc2_;
    }

    private function assertTargetGroup(param1:String):void {
        if (!App.utils) {
            return;
        }
        var _loc2_:* = "component with instance \'" + param1 + "\'";
        var _loc3_:IAssertable = App.utils.asserter;
        _loc3_.assert(parent.hasOwnProperty(param1), "container \'" + parent + "\' has no " + _loc2_, ArgumentException);
        _loc3_.assert(parent[param1] is IGroupedControl, "container \'" + parent + "\'  must implements IGroupController interface");
    }

    private function changeView():void {
        var _loc1_:Object = null;
        var _loc2_:String = null;
        if (this._targetGroup && this._targetGroup.selectedItem != null) {
            _loc1_ = this._targetGroup.data;
            if (_loc1_ != null) {
                if (_loc1_.hasOwnProperty("linkage")) {
                    if (_loc1_.linkage != null) {
                        this.show(_loc1_.linkage);
                    }
                }
                else {
                    _loc2_ = "renderers data for View stack must have a linkage property!";
                    DebugUtils.LOG_DEBUG(_loc2_);
                }
            }
        }
    }

    private function setCurrentView(param1:MovieClip, param2:String, param3:Boolean):void {
        if (this._currentView != null) {
            if (this._currentView["__cached__"] == true) {
                this._currentView.visible = false;
                this._currentView.dispatchEvent(new ViewStackContentEvent(ViewStackContentEvent.VIEW_HIDE));
                this.callLogEvent(this._currentView, EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEWSTAK_ITEM_HIDE);
            }
            else {
                this._container.removeChild(this._currentView);
                if (param3) {
                    this.callLogEvent(this._currentView, EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEWSTAK_ITEM_HIDE);
                    if (!(param1 is IDAAPIEntity)) {
                        IDisposable(this._currentView).dispose();
                    }
                    else {
                        this.clearSubView(this._currentView);
                    }
                }
                this._currentView = null;
            }
        }
        this._currentView = param1;
        if (this._currentView != null) {
            this.callLogEvent(this._currentView, EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEWSTAK_ITEM_SHOW);
            this._currentView.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE, this.onDisposeSubViewHandler);
        }
        this._currentLinkage = param2;
        if (this._currentView && this._currentLinkage) {
            dispatchEvent(new ViewStackEvent(ViewStackEvent.VIEW_CHANGED, IViewStackContent(this._currentView), this._currentLinkage));
        }
    }

    private function createView(param1:String):UIComponent {
        var _loc2_:UIComponent = null;
        if (this.cachedViews[param1] != null) {
            _loc2_ = this.cachedViews[param1];
        }
        else {
            _loc2_ = App.utils.classFactory.getComponent(param1, IViewStackContent);
            _loc2_.visible = false;
            _loc2_.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE, this.onDisposeSubViewHandler);
            this._container.addChild(_loc2_);
            _loc2_.validateNow();
            dispatchEvent(new ViewStackEvent(ViewStackEvent.NEED_UPDATE, IViewStackContent(_loc2_), param1));
            if (_loc2_ != null && this.cache) {
                _loc2_["__cached__"] = true;
                this.cachedViews[param1] = _loc2_;
            }
        }
        return _loc2_;
    }

    private function clearSubView(param1:MovieClip):void {
        var _loc3_:* = null;
        var _loc4_:* = null;
        param1.removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE, this.onDisposeSubViewHandler);
        var _loc2_:Boolean = !this.cache || !this.cachedViews;
        if (this._container && this._container.contains(param1)) {
            this._container.removeChild(param1);
        }
        if (this._currentView == param1) {
            this.setCurrentView(null, null, false);
            _loc2_ = true;
        }
        for (_loc3_ in this.cachedViews) {
            if (this.cachedViews[_loc3_] == param1) {
                delete this.cachedViews[_loc3_];
                _loc2_ = true;
                break;
            }
        }
        _loc4_ = "View \' " + param1.name + "\'is disposed, but was not removed from viewStack \'" + name + "\'!";
        App.utils.asserter.assert(_loc2_, _loc4_, InfrastructureException);
    }

    private function callLogEvent(param1:DisplayObject, param2:String):void {
        App.eventLogManager.logUIElementViewStack(param1, param2, 0);
    }

    public function get targetGroup():String {
        return !!this._targetGroup ? this._targetGroup.name : null;
    }

    public function set targetGroup(param1:String):void {
        if (param1 != "") {
            this.assertTargetGroup(param1);
            this.groupRef = IGroupedControl(parent[param1]);
        }
    }

    public function set groupRef(param1:IGroupedControl):void {
        if (this._targetGroup != param1) {
            if (this._targetGroup != null) {
                this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE, this.onChangeViewHandler);
            }
            this._targetGroup = param1;
            if (this._targetGroup != null) {
                this._targetGroup.addEventListener(IndexEvent.INDEX_CHANGE, this.onChangeViewHandler);
                this.changeView();
            }
        }
    }

    public function get currentLinkage():String {
        return this._currentLinkage;
    }

    public function get currentView():MovieClip {
        return this._currentView;
    }

    private function onChangeViewHandler(param1:IndexEvent):void {
        this.changeView();
    }

    private function onDisposeSubViewHandler(param1:LifeCycleEvent):void {
        var _loc2_:MovieClip = MovieClip(param1.target);
        if (_loc2_) {
            this.clearSubView(_loc2_);
        }
    }
}
}

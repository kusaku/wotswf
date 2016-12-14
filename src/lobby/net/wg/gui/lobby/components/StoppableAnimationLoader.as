package net.wg.gui.lobby.components {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import net.wg.gui.lobby.components.events.StoppableAnimationLoaderEvent;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationItem;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoader;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoaderVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class StoppableAnimationLoader extends UIComponentEx implements IStoppableAnimationLoader {

    private var _backAnimation:IStoppableAnimationItem = null;

    private var _animationLoader:Loader;

    private var _playAnimation:Boolean = false;

    private var _endAnimation:Boolean = false;

    private var _data:IStoppableAnimationLoaderVO;

    public function StoppableAnimationLoader() {
        super();
    }

    override protected function onDispose():void {
        if (this._animationLoader != null) {
            this._animationLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onAnimationLoaderContentLoaderInfoCompleteHandler);
            this._animationLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onAnimationLoaderContentLoaderInfoIoErrorHandler);
            this._animationLoader.unloadAndStop(true);
            this._animationLoader = null;
        }
        this.tryClearBackAnimation();
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.loadBackAnimation();
        }
    }

    public function endAnimation():void {
        this._endAnimation = true;
        if (this._backAnimation != null) {
            this._backAnimation.endAnimation();
            dispatchEvent(new StoppableAnimationLoaderEvent(StoppableAnimationLoaderEvent.ANIMATION_END));
        }
    }

    public function playAnimation():void {
        this._playAnimation = true;
        if (this._backAnimation != null) {
            this._backAnimation.playAnimation();
            dispatchEvent(new StoppableAnimationLoaderEvent(StoppableAnimationLoaderEvent.ANIMATION_START));
        }
    }

    public function setData(param1:IStoppableAnimationLoaderVO):void {
        this._data = param1;
        invalidateData();
    }

    private function loadBackAnimation():void {
        if (this._animationLoader == null) {
            this._animationLoader = new Loader();
            this._animationLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onAnimationLoaderContentLoaderInfoCompleteHandler);
            this._animationLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onAnimationLoaderContentLoaderInfoIoErrorHandler);
        }
        else {
            this._animationLoader.unloadAndStop(true);
        }
        var _loc1_:URLRequest = new URLRequest(this._data.anmPath);
        var _loc2_:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
        this._animationLoader.load(_loc1_, _loc2_);
    }

    private function createBackAnimation():void {
        this.tryClearBackAnimation();
        this._backAnimation = App.utils.classFactory.getComponent(this._data.anmLinkage, IStoppableAnimationItem);
        this._backAnimation.setData(this._data);
        addChild(DisplayObject(this._backAnimation));
        if (this._endAnimation) {
            this._backAnimation.endAnimation();
            dispatchEvent(new StoppableAnimationLoaderEvent(StoppableAnimationLoaderEvent.ANIMATION_END));
        }
        else if (this._playAnimation) {
            this._backAnimation.playAnimation();
            dispatchEvent(new StoppableAnimationLoaderEvent(StoppableAnimationLoaderEvent.ANIMATION_START));
        }
    }

    private function tryClearBackAnimation():void {
        if (this._backAnimation != null) {
            removeChild(DisplayObject(this._backAnimation));
            this._backAnimation.dispose();
            this._backAnimation = null;
        }
    }

    private function onAnimationLoaderContentLoaderInfoCompleteHandler(param1:Event):void {
        this.createBackAnimation();
    }

    private function onAnimationLoaderContentLoaderInfoIoErrorHandler(param1:IOErrorEvent):void {
        DebugUtils.LOG_WARNING("Can\'t load animation swf: ", this._data.anmPath);
    }
}
}

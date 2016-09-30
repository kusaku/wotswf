package net.wg.gui.components.controls {
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import net.wg.data.constants.Values;
import net.wg.gui.events.UILoaderEvent;
import net.wg.infrastructure.exceptions.AssertionException;
import net.wg.infrastructure.exceptions.InfrastructureException;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.events.ComponentEvent;

public class UILoaderAlt extends MovieClip implements IDisposable {

    private static const MAX_RETRIES:int = 10;

    private static const CONTENT_TYPE_SWF:String = "application/x-shockwave-flash";

    private static const MSG_UNIQUE:String = "UIID is unique value and can not be modified.";

    public var background:Sprite = null;

    public var hideLoader:Boolean = false;

    public var enableInitCallback:Boolean = false;

    private var _loadFailed:Boolean = false;

    private var _previousContentUnloaded:Boolean = false;

    private var _loadInProgress:Boolean = false;

    private var _sizeRetries:int = 0;

    private var _width:Number = 0;

    private var _height:Number = 0;

    private var _loader:Loader = null;

    private var _invalid:Boolean = false;

    private var _uiid:uint = 4.294967295E9;

    private var _autoSize:Boolean = true;

    private var _source:String = "";

    private var _sourceAlt:String = "";

    private var _maintainAspectRatio:Boolean = true;

    public function UILoaderAlt() {
        super();
        this._width = width;
        this._height = height;
        this._loader = new Loader();
        addChild(this._loader);
        this.background.visible = false;
        scaleX = scaleY = 1;
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIoErrorHandler);
        this._loader.contentLoaderInfo.addEventListener(Event.UNLOAD, this.onLoaderUnloadHandler);
        this.hideLoader = true;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function invalidate():void {
        if (!this._invalid) {
            this._invalid = true;
            if (stage == null) {
                addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler, false, 0, true);
            }
            else {
                addEventListener(Event.ENTER_FRAME, this.onEnterFrameHandler, false, 0, true);
                addEventListener(Event.RENDER, this.onRenderHandler, false, 0, true);
                stage.invalidate();
            }
        }
        else if (stage != null) {
            stage.invalidate();
        }
    }

    public function setSourceSize(param1:Number, param2:Number):void {
        this._loader.width = param1;
        this._loader.height = param2;
        this._loader.scaleX = this._loader.scaleY = Math.min(this._height / param2, this._width / param1);
    }

    public function startLoadAlt():void {
        this.startLoad(this._sourceAlt);
    }

    public function unload():void {
        if (this._loadInProgress) {
            this._loader.close();
        }
        if (this._loader.contentLoaderInfo.contentType == CONTENT_TYPE_SWF) {
            this._loader.unloadAndStop(true);
        }
        else {
            this._loader.unload();
        }
        this._source = null;
        this._sizeRetries = 0;
    }

    protected function onDispose():void {
        if (this._loader != null) {
            this.removeLoaderListener();
            this.unload();
            removeChild(this._loader);
            this._loader = null;
        }
        if (this.background != null) {
            removeChild(this.background);
            this.background = null;
        }
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrameHandler);
        removeEventListener(Event.RENDER, this.onRenderHandler);
    }

    protected function startLoad(param1:String):void {
        this._source = param1;
        this._sizeRetries = 0;
        if (!this._previousContentUnloaded) {
            this._loader.unload();
        }
        this.toggleVisible(false);
        this._loadInProgress = true;
        this._previousContentUnloaded = false;
        var _loc2_:URLRequest = new URLRequest(param1);
        var _loc3_:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
        this._loader.scaleX = 1;
        this._loader.scaleY = 1;
        this._loader.load(_loc2_, _loc3_);
    }

    protected function loadComplete():void {
        this.toggleVisible(true);
        this.hideLoader = false;
        dispatchEvent(new UILoaderEvent(UILoaderEvent.COMPLETE));
        this._invalid = false;
    }

    private function toggleVisible(param1:Boolean):void {
        if (this.hideLoader) {
            this._loader.visible = param1;
        }
    }

    private function removeLoaderListener():void {
        this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIoErrorHandler);
        this._loader.contentLoaderInfo.removeEventListener(Event.UNLOAD, this.onLoaderUnloadHandler);
    }

    private function updateSize():void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrameHandler);
        removeEventListener(Event.RENDER, this.onRenderHandler);
        this.updateLoaderSize();
        this.loadComplete();
    }

    public function updateLoaderSize():void {
        var _loc1_:Number = NaN;
        if (this._autoSize) {
            if (this._loader.width <= 0) {
                if (this._sizeRetries < MAX_RETRIES) {
                    this._sizeRetries++;
                    this.invalidate();
                }
                else {
                    DebugUtils.LOG_DEBUG("Warning: " + this + "cannot be autoSized because content width is <= 0!");
                }
                return;
            }
            if (this._maintainAspectRatio) {
                _loc1_ = Math.min(this._height / this._loader.height, this._width / this._loader.width);
                this._loader.width = this._loader.width * _loc1_ | 0;
                this._loader.height = this._loader.height * _loc1_ | 0;
            }
            else {
                this._loader.width = this._loader.width * this._width / this._loader.width | 0;
                this._loader.height = this._loader.height * this._height / this._loader.height | 0;
            }
        }
        else {
            width = this._loader.width;
            height = this._loader.height;
            this._loader.scaleX = 1 / scaleX;
            this._loader.scaleY = 1 / scaleY;
        }
    }

    private function simpleAssert(param1:Boolean, param2:String, param3:Class = null):void {
        if (!param1) {
            if (param3 == null) {
                param3 = AssertionException;
            }
            throw new param3(param2);
        }
    }

    override public function get visible():Boolean {
        return super.visible;
    }

    override public function set visible(param1:Boolean):void {
        super.visible = param1;
        dispatchEvent(new ComponentEvent(!!param1 ? ComponentEvent.SHOW : ComponentEvent.HIDE));
    }

    public function get autoSize():Boolean {
        return this._autoSize;
    }

    public function set autoSize(param1:Boolean):void {
        this._autoSize = param1;
    }

    public function get source():String {
        return this._source;
    }

    public function set source(param1:String):void {
        this._loadFailed = false;
        if (!param1 || param1 == this._source) {
            return;
        }
        this.startLoad(param1);
    }

    public function get sourceAlt():String {
        return this._sourceAlt;
    }

    public function set sourceAlt(param1:String):void {
        if (!param1 || this._sourceAlt == param1) {
            return;
        }
        this._sourceAlt = param1;
        if (this._loadFailed) {
            this.startLoad(this._sourceAlt);
        }
    }

    public function get maintainAspectRatio():Boolean {
        return this._maintainAspectRatio;
    }

    public function set maintainAspectRatio(param1:Boolean):void {
        this._maintainAspectRatio = param1;
    }

    public function get originalWidth():Number {
        return this._width;
    }

    public function get originalHeight():Number {
        return this._height;
    }

    public function get UIID():uint {
        return this._uiid;
    }

    public function set UIID(param1:uint):void {
        if (this._uiid != Values.EMPTY_UIID) {
            this.simpleAssert(this._uiid == param1, MSG_UNIQUE, InfrastructureException);
        }
        this._uiid = param1;
    }

    private function onAddedToStageHandler(param1:Event):void {
        if (param1.type == Event.ADDED_TO_STAGE) {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler, false);
            addEventListener(Event.RENDER, this.onRenderHandler, false, 0, true);
            if (stage != null) {
                stage.invalidate();
            }
        }
    }

    private function onEnterFrameHandler(param1:Event):void {
        this.updateSize();
    }

    private function onRenderHandler(param1:Event):void {
        this.updateSize();
    }

    private function onLoaderCompleteHandler(param1:Event):void {
        if (this._loader.content is DisplayObjectContainer) {
            removeChild(this._loader);
            addChild(this._loader.content);
        }
        this._loadFailed = false;
        this._loadInProgress = false;
        this.updateSize();
    }

    private function onLoaderIoErrorHandler(param1:IOErrorEvent):void {
        if (!this._loadFailed && this._sourceAlt) {
            this._loadFailed = true;
            this.startLoad(this._sourceAlt);
        }
        else {
            dispatchEvent(new UILoaderEvent(UILoaderEvent.IOERROR));
            this._loadInProgress = false;
        }
    }

    private function onLoaderUnloadHandler(param1:Event):void {
        this._previousContentUnloaded = true;
    }
}
}

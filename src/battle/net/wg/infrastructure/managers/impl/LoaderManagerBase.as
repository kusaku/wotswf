package net.wg.infrastructure.managers.impl {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

import net.wg.data.constants.Errors;
import net.wg.data.daapi.LoadViewVO;
import net.wg.data.daapi.ViewSettingsVO;
import net.wg.infrastructure.base.meta.impl.LoaderManagerMeta;
import net.wg.infrastructure.events.LibraryLoaderEvent;
import net.wg.infrastructure.events.LoaderEvent;
import net.wg.infrastructure.interfaces.IView;
import net.wg.infrastructure.managers.ILoaderManager;

public class LoaderManagerBase extends LoaderManagerMeta implements ILoaderManager {

    private static const DEF_VIEW_NAME:String = "main";

    private static const KEY_NOT_LOADER_MESSAGE:String = "Not loader try to load swf";

    private var _librariesList:Vector.<String>;

    private var _processedCounter:int = 0;

    private var _loaders:Vector.<Loader> = null;

    private var _container:DisplayObjectContainer;

    private var loaderToInfo:Dictionary;

    private var loaderTimerValue:Number;

    private var stats:Object;

    public function LoaderManagerBase() {
        this._librariesList = Vector.<String>([]);
        this.stats = {};
        super();
        this.loaderToInfo = new Dictionary(true);
    }

    override protected function onDispose():void {
        var _loc1_:* = null;
        var _loc2_:Loader = null;
        var _loc3_:Loader = null;
        var _loc4_:StatsEntity = null;
        for (_loc1_ in this.loaderToInfo) {
            _loc2_ = _loc1_ as Loader;
            if (_loc2_) {
                _loc2_.close();
                _loc2_.contentLoaderInfo.removeEventListener(Event.INIT, this.onSWFLoaded);
                _loc2_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onSWFLoadError);
                delete this.loaderToInfo[_loc2_];
            }
            else {
                assert(false, KEY_NOT_LOADER_MESSAGE);
            }
        }
        this.loaderToInfo = null;
        for each(_loc3_ in this._loaders) {
            this.removeListeners(_loc3_.contentLoaderInfo);
            _loc3_.unloadAndStop(true);
        }
        this._loaders.splice(0, this._loaders.length);
        this._loaders = null;
        this._container = null;
        for each(_loc4_ in this.stats) {
            _loc4_.dispose();
            _loc4_ = null;
        }
        this.stats = null;
        this._librariesList = null;
        super.onDispose();
    }

    override protected function loadView(param1:LoadViewVO):void {
        var _loc3_:URLRequest = null;
        var _loc4_:Loader = null;
        var _loc5_:LoaderContext = null;
        this.loaderTimerValue = getTimer();
        param1.cached = App.cacheMgr && App.cacheMgr.isCached(param1.configVO.url);
        var _loc2_:ViewSettingsVO = param1.configVO;
        if (param1.cached) {
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADING, _loc2_, param1.name);
            App.utils.scheduler.scheduleOnNextFrame(this.onSWFCached, param1);
        }
        else {
            _loc3_ = new URLRequest(_loc2_.url);
            _loc4_ = new Loader();
            _loc5_ = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loc4_.load(_loc3_, _loc5_);
            _loc4_.contentLoaderInfo.addEventListener(Event.INIT, this.onSWFLoaded, false, 0, true);
            _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onSWFLoadError, false, 0, true);
            this.loaderToInfo[_loc4_] = param1;
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADING, _loc2_, param1.name);
        }
    }

    public function getStats():String {
        var _loc2_:StatsEntity = null;
        var _loc1_:* = "\nLoaderManager stats: ";
        for each(_loc2_ in this.stats) {
            _loc1_ = _loc1_ + ("\n\tURL:\t\t\t" + _loc2_.url);
            _loc1_ = _loc1_ + ("\n\tfrom cache:\t\t" + String(_loc2_.cached));
            _loc1_ = _loc1_ + "\n\tLoading time ";
            _loc1_ = _loc1_ + ("\n\t\taverage:\t" + String(_loc2_.loadTime));
            _loc1_ = _loc1_ + ("\n\t\tmax:\t\t" + String(_loc2_.loadTimeMax));
            _loc1_ = _loc1_ + "\n\tInit time ";
            _loc1_ = _loc1_ + ("\n\t\taverage:\t" + String(_loc2_.initTime));
            _loc1_ = _loc1_ + ("\n\t\tmax:\t\t" + String(_loc2_.initTimeMax));
            _loc1_ = _loc1_ + "\n\t- - - - - - - - - - - - - - - - - - - -";
        }
        return _loc1_;
    }

    public function initLibraries(param1:DisplayObjectContainer):void {
        this._container = param1;
        this._loaders = new Vector.<Loader>();
    }

    public function loadLibraries(param1:Vector.<String>):void {
        var _loc2_:String = null;
        var _loc3_:URLRequest = null;
        var _loc4_:Loader = null;
        var _loc5_:LoaderContext = null;
        this._librariesList = param1;
        App.utils.asserter.assertNotNull(param1, "librariesList" + Errors.CANT_NULL);
        if (param1.length) {
            _loc5_ = new LoaderContext(false, ApplicationDomain.currentDomain);
            for each(_loc2_ in param1) {
                DebugUtils.LOG_DEBUG("LibraryLoader load", _loc2_);
                _loc3_ = new URLRequest(_loc2_);
                _loc4_ = new Loader();
                _loc4_.load(_loc3_, _loc5_);
                this.addListeners(_loc4_.contentLoaderInfo);
                this._loaders.push(_loc4_);
            }
        }
    }

    public function stopLoadingByAliases(param1:Array):void {
        var _loc2_:* = undefined;
        var _loc3_:Loader = null;
        var _loc4_:LoadViewVO = null;
        var _loc5_:int = 0;
        for (_loc2_ in this.loaderToInfo) {
            _loc3_ = Loader(_loc2_);
            _loc4_ = this.loaderToInfo[_loc3_];
            _loc5_ = param1.indexOf(_loc4_.alias);
            if (_loc5_ != -1) {
                param1.splice(_loc5_, 1);
                _loc2_.contentLoaderInfo.removeEventListener(Event.INIT, this.onSWFLoaded, false);
                _loc2_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onSWFLoadError, false);
                _loc3_.unloadAndStop(true);
                _loc4_.dispose();
                delete this.loaderToInfo[_loc2_];
            }
        }
    }

    private function dispatchLoaderEvent(param1:String, param2:ViewSettingsVO, param3:String, param4:IView = null):void {
        dispatchEvent(new LoaderEvent(param1, param2, param3, param4));
    }

    private function applyViewData(param1:IView, param2:LoadViewVO, param3:Loader):void {
        param1.as_config = param2;
        param1.loader = param3;
    }

    private function removeExtraInstances(param1:Loader):void {
        var _loc4_:DisplayObject = null;
        var _loc2_:int = DisplayObjectContainer(param1.content).numChildren;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = DisplayObjectContainer(param1.content).getChildAt(_loc3_);
            if (_loc4_.name != DEF_VIEW_NAME) {
                App.utils.commons.releaseReferences(_loc4_);
            }
            _loc3_++;
        }
    }

    private function onSWFCached(param1:LoadViewVO):void {
        var config:ViewSettingsVO = null;
        var view:IView = null;
        var viewClass:Class = null;
        var data:LoadViewVO = param1;
        config = data.configVO;
        var statsEntity:StatsEntity = this.stats[config.url];
        statsEntity.loadTime = getTimer() - this.loaderTimerValue;
        statsEntity.cached = true;
        this.loaderTimerValue = getTimer();
        try {
            viewClass = App.cacheMgr.getClassDef(config.url, true);
            view = IView(new viewClass());
        }
        catch (error:*) {
            DebugUtils.LOG_ERROR("Couldn\'t initialize cached object for " + config.url + ": \n" + error.toString());
        }
        if (view) {
            this.applyViewData(view, data, null);
            statsEntity.initTime = getTimer() - this.loaderTimerValue;
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADED, null, "", view);
            viewLoadedS(data.name, view);
        }
        else {
            viewInitializationErrorS(data.alias, data.name);
        }
        data.dispose();
    }

    private function checkLoadComplete():void {
        this._processedCounter++;
        if (this._processedCounter == this._librariesList.length) {
            DebugUtils.LOG_DEBUG("Libraries loading has been completed.");
            dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LOADED_COMPLETED, null, null));
        }
    }

    private function addListeners(param1:LoaderInfo):void {
        param1.addEventListener(Event.INIT, this.onLibraryLoaded);
        param1.addEventListener(IOErrorEvent.IO_ERROR, this.onLibraryLoadError);
    }

    private function removeListeners(param1:LoaderInfo):void {
        param1.removeEventListener(Event.INIT, this.onLibraryLoaded);
        param1.removeEventListener(IOErrorEvent.IO_ERROR, this.onLibraryLoadError);
    }

    private function onSWFLoaded(param1:Event):void {
        var loader:Loader = null;
        var event:Event = param1;
        var info:LoaderInfo = LoaderInfo(event.currentTarget);
        loader = info.loader;
        info.removeEventListener(Event.INIT, this.onSWFLoaded);
        info.removeEventListener(IOErrorEvent.IO_ERROR, this.onSWFLoadError);
        var data:LoadViewVO = this.loaderToInfo[loader];
        var config:ViewSettingsVO = data.configVO;
        var alias:String = data.alias;
        this.loaderTimerValue = getTimer() - this.loaderTimerValue;
        var statsEntity:StatsEntity = this.stats[config.url];
        if (!statsEntity) {
            statsEntity = new StatsEntity(config.url);
            this.stats[config.url] = statsEntity;
        }
        statsEntity.loadTime = this.loaderTimerValue;
        this.loaderTimerValue = getTimer();
        var view:IView = loader.content as IView;
        if (!view) {
            try {
                view = IView(loader.content[DEF_VIEW_NAME]);
                this.removeExtraInstances(loader);
            }
            catch (error:*) {
                DebugUtils.LOG_ERROR("Couldn\'t initialize loaded object for " + loader.contentLoaderInfo.url + ": \n" + error.toString());
            }
        }
        data.cached = App.cacheMgr && App.cacheMgr.add(config.url, loader, App.utils.classFactory.getClass(getQualifiedClassName(view)));
        if (data.cached) {
            loader.contentLoaderInfo.removeEventListener(Event.INIT, this.onSWFLoaded);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onSWFLoadError);
        }
        if (view) {
            this.applyViewData(view, data, loader);
            statsEntity.initTime = getTimer() - this.loaderTimerValue;
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADED, null, "", view);
            viewLoadedS(data.name, view);
        }
        else {
            viewInitializationErrorS(alias, data.name);
        }
        delete this.loaderToInfo[loader];
    }

    private function onSWFLoadError(param1:IOErrorEvent):void {
        var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
        _loc2_.removeEventListener(Event.INIT, this.onSWFLoaded);
        _loc2_.removeEventListener(IOErrorEvent.IO_ERROR, this.onSWFLoadError);
        var _loc3_:Loader = _loc2_.loader;
        _loc3_.unloadAndStop();
        var _loc4_:LoadViewVO = this.loaderToInfo[_loc3_];
        viewLoadErrorS(_loc4_.alias, _loc4_.name, param1.text);
        _loc4_.dispose();
        delete this.loaderToInfo[_loc3_];
        dispatchEvent(new LoaderEvent(LoaderEvent.VIEW_LOAD_ERROR, _loc4_.configVO, _loc4_.name));
    }

    private function onLibraryLoaded(param1:Event):void {
        var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
        this.removeListeners(_loc2_);
        DebugUtils.LOG_DEBUG("Library loaded", _loc2_.url);
        _loc2_.loader.visible = false;
        this._container.addChild(_loc2_.loader);
        dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LOADED, _loc2_.loader, _loc2_.url));
        this.checkLoadComplete();
    }

    private function onLibraryLoadError(param1:IOErrorEvent):void {
        var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
        this.removeListeners(_loc2_);
        DebugUtils.LOG_DEBUG("Library load error", _loc2_.url);
        this.checkLoadComplete();
    }
}
}

class StatsEntity {

    public var url:String;

    public var cached:Boolean;

    private var _loadTime:Number = 0;

    private var _loadTimeMax:Number = 0;

    private var _initTime:Number = 0;

    private var _initTimeMax:Number = 0;

    function StatsEntity(param1:String) {
        super();
        this.url = param1;
        this.cached = false;
    }

    public function set initTime(param1:Number):void {
        this._initTimeMax = Math.max(this._initTime, param1);
        this._initTime = this._initTime > 0 ? Number(this._initTime + param1 >> 1) : Number(param1);
    }

    public function get initTime():Number {
        return this._initTime;
    }

    public function get initTimeMax():Number {
        return this._initTimeMax;
    }

    public function set loadTime(param1:Number):void {
        this._loadTimeMax = Math.max(this._loadTime, param1);
        this._loadTime = this._loadTime > 0 ? Number(this._loadTime + param1 >> 1) : Number(param1);
    }

    public function get loadTime():Number {
        return this._loadTime;
    }

    public function get loadTimeMax():Number {
        return this._loadTimeMax;
    }

    public function dispose():void {
        this.url = null;
    }
}

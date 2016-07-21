package net.wg.infrastructure.managers.impl {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.Dictionary;

import net.wg.data.VO.TutorialComponentPathVO;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.infrastructure.base.meta.impl.TutorialManagerMeta;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.events.TutorialEvent;
import net.wg.infrastructure.events.TutorialHintEvent;
import net.wg.infrastructure.interfaces.ITriggerWatcher;
import net.wg.infrastructure.interfaces.ITutorialBuilder;
import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
import net.wg.infrastructure.interfaces.IView;
import net.wg.infrastructure.managers.ITutorialManager;
import net.wg.infrastructure.managers.impl.tutorial.TriggerEvent;
import net.wg.infrastructure.managers.impl.tutorial.TriggerWatcherFactory;

import scaleform.clik.controls.Button;
import scaleform.clik.controls.ButtonBar;
import scaleform.clik.controls.CoreList;
import scaleform.clik.interfaces.IListItemRenderer;

public class TutorialManager extends TutorialManagerMeta implements ITutorialManager {

    private static const FULL_MATCH:int = 2;

    private static const PARTIAL_MATCH:int = 1;

    private static const MISMATCH:int = 0;

    private static const LINKAGE_REG_EXP:RegExp = new RegExp(/:[^\?\.]*[\.\?]/g);

    private static const CRITERIA_REG_EXP:RegExp = new RegExp(/\?%[^%]*%/);

    private static const PARAMS_REG_EXP:RegExp = new RegExp(/\?.*$/);

    private var _descriptions:Object;

    private var _ignoredInTutorialComponents:Vector.<DisplayObject>;

    private var _tutorialLinkages:Vector.<String>;

    private var _aliasToPathsList:Object;

    private var _fullPathToVO:Object;

    private var _idToVO:Object;

    private var _componentToVO:Dictionary;

    private var _pendingCriteria:Object;

    private var _criteriaHash:Object;

    private var _shownIds:Vector.<String>;

    private var _compIdToWatchers:Object;

    private var _isSystemEnabled:Object;

    public function TutorialManager() {
        this._ignoredInTutorialComponents = new Vector.<DisplayObject>();
        this._tutorialLinkages = new Vector.<String>();
        this._aliasToPathsList = {};
        this._fullPathToVO = {};
        this._idToVO = {};
        this._componentToVO = new Dictionary(true);
        this._pendingCriteria = {};
        this._criteriaHash = {};
        this._shownIds = new Vector.<String>();
        this._compIdToWatchers = {};
        super();
    }

    override protected function onDispose():void {
        var _loc3_:* = null;
        var _loc4_:* = null;
        var _loc5_:* = null;
        var _loc6_:DisplayObject = null;
        var _loc7_:Vector.<String> = null;
        var _loc8_:TutorialComponentPathVO = null;
        var _loc9_:Array = null;
        var _loc10_:Array = null;
        var _loc11_:Array = null;
        var _loc12_:Vector.<String> = null;
        var _loc13_:Vector.<DisplayObject> = null;
        App.utils.data.cleanupDynamicObject(this._descriptions);
        App.utils.data.cleanupDynamicObject(this._criteriaHash);
        this._descriptions = null;
        var _loc1_:int = this._ignoredInTutorialComponents.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc6_ = this._ignoredInTutorialComponents[_loc2_];
            this.removeListenersFromNotTutorialObject(_loc6_);
            _loc2_++;
        }
        this._ignoredInTutorialComponents.splice(0, _loc1_);
        this._tutorialLinkages.splice(0, this._tutorialLinkages.length);
        for (_loc3_ in this._aliasToPathsList) {
            _loc7_ = this._aliasToPathsList[_loc3_];
            _loc7_.splice(0, _loc7_.length);
        }
        App.utils.data.cleanupDynamicObject(this._aliasToPathsList);
        for (_loc4_ in this._fullPathToVO) {
            _loc8_ = this._fullPathToVO[_loc4_];
            _loc8_.dispose();
        }
        App.utils.data.cleanupDynamicObject(this._fullPathToVO);
        App.utils.data.cleanupDynamicObject(this._idToVO);
        for (_loc5_ in this._pendingCriteria) {
            _loc9_ = this._pendingCriteria[_loc5_];
            for each(_loc10_ in _loc9_) {
                _loc11_ = _loc10_[0];
                _loc12_ = _loc10_[1];
                _loc13_ = _loc10_[2];
                _loc11_.splice(0, _loc11_.length);
                _loc12_.splice(0, _loc12_.length);
                _loc13_.splice(0, _loc13_.length);
            }
            _loc9_.splice(0, _loc9_.length);
        }
        App.utils.data.cleanupDynamicObject(this._pendingCriteria);
        App.utils.data.cleanupDynamicObject(this._componentToVO);
        App.utils.data.cleanupDynamicObject(this._isSystemEnabled);
        App.utils.data.cleanupDynamicObject(this._compIdToWatchers);
        this._componentToVO = null;
        this._pendingCriteria = null;
        this._fullPathToVO = null;
        this._idToVO = null;
        this._ignoredInTutorialComponents = null;
        this._tutorialLinkages = null;
        this._criteriaHash = null;
        this._isSystemEnabled = null;
        this._compIdToWatchers = null;
        this._shownIds.splice(0, this._shownIds.length);
        this._shownIds = null;
        super.onDispose();
    }

    public function addListenersToCustomTutorialComponent(param1:ITutorialCustomComponent):void {
        param1.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, this.customComponentReadyForTutorialHandler);
    }

    public function as_hideHint(param1:String, param2:String):void {
        var _loc4_:int = 0;
        var _loc3_:TutorialComponentPathVO = this._idToVO[param2];
        if (_loc3_) {
            _loc4_ = this._shownIds.indexOf(param2);
            if (_loc4_ != -1) {
                this._shownIds.splice(_loc4_, 1);
            }
            dispatchEvent(new TutorialHintEvent(TutorialHintEvent.HIDE_HINT, param1));
        }
    }

    public function as_setCriteria(param1:String, param2:String, param3:Boolean = true):void {
        var _loc4_:Array = null;
        var _loc5_:Vector.<String> = null;
        var _loc6_:Vector.<DisplayObject> = null;
        var _loc7_:TutorialComponentPathVO = null;
        var _loc8_:DisplayObject = null;
        var _loc9_:Array = null;
        var _loc10_:Array = null;
        if (!param3) {
            this._criteriaHash[param1] = param2;
        }
        if (this._pendingCriteria.hasOwnProperty(param1)) {
            _loc9_ = this._pendingCriteria[param1];
            for each(_loc10_ in _loc9_) {
                _loc4_ = _loc10_[0];
                _loc5_ = _loc10_[1];
                _loc6_ = _loc10_[2];
                _loc7_ = _loc10_[3];
                if (this.isPathValid(_loc6_)) {
                    this.updatePathWithCriteria(_loc4_, param1, param2);
                    if (_loc7_.foundComponent != null) {
                        this.as_hideHint("", _loc7_.id);
                        _loc7_.foundComponent = null;
                    }
                    _loc8_ = this.checkPartialMatch(_loc4_, _loc5_, _loc6_);
                    this.processFoundComponent(_loc8_, _loc7_);
                    _loc4_.splice(0, _loc4_.length);
                    _loc5_.splice(0, _loc5_.length);
                    _loc6_.splice(0, _loc6_.length);
                }
            }
            _loc9_.splice(0, _loc9_.length);
            delete this._pendingCriteria[param1];
        }
    }

    public function as_setDescriptions(param1:Object):void {
        var _loc2_:* = null;
        this._descriptions = param1;
        for (_loc2_ in param1) {
            this._aliasToPathsList[_loc2_] = this.generateData(_loc2_, param1[_loc2_]);
        }
    }

    public function as_setSystemEnabled(param1:Boolean):void {
        this._isSystemEnabled = param1;
    }

    public function as_setTriggers(param1:String, param2:Array):void {
        var _loc3_:Vector.<ITriggerWatcher> = this._compIdToWatchers[param1];
        if (_loc3_ && _loc3_.length > 0) {
            this.cleanupTriggerWatchers(_loc3_);
        }
        if (param2 && param2.length > 0) {
            this._compIdToWatchers[param1] = this.createTriggerWatchers(param1, param2);
        }
        else {
            delete this._compIdToWatchers[param1];
        }
    }

    public function as_showHint(param1:String, param2:String, param3:Object, param4:Boolean = false):void {
        var _loc6_:DisplayObject = null;
        var _loc5_:TutorialComponentPathVO = this._idToVO[param2];
        if (_loc5_) {
            _loc6_ = _loc5_.foundComponent;
            if (_loc6_) {
                dispatchEvent(new TutorialHintEvent(TutorialHintEvent.SHOW_HINT, param1, _loc6_, param3, param4));
            }
        }
    }

    public function dispatchEventForCustomComponent(param1:ITutorialCustomComponent):void {
        var _loc2_:TutorialEvent = null;
        if (this._isSystemEnabled) {
            _loc2_ = new TutorialEvent(TutorialEvent.VIEW_READY_FOR_TUTORIAL);
            _loc2_.addPathPoint(DisplayObject(param1), param1.getTutorialDescriptionName());
            _loc2_.unstoppable = param1.generatedUnstoppableEvents();
            param1.dispatchEvent(_loc2_);
        }
    }

    public function onComponentCheckComplete(param1:String, param2:TutorialEvent):void {
        var _loc8_:DisplayObject = null;
        var _loc10_:String = null;
        var _loc11_:Array = null;
        var _loc12_:Vector.<String> = null;
        var _loc13_:Vector.<DisplayObject> = null;
        var _loc14_:int = 0;
        var _loc15_:String = null;
        var _loc16_:TutorialComponentPathVO = null;
        var _loc17_:Array = null;
        var _loc18_:Boolean = false;
        var _loc19_:int = 0;
        var _loc20_:String = null;
        var _loc3_:Vector.<String> = this._aliasToPathsList[param1];
        if (!_loc3_) {
            this.clearTutorialEvent(param2);
            return;
        }
        var _loc4_:Vector.<String> = param2.pathPointNames;
        var _loc5_:String = _loc4_.join(".*");
        var _loc6_:RegExp = new RegExp(_loc5_);
        var _loc7_:int = _loc3_.length;
        var _loc9_:int = 0;
        while (_loc9_ < _loc7_) {
            _loc10_ = _loc3_[_loc9_];
            if (_loc10_.match(_loc6_) != null) {
                if (_loc10_.indexOf(":") != -1 == (_loc5_.indexOf(":") != -1)) {
                    _loc11_ = _loc10_.split(".");
                    _loc12_ = new Vector.<String>(_loc11_.length);
                    _loc13_ = new Vector.<DisplayObject>(_loc11_.length);
                    _loc14_ = this.checkForFullMatching(_loc11_, _loc12_, _loc13_, param2);
                    _loc15_ = this.makeFullPath(param1, _loc10_);
                    _loc16_ = this._fullPathToVO[_loc15_];
                    assert(_loc16_ != null, "TutorialComponentPathVO is not found for path - " + _loc15_);
                    if (_loc14_ == FULL_MATCH) {
                        _loc8_ = DisplayObject(param2.pathPointObjects[param2.pathPointObjects.length - 1]);
                        this.processFoundComponent(_loc8_, _loc16_);
                    }
                    else if (_loc14_ == PARTIAL_MATCH) {
                        _loc15_ = this.makeFullPath(param1, _loc10_);
                        _loc16_ = this._fullPathToVO[_loc15_];
                        if (_loc16_.foundComponent != null) {
                            this.as_hideHint("", _loc16_.id);
                            _loc16_.foundComponent = null;
                        }
                        _loc17_ = _loc10_.match(CRITERIA_REG_EXP);
                        _loc18_ = false;
                        if (_loc17_ != null) {
                            _loc19_ = 0;
                            while (_loc19_ < _loc17_.length) {
                                _loc20_ = this.cutSubstitution(_loc17_[_loc19_]);
                                if (this._criteriaHash.hasOwnProperty(_loc20_)) {
                                    this.updatePathWithCriteria(_loc11_, _loc20_, this._criteriaHash[_loc20_]);
                                }
                                else {
                                    if (!this._pendingCriteria.hasOwnProperty(_loc20_)) {
                                        this._pendingCriteria[_loc20_] = [];
                                    }
                                    _loc18_ = true;
                                    this._pendingCriteria[_loc20_].push([_loc11_, _loc12_, _loc13_, _loc16_]);
                                    requestCriteriaValueS(_loc20_);
                                }
                                _loc19_++;
                            }
                        }
                        _loc8_ = this.checkPartialMatch(_loc11_, _loc12_, _loc13_);
                        if (!_loc18_) {
                            _loc11_.splice(0, _loc11_.length);
                            _loc12_.splice(0, _loc12_.length);
                            _loc13_.splice(0, _loc13_.length);
                        }
                        this.processFoundComponent(_loc8_, _loc16_);
                    }
                }
            }
            _loc9_++;
        }
        this.clearTutorialEvent(param2);
    }

    public function onComponentCreatedByLinkage(param1:DisplayObject, param2:String):void {
        if (!this.isTutorialLinkage(param2)) {
            this._ignoredInTutorialComponents.push(DisplayObject(param1));
            param1.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, this.viewReadyForTutorialHandler);
            param1.addEventListener(LifeCycleEvent.ON_DISPOSE, this.objectDisposeHandler);
        }
    }

    public function removeListenersFromCustomTutorialComponent(param1:ITutorialCustomComponent):void {
        param1.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, this.customComponentReadyForTutorialHandler);
    }

    public function setupHintBuilder(param1:IView, param2:String, param3:Object, param4:DisplayObject = null):void {
        var _loc5_:String = null;
        var _loc6_:Class = null;
        var _loc7_:* = false;
        var _loc8_:TutorialHintEvent = null;
        if (param1 != null) {
            _loc5_ = Values.EMPTY_STR;
            _loc6_ = null;
            _loc7_ = false;
            _loc8_ = new TutorialHintEvent(TutorialHintEvent.SETUP_HINT, param1.viewTutorialId, param4, param3);
            dispatchEvent(_loc8_);
            if (!_loc8_.handled) {
                if (param2 != Values.EMPTY_STR) {
                    _loc5_ = param2;
                }
                else {
                    _loc5_ = param4 == null ? Linkages.DEFAULT_OVERLAY_BUILDER_LNK : Linkages.DEFAULT_HINT_BUILDER_LNK;
                }
                _loc6_ = App.utils.classFactory.getClass(_loc5_);
                if (param4 == null) {
                    _loc7_ = new _loc6_(param1, param3) is ITutorialBuilder;
                }
                else {
                    _loc7_ = new _loc6_(param1, param3, param4) is ITutorialBuilder;
                }
                App.utils.asserter.assert(_loc7_, Errors.INVALID_TYPE + ITutorialBuilder);
            }
        }
    }

    protected function getObjectByParams(param1:DisplayObject, param2:Object):DisplayObject {
        var _loc3_:CoreList = null;
        var _loc4_:int = 0;
        var _loc5_:IListItemRenderer = null;
        var _loc6_:Object = null;
        var _loc7_:ButtonBar = null;
        var _loc8_:Button = null;
        if (param1 is CoreList) {
            _loc3_ = CoreList(param1);
            _loc4_ = 0;
            if (_loc3_.container) {
                while (_loc4_ < _loc3_.container.numChildren) {
                    if (_loc3_.container.getChildAt(_loc4_) is IListItemRenderer) {
                        _loc5_ = IListItemRenderer(_loc3_.container.getChildAt(_loc4_));
                        _loc6_ = _loc5_.getData();
                        if (this.checkForParamsMatch(_loc6_, param2)) {
                            return DisplayObject(_loc5_);
                        }
                    }
                    _loc4_++;
                }
            }
        }
        if (param1 is ButtonBar) {
            _loc7_ = ButtonBar(param1);
            if (_loc7_.container) {
                while (_loc4_ < _loc7_.container.numChildren) {
                    if (_loc7_.container.getChildAt(_loc4_) is Button) {
                        _loc8_ = Button(_loc7_.container.getChildAt(_loc4_));
                        if (this.checkForParamsMatch(_loc8_.data, param2)) {
                            return DisplayObject(_loc8_);
                        }
                    }
                    _loc4_++;
                }
            }
        }
        return null;
    }

    protected function checkForParamsMatch(param1:Object, param2:Object):Boolean {
        var _loc3_:* = null;
        for (_loc3_ in param2) {
            if (!param1.hasOwnProperty(_loc3_)) {
                return false;
            }
            if (String(param1[_loc3_]) != param2[_loc3_]) {
                return false;
            }
        }
        return true;
    }

    private function cleanupTriggerWatchers(param1:Vector.<ITriggerWatcher>):void {
        var _loc2_:ITriggerWatcher = null;
        for each(_loc2_ in param1) {
            _loc2_.dispose();
        }
        param1.splice(0, param1.length);
    }

    private function createTriggerWatchers(param1:String, param2:Array):Vector.<ITriggerWatcher> {
        var _loc3_:String = null;
        var _loc4_:ITriggerWatcher = null;
        var _loc6_:TutorialComponentPathVO = null;
        var _loc5_:Vector.<ITriggerWatcher> = new Vector.<ITriggerWatcher>();
        for each(_loc3_ in param2) {
            _loc4_ = TriggerWatcherFactory.createWatcher(param1, _loc3_, this.onTriggerActivatedHandler);
            _loc6_ = this._idToVO[param1];
            if (_loc6_ && _loc6_.foundComponent) {
                _loc4_.start(_loc6_.foundComponent);
                _loc5_.push(_loc4_);
            }
        }
        return _loc5_;
    }

    private function isPathValid(param1:Vector.<DisplayObject>):Boolean {
        var _loc4_:DisplayObject = null;
        var _loc2_:int = param1.length - 1;
        var _loc3_:int = _loc2_;
        while (_loc3_ > -1) {
            _loc4_ = param1[_loc3_];
            if (_loc4_ && _loc4_.parent == null) {
                return false;
            }
            _loc3_--;
        }
        return true;
    }

    private function updatePathWithCriteria(param1:Array, param2:String, param3:String):void {
        param2 = "%" + param2 + "%";
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            if (param1[_loc4_].indexOf(param2) != -1) {
                param1[_loc4_] = param1[_loc4_].replace(param2, param3);
                return;
            }
            _loc4_++;
        }
    }

    private function processFoundComponent(param1:DisplayObject, param2:TutorialComponentPathVO):void {
        var _loc3_:Array = null;
        if (param1) {
            param2.foundComponent = param1;
            param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE, this.onComponentDisposedHandler, false, 0, false);
            this._componentToVO[param1] = param2;
            _loc3_ = onComponentFoundS(param2.id);
            if (_loc3_ != null) {
                this.as_setTriggers(param2.id, _loc3_);
            }
        }
    }

    private function cutSubstitution(param1:String):String {
        return param1.slice(2, param1.length - 1);
    }

    private function checkPartialMatch(param1:Array, param2:Vector.<String>, param3:Vector.<DisplayObject>):DisplayObject {
        var _loc4_:int = 0;
        var _loc5_:String = null;
        var _loc7_:Boolean = false;
        var _loc8_:int = 0;
        var _loc9_:Object = null;
        var _loc10_:DisplayObject = null;
        do
        {
            _loc7_ = false;
            _loc8_ = param1.length;
            _loc4_ = 0;
            while (_loc4_ < _loc8_) {
                _loc5_ = param1[_loc4_];
                _loc9_ = this.parseParamString(_loc5_);
                if (_loc9_ != null) {
                    _loc10_ = this.getObjectByParams(param3[_loc4_], _loc9_);
                    if (_loc10_ != null) {
                        _loc7_ = true;
                        param3[_loc4_] = _loc10_;
                        param1[_loc4_] = param2[_loc4_];
                    }
                }
                _loc4_++;
            }
        }
        while (_loc7_);

        _loc4_ = 0;
        while (_loc4_ < param2.length) {
            _loc5_ = param2[_loc4_];
            if (this.isNULLString(_loc5_)) {
                _loc10_ = (param3[_loc4_ - 1] as DisplayObjectContainer).getChildByName(param1[_loc4_]);
                if (_loc10_) {
                    param2[_loc4_] = param1[_loc4_];
                    param3[_loc4_] = _loc10_;
                }
            }
            _loc4_++;
        }
        var _loc6_:Boolean = true;
        _loc4_ = 0;
        while (_loc4_ < param2.length) {
            if (param2[_loc4_] != param1[_loc4_]) {
                _loc6_ = false;
            }
            _loc4_++;
        }
        if (_loc6_) {
            _loc10_ = param3[param3.length - 1] as DisplayObject;
            if (_loc10_) {
                return _loc10_;
            }
        }
        return null;
    }

    private function isNULLString(param1:String):Boolean {
        return param1 == null || param1 == "null";
    }

    private function parseParamString(param1:String):Object {
        var _loc3_:Object = null;
        var _loc4_:String = null;
        var _loc5_:Array = null;
        var _loc6_:int = 0;
        var _loc7_:Array = null;
        var _loc2_:int = param1.search(PARAMS_REG_EXP);
        if (_loc2_ != -1) {
            _loc3_ = {};
            _loc4_ = param1.slice(_loc2_ + 1, param1.length);
            _loc5_ = _loc4_.split("&");
            _loc6_ = 0;
            while (_loc6_ < _loc5_.length) {
                _loc7_ = _loc5_[_loc6_].split("=");
                _loc3_[_loc7_[0]] = _loc7_[1];
                _loc6_++;
            }
            return _loc3_;
        }
        return null;
    }

    private function checkForFullMatching(param1:Array, param2:Vector.<String>, param3:Vector.<DisplayObject>, param4:TutorialEvent):int {
        var _loc6_:int = 0;
        var _loc9_:String = null;
        var _loc10_:int = 0;
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        var _loc13_:String = null;
        var _loc14_:DisplayObject = null;
        var _loc15_:String = null;
        var _loc5_:int = param4.pathPointNames.length;
        _loc6_ = 0;
        while (_loc6_ < _loc5_) {
            _loc9_ = param4.pathPointNames[_loc6_];
            _loc10_ = param1.indexOf(_loc9_);
            if (_loc10_ != -1) {
                param2[_loc10_] = _loc9_;
                param3[_loc10_] = param4.pathPointObjects[_loc6_];
            }
            else {
                _loc11_ = param1.length;
                _loc12_ = 0;
                while (_loc12_ < _loc11_) {
                    _loc13_ = param1[_loc12_];
                    if (_loc13_.match(new RegExp(_loc9_ + "?.*"))) {
                        param2[_loc12_] = _loc9_;
                        param3[_loc12_] = param4.pathPointObjects[_loc6_];
                        break;
                    }
                    _loc12_++;
                }
            }
            _loc6_++;
        }
        _loc5_ = param2.length - 1;
        var _loc7_:Boolean = false;
        while (this.isNULLString(param2[_loc5_])) {
            _loc5_--;
            _loc7_ = true;
        }
        if (_loc7_) {
            if (param1[_loc5_].indexOf("?") == -1) {
                return MISMATCH;
            }
        }
        _loc6_ = _loc5_;
        while (_loc6_ > -1) {
            if (this.isNULLString(param2[_loc6_])) {
                _loc14_ = DisplayObject(param3[_loc6_ + 1]);
                param3[_loc6_] = _loc14_.parent;
                param2[_loc6_] = _loc14_.parent.name;
            }
            _loc6_--;
        }
        _loc5_ = param1.length;
        var _loc8_:Boolean = false;
        _loc6_ = 0;
        while (_loc6_ < _loc5_) {
            _loc15_ = param1[_loc6_];
            if (_loc15_ != param2[_loc6_] && !this.isNULLString(param2[_loc6_])) {
                if (_loc15_.indexOf("?") == -1) {
                    return MISMATCH;
                }
                _loc8_ = true;
            }
            _loc6_++;
        }
        if (_loc8_) {
            return PARTIAL_MATCH;
        }
        return FULL_MATCH;
    }

    private function isTutorialLinkage(param1:String):Boolean {
        return this._tutorialLinkages.indexOf(param1) != -1;
    }

    private function removeListenersFromNotTutorialObject(param1:DisplayObject):void {
        param1.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL, this.viewReadyForTutorialHandler);
        param1.removeEventListener(LifeCycleEvent.ON_DISPOSE, this.objectDisposeHandler);
    }

    private function generateData(param1:String, param2:Array):Vector.<String> {
        var _loc4_:Object = null;
        var _loc5_:TutorialComponentPathVO = null;
        var _loc6_:Array = null;
        var _loc7_:uint = 0;
        var _loc8_:int = 0;
        var _loc9_:String = null;
        var _loc3_:Vector.<String> = new Vector.<String>();
        for each(_loc4_ in param2) {
            _loc5_ = new TutorialComponentPathVO(_loc4_);
            _loc3_.push(_loc5_.path);
            LINKAGE_REG_EXP.lastIndex = 0;
            _loc6_ = _loc5_.path.match(LINKAGE_REG_EXP);
            if (_loc6_) {
                _loc7_ = _loc6_.length;
                _loc8_ = 0;
                while (_loc8_ < _loc7_) {
                    _loc9_ = _loc6_[_loc8_];
                    this._tutorialLinkages.push(_loc9_.substring(1, _loc9_.length - 1));
                    _loc8_++;
                }
            }
            this._fullPathToVO[this.makeFullPath(param1, _loc5_.path)] = _loc5_;
            this._idToVO[_loc5_.id] = _loc5_;
        }
        return _loc3_;
    }

    private function makeFullPath(param1:String, param2:String):String {
        return param1 + "." + param2;
    }

    public function get isSystemEnabled():Object {
        return this._isSystemEnabled;
    }

    private function onTriggerActivatedHandler(param1:TriggerEvent):void {
        var _loc2_:ITriggerWatcher = param1.target as ITriggerWatcher;
        onTriggerActivatedS(_loc2_.componentId, _loc2_.type);
    }

    private function onComponentDisposedHandler(param1:LifeCycleEvent):void {
        var _loc3_:TutorialComponentPathVO = null;
        var _loc4_:Vector.<ITriggerWatcher> = null;
        var _loc2_:DisplayObject = param1.target as DisplayObject;
        if (_loc2_ && _loc2_ == param1.currentTarget) {
            _loc2_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE, this.onComponentDisposedHandler);
            _loc3_ = this._componentToVO[param1.target];
            _loc4_ = this._compIdToWatchers[_loc3_.id];
            if (_loc4_ && _loc4_.length > 0) {
                this.cleanupTriggerWatchers(_loc4_);
                this._compIdToWatchers[_loc3_.id] = null;
            }
            if (_loc3_) {
                _loc3_.foundComponent = null;
                delete this._componentToVO[_loc2_];
                onComponentDisposedS(_loc3_.id);
            }
        }
    }

    private function clearTutorialEvent(param1:TutorialEvent):void {
        param1.pathPointNames.splice(0, param1.pathPointNames.length);
        param1.pathPointObjects.splice(0, param1.pathPointObjects.length);
        param1.pathPointNames = null;
        param1.pathPointObjects = null;
    }

    private function viewReadyForTutorialHandler(param1:TutorialEvent):void {
        param1.stopPropagation();
    }

    private function objectDisposeHandler(param1:LifeCycleEvent):void {
        this.removeListenersFromNotTutorialObject(DisplayObject(param1.target));
        this._ignoredInTutorialComponents.splice(this._ignoredInTutorialComponents.indexOf(DisplayObject(param1.target)), 1);
    }

    private function customComponentReadyForTutorialHandler(param1:TutorialEvent):void {
        var _loc3_:ITutorialCustomComponent = null;
        var _loc2_:ITutorialCustomComponent = ITutorialCustomComponent(param1.currentTarget);
        if (param1.target != param1.currentTarget) {
            param1.addPathPoint(DisplayObject(_loc2_), _loc2_.getTutorialDescriptionName());
            if (_loc2_.needPreventInnerEvents()) {
                _loc3_ = param1.target as ITutorialCustomComponent;
                if (_loc3_ != null && _loc3_.generatedUnstoppableEvents()) {
                    return;
                }
                param1.stopImmediatePropagation();
            }
        }
    }
}
}

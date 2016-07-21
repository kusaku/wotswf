package net.wg.gui.lobby.settings {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;

import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.KeyProps;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
import net.wg.data.managers.ITooltipProps;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.windows.WindowEvent;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.interfaces.ISettingsBase;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent;
import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataIncomeVo;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.ControlsSettingsDataVo;
import net.wg.infrastructure.base.meta.ISettingsWindowMeta;
import net.wg.infrastructure.base.meta.impl.SettingsWindowMeta;
import net.wg.infrastructure.constants.WindowViewInvalidationType;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.utils.IDataUtils;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.utils.Padding;

public class SettingsWindow extends SettingsWindowMeta implements ISettingsWindowMeta {

    private static var _currentTab:Number = 0;

    private static const CONTROLS_WARNING:String = "controlsWrongNotification";

    private static const SOUND_MODE_WARNING:String = "soundModeInvalid";

    private static const MAX_RENDERER_Y_OFFSET:uint = 18;

    private static const MAX_TOOLTIP_WIDTH:uint = 3000;

    private static const WINDOW_PADDINGS:Padding = new Padding(35, 13, 19, 10);

    private static const FIELD_DATA:String = "data";

    private static const FIELD_DESCR:String = "descr";

    private static const FIELD_CURRENT:String = "current";

    private static const FIELD_DEF:String = "default";

    private static const FIELD_KEY:String = "key";

    private static const FIELD_CMD:String = "cmd";

    private static const FIELD_VALUES:String = "values";

    public var tabs:ButtonBarEx = null;

    public var tabLine:Sprite = null;

    public var view:ViewStack = null;

    public var submitBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var applyBtn:SoundButtonEx = null;

    private var _invalidTabs:Object;

    private var _settingsData:SettingsDataVo = null;

    private var _pythonSettingsData:SettingsDataVo = null;

    private var _changesData:SettingsChangesMap = null;

    private var _needToUpdateGraphicSettings:Boolean = false;

    private var _tabToSelect:int = -1;

    private var _graphicsPresetToSelect:int = -1;

    private var _settingsConfigHelper:SettingsConfigHelper;

    public function SettingsWindow() {
        this._invalidTabs = {};
        super();
        this.canDrag = false;
        this.canClose = true;
        this.canResize = false;
        this.showWindowBgForm = false;
        this.isModal = true;
        this.isCentered = true;
        this._settingsConfigHelper = SettingsConfigHelper.instance;
    }

    override public function setWindow(param1:IWindow):void {
        super.setWindow(param1);
        if (window) {
            window.title = SETTINGS.TITLE;
            window.contentPadding = WINDOW_PADDINGS;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.submitBtn.label = SETTINGS.OK_BUTTON;
        this.cancelBtn.label = SETTINGS.CANCEL_BUTTON;
        this.applyBtn.label = SETTINGS.APPLY_BUTTON;
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler, false, 0, true);
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyBtnClickHandler, false, 0, true);
        this.submitBtn.addEventListener(ButtonEvent.CLICK, this.onSubmitBtnClickHandler, false, 0, true);
        if (this.tabs != null) {
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
            this.view.addEventListener(ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
            this.view.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewViewChangedHandler);
            if (this._tabToSelect != -1) {
                this.tabs.selectedIndex = this._tabToSelect;
            }
        }
        addEventListener(SettingViewEvent.ON_CONTROL_CHANGED, this.onOnControlChangedHandler);
        addEventListener(SettingViewEvent.ON_PTT_CONTROL_CHANGED, this.onOnPttControlChangedHandler);
        addEventListener(SettingViewEvent.ON_AUTO_DETECT_QUALITY, this.onOnAutoDetectQualityHandler);
        addEventListener(SettingViewEvent.ON_VIVOX_TEST, this.onOnVivoxTestHandler);
        addEventListener(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, this.onOnUpdateCaptureDeviceHandler);
        addEventListener(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES, this.onOnTestAlternativeVoicesHandler);
        updateStage(App.appWidth, App.appHeight);
        window.addEventListener(WindowEvent.SCALE_Y_CHANGED, this.onWindowScaleYChangedHandler);
    }

    override protected function draw():void {
        super.draw();
        if (geometry && window && isInvalid(WindowViewInvalidationType.POSITION_INVALID)) {
            window.x = App.appWidth - window.getBackground().width >> 1;
            window.y = App.appHeight - window.getBackground().height >> 1;
        }
    }

    override protected function onDispose():void {
        window.removeEventListener(WindowEvent.SCALE_Y_CHANGED, this.onWindowScaleYChangedHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyBtnClickHandler);
        this.submitBtn.removeEventListener(ButtonEvent.CLICK, this.onSubmitBtnClickHandler);
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.submitBtn.dispose();
        this.submitBtn = null;
        this.tabLine = null;
        this.applyBtn.dispose();
        this.applyBtn = null;
        if (this.view) {
            this.view.removeEventListener(ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
            this.view.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewViewChangedHandler);
            this.view.dispose();
            this.view = null;
        }
        if (this.tabs != null) {
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
            this.tabs.dispose();
            this.tabs = null;
        }
        removeEventListener(SettingViewEvent.ON_PTT_CONTROL_CHANGED, this.onOnPttControlChangedHandler);
        removeEventListener(SettingViewEvent.ON_CONTROL_CHANGED, this.onOnControlChangedHandler);
        removeEventListener(SettingViewEvent.ON_AUTO_DETECT_QUALITY, this.onOnAutoDetectQualityHandler);
        removeEventListener(SettingViewEvent.ON_VIVOX_TEST, this.onOnVivoxTestHandler);
        removeEventListener(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, this.onOnUpdateCaptureDeviceHandler);
        removeEventListener(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES, this.onOnTestAlternativeVoicesHandler);
        this._changesData.clear();
        this._changesData = null;
        this._settingsConfigHelper.dispose();
        this._settingsConfigHelper = null;
        this._settingsData = null;
        this._invalidTabs = App.utils.data.cleanupDynamicObject(this._invalidTabs);
        this._invalidTabs = null;
        this._pythonSettingsData.dispose();
        this._pythonSettingsData = null;
        super.onDispose();
    }

    public function as_ConfirmationOfApplication(param1:Boolean):void {
        this.updateSettingsConfig(param1);
    }

    public function as_confirmWarningDialog(param1:Boolean, param2:String):void {
        var _loc3_:Object = null;
        var _loc4_:SettingsControlProp = null;
        var _loc5_:SoundSettings = null;
        var _loc6_:Number = NaN;
        this.updateSettingsConfig(param1);
        if (param1) {
            if (param2.indexOf(SOUND_MODE_WARNING, 0) >= 0) {
                _loc3_ = this._settingsConfigHelper.settingsData[SettingsConfigHelper.SOUND_SETTINGS];
                _loc4_ = SettingsControlProp(_loc3_[SettingsConfigHelper.ALTERNATIVE_VOICES]);
                _loc4_.current = 0;
                _loc5_ = this.getSoundSettings();
                if (_loc5_ != null && _loc5_.alternativeVoicesDropDown != null) {
                    _loc5_.alternativeVoicesDropDown.selectedIndex = 0;
                }
            }
        }
        else {
            _loc6_ = 2;
            if (param2.indexOf(CONTROLS_WARNING, 0) >= 0) {
                _loc6_ = 3;
            }
            this.tabs.selectedIndex = _loc6_;
        }
    }

    public function as_isPresetApplied():Boolean {
        var _loc2_:DropdownMenu = null;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc1_:GraphicSettings = this.getGraphicsSettings();
        if (_loc1_) {
            _loc2_ = _loc1_.graphicsQualityDropDown;
            _loc3_ = _loc2_.dataProvider.requestItemAt(_loc2_.selectedIndex)[FIELD_DATA];
            _loc4_ = _loc1_.tryFindPreset();
            if (_loc3_ == _loc4_) {
                return true;
            }
        }
        return false;
    }

    public function as_onVibroManagerConnect(param1:Boolean):void {
        SettingsControlProp(this._settingsConfigHelper.settingsData.getByKey(SettingsConfigHelper.OTHER_SETTINGS).vibroIsConnected).current = param1;
        this.updateTabs(param1);
    }

    public function as_openTab(param1:Number):void {
        this._tabToSelect = param1;
        if (initialized && param1 != -1) {
            this.tabs.selectedIndex = param1;
        }
    }

    public function as_setCaptureDevices(param1:Number, param2:Array):void {
        var _loc3_:SoundSettings = this.getSoundSettings();
        if (_loc3_ != null) {
            _loc3_.setCaptureDevices(param1, param2);
        }
    }

    public function as_setData(param1:Object):void {
        this._pythonSettingsData = new SettingsDataIncomeVo(param1);
        this.invalidateAllTabs();
        this.initializeCommonData(this._pythonSettingsData);
        App.utils.data.cleanupDynamicObject(param1);
    }

    public function as_setGraphicsPreset(param1:Number):void {
        this._graphicsPresetToSelect = param1;
        var _loc2_:GraphicSettings = this.getGraphicsSettings();
        if (_loc2_) {
            _loc2_.setPresetAfterAutoDetect(this._graphicsPresetToSelect);
            this._graphicsPresetToSelect = -1;
        }
    }

    public function as_updateVideoSettings(param1:Object):void {
        var _loc4_:uint = 0;
        var _loc5_:String = null;
        var _loc6_:SettingsControlProp = null;
        var _loc7_:SettingsControlProp = null;
        var _loc8_:* = undefined;
        var _loc9_:uint = 0;
        var _loc2_:Boolean = false;
        if (param1) {
            _loc4_ = this._settingsConfigHelper.liveUpdateVideoSettingsOrderData.length;
            _loc9_ = 0;
            while (_loc9_ < _loc4_) {
                _loc2_ = false;
                _loc5_ = this._settingsConfigHelper.liveUpdateVideoSettingsOrderData[_loc9_];
                _loc6_ = new SettingsControlProp();
                _loc8_ = param1[_loc5_];
                if (_loc8_ != null) {
                    if (_loc8_ is Boolean || _loc8_ is String || _loc8_ is Number) {
                        _loc6_.current = _loc8_;
                        _loc2_ = true;
                    }
                    else {
                        if (_loc8_.current is Object && _loc8_.current != undefined) {
                            _loc6_.current = _loc8_.real != null ? _loc8_.real : _loc8_.current;
                        }
                        if (_loc8_.options != undefined) {
                            _loc6_.options = App.utils.data.cloneObject(_loc8_.options);
                            _loc2_ = true;
                        }
                        else {
                            _loc6_.options = [];
                        }
                    }
                }
                else if (_loc5_ == SettingsConfigHelper.DYNAMIC_RENDERER) {
                    _loc7_ = this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc5_];
                    if (_loc7_ != null) {
                        _loc7_.dispose();
                    }
                    delete this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc5_];
                }
                if (_loc2_) {
                    this._settingsConfigHelper.liveUpdateVideoSettingsData[_loc5_] = _loc6_;
                }
                _loc9_++;
            }
        }
        var _loc3_:GraphicSettings = this.getGraphicsSettings();
        if (_loc3_) {
            _loc3_.updateDependentData();
            this._needToUpdateGraphicSettings = false;
        }
        else {
            this._needToUpdateGraphicSettings = true;
        }
    }

    private function getGraphicsSettings():GraphicSettings {
        return GraphicSettings(this.tryGetView(SettingsConfigHelper.GRAPHIC_SETTINGS));
    }

    private function getSoundSettings():SoundSettings {
        return SoundSettings(this.tryGetView(SettingsConfigHelper.SOUND_SETTINGS));
    }

    private function invalidateAllTabs():void {
        var _loc2_:Object = null;
        this._invalidTabs = {};
        var _loc1_:Array = this._settingsConfigHelper.tabsDataProviderWithOther;
        for each(_loc2_ in _loc1_) {
            this._invalidTabs[_loc2_.linkage] = true;
        }
    }

    private function isTabInvalid(param1:String):Boolean {
        var _loc2_:Boolean = false;
        if (this._invalidTabs.hasOwnProperty(param1) && this._invalidTabs[param1]) {
            _loc2_ = true;
        }
        return _loc2_;
    }

    private function updateTabIfNeeded(param1:String, param2:IViewStackContent):void {
        if (this.isTabInvalid(param1)) {
            param2.update({
                "id": param1,
                "data": this._settingsData[param1]
            });
            this._invalidTabs[param1] = false;
        }
    }

    private function initializeCommonData(param1:SettingsDataVo):void {
        var _loc2_:String = null;
        var _loc3_:IViewStackContent = null;
        this._settingsData = this.normalize(param1);
        this._changesData = new SettingsChangesMap();
        this.updateApplyBtnState();
        if (this.tabs != null) {
            this.updateTabs(SettingsControlProp(this._settingsData[SettingsConfigHelper.OTHER_SETTINGS].vibroIsConnected).current);
            _loc2_ = this._settingsConfigHelper.tabsDataProviderWithOther[_currentTab].linkage;
            this.view.show(_loc2_);
            _loc3_ = IViewStackContent(this.view.currentView);
            _loc3_.update({
                "id": _loc2_,
                "data": this._settingsData[_loc2_]
            });
            this.tabs.validateNow();
        }
    }

    private function updateTabs(param1:Boolean):void {
        var _loc3_:uint = 0;
        var _loc2_:DataProvider = new DataProvider(!!param1 ? this._settingsConfigHelper.tabsDataProviderWithOther : this._settingsConfigHelper.tabsDataProvider);
        this.tabs.dataProvider = _loc2_;
        if (this.tabs.selectedIndex == -1) {
            _loc3_ = _loc2_.length;
            if (_currentTab >= _loc3_) {
                this.tabs.selectedIndex = _loc3_ - 1;
            }
            else {
                this.tabs.selectedIndex = _currentTab;
            }
        }
    }

    private function controlDefValEqNewVal(param1:*, param2:*):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Array = null;
        var _loc5_:Object = null;
        var _loc6_:* = null;
        if (param1 is SettingsControlProp) {
            _loc3_ = param2 as Array;
            if (_loc3_) {
                _loc4_ = SettingsControlProp(param1).current as Array;
                return _loc4_ != null ? _loc4_.join() == _loc3_.join() : false;
            }
            return SettingsControlProp(param1).current == param2;
        }
        if (param1 is SettingsKeyProp) {
            return SettingsKeyProp(param1).key == param2;
        }
        if (!(param2 is String) && !(param2 is Number) && !(param2 is Boolean)) {
            for (_loc6_ in param2) {
                _loc5_ = param1.getByKey(_loc6_);
                if (_loc5_ != null) {
                    if (_loc5_ is SettingsControlProp) {
                        return SettingsControlProp(_loc5_).current == param2[_loc6_];
                    }
                    if (_loc5_ is SettingsKeyProp) {
                        return SettingsKeyProp(_loc5_).key == param2[_loc6_];
                    }
                    return this.controlDefValEqNewVal(_loc5_, param2[_loc6_]);
                }
            }
        }
        return false;
    }

    private function checkChanges(param1:Boolean, param2:String, param3:*):void {
        if (param1) {
            this._changesData.tryCutChanges(param2, param3);
        }
        else {
            this._changesData.tryAddChanges(param2, param3);
        }
        this.updateApplyBtnState();
    }

    private function updateApplyBtnState():void {
        this.applyBtn.enabled = this._changesData && this._changesData.length > 0;
    }

    private function tryGetView(param1:String):MovieClip {
        if (!this.view) {
            return null;
        }
        return this.view.cachedViews[param1];
    }

    private function normalize(param1:SettingsDataVo):SettingsDataVo {
        var _loc7_:SettingsControlProp = null;
        var _loc8_:SettingsKeyProp = null;
        var _loc2_:SettingsDataVo = this._settingsConfigHelper.settingsData;
        var _loc3_:Vector.<String> = param1.keys;
        var _loc4_:Vector.<Object> = param1.values;
        var _loc5_:int = _loc3_.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            if (_loc4_[_loc6_] != undefined) {
                this.normalizeInside(SettingsDataVo(_loc4_[_loc6_]), _loc2_[_loc3_[_loc6_]]);
            }
            _loc6_++;
        }
        if (_loc2_[SettingsConfigHelper.SOUND_SETTINGS][SettingsConfigHelper.PTT] && _loc2_[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD].getByKey(SettingsConfigHelper.PUSH_TO_TALK)) {
            _loc7_ = SettingsControlProp(_loc2_[SettingsConfigHelper.SOUND_SETTINGS][SettingsConfigHelper.PTT]);
            _loc8_ = SettingsKeyProp(_loc2_[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD].getByKey(SettingsConfigHelper.PUSH_TO_TALK));
            _loc7_.current = _loc8_.key;
        }
        SettingsControlProp(_loc2_[SettingsConfigHelper.GAME_SETTINGS][SettingsConfigHelper.ENABLE_OL_FILTER]).readOnly = App.globalVarsMgr.isChinaS();
        return _loc2_;
    }

    private function normalizeInside(param1:SettingsDataVo, param2:SettingsDataVo):void {
        var _loc7_:int = 0;
        var _loc9_:Array = null;
        var _loc10_:int = 0;
        var _loc11_:* = null;
        var _loc3_:int = param1.keys.length;
        var _loc4_:String = Values.EMPTY_STR;
        var _loc5_:* = null;
        var _loc6_:int = 0;
        var _loc8_:IDataUtils = App.utils.data;
        _loc6_ = 0;
        while (_loc6_ < _loc3_) {
            _loc4_ = param1.keys[_loc6_];
            _loc5_ = param1.values[_loc6_];
            if (_loc5_ != undefined) {
                switch (_loc4_) {
                    case SettingsConfigHelper.PRESETS:
                        param2[_loc4_] = new SettingsDataVo(_loc8_.cloneObject(_loc5_));
                        break;
                    case SettingsConfigHelper.QUALITY_ORDER:
                        if (_loc5_ is Array) {
                            _loc7_ = _loc5_.length;
                            _loc10_ = 0;
                            while (_loc10_ < _loc7_) {
                                param2[_loc4_].push(_loc5_[_loc10_]);
                                _loc10_++;
                            }
                        }
                        break;
                    case SettingsConfigHelper.COLOR_FILTER_IMAGES:
                        _loc9_ = [];
                        for (_loc11_ in _loc5_) {
                            _loc9_[int(_loc11_)] = _loc5_[_loc11_];
                        }
                        param2[_loc4_] = Vector.<String>(_loc9_);
                        break;
                    case SettingsConfigHelper.KEYBOARD_IMPORTANT_BINDS:
                        param2[_loc4_] = Vector.<String>(_loc5_);
                        break;
                    case SettingsConfigHelper.KEYBOARD:
                        this.normalizeKeys(_loc5_, _loc5_[SettingsConfigHelper.KEYS_LAYOUT], param2[_loc4_], param2[SettingsConfigHelper.KEYS_LAYOUT_ORDER]);
                        break;
                    default:
                        this.normalizeDefault(param2, _loc4_, _loc5_);
                }
            }
            _loc6_++;
        }
    }

    private function normalizeDefault(param1:SettingsDataVo, param2:String, param3:*):void {
        var _loc6_:* = null;
        var _loc7_:SettingsDataVo = null;
        var _loc4_:IDataUtils = App.utils.data;
        var _loc5_:SettingsControlProp = param1[param2] as SettingsControlProp;
        if (_loc5_) {
            if (param3 is Boolean || param3 is String || param3 is Number) {
                _loc5_.current = _loc5_.type == SettingsConfigHelper.TYPE_CHECKBOX ? Boolean(param3) : param3;
                _loc5_.prevVal = _loc5_.current;
            }
            else if (param3 is Array) {
                if (_loc5_.type == SettingsConfigHelper.TYPE_RANGE_SLIDER) {
                    _loc5_.current = param3;
                }
            }
            else if (param3 is Object && param3.current != undefined) {
                if (_loc5_.type == SettingsConfigHelper.TYPE_CHECKBOX) {
                    _loc5_.current = Boolean(param3.current);
                    _loc5_.prevVal = _loc5_.current;
                    if (param1 is ControlsSettingsDataVo) {
                        this.tryToSetDefault(param3, _loc5_);
                    }
                    if (param3.hasOwnProperty(SettingsControlProp.OPTIONS_LBL)) {
                        _loc5_.options = _loc4_.cloneObject(param3.options);
                        for (_loc6_ in param3.options) {
                            if (param3.options[_loc6_].hasOwnProperty(SettingsControlProp.ADVANCED_LBL) && param3.options[_loc6_].advanced == true) {
                                _loc5_.advanced = true;
                                break;
                            }
                        }
                    }
                    if (param3.hasOwnProperty(SettingsControlProp.EXTRA_DATA_LBL)) {
                        _loc5_.extraData = _loc4_.cloneObject(param3.extraData);
                    }
                }
                else {
                    _loc5_.current = Math.max(param3.current, 0);
                    _loc5_.prevVal = _loc5_.current;
                    if (param1 is ControlsSettingsDataVo) {
                        this.tryToSetDefault(param3, _loc5_);
                    }
                    if (param3.options != undefined) {
                        _loc5_.options = _loc4_.cloneObject(param3.options);
                    }
                    else {
                        _loc5_.options = [];
                    }
                }
            }
        }
        else if (param1[param2] != undefined) {
            _loc7_ = new SettingsDataVo(param3);
            App.utils.data.cleanupDynamicObject(param3);
            this.normalizeInside(_loc7_, param1[param2]);
            _loc7_.dispose();
        }
    }

    private function tryToSetDefault(param1:*, param2:SettingsControlProp):void {
        var _loc3_:Boolean = false;
        var _loc4_:* = null;
        if (param1.hasOwnProperty(SettingsControlProp.DEFAULT_LBL)) {
            _loc3_ = true;
        }
        switch (param2.type) {
            case SettingsConfigHelper.TYPE_CHECKBOX:
                _loc4_ = _loc3_ && Boolean(param1.default);
                break;
            default:
                if (_loc3_) {
                    _loc4_ = Math.max(param1.default, 0);
                }
                else {
                    _loc4_ = 0;
                }
        }
        param2.defaultValue = _loc4_;
    }

    private function normalizeKeys(param1:Object, param2:Array, param3:SettingsDataVo, param4:Vector.<String>):void {
        var _loc5_:String = null;
        var _loc6_:Array = null;
        var _loc7_:Object = null;
        var _loc8_:Object = null;
        var _loc9_:uint = 0;
        var _loc10_:String = null;
        var _loc11_:String = null;
        var _loc12_:Array = null;
        var _loc13_:Object = null;
        var _loc14_:Number = NaN;
        var _loc15_:Number = NaN;
        var _loc17_:uint = 0;
        var _loc18_:uint = 0;
        param3.keys.splice(0, param3.keys.length);
        param3.values.splice(0, param3.values.length);
        param4.splice(0, param4.length);
        var _loc16_:uint = param2.length;
        while (_loc17_ < _loc16_) {
            _loc8_ = param2[_loc17_];
            _loc5_ = _loc8_[FIELD_KEY];
            _loc6_ = _loc8_[FIELD_VALUES];
            _loc9_ = _loc6_.length;
            param4.push(_loc5_);
            param3.keys.push(_loc5_);
            param3.values.push(new SettingsKeyProp(_loc5_, true, _loc5_, null, NaN, NaN, null, false, _loc17_ == 0 ? Number(0) : Number(MAX_RENDERER_Y_OFFSET)));
            _loc18_ = 0;
            while (_loc18_ < _loc9_) {
                _loc7_ = _loc6_[_loc18_];
                _loc10_ = _loc7_[FIELD_KEY];
                _loc11_ = _loc7_[FIELD_CMD];
                _loc12_ = !!_loc7_.hasOwnProperty(FIELD_DESCR) ? _loc7_[FIELD_DESCR] : null;
                _loc13_ = param1[_loc10_];
                if (_loc13_[FIELD_CURRENT]) {
                    _loc14_ = _loc13_[FIELD_CURRENT];
                    _loc15_ = _loc13_[FIELD_DEF];
                    param4.push(_loc10_);
                    param3.keys.push(_loc10_);
                    param3.values.push(new SettingsKeyProp(_loc10_, false, _loc10_, _loc11_, _loc14_, _loc15_, _loc12_, true));
                }
                _loc18_++;
            }
            _loc17_++;
        }
    }

    private function sendData(param1:Boolean):void {
        var _loc5_:String = null;
        var _loc6_:GraphicSettings = null;
        this.cancelBtn.enabled = this.applyBtn.enabled = this.submitBtn.enabled = false;
        var _loc2_:SoundSettings = this.getSoundSettings();
        if (_loc2_) {
            _loc2_.breakSoundCheck();
        }
        var _loc3_:Boolean = this.checkControlsWrong();
        var _loc4_:* = !isSoundModeValidS();
        if (_loc3_ || _loc4_) {
            _loc5_ = !!_loc3_ ? CONTROLS_WARNING : Values.EMPTY_STR;
            _loc5_ = _loc5_ + (!!_loc4_ ? SOUND_MODE_WARNING : Values.EMPTY_STR);
            showWarningDialogS(_loc5_, this._changesData.getChanges(), param1);
        }
        else {
            _loc6_ = this.getGraphicsSettings();
            if (_loc6_) {
                _loc6_.rewriteInitialValues();
            }
            applySettingsS(this._changesData.getChanges(), param1);
            if (!param1) {
                this.as_ConfirmationOfApplication(false);
            }
        }
    }

    private function checkControlsWrong():Boolean {
        var _loc2_:Object = null;
        var _loc3_:SettingsKeyProp = null;
        var _loc4_:* = null;
        var _loc1_:ControlsSettings = ControlsSettings(this.tryGetView(SettingsConfigHelper.CONTROLS_SETTINGS));
        if (_loc1_) {
            return _loc1_.isControlsChanged(true);
        }
        _loc2_ = this._settingsConfigHelper.settingsData[SettingsConfigHelper.CONTROLS_SETTINGS][SettingsConfigHelper.KEYBOARD];
        for (_loc4_ in _loc2_) {
            _loc3_ = SettingsKeyProp(_loc2_[_loc4_]);
            if (_loc3_.key == KeyProps.KEY_NONE) {
                return true;
            }
        }
        return false;
    }

    private function updateSettingsConfig(param1:Boolean):void {
        var _loc2_:Object = null;
        if (param1 && this._changesData) {
            _loc2_ = this._changesData.getChanges();
            this.searchAndOverride(this._settingsConfigHelper.settingsData, _loc2_);
            this._changesData.clear();
        }
        this.cancelBtn.enabled = this.submitBtn.enabled = true;
        this.updateApplyBtnState();
    }

    private function searchAndOverride(param1:SettingsDataVo, param2:Object):void {
        var _loc5_:SettingsDataVo = null;
        var _loc6_:* = null;
        var _loc3_:Object = {};
        var _loc4_:* = null;
        for (_loc6_ in param2) {
            _loc4_ = param2[_loc6_];
            _loc3_ = this.getControlInLayer(param1, _loc6_);
            if (_loc4_ is Boolean || _loc4_ is Number || _loc4_ is String) {
                if (_loc3_ != null && _loc4_ != null) {
                    if (_loc3_ is SettingsControlProp) {
                        SettingsControlProp(_loc3_).current = _loc4_;
                    }
                    else if (_loc3_ is SettingsKeyProp) {
                        SettingsKeyProp(_loc3_).key = _loc4_;
                    }
                }
            }
            else if (_loc3_ is SettingsControlProp) {
                SettingsControlProp(_loc3_).current = _loc4_;
            }
            else {
                _loc5_ = SettingsDataVo(_loc3_);
                if (_loc5_ != null) {
                    this.searchAndOverride(_loc5_, _loc4_);
                }
            }
        }
    }

    private function getControlInLayer(param1:SettingsDataVo, param2:String):Object {
        var _loc7_:int = 0;
        var _loc3_:Vector.<Object> = param1.values;
        var _loc4_:int = param1.keys.length;
        var _loc5_:Object = param1.getByKey(param2);
        var _loc6_:SettingsDataVo = null;
        if (_loc5_ == null) {
            _loc7_ = 0;
            while (_loc7_ < _loc4_) {
                _loc6_ = _loc3_[_loc7_] as SettingsDataVo;
                if (_loc6_) {
                    _loc5_ = _loc6_.getByKey(param2);
                }
                if (_loc5_ != null) {
                    return _loc5_;
                }
                _loc7_++;
            }
        }
        return _loc5_;
    }

    private function onTabIndexChangeHandler(param1:IndexEvent):void {
        _currentTab = param1.index;
        App.toolTipMgr.hide();
        var _loc2_:SoundSettings = this.getSoundSettings();
        if (_loc2_) {
            _loc2_.onViewChanged();
        }
        onTabSelectedS(this._settingsConfigHelper.tabsDataProviderWithOther[_currentTab].label);
    }

    private function onViewNeedUpdateHandler(param1:ViewStackEvent):void {
        this.updateTabIfNeeded(param1.linkage, param1.view);
    }

    private function onViewViewChangedHandler(param1:ViewStackEvent):void {
        this.updateTabIfNeeded(param1.linkage, param1.view);
        var _loc2_:IViewStackContent = param1.view;
        var _loc3_:ISettingsBase = ISettingsBase(_loc2_);
        var _loc4_:GraphicSettings = _loc3_ as GraphicSettings;
        if (_loc4_) {
            if (this._needToUpdateGraphicSettings) {
                _loc4_.updateDependentData();
                this._needToUpdateGraphicSettings = false;
            }
            if (this._graphicsPresetToSelect != -1) {
                _loc4_.setPresetAfterAutoDetect(this._graphicsPresetToSelect);
                this._graphicsPresetToSelect = -1;
            }
        }
        else {
            _loc3_.updateDependentData();
        }
    }

    private function onOnPttControlChangedHandler(param1:SettingViewEvent):void {
        var _loc2_:SettingsControlProp = SettingsControlProp(this._settingsConfigHelper.settingsData[SettingsConfigHelper.SOUND_SETTINGS][SettingsConfigHelper.PTT]);
        _loc2_.current = param1.controlValue;
        var _loc3_:SoundSettings = this.getSoundSettings();
        if (_loc3_) {
            _loc3_.updatePTTControl(_loc2_.current);
        }
    }

    private function onOnControlChangedHandler(param1:SettingViewEvent):void {
        var _loc2_:String = param1.viewId;
        var _loc3_:String = param1.controlId;
        var _loc4_:* = param1.controlValue;
        onSettingsChangeS(_loc3_, _loc4_);
        var _loc5_:Boolean = this.controlDefValEqNewVal(this._settingsData.getByKey(_loc2_).getByKey(_loc3_), _loc4_);
        this.checkChanges(_loc5_, _loc3_, _loc4_);
    }

    private function onOnVivoxTestHandler(param1:SettingViewEvent):void {
        var _loc2_:Boolean = Boolean(param1.controlValue);
        var _loc3_:Boolean = startVOIPTestS(_loc2_);
        var _loc4_:SoundSettings = this.getSoundSettings();
        if (_loc4_ != null) {
            _loc4_.setVoiceTestState(!(_loc3_ || !_loc2_));
        }
    }

    private function onOnAutoDetectQualityHandler(param1:SettingViewEvent):void {
        var _loc2_:Number = autodetectQualityS();
        var _loc3_:GraphicSettings = this.getGraphicsSettings();
        if (_loc3_ != null) {
            _loc3_.setPresetAfterAutoDetect(_loc2_);
        }
    }

    private function onOnUpdateCaptureDeviceHandler(param1:SettingViewEvent):void {
        updateCaptureDevicesS();
    }

    private function onOnTestAlternativeVoicesHandler(param1:AlternativeVoiceEvent):void {
        var _loc2_:SoundSettings = null;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc5_:Point = null;
        var _loc6_:ITooltipProps = null;
        var _loc7_:String = null;
        if (isSoundModeValidS()) {
            altVoicesPreviewS();
        }
        else {
            _loc2_ = this.getSoundSettings();
            _loc3_ = _loc2_.testAlternativeVoicesButton.x;
            _loc4_ = _loc2_.testAlternativeVoicesButton.y;
            _loc5_ = this.localToGlobal(new Point(_loc3_, _loc4_));
            _loc6_ = new TooltipProps(BaseTooltips.TYPE_WARNING, _loc5_.x, _loc5_.y, 0, 0, MAX_TOOLTIP_WIDTH);
            _loc7_ = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.ERROR_TEXT, App.utils.locale.makeString(TOOLTIPS.SETTINGS_DIALOG_SOUND_SOUNDMODEINVALID));
            App.toolTipMgr.show(_loc7_, _loc6_);
        }
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:SoundSettings = this.getSoundSettings();
        if (_loc2_) {
            _loc2_.breakSoundCheck();
        }
        onWindowCloseS();
    }

    private function onApplyBtnClickHandler(param1:ButtonEvent):void {
        this.sendData(false);
    }

    private function onSubmitBtnClickHandler(param1:ButtonEvent):void {
        this.sendData(true);
    }

    private function onWindowScaleYChangedHandler(param1:WindowEvent):void {
        invalidate(WindowViewInvalidationType.POSITION_INVALID);
    }
}
}

package net.wg.gui.lobby.settings {
import flash.events.Event;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.RangeSlider;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.lobby.settings.components.SettingsStepSlider;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.events.SettingViewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.utils.IDataUtils;

import scaleform.clik.core.UIComponent;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.events.SliderEvent;
import scaleform.clik.interfaces.IDataProvider;

public class GraphicSettings extends GraphicSettingsBase {

    private static const CURRENT_STR:String = "current";

    private static const DATA_STR:String = "data";

    private static const SUPPORTED_STR:String = "supported";

    private static const POSTFIX_STR:String = "%";

    private static const OPTIONS_STR:String = "options";

    private var _graphicsQualityDataProv:Object = null;

    private var _qualityOrderIdList:Vector.<String> = null;

    private var _isCustomPreset:Boolean = false;

    private var _onlyPresetsDP:Array;

    private var _presetsWithCustomDP:Array;

    private var _isAdvanced:Boolean = false;

    private var _presets:SettingsDataVo = null;

    private var _colorFilterPreviews:Vector.<String> = null;

    private var _isInited:Boolean = false;

    private var _allowCheckPreset:Boolean = true;

    private var _extendAdvancedControls:Object;

    private var _extendAdvancedControlsIds:Vector.<String>;

    private var _skipIdList:Vector.<String>;

    private var _skipSetEnableIdList:Vector.<String>;

    private var _skipDispatchPresetEvent:Boolean = false;

    private var _initialFOVValues:Array = null;

    private const _imaginaryIdList:Vector.<String> = Vector.<String>([SettingsConfigHelper.CUSTOM_AA, SettingsConfigHelper.MULTISAMPLING, SettingsConfigHelper.WINDOW_SIZE, SettingsConfigHelper.RESOLUTION, SettingsConfigHelper.PRESETS, SettingsConfigHelper.QUALITY_ORDER]);

    public function GraphicSettings() {
        this._onlyPresetsDP = [];
        this._presetsWithCustomDP = [];
        this._extendAdvancedControlsIds = Vector.<String>([SettingsConfigHelper.COLOR_GRADING_TECHNIQUE]);
        super();
    }

    override public function toString():String {
        return "[WG GraphicSettings " + name + "]";
    }

    override public function update(param1:Object):void {
        var _loc3_:uint = 0;
        var _loc4_:uint = 0;
        var _loc5_:String = null;
        this._graphicsQualityDataProv = {};
        var _loc2_:Object = param1.data;
        this._qualityOrderIdList = _loc2_.qualityOrder;
        if (this._qualityOrderIdList is Vector.<String>) {
            _loc3_ = this._qualityOrderIdList.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc5_ = this._qualityOrderIdList[_loc4_];
                if (_loc2_[_loc5_] != undefined) {
                    this._graphicsQualityDataProv[_loc5_] = SettingsControlProp(_loc2_[_loc5_]).clone();
                }
                _loc4_++;
            }
        }
        this._presets = param1.data.presets;
        super.update(param1);
    }

    override public function updateDependentData():void {
        if (SettingsConfigHelper.instance.liveUpdateVideoSettingsData && this._isInited) {
            this.initMonitors();
            this.updateLiveVideoData();
        }
    }

    override protected function onDispose():void {
        var _loc3_:CheckBox = null;
        var _loc4_:Slider = null;
        var _loc5_:Slider = null;
        var _loc6_:DropdownMenu = null;
        var _loc7_:SettingsControlProp = null;
        var _loc8_:int = 0;
        var _loc9_:* = null;
        var _loc10_:int = 0;
        if (data) {
            _loc3_ = null;
            _loc4_ = null;
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = null;
            _loc8_ = data.keys.length;
            _loc9_ = Values.EMPTY_STR;
            _loc10_ = 0;
            while (_loc10_ < _loc8_) {
                _loc9_ = data.keys[_loc10_];
                if (this._skipIdList.indexOf(_loc9_) < 0) {
                    _loc7_ = SettingsControlProp(data.values[_loc10_]);
                    switch (_loc7_.type) {
                        case SettingsConfigHelper.TYPE_CHECKBOX:
                            _loc3_ = this[_loc9_ + _loc7_.type];
                            _loc3_.removeEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
                            break;
                        case SettingsConfigHelper.TYPE_SLIDER:
                            _loc4_ = this[_loc9_ + _loc7_.type];
                            _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
                            break;
                        case SettingsConfigHelper.TYPE_RANGE_SLIDER:
                            _loc5_ = this[_loc9_ + _loc7_.type];
                            _loc5_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onRangeSliderValueChangeHandler);
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc6_ = this[_loc9_ + _loc7_.type];
                            _loc6_.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
                    }
                }
                _loc10_++;
            }
        }
        var _loc1_:SettingsStepSlider = null;
        _loc9_ = SettingsConfigHelper.GRAPHIC_QUALITY;
        _loc7_ = SettingsControlProp(data[_loc9_]);
        _loc6_ = this[_loc9_ + _loc7_.type];
        _loc6_.removeEventListener(ListEvent.INDEX_CHANGE, this.onGraphicsQualityIndexChangeHandler);
        _loc9_ = SettingsConfigHelper.RENDER_PIPELINE;
        _loc7_ = SettingsControlProp(data[_loc9_]);
        var _loc2_:ButtonBarEx = this[_loc9_ + _loc7_.type];
        _loc2_.removeEventListener(IndexEvent.INDEX_CHANGE, this.onGraphicsQualityRenderPipelineIndexChangeHandler);
        for (_loc9_ in this._graphicsQualityDataProv) {
            if (_loc9_ == SettingsConfigHelper.RENDER_PIPELINE) {
                continue;
            }
            _loc7_ = SettingsControlProp(this._graphicsQualityDataProv[_loc9_]);
            switch (_loc7_.type) {
                case SettingsConfigHelper.TYPE_CHECKBOX:
                    _loc3_ = this[_loc9_ + _loc7_.type];
                    _loc3_.removeEventListener(Event.SELECT, this.onCheckBoxOrderedSelectHandler);
                    continue;
                case SettingsConfigHelper.TYPE_STEP_SLIDER:
                    _loc1_ = this[_loc9_ + _loc7_.type];
                    _loc1_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onSliderOrderedValueChangeHandler);
                    continue;
                case SettingsConfigHelper.TYPE_DROPDOWN:
                    _loc6_ = this[_loc9_ + _loc7_.type];
                    _loc6_.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownOrderedIndexChangeHandler);
                    continue;
                default:
                    continue;
            }
        }
        while (this._graphicsQualityDataProv.length) {
            this._graphicsQualityDataProv.pop();
        }
        this._graphicsQualityDataProv = null;
        while (this._extendAdvancedControls.length) {
            this._extendAdvancedControls.pop();
        }
        this._extendAdvancedControls = null;
        if (this._onlyPresetsDP) {
            this._onlyPresetsDP.splice(0);
            this._onlyPresetsDP = null;
        }
        while (this._skipSetEnableIdList.length) {
            this._skipSetEnableIdList.pop();
        }
        this._skipSetEnableIdList = null;
        if (this._presetsWithCustomDP) {
            this._presetsWithCustomDP.splice(0);
            this._presetsWithCustomDP = null;
        }
        App.utils.data.cleanupDynamicObject(this._presets);
        this._presets = null;
        App.utils.data.cleanupDynamicObject(this._skipIdList);
        this._skipIdList = null;
        this._colorFilterPreviews.splice(0, this._colorFilterPreviews.length);
        this._colorFilterPreviews = null;
        App.utils.data.cleanupDynamicObject(this._qualityOrderIdList);
        this._qualityOrderIdList = null;
        App.utils.data.cleanupDynamicObject(this._extendAdvancedControlsIds);
        this._extendAdvancedControlsIds = null;
        autodetectQuality.removeEventListener(ButtonEvent.CLICK, this.onAutodetectClickHandler);
        tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        refreshRateDropDown.removeEventListener(ListEvent.INDEX_CHANGE, this.onRefreshRateDropDownIndexChangeHandler);
        sizesDropDown.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        if (interfaceScaleDropDown.visible) {
            interfaceScaleDropDown.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        }
        this._initialFOVValues = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        graphicsQualityLabel.text = SETTINGS.GRAPHICSQUALITY;
        autodetectQuality.label = SETTINGS.AUTODETECTBUTTON;
        dynamicRendererLabel.text = SETTINGS.DYNAMICRENDERER;
        this._skipSetEnableIdList = new Vector.<String>();
        this._skipSetEnableIdList.push(SettingsConfigHelper.COLOR_FILTER_INTENSITY);
        this._skipSetEnableIdList.push(SettingsConfigHelper.ASPECTRATIO);
        this._skipSetEnableIdList.push(SettingsConfigHelper.GAMMA);
        this._skipSetEnableIdList.push(SettingsConfigHelper.REFRESH_RATE);
        tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        tabs.dataProvider = new DataProvider([{"label": SETTINGS.GRAPHICS_TABSCREEN}, {"label": SETTINGS.GRAPHICS_TABADVANCED}]);
        this.updateCurrentTab();
        autodetectQuality.addEventListener(ButtonEvent.CLICK, this.onAutodetectClickHandler);
    }

    override protected function setData(param1:SettingsDataVo):void {
        this.setControlsData(param1);
        super.setData(param1);
    }

    override protected function updateDependedControl(param1:String):void {
        var _loc3_:CheckBox = null;
        var _loc2_:SettingsControlProp = data[param1];
        if (param1 == SettingsConfigHelper.VERTICAL_SYNC) {
            _loc3_ = this[_loc2_.isDependOn + SettingsConfigHelper.TYPE_CHECKBOX];
            _loc3_.selected = Boolean(_loc2_.changedVal);
        }
        super.updateDependedControl(param1);
    }

    public function rewriteInitialValues():void {
        var _loc1_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.FOV]);
        this._initialFOVValues = [fovRangeSlider.value, fovRangeSlider.leftValue, fovRangeSlider.rightValue];
        _loc1_.current = this._initialFOVValues;
    }

    public function setPresetAfterAutoDetect(param1:Number):void {
        var _loc2_:String = SettingsConfigHelper.GRAPHIC_QUALITY;
        var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
        var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
        this._presets.setByKey(CURRENT_STR, param1);
        _loc3_.changedVal = this._presets.getByKey(CURRENT_STR);
        _loc4_.dataProvider = new DataProvider(_loc3_.options);
        this.updateDropDownEnabled(_loc2_);
        _loc4_.selectedIndex = this.getDPItemIndex(_loc4_.dataProvider, _loc3_.changedVal);
        autodetectQuality.enabled = true;
    }

    public function tryFindPreset():Number {
        var _loc1_:Array = null;
        var _loc2_:Number = NaN;
        var _loc3_:SettingsControlProp = null;
        var _loc4_:Number = NaN;
        var _loc5_:* = null;
        var _loc6_:Number = NaN;
        var _loc7_:Boolean = false;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc10_:DropdownMenu = null;
        var _loc11_:Number = NaN;
        var _loc12_:Number = NaN;
        if (this._allowCheckPreset) {
            _loc1_ = this._presets.getByKey(OPTIONS_STR) as Array;
            App.utils.asserter.assertNotNull(_loc1_, " _presets.getByKey(OPTIONS_STR) must be Array");
            _loc2_ = _loc1_.length;
            _loc3_ = null;
            _loc4_ = -1;
            _loc5_ = Values.EMPTY_STR;
            _loc6_ = 0;
            while (_loc6_ < _loc2_) {
                _loc7_ = true;
                for (_loc5_ in _loc1_[_loc6_].settings) {
                    _loc8_ = _loc1_[_loc6_].settings[_loc5_];
                    _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[_loc5_]);
                    _loc9_ = Number(_loc3_.changedVal);
                    if (_loc8_ != _loc9_) {
                        _loc7_ = false;
                        break;
                    }
                }
                if (_loc7_) {
                    this._isCustomPreset = _loc1_[_loc6_].key == SettingsConfigHelper.CUSTOM;
                    _loc4_ = _loc1_[_loc6_].index;
                    break;
                }
                _loc6_++;
            }
            if (_loc4_ >= 0) {
                _loc5_ = SettingsConfigHelper.GRAPHIC_QUALITY;
                _loc3_ = SettingsControlProp(data[_loc5_]);
                _loc10_ = this[_loc5_ + _loc3_.type];
                this.updatePresetsDP();
                _loc11_ = _loc10_.selectedIndex;
                _loc12_ = this.getDPItemIndex(_loc10_.dataProvider, _loc4_);
                if (_loc11_ != _loc12_) {
                    this._skipDispatchPresetEvent = true;
                    _loc10_.selectedIndex = _loc12_;
                }
            }
        }
        return _loc4_;
    }

    private function updateCurrentTab():void {
        screenForm.visible = tabs.selectedIndex == 0;
        advancedForm.visible = !screenForm.visible;
    }

    private function setControlsData(param1:SettingsDataVo):void {
        var _loc6_:String = null;
        var _loc7_:SettingsControlProp = null;
        var _loc9_:SettingsControlProp = null;
        var _loc10_:* = false;
        var _loc11_:CheckBox = null;
        var _loc12_:Slider = null;
        var _loc13_:RangeSlider = null;
        var _loc14_:DropdownMenu = null;
        this._skipIdList = new Vector.<String>();
        this._extendAdvancedControls = {};
        var _loc2_:Vector.<String> = Vector.<String>([SettingsConfigHelper.SMOOTHING, SettingsConfigHelper.SIZE]);
        this._skipIdList = this._qualityOrderIdList.slice(0);
        this._skipIdList = this._skipIdList.concat(this._imaginaryIdList);
        this._skipIdList = this._skipIdList.concat(_loc2_);
        this._skipIdList.push(SettingsConfigHelper.GRAPHIC_QUALITY);
        this._skipIdList.push(SettingsConfigHelper.GRAPHIC_QUALITY_HDSD);
        this._skipIdList.push(SettingsConfigHelper.COLOR_FILTER_IMAGES);
        this._skipIdList.push(SettingsConfigHelper.REFRESH_RATE);
        this._skipIdList.push(SettingsConfigHelper.INTERFACE_SCALE);
        var _loc3_:Vector.<String> = param1.keys;
        var _loc4_:Vector.<Object> = param1.values;
        var _loc5_:int = _loc3_.length;
        _loc6_ = Values.EMPTY_STR;
        _loc7_ = null;
        var _loc8_:int = 0;
        for (; _loc8_ < _loc5_; _loc8_++) {
            _loc6_ = _loc3_[_loc8_];
            trySetLabel(_loc6_);
            if (this._skipIdList.indexOf(_loc6_) >= 0) {
                if (_loc6_ == SettingsConfigHelper.COLOR_FILTER_IMAGES) {
                    this._colorFilterPreviews = data[_loc6_];
                }
                else if (_loc6_ == SettingsConfigHelper.GRAPHIC_QUALITY_HDSD) {
                    _loc9_ = SettingsControlProp(_loc4_[_loc8_]);
                    if (_loc9_.current != null && _loc9_.current != Values.EMPTY_STR) {
                        graphicsQualityHDSD.htmlText = _loc9_.current.toString();
                        graphicsQualityHDSD.visible = true;
                    }
                }
                if (this._extendAdvancedControlsIds.indexOf(_loc6_) == -1) {
                    continue;
                }
            }
            if (_loc4_[_loc8_].type && this[_loc6_ + _loc4_[_loc8_].type] != undefined) {
                _loc7_ = _loc4_[_loc8_] as SettingsControlProp;
                App.utils.asserter.assertNotNull(_loc7_, "values[i] must be SettingsControlProp");
                _loc10_ = !(_loc7_.current == null || _loc7_.readOnly);
                if (_loc7_.isDependOn) {
                    headDependedControls.push(_loc6_);
                }
                if (this._extendAdvancedControlsIds.indexOf(_loc6_) >= 0) {
                    this._extendAdvancedControls[_loc6_] = _loc7_.clone();
                }
                else {
                    switch (_loc7_.type) {
                        case SettingsConfigHelper.TYPE_CHECKBOX:
                            _loc11_ = this[_loc6_ + _loc7_.type];
                            if (_loc11_.label == Values.EMPTY_STR) {
                                _loc11_.label = SettingsConfigHelper.LOCALIZATION + _loc6_;
                            }
                            _loc11_.selected = _loc7_.current;
                            _loc11_.addEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
                            _loc11_.visible = _loc7_.current != null;
                            if (this._skipSetEnableIdList.indexOf(_loc6_) == -1) {
                                _loc11_.enabled = _loc10_;
                            }
                            if (_loc6_ == SettingsConfigHelper.FULL_SCREEN) {
                                isFullScreen = _loc11_.selected;
                            }
                            else if (_loc6_ == SettingsConfigHelper.DYNAMIC_FOV) {
                                fovRangeSlider.rangeMode = _loc11_.selected;
                            }
                            break;
                        case SettingsConfigHelper.TYPE_SLIDER:
                            _loc12_ = this[_loc6_ + _loc7_.type];
                            _loc12_.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
                            _loc12_.value = Number(_loc7_.current);
                            if (this._skipSetEnableIdList.indexOf(_loc6_) == -1) {
                                _loc12_.enabled = _loc10_;
                            }
                            break;
                        case SettingsConfigHelper.TYPE_RANGE_SLIDER:
                            _loc13_ = this[_loc6_ + _loc7_.type];
                            _loc13_.addEventListener(SliderEvent.VALUE_CHANGE, this.onRangeSliderValueChangeHandler);
                            this._initialFOVValues = _loc7_.current as Array;
                            App.utils.asserter.assertNotNull(this._initialFOVValues, "controlProp.current must be Array");
                            this.setInitialFOVValues();
                            _loc13_.enabled = _loc10_;
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc14_ = this[_loc6_ + _loc7_.type];
                            _loc14_.visible = _loc7_.current != null;
                            _loc14_.dataProvider = new DataProvider(_loc7_.options);
                            if (_loc7_.isDataAsSelectedIndex) {
                                _loc14_.selectedIndex = findSelectedIndexForDD(Number(_loc7_.current), _loc7_.options);
                            }
                            else {
                                _loc14_.selectedIndex = int(_loc7_.current);
                            }
                            _loc14_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
                            if (this._skipSetEnableIdList.indexOf(_loc6_) == -1) {
                                this.updateDropDownEnabled(_loc6_);
                            }
                    }
                }
            }
            else if (!_loc7_.readOnly && SettingsConfigHelper.reservedImaginaryControls.indexOf(_loc6_) == -1) {
                DebugUtils.LOG_WARNING("ERROR in" + this + " control " + _loc6_ + " can not find");
                continue;
            }
        }
        this.initMonitors();
        this.updateFullScreenDependentControls();
        this.setSizeControl(false);
        this.initRefreshRateControl();
        this.updateRefreshRate();
        this.initInterfaceScale();
        this._allowCheckPreset = false;
        this.setPresets();
        this.setRenderPipeline();
        this.updateAdvancedDependedControls();
        this._allowCheckPreset = true;
        this._isInited = true;
    }

    private function initMonitors():void {
        var _loc1_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.MONITOR]);
        var _loc2_:Number = Number(_loc1_.changedVal);
        var _loc3_:uint = _loc1_.options is Array ? uint(_loc1_.options.length) : uint(0);
        var _loc4_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.RESOLUTION]);
        var _loc5_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.WINDOW_SIZE]);
        _loc4_.prevVal = [];
        _loc5_.prevVal = [];
        var _loc6_:Number = 0;
        while (_loc6_ < _loc3_) {
            _loc4_.prevVal[_loc6_] = _loc6_ == _loc2_ ? _loc4_.changedVal : 0;
            _loc5_.prevVal[_loc6_] = _loc6_ == _loc2_ ? _loc5_.changedVal : 0;
            _loc6_++;
        }
    }

    private function updateFullScreenDependentControls():void {
        var _loc2_:String = null;
        var _loc3_:SettingsControlProp = null;
        var _loc4_:UIComponent = null;
        var _loc5_:DropdownMenu = null;
        var _loc1_:Array = [SettingsConfigHelper.ASPECTRATIO, SettingsConfigHelper.REFRESH_RATE, SettingsConfigHelper.GAMMA];
        for each(_loc2_ in _loc1_) {
            _loc3_ = SettingsControlProp(data[_loc2_]);
            _loc4_ = this[_loc2_ + _loc3_.type];
            if (_loc3_.type == SettingsConfigHelper.TYPE_DROPDOWN) {
                _loc5_ = this[_loc2_ + _loc3_.type];
                _loc4_.enabled = isFullScreen && !(_loc3_.changedVal == null || _loc3_.readOnly) && _loc5_.dataProvider.length > 1;
            }
            else {
                _loc4_.enabled = isFullScreen && !(_loc3_.changedVal == null || _loc3_.readOnly);
            }
        }
    }

    private function setSizeControl(param1:Boolean = true):void {
        var _loc2_:String = SettingsConfigHelper.SIZE;
        var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
        var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
        var _loc5_:String = !!isFullScreen ? SettingsConfigHelper.RESOLUTION : SettingsConfigHelper.WINDOW_SIZE;
        var _loc6_:SettingsControlProp = SettingsControlProp(data[_loc5_]);
        sizesLabel.text = SettingsConfigHelper.LOCALIZATION + _loc5_;
        var _loc7_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.MONITOR]);
        var _loc8_:Number = Number(_loc7_.changedVal);
        _loc3_.options = _loc6_.options[_loc8_];
        var _loc9_:Number = Number(_loc6_.changedVal);
        if (param1) {
            _loc9_ = _loc3_.options.length - 1;
            if (_loc4_.selectedIndex >= 0 && _loc4_.selectedIndex <= _loc4_.dataProvider.length) {
                _loc9_ = this.trySearchSameSizeForAnotherMonitor(_loc4_.dataProvider.requestItemAt(_loc4_.selectedIndex).toString(), _loc3_.options);
            }
        }
        _loc4_.dataProvider = new DataProvider(_loc3_.options);
        var _loc10_:Number = _loc4_.selectedIndex;
        _loc4_.selectedIndex = _loc9_;
        this.updateDropDownEnabled(_loc2_);
        if (!this._isInited) {
            _loc3_.current = _loc9_;
            _loc4_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        }
        else if (_loc10_ == _loc9_) {
            this.updateInterfaceScale();
        }
    }

    private function updateDropDownEnabled(param1:String):void {
        var _loc2_:SettingsControlProp = SettingsControlProp(data.getByKey(param1));
        var _loc3_:DropdownMenu = this[param1 + _loc2_.type];
        _loc3_.enabled = _loc3_.dataProvider.length > 1 && !_loc2_.readOnly;
    }

    private function setInitialFOVValues():void {
        fovRangeSlider.value = this._initialFOVValues[0];
        fovRangeSlider.rightValue = this._initialFOVValues[2];
        fovRangeSlider.leftValue = this._initialFOVValues[1];
    }

    private function initRefreshRateControl():void {
        refreshRateDropDown.addEventListener(ListEvent.INDEX_CHANGE, this.onRefreshRateDropDownIndexChangeHandler);
    }

    private function updateRefreshRate(param1:Boolean = false):void {
        var _loc7_:SettingsControlProp = null;
        var _loc8_:int = 0;
        var _loc9_:int = 0;
        var _loc10_:Array = null;
        var _loc11_:Number = NaN;
        var _loc2_:String = SettingsConfigHelper.REFRESH_RATE;
        var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
        var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
        if (SettingsConfigHelper.instance.liveUpdateVideoSettingsData[_loc2_] && param1) {
            _loc7_ = SettingsControlProp(SettingsConfigHelper.instance.liveUpdateVideoSettingsData[_loc2_]);
            _loc3_.options = App.utils.data.cloneObject(_loc7_.options);
            _loc3_.current = _loc7_.current;
        }
        var _loc5_:Object = _loc3_.changedVal;
        if (isFullScreen) {
            _loc8_ = monitorDropDown.selectedIndex;
            _loc9_ = sizesDropDown.selectedIndex;
            _loc10_ = _loc3_.options[_loc8_][_loc9_];
            _loc4_.dataProvider = new DataProvider(_loc10_);
        }
        else {
            _loc4_.dataProvider = new DataProvider([SETTINGS.REFRESHRATE_DEFAULT]);
        }
        this.updateDropDownEnabled(_loc2_);
        var _loc6_:int = _loc4_.dataProvider.indexOf(_loc5_);
        if (_loc6_ == -1) {
            _loc11_ = this.getClosestRefreshRate(int(_loc5_), _loc4_.dataProvider);
            if (isNaN(_loc11_)) {
                _loc4_.selectedIndex = _loc4_.dataProvider.length - 1;
            }
            else {
                _loc4_.selectedIndex = _loc4_.dataProvider.indexOf(_loc11_);
            }
        }
        else {
            _loc4_.selectedIndex = _loc6_;
        }
        this.onRefreshRateDropDownIndexChangeHandler();
    }

    private function initInterfaceScale():void {
        var _loc1_:String = SettingsConfigHelper.INTERFACE_SCALE;
        var _loc2_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
        var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
        _loc3_.visible = _loc2_.current != null;
        interfaceScaleLabel.visible = _loc3_.visible;
        if (_loc3_.visible) {
            this.updateInterfaceScale();
            _loc3_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        }
    }

    private function updateInterfaceScale():void {
        var _loc1_:String = SettingsConfigHelper.INTERFACE_SCALE;
        var _loc2_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
        var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
        if (!_loc3_.visible) {
            return;
        }
        var _loc4_:Number = Number(isFullScreen);
        var _loc5_:int = monitorDropDown.selectedIndex;
        var _loc6_:int = sizesDropDown.selectedIndex;
        var _loc7_:Array = _loc2_.options[_loc4_][_loc5_][_loc6_];
        var _loc8_:Number = 0;
        if (_loc3_.selectedIndex >= 0) {
            _loc8_ = _loc3_.selectedIndex < _loc7_.length ? Number(_loc3_.selectedIndex) : Number(_loc7_.length - 1);
        }
        _loc3_.dataProvider = new DataProvider(_loc7_);
        _loc3_.selectedIndex = !!this._isInited ? int(_loc8_) : int(int(_loc2_.current));
        this.updateDropDownEnabled(_loc1_);
        if (_loc3_.enabled) {
            interfaceScaleLabel.toolTip = SETTINGS.INTERFACESCALE;
            registerToolTip(interfaceScaleLabel, SettingsConfigHelper.INTERFACE_SCALE);
        }
        else {
            interfaceScaleLabel.toolTip = SETTINGS.INTERFACESCALEDISABLED;
            registerToolTip(interfaceScaleLabel, SettingsConfigHelper.INTERFACE_SCALE_DISABLED);
        }
    }

    private function getClosestRefreshRate(param1:int, param2:IDataProvider):Number {
        var _loc6_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:int = param2.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = Number(param2.requestItemAt(_loc5_));
            if (_loc6_ > param1 && (!!isNaN(_loc3_) ? Boolean(true) : Boolean(_loc6_ < _loc3_))) {
                _loc3_ = _loc6_;
            }
            _loc5_++;
        }
        return _loc3_;
    }

    private function setPresets():void {
        var _loc4_:int = 0;
        var _loc5_:String = null;
        var _loc6_:int = 0;
        var _loc7_:Object = null;
        var _loc9_:Object = null;
        var _loc10_:* = null;
        var _loc11_:Array = null;
        var _loc12_:IDataProvider = null;
        var _loc13_:int = 0;
        var _loc1_:String = SettingsConfigHelper.GRAPHIC_QUALITY;
        var _loc2_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
        var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
        this._onlyPresetsDP = [];
        this._presetsWithCustomDP = [];
        var _loc8_:Object = this._presets.getByKey(OPTIONS_STR);
        for (_loc10_ in _loc8_) {
            _loc9_ = _loc8_[_loc10_];
            _loc6_ = _loc9_.index;
            _loc5_ = _loc9_.key;
            _loc7_ = {
                "label": SETTINGS.graphicssettingsoptions(_loc5_),
                "settings": _loc9_.settings,
                "key": _loc5_,
                "data": _loc6_
            };
            this._presetsWithCustomDP.push(_loc7_);
            if (_loc5_ == SettingsConfigHelper.CUSTOM) {
                this._isCustomPreset = _loc6_ == this._presets.getByKey(CURRENT_STR);
                _loc4_ = _loc6_;
            }
            else {
                this._onlyPresetsDP.push(_loc7_);
            }
        }
        _loc2_.changedVal = this._presets.getByKey(CURRENT_STR);
        _loc11_ = new DataProvider(this._presetsWithCustomDP) as Array;
        App.utils.asserter.assertNotNull(_loc11_, "_presetsWithCustomDP must be Array");
        _loc2_.options = _loc11_;
        _loc12_ = _loc2_.options as IDataProvider;
        App.utils.asserter.assertNotNull(_loc12_, "controlProp.options must be IDataProvider");
        _loc13_ = this.getDPItemIndex(_loc12_, _loc2_.changedVal);
        if (_loc13_ == -1) {
            this._isCustomPreset = true;
            this.updatePresetsDP();
            _loc2_.current = _loc4_;
            _loc13_ = this.getDPItemIndex(_loc3_.dataProvider, _loc4_);
        }
        else {
            this.updatePresetsDP();
        }
        _loc3_.selectedIndex = _loc13_;
        _loc3_.addEventListener(ListEvent.INDEX_CHANGE, this.onGraphicsQualityIndexChangeHandler);
    }

    private function setRenderPipeline():void {
        var _loc2_:SettingsControlProp = null;
        var _loc3_:* = false;
        var _loc4_:ButtonBarEx = null;
        var _loc1_:String = SettingsConfigHelper.RENDER_PIPELINE;
        if (data[_loc1_] && this[_loc1_ + data[_loc1_].type] != undefined) {
            _loc2_ = SettingsControlProp(data[_loc1_]);
            _loc3_ = !(_loc2_.changedVal == null || _loc2_.readOnly);
            _loc4_ = this[_loc1_ + _loc2_.type];
            _loc4_.dataProvider = new DataProvider(_loc2_.options);
            _loc4_.selectedIndex = this.getDPItemIndex(_loc4_.dataProvider, _loc2_.changedVal);
            _loc4_.enabled = _loc3_;
            this._isAdvanced = _loc4_.selectedItem[DATA_STR] == SettingsConfigHelper.ADVANCED_GRAPHICS_DATA;
            _loc4_.addEventListener(IndexEvent.INDEX_CHANGE, this.onGraphicsQualityRenderPipelineIndexChangeHandler);
        }
    }

    private function getDPItemIndex(param1:IDataProvider, param2:Object, param3:String = "data"):int {
        var _loc5_:Object = null;
        var _loc4_:int = -1;
        for each(_loc5_ in param1) {
            if (_loc5_.hasOwnProperty(param3) && _loc5_[param3] == param2) {
                _loc4_ = param1.indexOf(_loc5_);
                break;
            }
        }
        return _loc4_;
    }

    private function updateAdvancedDependedControls():void {
        this.updateDataProviderForQuality();
        this.updateExtendedAdvancedControlsData();
        this.updateQualityControls();
        this.updateExtendedAdvancedControls();
        this.updateSmoothingControl();
    }

    private function updateDataProviderForQuality():void {
        var _loc1_:* = null;
        var _loc2_:SettingsControlProp = null;
        var _loc3_:SettingsStepSlider = null;
        var _loc4_:Array = null;
        var _loc5_:* = null;
        for (_loc1_ in this._graphicsQualityDataProv) {
            if (_loc1_ == SettingsConfigHelper.RENDER_PIPELINE) {
                continue;
            }
            _loc2_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
            switch (_loc2_.type) {
                case SettingsConfigHelper.TYPE_CHECKBOX:
                    continue;
                case SettingsConfigHelper.TYPE_SLIDER:
                    continue;
                case SettingsConfigHelper.TYPE_STEP_SLIDER:
                    _loc3_ = this[_loc1_ + _loc2_.type];
                    _loc3_.inAdvancedMode = this._isAdvanced;
                    continue;
                case SettingsConfigHelper.TYPE_DROPDOWN:
                    _loc2_.options = [];
                    _loc4_ = data[_loc1_].options;
                    for (_loc5_ in _loc4_) {
                        if (this._isAdvanced || !_loc4_[_loc5_].advanced) {
                            _loc2_.options.push(_loc4_[_loc5_]);
                        }
                    }
                    continue;
                default:
                    continue;
            }
        }
    }

    private function updateQualityControls():void {
        var _loc1_:* = null;
        var _loc2_:SettingsControlProp = null;
        var _loc3_:CheckBox = null;
        for (_loc1_ in this._graphicsQualityDataProv) {
            if (_loc1_ != SettingsConfigHelper.RENDER_PIPELINE) {
                if (this[_loc1_ + SettingsControlProp(this._graphicsQualityDataProv[_loc1_]).type]) {
                    _loc2_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
                    this.updateAdvancedQualityControl(_loc1_, _loc2_);
                }
            }
        }
        _loc3_ = CheckBox(this[SettingsConfigHelper.DRR_AUTOSCALER_ENABLED + SettingsConfigHelper.TYPE_CHECKBOX]);
        this.updateDynamicRendererSlider(_loc3_.selected);
    }

    private function updateAdvancedQualityControl(param1:String, param2:SettingsControlProp):void {
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc5_:uint = 0;
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        var _loc9_:CheckBox = null;
        var _loc10_:Boolean = false;
        var _loc11_:SettingsStepSlider = null;
        var _loc12_:DropdownMenu = null;
        var _loc8_:uint = 0;
        switch (param2.type) {
            case SettingsConfigHelper.TYPE_CHECKBOX:
                _loc9_ = this[param1 + param2.type];
                _loc10_ = param2.changedVal;
                _loc9_.selected = _loc10_ && (this._isAdvanced || !param2.advanced);
                _loc9_.enabled = Boolean(this._isAdvanced || !param2.advanced);
                if (_loc10_ != _loc9_.selected) {
                    param2.changedVal = _loc9_.selected;
                    dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, param1, _loc9_.selected));
                }
                if (!this._isInited) {
                    _loc9_.addEventListener(Event.SELECT, this.onCheckBoxOrderedSelectHandler);
                }
                break;
            case SettingsConfigHelper.TYPE_STEP_SLIDER:
                _loc11_ = this[param1 + param2.type];
                _loc3_ = Number(param2.changedVal);
                _loc4_ = -1;
                _loc5_ = param2.options.length;
                _loc8_ = 0;
                while (_loc8_ < _loc5_) {
                    if (param2.options[_loc8_].data == _loc3_) {
                        _loc4_ = _loc8_;
                        break;
                    }
                    _loc8_++;
                }
                _loc11_.dataProvider = new DataProvider(param2.options);
                _loc11_.inAdvancedMode = this._isAdvanced;
                _loc11_.validateNow();
                _loc6_ = _loc11_.value;
                _loc11_.value = _loc4_ != -1 ? Number(_loc4_) : Number(0);
                _loc7_ = param2.options[_loc11_.value].data;
                if (_loc6_ == _loc11_.value) {
                    if (param2.prevVal != _loc7_) {
                        param2.prevVal = param2.changedVal;
                        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, param1, _loc7_));
                    }
                }
                param2.changedVal = _loc7_;
                if (!this._isInited) {
                    _loc11_.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderOrderedValueChangeHandler);
                }
                break;
            case SettingsConfigHelper.TYPE_DROPDOWN:
                _loc12_ = this[param1 + param2.type];
                _loc3_ = Number(param2.changedVal);
                _loc4_ = -1;
                _loc5_ = param2.options.length;
                _loc8_ = 0;
                while (_loc8_ < _loc5_) {
                    if (param2.options[_loc8_].data == _loc3_) {
                        _loc4_ = _loc8_;
                        break;
                    }
                    _loc8_++;
                }
                _loc12_.menuRowCount = param2.options.length <= 7 ? Number(param2.options.length) : Number(7);
                _loc12_.dataProvider = new DataProvider(param2.options);
                _loc6_ = _loc12_.selectedIndex;
                _loc12_.selectedIndex = _loc4_ != -1 ? int(_loc4_) : 0;
                _loc7_ = param2.options[_loc12_.selectedIndex].data;
                if (_loc6_ == _loc12_.selectedIndex) {
                    if (param2.prevVal != _loc7_) {
                        param2.prevVal = param2.changedVal;
                        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, param1, _loc7_));
                    }
                }
                param2.changedVal = _loc7_;
                this.updateDropDownEnabled(param1);
                if (!this._isInited) {
                    _loc12_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownOrderedIndexChangeHandler);
                }
                if (param1 == SettingsConfigHelper.COLOR_GRADING_TECHNIQUE) {
                    this.updateColorFilterPreview(_loc7_);
                }
        }
    }

    private function updateExtendedAdvancedControlsData():void {
        var _loc1_:SettingsControlProp = null;
        var _loc2_:* = null;
        var _loc3_:Array = null;
        var _loc4_:* = null;
        if (this._extendAdvancedControls) {
            for (_loc2_ in this._extendAdvancedControls) {
                _loc1_ = SettingsControlProp(this._extendAdvancedControls[_loc2_]);
                _loc1_.options = [];
                _loc3_ = data[_loc2_].options;
                for (_loc4_ in _loc3_) {
                    if (this._isAdvanced || !_loc3_[_loc4_].advanced) {
                        _loc1_.options.push(_loc3_[_loc4_]);
                    }
                }
            }
        }
    }

    private function updateExtendedAdvancedControls():void {
        var _loc1_:SettingsControlProp = null;
        var _loc2_:* = null;
        if (this._extendAdvancedControls) {
            for (_loc2_ in this._extendAdvancedControls) {
                _loc1_ = SettingsControlProp(this._extendAdvancedControls[_loc2_]);
                this.updateAdvancedQualityControl(_loc2_, _loc1_);
            }
        }
    }

    private function updateSmoothingControl():void {
        var _loc4_:DropdownMenu = null;
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        var _loc1_:String = !!this._isAdvanced ? SettingsConfigHelper.CUSTOM_AA : SettingsConfigHelper.MULTISAMPLING;
        var _loc2_:SettingsControlProp = SettingsControlProp(data[SettingsConfigHelper.SMOOTHING]);
        var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc1_]);
        _loc2_.options = _loc3_.options;
        if (this[SettingsConfigHelper.SMOOTHING + _loc2_.type]) {
            _loc4_ = this[SettingsConfigHelper.SMOOTHING + _loc2_.type];
            _loc5_ = Number(_loc2_.changedVal);
            _loc4_.enabled = _loc2_.options && _loc2_.options.length > 0;
            _loc4_.dataProvider = new DataProvider(_loc2_.options);
            this.updateDropDownEnabled(SettingsConfigHelper.SMOOTHING);
            _loc6_ = _loc3_.prevVal >= 0 && _loc3_.prevVal < _loc2_.options.length ? Number(Number(_loc3_.prevVal)) : Number(0);
            if (!this._isInited) {
                _loc2_.current = _loc6_;
            }
            if (_loc5_ != _loc6_ || !this._isInited) {
                _loc4_.selectedIndex = _loc6_;
            }
            if (!this._isInited) {
                _loc4_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
            }
        }
    }

    private function updateCurrentPropForGraphicsOrderInPreset(param1:Object):void {
        var _loc2_:* = null;
        var _loc3_:SettingsControlProp = null;
        for (_loc2_ in param1) {
            if (_loc2_ != SettingsConfigHelper.RENDER_PIPELINE) {
                if (this._qualityOrderIdList.indexOf(_loc2_) >= 0) {
                    _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[_loc2_]);
                    _loc3_.changedVal = _loc3_.type == SettingsConfigHelper.TYPE_CHECKBOX ? Boolean(param1[_loc2_]) : Number(param1[_loc2_]);
                }
                else {
                    DebugUtils.LOG_WARNING("TRY SET DATA USE PRESET FOR CONTROL:", _loc2_);
                }
            }
        }
    }

    private function updateLiveVideoData():void {
        var _loc6_:String = null;
        var _loc7_:SettingsControlProp = null;
        var _loc10_:SettingsControlProp = null;
        var _loc11_:String = null;
        var _loc12_:SettingsControlProp = null;
        var _loc13_:Number = NaN;
        var _loc1_:CheckBox = null;
        var _loc2_:DropdownMenu = null;
        var _loc3_:Slider = null;
        var _loc4_:uint = SettingsConfigHelper.instance.liveUpdateVideoSettingsOrderData.length;
        var _loc5_:IDataUtils = App.utils.data;
        var _loc8_:uint = 0;
        while (_loc8_ < _loc4_) {
            _loc6_ = SettingsConfigHelper.instance.liveUpdateVideoSettingsOrderData[_loc8_];
            _loc7_ = SettingsControlProp(data[_loc6_]);
            if (SettingsConfigHelper.instance.liveUpdateVideoSettingsData[_loc6_]) {
                _loc10_ = SettingsControlProp(SettingsConfigHelper.instance.liveUpdateVideoSettingsData[_loc6_]);
                _loc7_.options = _loc5_.cloneObject(_loc10_.options);
                _loc7_.current = _loc10_.current;
            }
            _loc8_++;
        }
        var _loc9_:Boolean = false;
        _loc8_ = 0;
        while (_loc8_ < _loc4_) {
            _loc6_ = SettingsConfigHelper.instance.liveUpdateVideoSettingsOrderData[_loc8_];
            _loc7_ = SettingsControlProp(data[_loc6_]);
            if (_loc7_ && this[_loc6_ + _loc7_.type]) {
                switch (_loc7_.type) {
                    case SettingsConfigHelper.TYPE_CHECKBOX:
                        _loc1_ = CheckBox(this[_loc6_ + _loc7_.type]);
                        _loc1_.selected = Boolean(_loc7_.changedVal);
                        break;
                    case SettingsConfigHelper.TYPE_SLIDER:
                        if (SettingsConfigHelper.instance.liveUpdateVideoSettingsData[_loc6_]) {
                            _loc3_ = Slider(this[_loc6_ + _loc7_.type]);
                            _loc3_.value = Number(_loc7_.changedVal);
                        }
                        break;
                    case SettingsConfigHelper.TYPE_DROPDOWN:
                        _loc2_ = DropdownMenu(this[_loc6_ + _loc7_.type]);
                        if (_loc6_ == SettingsConfigHelper.SIZE) {
                            _loc11_ = !!isFullScreen ? SettingsConfigHelper.RESOLUTION : SettingsConfigHelper.WINDOW_SIZE;
                            _loc12_ = SettingsControlProp(SettingsConfigHelper.instance.liveUpdateVideoSettingsData[_loc11_]);
                            if (_loc12_ && _loc12_.options is Array) {
                                _loc13_ = monitorDropDown.selectedIndex;
                                SettingsControlProp(data[_loc11_]).prevVal[_loc13_] = _loc12_.changedVal;
                                _loc2_.dataProvider = new DataProvider(_loc12_.options[_loc13_]);
                                _loc2_.selectedIndex = int(_loc12_.changedVal);
                                _loc2_.enabled = _loc2_.dataProvider.length > 1;
                            }
                        }
                        else if (_loc6_ == SettingsConfigHelper.REFRESH_RATE) {
                            this.updateRefreshRate(true);
                        }
                        else if (_loc6_ == SettingsConfigHelper.INTERFACE_SCALE) {
                            _loc9_ = true;
                        }
                        else {
                            _loc2_.dataProvider = new DataProvider(_loc7_.options);
                            _loc2_.selectedIndex = int(_loc7_.changedVal);
                            this.updateDropDownEnabled(_loc6_);
                        }
                }
            }
            _loc8_++;
        }
        if (_loc9_) {
            this.updateInterfaceScale();
        }
    }

    private function updatePresetsDP():void {
        var _loc1_:String = SettingsConfigHelper.GRAPHIC_QUALITY;
        var _loc2_:SettingsControlProp = SettingsControlProp(data.getByKey(_loc1_));
        var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
        _loc3_.dataProvider = new DataProvider(!!this._isCustomPreset ? this._presetsWithCustomDP : this._onlyPresetsDP);
        this.updateDropDownEnabled(_loc1_);
    }

    private function trySearchSameSizeForAnotherMonitor(param1:String, param2:Array):Number {
        var _loc3_:RegExp = /\*/g;
        param1 = param1.replace(_loc3_, Values.EMPTY_STR);
        var _loc4_:Number = param2.indexOf(param1);
        return _loc4_ == -1 ? Number(param2.length - 1) : Number(_loc4_);
    }

    private function updateColorFilterPreview(param1:int):void {
        colorFilterOverlayImg.source = this._colorFilterPreviews[param1];
        colorFilterIntensitySlider.enabled = param1 != SettingsConfigHelper.NO_COLOR_FILTER_DATA;
        colorFilterIntensityValue.visible = param1 != SettingsConfigHelper.NO_COLOR_FILTER_DATA;
    }

    private function updateDynamicRendererSlider(param1:Boolean):void {
        var _loc2_:String = SettingsConfigHelper.DYNAMIC_RENDERER;
        var _loc3_:SettingsControlProp = SettingsControlProp(data[_loc2_]);
        var _loc4_:Slider = Slider(this[_loc2_ + _loc3_.type]);
        if (param1) {
            _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
            _loc4_.value = _loc4_.maximum;
            this.updateSliderLabel(_loc2_, _loc3_.hasValue, _loc4_.value.toString());
        }
        else {
            _loc4_.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
            _loc4_.value = Number(_loc3_.prevVal);
        }
        _loc4_.enabled = dynamicRendererValue.enabled = !param1;
    }

    private function updateSliderLabel(param1:String, param2:Boolean, param3:String):void {
        var _loc4_:LabelControl = null;
        var _loc5_:String = null;
        if (param2 && this[param1 + SettingsConfigHelper.TYPE_VALUE]) {
            _loc4_ = this[param1 + SettingsConfigHelper.TYPE_VALUE];
            _loc5_ = Values.EMPTY_STR;
            if (param1 == SettingsConfigHelper.DYNAMIC_RENDERER || param1 == SettingsConfigHelper.COLOR_FILTER_INTENSITY) {
                _loc5_ = POSTFIX_STR;
            }
            _loc4_.text = param3.toString() + _loc5_;
        }
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        if (initialized) {
            this.updateCurrentTab();
        }
    }

    private function onRefreshRateDropDownIndexChangeHandler(param1:ListEvent = null):void {
        var _loc2_:String = null;
        var _loc3_:SettingsControlProp = null;
        var _loc4_:DropdownMenu = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        if (isFullScreen) {
            _loc2_ = SettingsConfigHelper.REFRESH_RATE;
            _loc3_ = SettingsControlProp(data[_loc2_]);
            _loc4_ = this[_loc2_ + _loc3_.type];
            _loc5_ = int(_loc3_.changedVal);
            _loc6_ = int(_loc4_.dataProvider.requestItemAt(_loc4_.selectedIndex));
            if (_loc5_ != _loc6_) {
                _loc3_.prevVal = _loc5_;
                _loc3_.changedVal = _loc6_;
                dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc2_, _loc6_));
            }
        }
    }

    private function onGraphicsQualityIndexChangeHandler(param1:ListEvent):void {
        var _loc5_:SettingsControlProp = null;
        var _loc6_:ButtonBarEx = null;
        var _loc7_:Number = NaN;
        var _loc8_:Number = NaN;
        var _loc9_:int = 0;
        var _loc10_:Object = null;
        var _loc11_:Boolean = false;
        this._allowCheckPreset = false;
        var _loc2_:Object = param1.itemData;
        var _loc3_:String = _loc2_.key;
        this._presets.setByKey(CURRENT_STR, _loc2_.index);
        this._isCustomPreset = _loc3_ == SettingsConfigHelper.CUSTOM;
        this.updatePresetsDP();
        if (this._skipDispatchPresetEvent || this._isCustomPreset) {
            this._skipDispatchPresetEvent = false;
            this._allowCheckPreset = true;
            return;
        }
        this.updateCurrentPropForGraphicsOrderInPreset(_loc2_.settings);
        var _loc4_:String = SettingsConfigHelper.RENDER_PIPELINE;
        if (data[_loc4_] && this[_loc4_ + data[_loc4_].type] != undefined) {
            _loc5_ = SettingsControlProp(data[_loc4_]);
            _loc6_ = this[_loc4_ + _loc5_.type];
            _loc7_ = _loc6_.selectedItem[DATA_STR];
            _loc8_ = _loc2_.settings[SettingsConfigHelper.RENDER_PIPELINE];
            if (_loc7_ != _loc8_) {
                _loc9_ = this.getDPItemIndex(_loc6_.dataProvider, _loc8_);
                if (_loc9_ != -1) {
                    _loc10_ = _loc6_.dataProvider.requestItemAt(_loc9_);
                    _loc11_ = !!_loc10_.hasOwnProperty(SUPPORTED_STR) ? Boolean(_loc10_[SUPPORTED_STR]) : true;
                    if (_loc11_) {
                        _loc6_.selectedIndex = _loc9_;
                    }
                    else {
                        this._allowCheckPreset = true;
                        this.updateAdvancedDependedControls();
                    }
                }
            }
            else {
                this.updateAdvancedDependedControls();
            }
        }
        this._allowCheckPreset = true;
    }

    private function onGraphicsQualityRenderPipelineIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:Number = param1.index;
        var _loc3_:ButtonBarEx = ButtonBarEx(param1.target);
        var _loc4_:String = SettingsConfigHelper.instance.getControlId(_loc3_.name, SettingsConfigHelper.TYPE_BUTTON_BAR);
        var _loc5_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc4_]);
        var _loc6_:Number = _loc5_.options[_loc2_].data;
        var _loc7_:Boolean = this._isAdvanced;
        this._isAdvanced = _loc3_.selectedItem[DATA_STR] == SettingsConfigHelper.ADVANCED_GRAPHICS_DATA;
        _loc5_.prevVal = _loc5_.changedVal;
        _loc5_.changedVal = _loc6_;
        if (this._isAdvanced != _loc7_) {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc4_, _loc6_));
            this.updateAdvancedDependedControls();
        }
        this.tryFindPreset();
    }

    private function onDropDownIndexChangeHandler(param1:ListEvent):void {
        var _loc6_:String = null;
        var _loc7_:Number = NaN;
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
        var _loc5_:Number = _loc4_.isDataAsSelectedIndex && _loc4_.options[param1.index].hasOwnProperty(DATA_STR) ? Number(_loc4_.options[param1.index].data) : Number(param1.index);
        _loc4_.changedVal = _loc5_;
        if (_loc3_ == SettingsConfigHelper.SMOOTHING) {
            _loc6_ = !!this._isAdvanced ? SettingsConfigHelper.CUSTOM_AA : SettingsConfigHelper.MULTISAMPLING;
            _loc4_ = SettingsControlProp(data[_loc6_]);
            _loc4_.changedVal = _loc5_;
            _loc4_.prevVal = _loc5_;
        }
        else if (_loc3_ == SettingsConfigHelper.SIZE) {
            _loc3_ = !!isFullScreen ? SettingsConfigHelper.RESOLUTION : SettingsConfigHelper.WINDOW_SIZE;
            _loc4_ = SettingsControlProp(data[_loc3_]);
            _loc4_.changedVal = _loc5_;
            _loc7_ = monitorDropDown.selectedIndex;
            _loc4_.prevVal[_loc7_] = _loc5_;
            this.updateRefreshRate();
            this.updateInterfaceScale();
        }
        else {
            _loc4_.prevVal = _loc5_;
        }
        if (_loc3_ == SettingsConfigHelper.MONITOR) {
            this.setSizeControl();
            this.updateRefreshRate();
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc5_));
    }

    private function onRangeSliderValueChangeHandler(param1:SliderEvent):void {
        var _loc2_:RangeSlider = RangeSlider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(RangeSlider(param1.target).name, SettingsConfigHelper.TYPE_RANGE_SLIDER);
        var _loc4_:Array = [_loc2_.value, _loc2_.leftValue, _loc2_.rightValue];
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc4_));
    }

    private function onSliderValueChangeHandler(param1:SliderEvent):void {
        var _loc2_:Slider = Slider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(Slider(param1.target).name, SettingsConfigHelper.TYPE_SLIDER);
        var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
        this.updateSliderLabel(_loc3_, _loc4_.hasValue, _loc2_.value.toString());
        _loc4_.prevVal = _loc2_.value;
        if (_loc3_ == SettingsConfigHelper.COLOR_FILTER_INTENSITY) {
            colorFilterOverlayImg.alpha = _loc2_.value / 100;
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, Slider(param1.target).value));
    }

    private function onCheckBoxSelectHandler(param1:Event):void {
        var _loc2_:CheckBox = CheckBox(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_CHECKBOX);
        var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
        _loc4_.changedVal = _loc2_.selected;
        if (_loc3_ == SettingsConfigHelper.FULL_SCREEN) {
            isFullScreen = _loc2_.selected;
            this.updateFullScreenDependentControls();
            this.setSizeControl();
            this.updateRefreshRate();
        }
        else if (_loc3_ == SettingsConfigHelper.DYNAMIC_FOV) {
            fovRangeSlider.rangeMode = _loc2_.selected;
            this.setInitialFOVValues();
        }
        if (_loc4_.isDependOn) {
            this.updateDependedControl(_loc3_);
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc2_.selected));
    }

    private function onCheckBoxOrderedSelectHandler(param1:Event):void {
        var _loc2_:CheckBox = CheckBox(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_CHECKBOX);
        var _loc4_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
        _loc4_.changedVal = _loc2_.selected;
        if (_loc3_ == SettingsConfigHelper.DRR_AUTOSCALER_ENABLED) {
            this.updateDynamicRendererSlider(_loc2_.selected);
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc2_.selected));
        this.tryFindPreset();
    }

    private function onDropDownOrderedIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        var _loc4_:SettingsControlProp = null;
        if (this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0) {
            _loc4_ = SettingsControlProp(this._extendAdvancedControls[_loc3_]);
        }
        else {
            _loc4_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
        }
        var _loc5_:Number = _loc4_.options[param1.index].data;
        _loc4_.prevVal = _loc4_.changedVal;
        _loc4_.changedVal = _loc5_;
        if (_loc3_ == SettingsConfigHelper.COLOR_GRADING_TECHNIQUE) {
            this.updateColorFilterPreview(_loc5_);
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc5_));
        this.tryFindPreset();
    }

    private function onSliderOrderedValueChangeHandler(param1:SliderEvent):void {
        var _loc2_:SettingsStepSlider = SettingsStepSlider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_STEP_SLIDER);
        var _loc4_:SettingsControlProp = null;
        if (this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0) {
            _loc4_ = SettingsControlProp(this._extendAdvancedControls[_loc3_]);
        }
        else {
            _loc4_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
        }
        var _loc5_:Number = _loc4_.options[_loc2_.value].data;
        _loc4_.prevVal = _loc4_.changedVal;
        _loc4_.changedVal = _loc5_;
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc5_));
        this.tryFindPreset();
    }

    private function onAutodetectClickHandler(param1:ButtonEvent):void {
        autodetectQuality.enabled = false;
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_AUTO_DETECT_QUALITY, viewId));
    }
}
}

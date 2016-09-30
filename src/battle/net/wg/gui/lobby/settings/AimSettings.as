package net.wg.gui.lobby.settings {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.events.SettingViewEvent;
import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class AimSettings extends AimSettingsBase {

    private static const FORM:String = "Form";

    private static const GUN_TAG_TYPE:String = "gunTagType";

    private static const GUN_TAG:String = "gunTag";

    private static const MIXING_TYPE:String = "mixingType";

    private static const MIXING:String = "mixing";

    private static const RELOADING_TIME:Number = 4.2;

    private static const CROSSHAIR_SCALE:Number = 0.14;

    private static const CENTRAL_TAG_TYPE_STR:String = "centralTagType";

    private static const CENTRAL_TAG_STR:String = "centralTag";

    private static const NET_STR:String = "net";

    private static const NET_TYPE_STR:String = NET_STR + "Type";

    private static const RELOADER_STR:String = "reloader";

    private static const CONDITION_STR:String = "condition";

    private static const CASSETTE_STR:String = "cassette";

    private static const RELOADER_TIMER_STR:String = RELOADER_STR + "Timer";

    private static const ZOOM_INDICATOR_STR:String = "zoomIndicator";

    private static const TYPE_STR:String = "type";

    private static const NORMAL_STR:String = "normal";

    private static const DEFAULT_TYPE_STR:String = TYPE_STR + "0";

    private var _currentTab:uint = 0;

    private var _dynamicCursorsData:Object = null;

    private var _setDataInProgress:Boolean = false;

    public function AimSettings() {
        super();
    }

    override public function toString():String {
        return "[WG AimSettings " + name + "]";
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc12_:int = 0;
        var _loc13_:SettingsArcadeForm = null;
        super.setData(param1);
        this._dynamicCursorsData = {};
        this._setDataInProgress = true;
        var _loc2_:Vector.<String> = param1.keys;
        var _loc3_:Vector.<Object> = param1.values;
        var _loc4_:int = _loc2_.length;
        var _loc5_:SettingsDataVo = null;
        var _loc6_:Vector.<String> = null;
        var _loc7_:Vector.<Object> = null;
        var _loc8_:String = Values.EMPTY_STR;
        var _loc9_:int = 0;
        var _loc10_:String = Values.EMPTY_STR;
        var _loc11_:int = 0;
        while (_loc11_ < _loc4_) {
            _loc8_ = _loc2_[_loc11_];
            _loc5_ = _loc3_[_loc11_] as SettingsDataVo;
            App.utils.asserter.assertNotNull(_loc5_, "values[i] must be SettingsDataVo");
            if (this[_loc8_ + FORM]) {
                _loc13_ = SettingsArcadeForm(this[_loc8_ + FORM]);
                _loc13_.setData(_loc8_, _loc5_);
                _loc13_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormAimOnControlChangeHandler);
            }
            _loc6_ = _loc5_.keys;
            _loc7_ = _loc5_.values;
            _loc9_ = _loc5_.keys.length;
            _loc12_ = 0;
            while (_loc12_ < _loc9_) {
                _loc10_ = _loc6_[_loc12_];
                if (!this._dynamicCursorsData.hasOwnProperty(_loc8_)) {
                    this._dynamicCursorsData[_loc8_] = {};
                }
                this._dynamicCursorsData[_loc8_][_loc10_] = !!SettingsControlProp(_loc7_[_loc12_]).current ? SettingsControlProp(_loc7_[_loc12_]).current : 0;
                _loc12_++;
            }
            _loc11_++;
        }
        this._setDataInProgress = false;
        tabs.dataProvider = new DataProvider(SettingsConfigHelper.instance.cursorTabsDataProvider);
        tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        tabs.selectedIndex = this._currentTab;
    }

    override protected function onBeforeDispose():void {
        tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        arcadeForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormAimOnControlChangeHandler);
        sniperForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onFormAimOnControlChangeHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._dynamicCursorsData = null;
        super.onDispose();
    }

    private function updateShowContent():void {
        var _loc3_:SettingsArcadeForm = null;
        var _loc4_:MovieClip = null;
        var _loc1_:uint = SettingsConfigHelper.instance.cursorTabsDataProvider.length;
        var _loc2_:uint = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = SettingsArcadeForm(this[SettingsConfigHelper.instance.cursorTabsDataProvider[_loc2_].formID]);
            _loc3_.visible = _loc3_.id == SettingsConfigHelper.instance.cursorTabsDataProvider[this._currentTab].id;
            _loc4_ = MovieClip(this[SettingsConfigHelper.instance.cursorTabsDataProvider[_loc2_].crosshairID]);
            _loc4_.visible = _loc3_.visible;
            _loc2_++;
        }
        this.updateCrosshairs(this._currentTab);
    }

    private function updateCrosshairs(param1:Number):void {
        var _loc20_:TextField = null;
        var _loc21_:TextField = null;
        var _loc2_:String = SettingsConfigHelper.instance.cursorTabsDataProvider[param1].id;
        var _loc3_:Object = this._dynamicCursorsData[_loc2_];
        var _loc4_:* = param1 == 0;
        var _loc5_:Number = 0;
        var _loc6_:String = !!_loc3_[CENTRAL_TAG_TYPE_STR] ? TYPE_STR + _loc3_[CENTRAL_TAG_TYPE_STR] : DEFAULT_TYPE_STR;
        var _loc7_:Number = !!_loc3_[CENTRAL_TAG_STR] ? Number(_loc3_[CENTRAL_TAG_STR] / 100) : Number(0);
        var _loc8_:String = !!_loc3_[NET_TYPE_STR] ? TYPE_STR + _loc3_[NET_TYPE_STR] : DEFAULT_TYPE_STR;
        var _loc9_:Number = !!_loc3_[NET_STR] ? Number(_loc3_[NET_STR] / 100) : Number(0);
        var _loc10_:Number = !!_loc3_[RELOADER_STR] ? Number(_loc3_[RELOADER_STR] / 100) : Number(0);
        var _loc11_:Number = !!_loc3_[CONDITION_STR] ? Number(_loc3_[CONDITION_STR] / 100) : Number(0);
        var _loc12_:Number = !!_loc3_[CASSETTE_STR] ? Number(_loc3_[CASSETTE_STR] / 100) : Number(0);
        var _loc13_:Number = !!_loc3_[RELOADER_TIMER_STR] ? Number(_loc3_[RELOADER_TIMER_STR] / 100) : Number(0);
        var _loc14_:Boolean = _loc3_[ZOOM_INDICATOR_STR];
        var _loc15_:Number = !!_loc14_ ? Number(_loc3_[ZOOM_INDICATOR_STR] / 100) : Number(0);
        var _loc16_:MovieClip = null;
        switch (param1) {
            case 0:
                _loc16_ = arcadeCursor;
                break;
            case 1:
                _loc16_ = snipperCursor;
        }
        if (_loc16_) {
            _loc16_.center.gotoAndStop(_loc6_);
            _loc16_.center.alpha = _loc7_;
            _loc16_.gotoAndStop(_loc8_);
            _loc16_.grid1.alpha = _loc9_;
            _loc16_.reloadingBarMC.alpha = _loc10_;
            _loc16_.universalBarMC.alpha = _loc11_;
            _loc16_.timerTextField.alpha = _loc13_;
            _loc16_.cassette.alpha = _loc12_;
            if (_loc14_) {
                _loc21_ = _loc16_.zoomTF;
                _loc21_.alpha = _loc15_;
                _loc21_.text = App.utils.locale.makeString(SETTINGS.MULTISAMPLINGTYPE_TYPE2);
            }
            switch (_loc16_.currentFrame) {
                case 1:
                    _loc5_ = -1;
                    break;
                case 2:
                    _loc5_ = 13;
                    break;
                case 3:
                    _loc5_ = -1;
                    break;
                default:
                    _loc5_ = 0;
            }
            _loc16_.cassette.y = _loc5_;
            if (!_loc4_ && _loc16_.currentFrame == 1) {
                _loc16_.cassette.x = -29;
                _loc16_.center.x = 10;
            }
            else {
                _loc16_.cassette.x = -39;
                _loc16_.center.x = 0;
            }
            _loc16_.targetMC.gotoAndStop(60);
            _loc16_.universalBarMC.gotoAndStop(60);
            _loc16_.reloadingBarMC.gotoAndStop(60);
            _loc20_ = _loc16_.timerTextField as TextField;
            if (_loc20_) {
                _loc20_.text = App.utils.locale.float(RELOADING_TIME);
            }
        }
        var _loc17_:Object = this._dynamicCursorsData[_loc2_];
        var _loc18_:MovieClip = crosshairMC.radiusMC;
        var _loc19_:MovieClip = crosshairMC.markerMC;
        _loc18_.scaleX = crosshairMC.radiusMC.scaleY = CROSSHAIR_SCALE;
        _loc19_.gotoAndStop(TYPE_STR + _loc17_[GUN_TAG_TYPE]);
        _loc19_.alpha = _loc17_[GUN_TAG] / 100;
        _loc18_.gotoAndStop(TYPE_STR + _loc17_[MIXING_TYPE]);
        _loc18_.mixingMC.gotoAndStop(37);
        _loc18_.mixingMC.alpha = _loc17_[MIXING] / 100;
        _loc19_.tag.gotoAndStop(NORMAL_STR);
    }

    private function onFormAimOnControlChangeHandler(param1:SettingsSubVewEvent):void {
        if (this._setDataInProgress) {
            return;
        }
        var _loc2_:String = param1.subViewId;
        var _loc3_:String = param1.controlId;
        var _loc4_:Object = {};
        _loc4_[_loc3_] = param1.controlValue;
        if (this._dynamicCursorsData != null) {
            this._dynamicCursorsData[_loc2_][param1.controlId] = param1.controlValue;
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc2_, _loc4_));
        this.updateCrosshairs(this._currentTab);
    }

    private function onTabIndexChangeHandler(param1:IndexEvent):void {
        this._currentTab = param1.index;
        this.updateShowContent();
    }
}
}

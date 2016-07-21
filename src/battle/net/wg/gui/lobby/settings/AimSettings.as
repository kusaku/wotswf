package net.wg.gui.lobby.settings {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.crosshair.ClipQuantityBar;
import net.wg.gui.components.crosshair.CrosshairSniper;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
import net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class AimSettings extends SettingsBaseView {

    private static const FORM:String = "Form";

    private static const GUN_TAG_TYPE:String = "gunTagType";

    private static const GUN_TAG:String = "gunTag";

    private static const MIXING_TYPE:String = "mixingType";

    private static const MIXING:String = "mixing";

    private static const RELOADING_TIME:String = "4.20";

    private static const CROSSHAIR_SCALE:Number = 0.14;

    public var tabs:ButtonBarEx = null;

    public var arcadeForm:SettingsArcadeForm = null;

    public var sniperForm:SettingsArcadeForm = null;

    public var crosshairMC:CrosshairSniper = null;

    public var arcadeCursor:MovieClip = null;

    public var snipperCursor:MovieClip = null;

    private var _currentTab:uint = 0;

    private var _cassete:ClipQuantityBar = null;

    private var _snpCassete:ClipQuantityBar = null;

    private var _dynamicCursorsData:Object = null;

    private var _setDataInProgress:Boolean = false;

    public function AimSettings() {
        super();
    }

    override public function toString():String {
        return "[WG AimSettings " + name + "]";
    }

    override public function update(param1:Object):void {
        super.update(param1);
    }

    override protected function configUI():void {
        super.configUI();
        this._cassete = ClipQuantityBar.create(7, 1);
        this._cassete.quantityInClip = 7;
        this._cassete.clipState = "normal";
        this._snpCassete = ClipQuantityBar.create(7, 1);
        this._snpCassete.quantityInClip = 7;
        this._snpCassete.clipState = "normal";
        MovieClip(this.arcadeCursor.cassette).addChild(this._cassete);
        MovieClip(this.snipperCursor.cassette).addChild(this._snpCassete);
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
            if (this[_loc8_ + FORM]) {
                _loc13_ = SettingsArcadeForm(this[_loc8_ + FORM]);
                _loc13_.setData(_loc8_, _loc5_);
                _loc13_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
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
        this.tabs.dataProvider = new DataProvider(SettingsConfigHelper.instance.cursorTabsDataProvider);
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabChange);
        this.tabs.selectedIndex = this._currentTab;
    }

    override protected function onDispose():void {
        this._dynamicCursorsData = null;
        if (this._cassete && this.arcadeCursor) {
            MovieClip(this.arcadeCursor.cassette).removeChild(this._cassete);
        }
        if (this._snpCassete && this.snipperCursor) {
            MovieClip(this.snipperCursor.cassette).removeChild(this._snpCassete);
        }
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabChange);
        if (this.arcadeForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE)) {
            this.arcadeForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
        }
        if (this.sniperForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE)) {
            this.sniperForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
        }
        this.arcadeForm.dispose();
        this.arcadeForm = null;
        this.sniperForm.dispose();
        this.sniperForm = null;
        this.tabs.dispose();
        this.tabs = null;
        this._cassete = null;
        this._snpCassete = null;
        this.crosshairMC = null;
        this.arcadeCursor = null;
        this.snipperCursor = null;
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
        var _loc17_:TextField = null;
        var _loc18_:TextField = null;
        var _loc2_:String = SettingsConfigHelper.instance.cursorTabsDataProvider[param1].id;
        var _loc3_:Object = this._dynamicCursorsData[_loc2_];
        var _loc4_:* = param1 == 0;
        var _loc5_:Number = 0;
        var _loc6_:String = !!_loc3_["centralTagType"] ? "type" + _loc3_["centralTagType"] : "type0";
        var _loc7_:Number = !!_loc3_["centralTag"] ? Number(_loc3_["centralTag"] / 100) : Number(0);
        var _loc8_:String = !!_loc3_["netType"] ? "type" + _loc3_["netType"] : "type0";
        var _loc9_:Number = !!_loc3_["net"] ? Number(_loc3_["net"] / 100) : Number(0);
        var _loc10_:Number = !!_loc3_["reloader"] ? Number(_loc3_["reloader"] / 100) : Number(0);
        var _loc11_:Number = !!_loc3_["condition"] ? Number(_loc3_["condition"] / 100) : Number(0);
        var _loc12_:Number = !!_loc3_["cassette"] ? Number(_loc3_["cassette"] / 100) : Number(0);
        var _loc13_:Number = !!_loc3_["reloaderTimer"] ? Number(_loc3_["reloaderTimer"] / 100) : Number(0);
        var _loc14_:Boolean = _loc3_["zoomIndicator"];
        var _loc15_:Number = !!_loc14_ ? Number(_loc3_["zoomIndicator"] / 100) : Number(0);
        var _loc16_:MovieClip = null;
        switch (param1) {
            case 0:
                _loc16_ = this.arcadeCursor;
                break;
            case 1:
                _loc16_ = this.snipperCursor;
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
                _loc18_ = _loc16_.zoomTF;
                _loc18_.alpha = _loc15_;
                _loc18_.text = App.utils.locale.makeString(SETTINGS.MULTISAMPLINGTYPE_TYPE2);
            }
            switch (_loc16_.currentFrame) {
                case 1:
                    _loc5_ = -1;
                    break;
                case 2:
                    _loc5_ = 13;
                    break;
                case 3:
                    if (_loc4_) {
                        _loc5_ = -11;
                    }
                    else {
                        _loc5_ = -1;
                    }
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
            _loc17_ = _loc16_.timerTextField as TextField;
            if (_loc17_) {
                _loc17_.text = RELOADING_TIME;
            }
        }
        this.setCrossHair(this._dynamicCursorsData[_loc2_][GUN_TAG_TYPE], this._dynamicCursorsData[_loc2_][GUN_TAG], this._dynamicCursorsData[_loc2_][MIXING_TYPE], this._dynamicCursorsData[_loc2_][MIXING]);
    }

    private function setCrossHair(param1:String, param2:Number, param3:String, param4:Number):void {
        this.crosshairMC.radiusMC.scaleX = this.crosshairMC.radiusMC.scaleY = CROSSHAIR_SCALE;
        this.crosshairMC.markerMC.gotoAndStop("type" + param1);
        this.crosshairMC.markerMC.alpha = param2 / 100;
        this.crosshairMC.radiusMC.gotoAndStop("type" + param3);
        this.crosshairMC.radiusMC.mixingMC.gotoAndStop(37);
        this.crosshairMC.radiusMC.mixingMC.alpha = param4 / 100;
        this.crosshairMC.markerMC.tag.gotoAndStop("normal");
    }

    private function onControlChange(param1:SettingsSubVewEvent):void {
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
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc2_, _loc4_));
        this.updateCrosshairs(this._currentTab);
    }

    private function onTabChange(param1:IndexEvent):void {
        this._currentTab = param1.index;
        this.updateShowContent();
    }
}
}

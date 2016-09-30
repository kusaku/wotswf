package net.wg.gui.lobby.settings.feedback {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.settings.SettingsBaseView;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.events.SettingViewEvent;
import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
import net.wg.gui.lobby.settings.interfaces.IViewWithCounteredBar;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.FeedbackSettingsDataVo;

import scaleform.clik.controls.ButtonBar;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class FeedbackSettings extends SettingsBaseView implements IViewWithCounteredBar {

    public var tabs:ButtonBarEx = null;

    public var viewStack:ViewStack = null;

    private var _currentTabIdx:int = 0;

    private var _currentViewLinkage:String;

    private var _tabsDataProvider:DataProvider = null;

    private var _feedbackData:FeedbackSettingsDataVo = null;

    private var _dynamicFeedbackData:Object = null;

    private var _setDataInProgress:Boolean = false;

    public function FeedbackSettings() {
        super();
        this._tabsDataProvider = SettingsConfigHelper.instance.feedbackDataProvider;
    }

    override protected function configUI():void {
        super.configUI();
        this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewViewChangedHandler);
        this.viewStack.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onViewStackOnControlChangeHandler, true);
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc5_:int = 0;
        var _loc6_:String = null;
        var _loc7_:String = null;
        var _loc8_:SettingsControlProp = null;
        var _loc13_:int = 0;
        super.setData(param1);
        this._feedbackData = FeedbackSettingsDataVo(param1);
        App.utils.data.cleanupDynamicObject(this._dynamicFeedbackData);
        this._dynamicFeedbackData = {};
        this._setDataInProgress = true;
        var _loc2_:Vector.<String> = param1.keys;
        var _loc3_:Vector.<Object> = param1.values;
        var _loc4_:int = _loc2_.length;
        var _loc9_:SettingsDataVo = null;
        var _loc10_:Vector.<String> = null;
        var _loc11_:Vector.<Object> = null;
        var _loc12_:int = 0;
        while (_loc12_ < _loc4_) {
            _loc6_ = _loc2_[_loc12_];
            _loc9_ = SettingsDataVo(_loc3_[_loc12_]);
            _loc10_ = _loc9_.keys;
            _loc11_ = _loc9_.values;
            _loc5_ = _loc10_.length;
            _loc13_ = 0;
            while (_loc13_ < _loc5_) {
                _loc7_ = _loc10_[_loc13_];
                if (!this._dynamicFeedbackData.hasOwnProperty(_loc6_)) {
                    this._dynamicFeedbackData[_loc6_] = {};
                }
                App.utils.asserter.assertNotNull(_loc9_, Errors.CANT_NULL);
                _loc8_ = SettingsControlProp(_loc11_[_loc13_]);
                this._dynamicFeedbackData[_loc6_][_loc7_] = _loc8_.current;
                _loc13_++;
            }
            _loc12_++;
        }
        this._setDataInProgress = false;
        this.tabs.dataProvider = this._tabsDataProvider;
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.tabs.selectedIndex = this._currentTabIdx;
    }

    override protected function onDispose():void {
        this._dynamicFeedbackData = App.utils.data.cleanupDynamicObject(this._dynamicFeedbackData);
        this._dynamicFeedbackData = null;
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.tabs.dispose();
        this.tabs = null;
        this.viewStack.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onViewStackOnControlChangeHandler, true);
        this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewViewChangedHandler);
        this.viewStack.dispose();
        this.viewStack = null;
        this._tabsDataProvider = null;
        this._feedbackData = null;
        super.onDispose();
    }

    private function onViewViewChangedHandler(param1:ViewStackEvent):void {
        var _loc2_:BaseForm = BaseForm(param1.view);
        _loc2_.setData(this._feedbackData[this._currentViewLinkage]);
        _loc2_.updateContent(this._dynamicFeedbackData[this._currentViewLinkage]);
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        this._currentTabIdx = param1.index;
        this._currentViewLinkage = this._tabsDataProvider[this._currentTabIdx].linkage;
        this.viewStack.show(this._currentViewLinkage);
    }

    private function onViewStackOnControlChangeHandler(param1:SettingsSubVewEvent):void {
        if (this._setDataInProgress) {
            return;
        }
        var _loc2_:String = param1.subViewId;
        var _loc3_:String = param1.controlId;
        var _loc4_:Object = {};
        _loc4_[_loc3_] = param1.controlValue;
        this._dynamicFeedbackData[_loc2_][_loc3_] = param1.controlValue;
        BaseForm(param1.target).updateContent(this._dynamicFeedbackData[this._currentViewLinkage]);
        var _loc5_:SettingViewEvent = new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, param1.controlValue);
        dispatchEvent(_loc5_);
    }

    public function getCounteredBar():ButtonBar {
        return this.tabs;
    }
}
}

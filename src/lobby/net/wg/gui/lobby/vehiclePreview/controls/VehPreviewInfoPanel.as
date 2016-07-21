package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.ResizableScrollPane;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoTabDataItemVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewInfoPanelEvent;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanel;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanelTab;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ComponentEvent;

public class VehPreviewInfoPanel extends UIComponentEx implements IVehPreviewInfoPanel {

    private static const SCROLL_STEP_FACTOR:Number = 10;

    private static const SCROLL_PANE_DEFAULT_X:int = 19;

    private static const SCROLL_PANE_WITH_BAR_X:int = 42;

    private static const MIN_BACKGROUND_HEIGHT:int = 244;

    private static const INV_CURRENT_VIEW:String = "invCurrentView";

    public var background:DisplayObject;

    public var tabButtonBar:ButtonBarEx;

    public var scrollPane:ResizableScrollPane;

    public var scrollBar:ScrollBar;

    public var flag:MovieClip;

    private var _tabViewStack:ViewStack;

    private var _flagHitArea:Sprite;

    private var _data:VehPreviewInfoPanelVO;

    public function VehPreviewInfoPanel() {
        super();
        this._flagHitArea = new Sprite();
        addChild(this._flagHitArea);
        this.flag.hitArea = this._flagHitArea;
        this._tabViewStack = ViewStack(this.scrollPane.target);
        this._tabViewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onTabViewStackViewChangedHandler);
        this.scrollBar.addEventListener(ComponentEvent.SHOW, this.onScrollBarShowHandler);
        this.scrollBar.addEventListener(ComponentEvent.HIDE, this.onScrollBarHideHandler);
    }

    override protected function configUI():void {
        super.configUI();
        this.scrollPane.scrollBar = this.scrollBar;
        this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
        this._tabViewStack.groupRef = this.tabButtonBar;
        this._tabViewStack.cache = true;
    }

    override protected function onDispose():void {
        this._tabViewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onTabViewStackViewChangedHandler);
        this.scrollBar.removeEventListener(ComponentEvent.SHOW, this.onScrollBarShowHandler);
        this.scrollBar.removeEventListener(ComponentEvent.HIDE, this.onScrollBarHideHandler);
        this._tabViewStack = null;
        this.background = null;
        this.tabButtonBar.dispose();
        this.tabButtonBar = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        this.scrollBar.dispose();
        this.scrollBar = null;
        removeChild(this._flagHitArea);
        this._flagHitArea = null;
        this.flag.hitArea = null;
        this.flag = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:IVehPreviewInfoPanelTab = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        super.draw();
        if (this._tabViewStack.currentView != null) {
            if (isInvalid(INV_CURRENT_VIEW)) {
                IViewStackContent(this._tabViewStack.currentView).update(this.getSelectedTabData());
                invalidateSize();
            }
            if (isInvalid(InvalidationType.SIZE)) {
                _loc1_ = IVehPreviewInfoPanelTab(this._tabViewStack.currentView);
                _loc2_ = this.height;
                _loc3_ = this.scrollPane.y + _loc1_.height + _loc1_.bottomMargin;
                if (_loc3_ > _loc2_) {
                    _loc3_ = _loc2_;
                }
                else if (_loc3_ < MIN_BACKGROUND_HEIGHT) {
                    _loc3_ = MIN_BACKGROUND_HEIGHT;
                }
                _loc4_ = _loc3_ - this.scrollPane.y - _loc1_.bottomMargin;
                this.scrollPane.height = _loc4_;
                this.scrollBar.height = _loc4_;
                this.background.height = _loc3_;
                this.setScrollPaneOffset();
            }
        }
    }

    public function update(param1:Object):void {
        this._data = VehPreviewInfoPanelVO(param1);
        this.tabButtonBar.selectedIndex = this._data.selectedTab;
        invalidate(INV_CURRENT_VIEW);
    }

    public function updateTabButtonsData(param1:Array):void {
        if (this.tabButtonBar.dataProvider != null) {
            this.tabButtonBar.dataProvider.cleanUp();
        }
        this.tabButtonBar.dataProvider = new DataProvider(param1);
    }

    private function getSelectedTabData():DAAPIDataClass {
        var _loc1_:int = this.tabButtonBar.selectedIndex;
        App.utils.asserter.assert(_loc1_ >= 0 && _loc1_ < this._data.tabData.length, "Invalid selected index.");
        return this._data.tabData[_loc1_].voData;
    }

    private function setScrollPaneOffset():void {
        this.scrollPane.x = !!this.scrollBar.visible ? Number(SCROLL_PANE_WITH_BAR_X) : Number(SCROLL_PANE_DEFAULT_X);
    }

    private function onScrollBarShowHandler(param1:ComponentEvent):void {
        this.setScrollPaneOffset();
    }

    private function onScrollBarHideHandler(param1:ComponentEvent):void {
        this.setScrollPaneOffset();
    }

    private function onTabViewStackViewChangedHandler(param1:ViewStackEvent):void {
        var _loc2_:VehPreviewInfoTabDataItemVO = VehPreviewInfoTabDataItemVO(this.getSelectedTabData());
        this.flag.visible = _loc2_.showNationFlag;
        if (this.flag.visible) {
            this.flag.gotoAndStop(this._data.nation);
        }
        dispatchEvent(new VehPreviewInfoPanelEvent(VehPreviewInfoPanelEvent.INFO_TAB_CHANGED, this.tabButtonBar.selectedIndex, true));
        invalidate(INV_CURRENT_VIEW);
    }
}
}

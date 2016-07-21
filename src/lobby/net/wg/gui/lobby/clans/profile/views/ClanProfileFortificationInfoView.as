package net.wg.gui.lobby.clans.profile.views {
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewInitVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewVO;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileFortificationTabView;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileFortificationTabbedView;
import net.wg.infrastructure.base.meta.IClanProfileFortificationInfoViewMeta;
import net.wg.infrastructure.base.meta.impl.ClanProfileFortificationInfoViewMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class ClanProfileFortificationInfoView extends ClanProfileFortificationInfoViewMeta implements IClanProfileFortificationInfoViewMeta {

    private static const INV_TABS:String = "invTabs";

    private static const INV_FORT_DATA:String = "invFortData";

    public var viewStack:ViewStack = null;

    private var _tabsDataProvider:DataProvider = null;

    private var _tabbedView:IClanProfileFortificationTabbedView = null;

    private var _clanProfileFortificationViewVO:ClanProfileFortificationViewVO = null;

    public function ClanProfileFortificationInfoView() {
        super();
        this.viewStack.cache = true;
        this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewStackViewChangedHandler);
    }

    override protected function setData(param1:ClanProfileFortificationViewInitVO):void {
        this.clearTabsProvider();
        this._tabsDataProvider = new DataProvider(param1.tabDataProvider);
        invalidate(INV_TABS);
    }

    override protected function setFortData(param1:ClanProfileFortificationViewVO):void {
        this._clanProfileFortificationViewVO = param1;
        invalidate(INV_FORT_DATA);
    }

    override protected function onDispose():void {
        this.clearTabsProvider();
        this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewStackViewChangedHandler);
        this.viewStack.dispose();
        this.viewStack = null;
        this.removeTabbedView();
        this._clanProfileFortificationViewVO = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._tabbedView != null && isInvalid(INV_TABS)) {
            this._tabbedView.setTabsProvider(this._tabsDataProvider);
            this._tabbedView.selectTabIndex(0);
        }
        if (this._clanProfileFortificationViewVO != null && isInvalid(INV_FORT_DATA)) {
            this.updateCurrentViewData();
        }
    }

    public function clearTabsProvider():void {
        if (this._tabsDataProvider) {
            this._tabsDataProvider.cleanUp();
            this._tabsDataProvider = null;
        }
    }

    public function removeTabbedView():void {
        if (this._tabbedView != null) {
            this._tabbedView.removeTabIndexChangedEventListener(this.onTabIndexChangedHandler);
            this._tabbedView = null;
        }
    }

    public function setTabbedView(param1:IClanProfileFortificationTabbedView):void {
        if (this._tabbedView != null) {
            this._tabbedView.removeTabIndexChangedEventListener(this.onTabIndexChangedHandler);
        }
        this._tabbedView = param1;
        this._tabbedView.addTabIndexChangedEventListener(this.onTabIndexChangedHandler);
        invalidate(INV_TABS);
    }

    private function updateCurrentViewData():void {
        var _loc1_:IClanProfileFortificationTabView = IClanProfileFortificationTabView(this.viewStack.currentView);
        if (_loc1_ != null && !_loc1_.isDataSet()) {
            _loc1_.setData(this._clanProfileFortificationViewVO);
        }
    }

    private function onViewStackViewChangedHandler(param1:ViewStackEvent):void {
        this.updateCurrentViewData();
    }

    private function onTabIndexChangedHandler(param1:IndexEvent):void {
        var _loc2_:String = ClanTabDataProviderVO(param1.data).linkage;
        this.viewStack.show(_loc2_);
    }
}
}

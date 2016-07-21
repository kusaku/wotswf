package net.wg.gui.lobby.clans.profile.views {
import flash.display.DisplayObject;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.CLANS_ALIASES;
import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.components.advanced.interfaces.IDummy;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileFortificationTabbedView;
import net.wg.infrastructure.base.meta.IClanProfileFortificationViewMeta;
import net.wg.infrastructure.base.meta.impl.ClanProfileFortificationViewMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class ClanProfileFortificationView extends ClanProfileFortificationViewMeta implements IClanProfileFortificationViewMeta, IClanProfileFortificationTabbedView {

    private static const INV_BODY_DUMMY_DATA:String = "invBodyDummyData";

    private static const BODY_DUMMY_X:int = 0;

    private static const BODY_DUMMY_Y:int = 94;

    private static const BODY_DUMMY_WIDTH:int = 1006;

    private static const BODY_DUMMY_HEIGHT:int = 503;

    public var tabs:ContentTabBar = null;

    private var _bodyDummy:IDummy = null;

    private var _bodyDummyData:DummyVO = null;

    public function ClanProfileFortificationView() {
        super();
        currentLinkage = CLANS_ALIASES.CLAN_PROFILE_FORTIFICATION_VIEW_LINKAGE;
    }

    override protected function initializeContentLinkages():void {
        addLinkageWithAlias(CLANS_ALIASES.CLAN_PROFILE_FORT_INFO_VIEW_LINKAGE, CLANS_ALIASES.CLAN_PROFILE_FORT_INFO_VIEW_ALIAS);
        addLinkageWithAlias(CLANS_ALIASES.CLAN_PROFILE_FORT_PROMO_VIEW_LINKAGE, CLANS_ALIASES.CLAN_PROFILE_FORT_PROMO_VIEW_ALIAS);
    }

    override protected function updateContent():void {
        super.updateContent();
        if (_contentLinkage == CLANS_ALIASES.CLAN_PROFILE_FORT_INFO_VIEW_LINKAGE) {
            this.showTabs();
        }
        else {
            this.hideTabs();
        }
    }

    override protected function draw():void {
        super.draw();
        if (this._bodyDummyData != null && isInvalid(INV_BODY_DUMMY_DATA)) {
            if (this._bodyDummy == null) {
                this.createBodyDummy();
                addChild(DisplayObject(this._bodyDummy));
            }
            this._bodyDummy.visible = true;
            this._bodyDummy.setData(this._bodyDummyData);
            container.visible = false;
            this.hideTabs();
        }
    }

    override protected function onDispose():void {
        this.tabs.dispose();
        this.tabs = null;
        if (this._bodyDummy != null) {
            this._bodyDummy.dispose();
            this._bodyDummy = null;
        }
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.hideTabs();
    }

    override protected function showBodyDummy(param1:DummyVO):void {
        this._bodyDummyData = param1;
        invalidate(INV_BODY_DUMMY_DATA);
        validateNow();
    }

    public function addTabIndexChangedEventListener(param1:Function):void {
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, param1);
    }

    public function as_hideBodyDummy():void {
        if (this._bodyDummy == null) {
            return;
        }
        this._bodyDummy.visible = false;
        container.visible = true;
        this.showTabs();
    }

    public function removeTabIndexChangedEventListener(param1:Function):void {
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, param1);
    }

    public function selectTabIndex(param1:int):void {
        this.tabs.selectedIndex = param1;
    }

    public function setTabsProvider(param1:DataProvider):void {
        this.tabs.dataProvider = param1;
    }

    private function showTabs():void {
        var _loc1_:ClanProfileFortificationInfoView = null;
        if (_contentLinkage == CLANS_ALIASES.CLAN_PROFILE_FORT_INFO_VIEW_LINKAGE) {
            _loc1_ = ClanProfileFortificationInfoView(_content);
            _loc1_.setTabbedView(this);
        }
        this.tabs.visible = true;
    }

    private function hideTabs():void {
        var _loc1_:ClanProfileFortificationInfoView = null;
        this.tabs.visible = false;
        if (_contentLinkage == CLANS_ALIASES.CLAN_PROFILE_FORT_INFO_VIEW_LINKAGE) {
            _loc1_ = ClanProfileFortificationInfoView(_content);
            _loc1_.removeTabbedView();
        }
    }

    private function createBodyDummy():void {
        this._bodyDummy = App.utils.classFactory.getComponent(Linkages.DUMMY_UI, IDummy);
        this._bodyDummy.x = BODY_DUMMY_X;
        this._bodyDummy.y = BODY_DUMMY_Y;
        this._bodyDummy.width = BODY_DUMMY_WIDTH;
        this._bodyDummy.height = BODY_DUMMY_HEIGHT;
    }
}
}

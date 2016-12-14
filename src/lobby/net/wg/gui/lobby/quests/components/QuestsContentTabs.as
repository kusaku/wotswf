package net.wg.gui.lobby.quests.components {
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.data.TabDataVO;
import net.wg.gui.data.TabsVO;
import net.wg.infrastructure.base.meta.IQuestsContentTabsMeta;
import net.wg.infrastructure.base.meta.impl.QuestsContentTabsMeta;

import scaleform.clik.events.IndexEvent;

public class QuestsContentTabs extends QuestsContentTabsMeta implements IQuestsContentTabsMeta {

    public var tabBar:ContentTabBar = null;

    public var tabsSeparator:MovieClip;

    private var _separatorsHitArea:Sprite;

    private var _suppressIndexChangeEvent:Boolean = false;

    public function QuestsContentTabs() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._separatorsHitArea = new Sprite();
        addChild(this._separatorsHitArea);
        this.tabsSeparator.hitArea = this._separatorsHitArea;
        this.tabsSeparator.mouseChildren = this.tabsSeparator.mouseEnabled = false;
        this.tabBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
    }

    override protected function onDispose():void {
        if (this._separatorsHitArea != null) {
            removeChild(this._separatorsHitArea);
            this._separatorsHitArea = null;
        }
        this.tabsSeparator.hitArea = null;
        this.tabsSeparator = null;
        this.tabBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.tabBar.dispose();
        this.tabBar = null;
        super.onDispose();
    }

    override protected function setTabs(param1:TabsVO):void {
        this.tabBar.dataProvider = param1.tabs;
    }

    public function as_selectTab(param1:int):void {
        this.selectTab(param1);
    }

    protected function selectTab(param1:int):void {
        App.utils.asserter.assert(param1 >= 0 && param1 < this.tabBar.dataProvider.length, "Selected index must be in tabs data provide range");
        this._suppressIndexChangeEvent = true;
        this.tabBar.selectedIndex = param1;
        this._suppressIndexChangeEvent = false;
    }

    protected function onTabSelect(param1:String):void {
        onSelectTabS(param1);
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:TabDataVO = null;
        if (!this._suppressIndexChangeEvent) {
            _loc2_ = TabDataVO(this.tabBar.selectedItem);
            if (_loc2_ != null) {
                this.onTabSelect(_loc2_.id);
            }
        }
    }
}
}

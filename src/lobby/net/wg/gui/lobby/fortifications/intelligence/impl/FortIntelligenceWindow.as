package net.wg.gui.lobby.fortifications.intelligence.impl {
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.gui.components.controls.interfaces.ISortableTable;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.gui.lobby.fortifications.data.IntelligenceRendererVO;
import net.wg.gui.lobby.fortifications.intelligence.IFortIntelFilter;
import net.wg.gui.rally.data.ManualSearchDataProvider;
import net.wg.infrastructure.base.meta.IFortIntelligenceWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortIntelligenceWindowMeta;
import net.wg.infrastructure.events.FocusRequestEvent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class FortIntelligenceWindow extends FortIntelligenceWindowMeta implements IFortIntelligenceWindowMeta {

    private static const CLAN_TAG:String = "clanTag";

    public var horSeparator:MovieClip = null;

    public var verSeparator:MovieClip = null;

    public var statusTextField:TextField = null;

    public var intelFilter:IFortIntelFilter = null;

    public var intelligenceTable:ISortableTable = null;

    public var clanDescription:FortIntelligenceClanDescription = null;

    private var _listDataProvider:ManualSearchDataProvider = null;

    public function FortIntelligenceWindow() {
        super();
        isModal = false;
        isCentered = true;
        this.horSeparator.mouseEnabled = false;
        this.verSeparator.mouseEnabled = false;
        this._listDataProvider = new ManualSearchDataProvider(IntelligenceRendererVO);
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        this.updatePosition();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.intelFilter, FORTIFICATION_ALIASES.FORT_INTEL_FILTER_ALIAS);
        registerFlashComponentS(this.clanDescription, FORTIFICATION_ALIASES.FORT_INTELLIGENCE_CLAN_DESCRIPTION);
    }

    override protected function configUI():void {
        super.configUI();
        this.updatePosition();
        window.title = FORTIFICATIONS.FORTINTELLIGENCE_WINDOWTITLE;
        addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onFocusRequestHandler);
        this.statusTextField.visible = false;
        this._listDataProvider.addEventListener(Event.CHANGE, this.onListDataProviderChangeHandler);
        this.intelligenceTable.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE, this.onIntelligenceTableListIndexChangeHandler);
    }

    override protected function onDispose():void {
        removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onFocusRequestHandler);
        this._listDataProvider.removeEventListener(Event.CHANGE, this.onListDataProviderChangeHandler);
        this._listDataProvider.cleanUp();
        this._listDataProvider = null;
        this.intelligenceTable.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE, this.onIntelligenceTableListIndexChangeHandler);
        this.intelligenceTable.dispose();
        this.intelligenceTable = null;
        this.intelFilter = null;
        this.horSeparator = null;
        this.verSeparator = null;
        this.clanDescription = null;
        this.statusTextField = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.updatePosition();
        }
    }

    override protected function setTableHeader(param1:NormalSortingTableHeaderVO):void {
        this.intelligenceTable.listDP = this._listDataProvider;
        this.intelligenceTable.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
        this.intelligenceTable.sortByField(CLAN_TAG, SortingInfo.ASCENDING_SORT);
    }

    public function as_getCurrentListIndex():int {
        return this.intelligenceTable.listSelectedIndex;
    }

    public function as_getSearchDP():Object {
        return this._listDataProvider;
    }

    public function as_selectByIndex(param1:int):void {
        if (this.intelligenceTable.listSelectedIndex != param1) {
            this.intelligenceTable.listSelectedIndex = param1;
        }
    }

    public function as_setStatusText(param1:String):void {
        this.statusTextField.htmlText = param1;
    }

    private function updatePosition():void {
        window.x = App.appWidth - window.width >> 1;
        window.y = App.appHeight - window.height >> 1;
    }

    private function onFocusRequestHandler(param1:FocusRequestEvent):void {
        assertNotNull(param1.focusContainer.getComponentForFocus(), "intelFilter focus reference");
        setFocus(param1.focusContainer.getComponentForFocus());
    }

    private function onIntelligenceTableListIndexChangeHandler(param1:SortableTableListEvent):void {
        requestClanFortInfoS(param1.index);
    }

    private function onListDataProviderChangeHandler(param1:Event):void {
        var _loc2_:* = this._listDataProvider.length > 0;
        this.intelligenceTable.visible = _loc2_;
        this.statusTextField.visible = !_loc2_;
        var _loc3_:int = FortIntelFilter(this.intelFilter).clanTypeDropDn.selectedIndex;
        var _loc4_:* = _loc3_ == FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_BOOKMARKS;
        var _loc5_:* = _loc3_ == FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_LASTSEARCH;
        if ((_loc4_ || _loc5_) && this.intelligenceTable.listDP.length > 0 && this.intelligenceTable.listSelectedIndex == -1) {
            this.intelligenceTable.listSelectedIndex = 0;
            setFocus(this.intelligenceTable.getComponentForFocus());
        }
    }
}
}

package net.wg.gui.lobby.fortifications.battleRoom.clanBattle {
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleListVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleRenderListVO;
import net.wg.gui.rally.data.ManualSearchDataProvider;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.interfaces.IRallyListItemVO;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.base.meta.IFortClanBattleListMeta;
import net.wg.infrastructure.base.meta.impl.FortClanBattleListMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

import scaleform.clik.data.DataProvider;

public class FortClanBattleList extends FortClanBattleListMeta implements IFortClanBattleListMeta, IFocusChainContainer {

    private static const START_TIME_LEFT:String = "startTimeLeft";

    public var currentBattlesCount:TextField = null;

    public var currentBattlesCountTitle:TextField = null;

    public var actionDescr:TextField = null;

    public function FortClanBattleList() {
        super();
        _deferredDispose = true;
        listDataProvider = new ManualSearchDataProvider(ClanBattleRenderListVO);
    }

    override public function getComponentForFocus():InteractiveObject {
        return rallyTable;
    }

    override protected function setClanBattleData(param1:ClanBattleListVO):void {
        rallyTable.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
        rallyTable.sortByField(START_TIME_LEFT, SortingInfo.ASCENDING_SORT);
        this.currentBattlesCountTitle.autoSize = TextFieldAutoSize.LEFT;
        this.currentBattlesCountTitle.htmlText = param1.battlesCountTitle;
        this.updateTextPosition();
        this.actionDescr.htmlText = param1.actionDescr;
        titleLbl.htmlText = param1.titleLbl;
        descrLbl.htmlText = param1.descrLbl;
        titleLbl.x = this._width - titleLbl.width >> 1;
        descrLbl.x = this._width - descrLbl.width >> 1;
    }

    override protected function convertToRallyVO(param1:Object):IRallyVO {
        return new ClanBattleDetailsVO(param1);
    }

    override protected function configUI():void {
        super.configUI();
        rallyTable.validateNow();
        detailsSection.addEventListener(RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM, this.onDetailsSectionCreateClanBattleRoomHandler);
        listDataProvider.addEventListener(ManualSearchEvent.DATA_UPDATED, this.onListDataProviderDataUpdatedHandler, false, 0, true);
        listDataProvider.addEventListener(Event.CHANGE, this.onListDataProviderChangeHandler);
        backBtn.tooltip = TOOLTIPS.FORTIFICATION_CLAN_LISTROOM_BACK;
    }

    override protected function onBeforeDispose():void {
        detailsSection.removeEventListener(RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM, this.onDetailsSectionCreateClanBattleRoomHandler);
        listDataProvider.removeEventListener(ManualSearchEvent.DATA_UPDATED, this.onListDataProviderDataUpdatedHandler);
        listDataProvider.removeEventListener(Event.CHANGE, this.onListDataProviderChangeHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.currentBattlesCount = null;
        this.currentBattlesCountTitle = null;
        this.actionDescr = null;
        super.onDispose();
    }

    override protected function getRallyViewAlias():String {
        return FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI;
    }

    public function as_upateClanBattlesCount(param1:String):void {
        this.currentBattlesCount.autoSize = TextFieldAutoSize.LEFT;
        this.currentBattlesCount.htmlText = param1;
        this.updateTextPosition();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = detailsSection.getFocusChain();
        _loc1_.unshift(rallyTable);
        _loc1_.unshift(backBtn);
        return _loc1_;
    }

    private function updateTextPosition():void {
        this.currentBattlesCount.x = Math.round(this.currentBattlesCountTitle.x + this.currentBattlesCountTitle.width);
    }

    private function onListDataProviderChangeHandler(param1:Event):void {
        if (rallyTable.listSelectedIndex == -1) {
            rallyTable.listSelectedIndex = 0;
        }
    }

    private function onListDataProviderDataUpdatedHandler(param1:ManualSearchEvent):void {
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    private function onDetailsSectionCreateClanBattleRoomHandler(param1:RallyViewsEvent):void {
        var _loc3_:Object = null;
        var _loc2_:IRallyListItemVO = rallyTable.getListSelectedItem() as IRallyListItemVO;
        if (_loc2_ && _loc2_.mgrID != 0) {
            _loc3_ = {
                "alias": RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM,
                "itemId": _loc2_.mgrID,
                "peripheryID": _loc2_.peripheryID
            };
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST, _loc3_));
        }
    }
}
}

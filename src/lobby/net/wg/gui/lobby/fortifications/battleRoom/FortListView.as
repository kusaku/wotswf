package net.wg.gui.lobby.fortifications.battleRoom {
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.data.daapi.base.DAAPIDataProvider;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.gui.components.controls.AlertIco;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortListViewHelper;
import net.wg.gui.lobby.fortifications.data.FortRegulationInfoVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
import net.wg.gui.rally.data.ManualSearchDataProvider;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.base.meta.IFortListMeta;
import net.wg.infrastructure.base.meta.impl.FortListMeta;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.TextFieldEx;

public class FortListView extends FortListMeta implements IFortListMeta {

    private static const REGULATIONS_TEXT_RIGHT_POS:int = 985;

    private static const REGULATIONS_TEXT_LOCALIZATION_GAP:int = 100;

    private static const REGULATIONS_TEXT_ICON_GAP:int = 19;

    private static const SHOW_TEXT_MESSAGE_DELAY:int = 100;

    private static const SHOW_TEXT_MESSAGE_EMPTY_DATA_DELAY:int = 300;

    public var searchResultsTF:TextField = null;

    public var textMessage:TextField = null;

    public var filterTF:TextField = null;

    public var filterDivision:DropdownMenu = null;

    public var filterInfo:InfoIcon = null;

    public var regulationsTF:TextField = null;

    public var regulationsInfo:InfoIcon = null;

    public var regulationsWarningTF:TextField = null;

    public var regulationsWarning:AlertIco = null;

    private var _fortRegulationInfo:FortRegulationInfoVO = null;

    private var _divisionsDP:DAAPIDataProvider = null;

    private var _filterIndexChanging:Boolean = false;

    private var _hoverEnabledControls:Vector.<IEventDispatcher> = null;

    private var _curfewEnabled:Boolean = false;

    private var _commons:ICommons = null;

    private var _tooltipMgr:ITooltipMgr = null;

    public function FortListView() {
        super();
        _deferredDispose = true;
        listDataProvider = new ManualSearchDataProvider(SortieRenderVO);
        this._divisionsDP = new DAAPIDataProvider();
        TextFieldEx.setVerticalAlign(this.textMessage, TextFieldEx.VALIGN_CENTER);
        this.textMessage.text = FORTIFICATIONS.SORTIE_LISTVIEW_ABSENTDIVISIONS;
        this.textMessage.visible = false;
        this._commons = App.utils.commons;
        this._tooltipMgr = App.toolTipMgr;
        this._hoverEnabledControls = new <IEventDispatcher>[this.regulationsTF, this.regulationsWarningTF, this.regulationsInfo, this.regulationsWarning, this.filterTF, this.filterInfo];
        this.regulationsWarning.buttonMode = false;
    }

    override protected function convertToRallyVO(param1:Object):IRallyVO {
        return new LegionariesSortieVO(param1);
    }

    override protected function getRallyTooltipLinkage():String {
        return TOOLTIPS_CONSTANTS.CYBER_SPORT_TEAM;
    }

    override protected function getRallyViewAlias():String {
        return FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_VIEW_UI;
    }

    override protected function configUI():void {
        super.configUI();
        this.textMessage.x = rallyTable.x + (rallyTable.width - this.textMessage.width >> 1) ^ 0;
        this.textMessage.y = rallyTable.y + (rallyTable.height - this.textMessage.height >> 1) ^ 0;
        createBtn.mouseEnabledOnDisabled = true;
        createBtn.label = FORTIFICATIONS.SORTIE_LISTVIEW_CREATE;
        titleLbl.text = FORTIFICATIONS.SORTIE_LISTVIEW_TITLE;
        descrLbl.htmlText = FORTIFICATIONS.SORTIE_LISTVIEW_DESCRIPTION;
        this.searchResultsTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_LISTTITLE;
        this.filterTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_FILTER;
        this.regulationsTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_SORTIESREGULATIONS;
        this.regulationsWarningTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_CURFEW;
        this.regulationsTF.visible = false;
        this.regulationsInfo.visible = false;
        this.regulationsWarningTF.visible = false;
        this.regulationsWarning.visible = false;
        this.alignRegulationText(this.regulationsWarningTF, this.regulationsWarning);
        this.alignRegulationText(this.regulationsTF, this.regulationsInfo);
        this.filterDivision.dataProvider = this._divisionsDP;
        this.filterDivision.addEventListener(ListEvent.INDEX_CHANGE, this.onFilterIndexChangeHandler);
        this._commons.addMultipleHandlers(this._hoverEnabledControls, MouseEvent.ROLL_OVER, this.onCommonsRollOverHandler);
        this._commons.addMultipleHandlers(this._hoverEnabledControls, MouseEvent.ROLL_OUT, this.onCommonsRollOutHandler);
    }

    override protected function onBeforeDispose():void {
        App.utils.scheduler.cancelTask(this.showTextMsg);
        this.filterDivision.removeEventListener(ListEvent.INDEX_CHANGE, this.onFilterIndexChangeHandler);
        this._commons.removeMultipleHandlers(this._hoverEnabledControls, MouseEvent.ROLL_OVER, this.onCommonsRollOverHandler);
        this._commons.removeMultipleHandlers(this._hoverEnabledControls, MouseEvent.ROLL_OUT, this.onCommonsRollOutHandler);
        super.onBeforeDispose();
    }

    private function onCommonsRollOutHandler(param1:MouseEvent):void {
        onControlRollOut();
    }

    override protected function onDispose():void {
        this.searchResultsTF = null;
        this.regulationsTF = null;
        this.regulationsWarningTF = null;
        this.textMessage = null;
        this._divisionsDP = null;
        this.filterTF = null;
        this.filterInfo.dispose();
        this.filterInfo = null;
        this.regulationsInfo.dispose();
        this.regulationsInfo = null;
        this.regulationsWarning.dispose();
        this.regulationsWarning = null;
        this.filterDivision.dispose();
        this.filterDivision = null;
        this._fortRegulationInfo = null;
        this._hoverEnabledControls.splice(0, this._hoverEnabledControls.length);
        this._hoverEnabledControls = null;
        this._commons = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function setRegulationInfo(param1:FortRegulationInfoVO):void {
        this._fortRegulationInfo = param1;
    }

    override protected function setTableHeader(param1:NormalSortingTableHeaderVO):void {
        rallyTable.headerDP.cleanUp();
        rallyTable.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
        rallyTable.sortByField(FortListViewHelper.CREATOR_NAME, SortingInfo.ASCENDING_SORT);
    }

    public function as_getDivisionsDP():Object {
        return this._divisionsDP;
    }

    public function as_setCreationEnabled(param1:Boolean):void {
        createBtn.enabled = param1;
    }

    public function as_setCurfewEnabled(param1:Boolean):void {
        this.regulationsTF.visible = !param1;
        this.regulationsInfo.visible = !param1;
        this.regulationsWarningTF.visible = param1;
        this.regulationsWarning.visible = param1;
        this._curfewEnabled = enabled;
    }

    public function as_setSelectedDivision(param1:int):void {
        this._filterIndexChanging = true;
        this.filterDivision.selectedIndex = param1;
        this._filterIndexChanging = false;
    }

    public function as_tryShowTextMessage():void {
        var _loc1_:int = listDataProvider.length;
        if (_loc1_ > 0) {
            this.textMessage.visible = false;
        }
        App.utils.scheduler.scheduleTask(this.showTextMsg, _loc1_ > 0 ? Number(SHOW_TEXT_MESSAGE_DELAY) : Number(SHOW_TEXT_MESSAGE_EMPTY_DATA_DELAY));
    }

    private function alignRegulationText(param1:TextField, param2:DisplayObject):void {
        param1.width = param1.textWidth + REGULATIONS_TEXT_LOCALIZATION_GAP ^ 0;
        param1.x = REGULATIONS_TEXT_RIGHT_POS - param1.textWidth ^ 0;
        param2.x = param1.x - REGULATIONS_TEXT_ICON_GAP;
    }

    private function showTextMsg():void {
        var _loc1_:* = listDataProvider.length <= 0;
        this.textMessage.visible = _loc1_;
        detailsSection.noRallyScreen.showText(!_loc1_);
    }

    override protected function itemRollOverPerformer(param1:SortableTableListEvent = null):void {
        this._tooltipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_RENDERERINFO);
    }

    private function onCommonsRollOverHandler(param1:MouseEvent):void {
        this.controlRollOverPerformer(param1);
    }

    override protected function controlRollOverPerformer(param1:MouseEvent = null):void {
        var _loc2_:String = null;
        var _loc3_:String = null;
        if (param1 == null) {
            return;
        }
        if (createBtn == param1.currentTarget && createBtn.enabled) {
            this._tooltipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_CREATEBTN);
        }
        else if (this.regulationsInfo == param1.currentTarget || this.regulationsTF == param1.currentTarget || this.regulationsWarningTF == param1.currentTarget || this.regulationsWarning == param1.currentTarget) {
            _loc2_ = this._fortRegulationInfo.serverName == Values.EMPTY_STR ? TOOLTIPS_CONSTANTS.FORT_SORTIE_TIME_LIMIT : TOOLTIPS_CONSTANTS.FORT_SORTIE_SERVER_LIMIT;
            _loc3_ = null;
            if (StringUtils.isNotEmpty(this._fortRegulationInfo.serverName)) {
                _loc3_ = this._fortRegulationInfo.serverName;
            }
            this._tooltipMgr.showSpecial(_loc2_, null, this._curfewEnabled, this._fortRegulationInfo.timeLimits, _loc3_);
        }
        else if (this.filterInfo == param1.currentTarget) {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.SORTIE_DIVISION, null);
        }
        else if (backBtn == param1.currentTarget) {
            this._tooltipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_BACK);
        }
    }

    private function onFilterIndexChangeHandler(param1:ListEvent):void {
        changeDivisionIndexS(param1.index);
    }
}
}

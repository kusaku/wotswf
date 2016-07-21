package net.wg.gui.cyberSport.views {
import flash.events.Event;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
import net.wg.data.constants.generated.CYBER_SPORT_HELP_IDS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.advanced.events.DummyEvent;
import net.wg.gui.components.advanced.interfaces.IDummy;
import net.wg.gui.components.advanced.interfaces.ISearchInput;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.cyberSport.controls.NavigationBlock;
import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.controls.events.CSRallyInfoEvent;
import net.wg.gui.cyberSport.views.events.CSShowHelpEvent;
import net.wg.gui.cyberSport.views.unit.IStaticRallyDetailsSection;
import net.wg.gui.cyberSport.vo.CSCommadDetailsVO;
import net.wg.gui.cyberSport.vo.CSCommandVO;
import net.wg.gui.cyberSport.vo.CSStaticLegionaryRallyVO;
import net.wg.gui.cyberSport.vo.CSStaticRallyVO;
import net.wg.gui.cyberSport.vo.NavigationBlockVO;
import net.wg.gui.cyberSport.vo.UnitListViewHeaderVO;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.CheckBoxIconVO;
import net.wg.gui.rally.controls.RallyInvalidationType;
import net.wg.gui.rally.data.ManualSearchDataProvider;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.interfaces.IRallyListItemVO;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
import net.wg.gui.rally.vo.RallyShortVO;
import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
import net.wg.infrastructure.base.meta.impl.CyberSportUnitsListMeta;
import net.wg.infrastructure.interfaces.IViewStackContent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;

public class UnitsListView extends CyberSportUnitsListMeta implements ICyberSportUnitsListMeta, IBaseRallyViewMeta {

    private static const REFRESH_BUTTON_OFFSET:Number = 14;

    private static const HEADER_INV:String = "headerInv";

    public var navigationBlock:NavigationBlock = null;

    public var refreshBtn:IButtonIconLoader = null;

    public var searchResultsTF:TextField = null;

    public var detailsViewStack:ViewStack = null;

    public var tableDescrTF:TextField = null;

    public var navigationDescrTF:TextField = null;

    public var filterCheckbox:CheckBox = null;

    public var helpLabel:TextField = null;

    public var helpLink:ISoundButtonEx = null;

    public var searchBtn:ISoundButtonEx = null;

    public var searchInput:ISearchInput = null;

    public var dummy:IDummy = null;

    private var _detailsData:DAAPIDataClass = null;

    private var _vehiclesLabel:String = null;

    private var _searchByNameEnable:Boolean = false;

    private var _headerDataVO:UnitListViewHeaderVO = null;

    public function UnitsListView() {
        super();
        listDataProvider = new ManualSearchDataProvider(CSCommandVO);
    }

    override public function as_setDetails(param1:Object):void {
        var _loc2_:CSCommadDetailsVO = new CSCommadDetailsVO(param1);
        var _loc3_:String = _loc2_.viewLinkage;
        var _loc4_:* = _loc3_ == CYBER_SPORT_ALIASES.COMMNAD_DETAILS_LINKAGE_JOIN_TO_NONSTATIC;
        this.detailsViewStack.visible = !_loc4_;
        detailsSection.visible = _loc4_;
        if (_loc4_) {
            super.as_setDetails(_loc2_.data);
        }
        else {
            if (this.detailsViewStack.currentLinkage != _loc2_.viewLinkage) {
                this.detailsViewStack.show(_loc2_.viewLinkage);
            }
            this.clearDetailsData();
            if (_loc2_.data != null) {
                if (_loc3_ == CYBER_SPORT_ALIASES.COMMNAD_DETAILS_LINKAGE_JOIN_TO_STATIC_AS_LEGIONARY) {
                    this._detailsData = new CSStaticLegionaryRallyVO(_loc2_.data);
                }
                else if (_loc3_ == CYBER_SPORT_ALIASES.COMMNAD_DETAILS_LINKAGE_JOIN_TO_STATIC) {
                    this._detailsData = new CSStaticRallyVO(_loc2_.data);
                }
            }
            IViewStackContent(this.detailsViewStack.currentView).update(this._detailsData);
        }
        _loc2_.dispose();
    }

    override public function as_setVehiclesTitle(param1:String):void {
        super.as_setVehiclesTitle(param1);
        this._vehiclesLabel = param1;
        invalidate(RallyInvalidationType.VEHICLE_LABEL);
    }

    override protected function draw():void {
        var _loc1_:BaseRallyDetailsSection = null;
        super.draw();
        if (isInvalid(RallyInvalidationType.VEHICLE_LABEL)) {
            _loc1_ = this.detailsViewStack.currentView as BaseRallyDetailsSection;
            if (_loc1_ != null) {
                _loc1_.vehiclesLabel = this._vehiclesLabel;
            }
        }
        if (this._headerDataVO != null && isInvalid(HEADER_INV)) {
            createBtn.label = this._headerDataVO.createBtnLabel;
            createBtn.enabled = this._headerDataVO.createBtnEnabled;
            createBtn.mouseEnabled = true;
            titleLbl.text = this._headerDataVO.title;
            descrLbl.text = this._headerDataVO.description;
            this._searchByNameEnable = this._headerDataVO.searchByNameEnable;
            if (!this._searchByNameEnable) {
                this.searchBtn.visible = false;
                this.searchInput.visible = false;
            }
            if (StringUtils.isNotEmpty(this._headerDataVO.createBtnTooltip)) {
                createBtn.tooltip = this._headerDataVO.createBtnTooltip;
            }
            rallyTable.headerDP = new DataProvider(App.utils.data.vectorToArray(this._headerDataVO.header));
        }
    }

    override protected function convertToRallyVO(param1:Object):IRallyVO {
        return new RallyShortVO(param1);
    }

    override protected function getRallyTooltipLinkage():String {
        return TOOLTIPS_CONSTANTS.CYBER_SPORT_TEAM;
    }

    override protected function getRallyTooltipData(param1:IRallyListItemVO):Object {
        var _loc2_:CSCommandVO = CSCommandVO(param1);
        return {
            "creatorName": _loc2_.creatorName,
            "rating": _loc2_.rating,
            "description": _loc2_.description,
            "isStatic": _loc2_.isStatic
        };
    }

    override protected function getRallyViewAlias():String {
        return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
    }

    override protected function configUI():void {
        super.configUI();
        this.helpLabel.text = MENU.INGAME_MENU_BUTTONS_HELP;
        this.navigationDescrTF.text = CYBERSPORT.WINDOW_UNIT_UNITLISTVIEW_PAGINATIONINFO;
        this.refreshBtn.addEventListener(ButtonEvent.CLICK, this.onRefreshBtnClickHandler);
        this.refreshBtn.iconOffsetTop = -1;
        this.refreshBtn.iconOffsetLeft = 1;
        this.refreshBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_CYBERSPORT_REFRESHICON;
        this.refreshBtn.tooltip = TOOLTIPS.CYBERSPORT_UNITLIST_REFRESH;
        this.filterCheckbox.addEventListener(Event.SELECT, this.onFilterCheckboxSelectHandler);
        this.navigationBlock.addEventListener(CSComponentEvent.LOAD_PREVIOUS_REQUEST, this.onNavigationBlockLoadPreviousRequestHandler);
        this.navigationBlock.addEventListener(CSComponentEvent.LOAD_NEXT_REQUEST, this.onNavigationBlockLoadNextRequestHandler);
        this.detailsViewStack.addEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST, onJoinRequest);
        this.detailsViewStack.addEventListener(CSRallyInfoEvent.SHOW_PROFILE, this.onDetailsViewStackShowProfileHandler);
        this.helpLink.addEventListener(ButtonEvent.CLICK, this.onHelpLinkClickHandler);
        this.searchBtn.addEventListener(ButtonEvent.CLICK, this.onSearchBtnClickHandler);
        this.searchBtn.label = CYBERSPORT.WINDOW_UNITLISTVIEW_SEARCHBTN_LABEL;
        this.searchInput.defaultText = CYBERSPORT.WINDOW_UNITLISTVIEW_SEARCHTEAMS;
        this.searchInput.addEventListener(InputEvent.INPUT, this.onSearchInputInputHandler);
        this.dummy.addEventListener(DummyEvent.BUTTON_PRESS, this.onDummyButtonPressHandler);
        this.dummy.visible = false;
        noItemsTF.visible = false;
        backBtn.tooltip = TOOLTIPS.CYBERSPORT_UNITLEVEL_BACK;
    }

    override protected function onDispose():void {
        this.navigationBlock.removeEventListener(CSComponentEvent.LOAD_PREVIOUS_REQUEST, this.onNavigationBlockLoadPreviousRequestHandler);
        this.navigationBlock.removeEventListener(CSComponentEvent.LOAD_NEXT_REQUEST, this.onNavigationBlockLoadNextRequestHandler);
        this.navigationBlock.dispose();
        this.navigationBlock = null;
        this.filterCheckbox.removeEventListener(Event.SELECT, this.onFilterCheckboxSelectHandler);
        this.filterCheckbox.dispose();
        this.filterCheckbox = null;
        this.refreshBtn.removeEventListener(ButtonEvent.CLICK, this.onRefreshBtnClickHandler);
        this.refreshBtn.dispose();
        this.refreshBtn = null;
        this.detailsViewStack.removeEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST, onJoinRequest);
        this.detailsViewStack.removeEventListener(CSRallyInfoEvent.SHOW_PROFILE, this.onDetailsViewStackShowProfileHandler);
        this.detailsViewStack.dispose();
        this.detailsViewStack = null;
        this.helpLink.removeEventListener(ButtonEvent.CLICK, this.onHelpLinkClickHandler);
        this.helpLink.dispose();
        this.helpLink = null;
        this.searchBtn.removeEventListener(ButtonEvent.CLICK, this.onSearchBtnClickHandler);
        this.searchBtn.dispose();
        this.searchBtn = null;
        this.searchInput.removeEventListener(InputEvent.INPUT, this.onSearchInputInputHandler);
        this.searchInput.dispose();
        this.searchInput = null;
        this.dummy.removeEventListener(DummyEvent.BUTTON_PRESS, this.onDummyButtonPressHandler);
        this.dummy.dispose();
        this.dummy = null;
        this.searchResultsTF = null;
        this.tableDescrTF = null;
        this.helpLabel = null;
        this.clearDetailsData();
        this._headerDataVO = null;
        super.onDispose();
    }

    override protected function coolDownControls(param1:Boolean, param2:int):void {
        this.refreshBtn.enabled = param1;
        this.filterCheckbox.enabled = param1;
        this.searchBtn.enabled = param1;
        super.coolDownControls(param1, param2);
    }

    override protected function setHeader(param1:UnitListViewHeaderVO):void {
        this._headerDataVO = param1;
        invalidate(HEADER_INV);
    }

    override protected function listDataChange():void {
        super.listDataChange();
        if (this._searchByNameEnable) {
            if (listDataProvider.length != 0) {
                this.dummy.visible = false;
            }
            else {
                noItemsTF.visible = false;
                detailsSection.updateNoRallyScreenVisibility(false);
                this.navigationBlock.setInCoolDown(true);
            }
        }
    }

    override protected function setDummy(param1:DummyVO):void {
        this.dummy.setData(param1);
    }

    override protected function updateNavigationBlock(param1:NavigationBlockVO):void {
        this.navigationBlock.setup(param1);
    }

    public function as_setDummyVisible(param1:Boolean):void {
        this.dummy.visible = param1;
        noItemsTF.visible = !param1;
        detailsSection.updateNoRallyScreenVisibility(!param1);
    }

    public function as_setSearchResultText(param1:String, param2:String, param3:Object):void {
        var _loc5_:* = false;
        var _loc6_:CheckBoxIconVO = null;
        this.searchResultsTF.htmlText = param1;
        this.refreshBtn.x = this.searchResultsTF.x + this.searchResultsTF.textWidth + REFRESH_BUTTON_OFFSET | 0;
        var _loc4_:Boolean = param2 != null && param2.length > 0;
        this.tableDescrTF.visible = _loc4_;
        if (_loc4_) {
            this.tableDescrTF.text = param2;
        }
        _loc5_ = param3 != null;
        this.filterCheckbox.visible = _loc5_;
        if (_loc5_) {
            _loc6_ = new CheckBoxIconVO(param3);
            this.filterCheckbox.label = _loc6_.label;
            this.filterCheckbox.selected = _loc6_.isSelected;
            _loc6_.dispose();
        }
    }

    public function as_updateRallyIcon(param1:String):void {
        var _loc2_:IStaticRallyDetailsSection = this.detailsViewStack.currentView as IStaticRallyDetailsSection;
        App.utils.asserter.assertNotNull(_loc2_, "Calling as_updateRallyIcon for view without icon.");
        _loc2_.updateRallyIcon(param1);
    }

    private function clearDetailsData():void {
        if (this._detailsData != null) {
            this._detailsData.dispose();
            this._detailsData = null;
        }
    }

    private function onDetailsViewStackShowProfileHandler(param1:CSRallyInfoEvent):void {
        showRallyProfileS(param1.rallyId);
    }

    private function onFilterCheckboxSelectHandler(param1:Event):void {
        setTeamFiltersS(this.filterCheckbox.selected);
    }

    private function onRefreshBtnClickHandler(param1:ButtonEvent):void {
        refreshTeamsS();
    }

    private function onNavigationBlockLoadNextRequestHandler(param1:CSComponentEvent):void {
        loadNextS();
    }

    private function onNavigationBlockLoadPreviousRequestHandler(param1:CSComponentEvent):void {
        loadPreviousS();
    }

    private function onHelpLinkClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CSShowHelpEvent(CYBER_SPORT_HELP_IDS.CYBERSPORT_TEAM_LIST_HELP));
    }

    private function onSearchBtnClickHandler(param1:ButtonEvent):void {
        searchTeamsS(this.searchInput.text);
    }

    private function onDummyButtonPressHandler(param1:DummyEvent):void {
        this.searchInput.text = Values.EMPTY_STR;
        searchTeamsS(Values.EMPTY_STR);
    }

    private function onSearchInputInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ENTER) {
            param1.handled = true;
            searchTeamsS(this.searchInput.text);
        }
    }
}
}

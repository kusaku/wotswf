package net.wg.gui.prebattle.company {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.PREBATTLE_ALIASES;
import net.wg.data.daapi.base.DAAPIDataProvider;
import net.wg.gui.components.advanced.interfaces.ISearchInput;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.messenger.ChannelComponent;
import net.wg.gui.prebattle.company.events.CompanyDropDownEvent;
import net.wg.gui.prebattle.company.events.CompanyEvent;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.infrastructure.base.meta.ICompanyListMeta;
import net.wg.infrastructure.base.meta.impl.CompanyListMeta;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InputValue;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.utils.Constraints;

public class CompanyListView extends CompanyListMeta implements ICompanyListMeta, IChannelComponentHolder {

    private static const MILLY_SECONDS_IN_SECOND:uint = 1000;

    private static const INDENT_FROM_SCROLLBAR:uint = 10;

    public var channelComponent:ChannelComponent;

    public var topPanel:MovieClip;

    public var createButton:ISoundButtonEx;

    public var cmpList:CompaniesScrollingList;

    public var refreshButton:IButtonIconLoader;

    public var filterButton:IButtonIconLoader;

    public var filterSearchInput:ISearchInput = null;

    public var filterInBattleCheckbox:CheckBox;

    public var division:DropdownMenu;

    private var _companiesDP:DAAPIDataProvider;

    private var _defaultFilterText:String = "";

    private var _selectedFilterInBattleCheckbox:Boolean = false;

    private var _defaultSelectedIndex:int = 0;

    private var _selectedDivisionData:Number = -1;

    public function CompanyListView() {
        super();
        this._companiesDP = new DAAPIDataProvider();
    }

    override public function as_getSearchDP():Object {
        return this._companiesDP;
    }

    override public function getComponentForFocus():InteractiveObject {
        return this.channelComponent.getComponentForFocus();
    }

    override protected function configUI():void {
        super.configUI();
        this.refreshButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_REFRESH;
        this.createButton.addEventListener(ButtonEvent.CLICK, this.onCreateButtonClickHandler);
        this.createButton.label = PREBATTLE.BUTTONS_COMPANY_CREATE;
        constraints = new Constraints(this, ConstrainMode.REFLOW);
        var _loc1_:DisplayObject = this.channelComponent.messageArea;
        constraints.addElement(_loc1_.name, _loc1_, Constraints.ALL);
        _loc1_ = this.channelComponent.messageInput;
        constraints.addElement(_loc1_.name, _loc1_, Constraints.BOTTOM | Constraints.LEFT | Constraints.RIGHT);
        _loc1_ = this.channelComponent.sendButton as DisplayObject;
        App.utils.asserter.assertNotNull(_loc1_, "component" + Errors.CANT_NULL);
        constraints.addElement(_loc1_.name, _loc1_, Constraints.BOTTOM | Constraints.RIGHT);
        constraints.addElement(this.cmpList.name, this.cmpList, Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
        constraints.addElement(this.topPanel.name, this.topPanel, Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
        constraints.addElement(this.refreshButton.name, this.refreshButton as DisplayObject, Constraints.TOP | Constraints.RIGHT);
        constraints.addElement(this.filterButton.name, this.filterButton as DisplayObject, Constraints.TOP | Constraints.RIGHT);
        constraints.addElement(this.filterSearchInput.name, this.filterSearchInput as DisplayObject, Constraints.TOP | Constraints.RIGHT | Constraints.LEFT);
        constraints.addElement(this.filterInBattleCheckbox.name, this.filterInBattleCheckbox, Constraints.TOP | Constraints.RIGHT);
        constraints.addElement(this.division.name, this.division, Constraints.TOP | Constraints.RIGHT);
        this.refreshButton.addEventListener(ButtonEvent.CLICK, this.onRefreshButtonClickHandler);
        this.cmpList.addEventListener(CompanyEvent.SELECTED_ITEM, this.onCmpListSelectedItemHandler);
        this.cmpList.dataProvider = this._companiesDP;
        this.cmpList.sbPadding.right = INDENT_FROM_SCROLLBAR;
        this.cmpList.addEventListener(CompanyEvent.DROP_LIST_CLICK, this.onCmpListDropListClickHandler);
        this.filterSearchInput.addEventListener(Event.CHANGE, this.onFilterSearchInputChangeHandler);
        this.filterSearchInput.addEventListener(InputEvent.INPUT, this.onFilterSearchInputInputHandler);
        this.filterSearchInput.isSearchIconVisible = false;
        this.filterSearchInput.text = this._defaultFilterText;
        this.filterButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_FILTER;
        this.filterButton.addEventListener(ButtonEvent.CLICK, this.onFilterButtonClickHandler);
        this.filterButton.label = PREBATTLE.COMPANYLISTVIEW_FILTERBUTTON_LABEL;
        this.filterButton.tooltip = TOOLTIPS.PREBATTLE_NAMEFILTERBUTTON;
        this.filterInBattleCheckbox.selected = this._selectedFilterInBattleCheckbox;
        addEventListener(CompanyDropDownEvent.SHOW_DROP_DOWN, this.onShowDropDownHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.channelComponent, Aliases.CHANNEL_COMPONENT);
        this.division.dataProvider = new DataProvider(getDivisionsListS());
        this.division.selectedIndex = this._defaultSelectedIndex;
        this.division.enabled = false;
        this.division.addEventListener(ListEvent.INDEX_CHANGE, this.onDivisionIndexChangeHandler);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.enableFilterButtons);
        removeEventListener(CompanyDropDownEvent.SHOW_DROP_DOWN, this.onShowDropDownHandler);
        this.refreshButton.removeEventListener(ButtonEvent.CLICK, this.onRefreshButtonClickHandler);
        this.refreshButton.dispose();
        this.refreshButton = null;
        this.cmpList.removeEventListener(CompanyEvent.DROP_LIST_CLICK, this.onCmpListDropListClickHandler);
        this.cmpList.removeEventListener(CompanyEvent.SELECTED_ITEM, this.onCmpListSelectedItemHandler);
        this.cmpList.dispose();
        this.cmpList = null;
        this.division.removeEventListener(ListEvent.INDEX_CHANGE, this.onDivisionIndexChangeHandler);
        this.division.dataProvider.cleanUp();
        this.division.dataProvider = null;
        this.division.dispose();
        this.division = null;
        this.createButton.removeEventListener(ButtonEvent.CLICK, this.onCreateButtonClickHandler);
        this.createButton.dispose();
        this.createButton = null;
        this.filterSearchInput.removeEventListener(Event.CHANGE, this.onFilterSearchInputChangeHandler);
        this.filterSearchInput.removeEventListener(InputEvent.INPUT, this.onFilterSearchInputInputHandler);
        this.filterSearchInput.dispose();
        this.filterSearchInput = null;
        this.filterButton.removeEventListener(ButtonEvent.CLICK, this.onFilterButtonClickHandler);
        this.filterButton.dispose();
        this.filterButton = null;
        this.filterInBattleCheckbox.dispose();
        this.filterInBattleCheckbox = null;
        this.channelComponent = null;
        this._companiesDP.cleanUp();
        this._companiesDP = null;
        this.topPanel = null;
        super.onDispose();
    }

    public function as_disableCreateButton(param1:Boolean):void {
        if (this.createButton != null) {
            this.createButton.enabled = !param1;
        }
    }

    public function as_setDefaultFilter(param1:String, param2:Boolean, param3:uint):void {
        this._defaultFilterText = param1;
        this._selectedFilterInBattleCheckbox = param2;
        this._defaultSelectedIndex = param3;
    }

    public function as_setRefreshCoolDown(param1:Number):void {
        this.coolDownProcess(param1 * MILLY_SECONDS_IN_SECOND);
    }

    public function as_showPlayersList(param1:uint):void {
        if (this.cmpList) {
            this.cmpList.setIndexCompany = param1;
        }
    }

    public function getChannelComponent():ChannelComponent {
        return this.channelComponent;
    }

    private function coolDownProcess(param1:Number):void {
        this.enableFilterButtons(false);
        App.utils.scheduler.scheduleTask(this.enableFilterButtons, param1, true);
    }

    private function enableFilterButtons(param1:Boolean):void {
        this._selectedDivisionData = this.getSelectedDivisionData();
        this.refreshButton.enabled = param1;
        this.filterButton.enabled = this.isSearchAvailable();
        this.division.enabled = param1;
        this.enableFilterSearchInput(param1);
    }

    private function enableFilterSearchInput(param1:Boolean):void {
        if (!param1) {
            if (this.filterSearchInput.hasEventListener(InputEvent.INPUT)) {
                this.filterSearchInput.removeEventListener(InputEvent.INPUT, this.onFilterSearchInputInputHandler);
            }
        }
        else {
            this.filterSearchInput.addEventListener(InputEvent.INPUT, this.onFilterSearchInputInputHandler);
        }
    }

    private function getSelectedDivisionData():Number {
        var _loc2_:Object = null;
        var _loc1_:Number = -1;
        if (this.division.dataProvider && this.division.selectedIndex >= 0) {
            _loc2_ = this.division.dataProvider.requestItemAt(this.division.selectedIndex);
            _loc1_ = !!_loc2_.hasOwnProperty("data") ? Number(_loc2_["data"]) : Number(-1);
        }
        return _loc1_;
    }

    private function isSearchAvailable():Boolean {
        return this.refreshButton.enabled && this._selectedDivisionData == 0 ? this.filterSearchInput.text != "" : false;
    }

    override public function handleInput(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN) {
            if (this.cmpList.isOpenedState) {
                this.cmpList.unselectedRenderers();
                param1.preventDefault();
                return;
            }
        }
        super.handleInput(param1);
        if (param1.handled) {
            return;
        }
        if (param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP) {
            showFAQWindowS();
            param1.handled = true;
        }
    }

    private function onDivisionIndexChangeHandler(param1:ListEvent):void {
        this._selectedDivisionData = this.getSelectedDivisionData();
        refreshCompaniesListS(this.filterSearchInput.text, this.filterInBattleCheckbox.selected, this._selectedDivisionData);
        this.filterButton.enabled = this.isSearchAvailable();
    }

    private function onRefreshButtonClickHandler(param1:ButtonEvent):void {
        refreshCompaniesListS(this.filterSearchInput.text, this.filterInBattleCheckbox.selected, this._selectedDivisionData);
    }

    private function onCmpListDropListClickHandler(param1:CompanyEvent):void {
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST, {
            "alias": PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI,
            "itemId": param1.prbID
        }));
    }

    private function onCreateButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST, {"alias": PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI}));
    }

    private function onFilterSearchInputChangeHandler(param1:Event):void {
        this._selectedDivisionData = this.getSelectedDivisionData();
        this.filterButton.enabled = this.isSearchAvailable();
    }

    private function onFilterButtonClickHandler(param1:ButtonEvent):void {
        refreshCompaniesListS(this.filterSearchInput.text, this.filterInBattleCheckbox.selected, this._selectedDivisionData);
    }

    private function onCmpListSelectedItemHandler(param1:CompanyEvent):void {
        if (param1.prbID > -1) {
            requestPlayersListS(param1.prbID);
        }
    }

    private function onFilterSearchInputInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ENTER) {
            param1.handled = true;
            this.filterButton.selected = true;
            refreshCompaniesListS(this.filterSearchInput.text, this.filterInBattleCheckbox.selected, this._selectedDivisionData);
            this.filterSearchInput.removeEventListener(InputEvent.INPUT, this.onFilterSearchInputInputHandler);
        }
    }

    private function onShowDropDownHandler(param1:CompanyDropDownEvent):void {
        var _loc2_:CompanyDropList = CompanyDropList(param1.dropDownref);
        var _loc3_:Point = globalToLocal(new Point(_loc2_.x, _loc2_.y));
        var _loc4_:Number = 0;
        if (_loc3_.y + _loc2_.height > y + height) {
            _loc4_ = _loc3_.y + _loc2_.height - y - height;
        }
        _loc3_.y = _loc3_.y - _loc4_;
        addChild(_loc2_);
        _loc2_.x = _loc3_.x;
        _loc2_.y = _loc3_.y;
        _loc2_.replaceArrow(_loc4_);
    }
}
}

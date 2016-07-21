package net.wg.gui.prebattle.company {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.daapi.base.DAAPIDataProvider;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TextInput;
import net.wg.gui.events.MessengerBarEvent;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
import net.wg.gui.messenger.ChannelComponent;
import net.wg.gui.prebattle.company.events.CompanyDropDownEvent;
import net.wg.gui.prebattle.company.events.CompanyEvent;
import net.wg.gui.prebattle.meta.ICompaniesWindowMeta;
import net.wg.gui.prebattle.meta.impl.CompaniesWindowMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;
import net.wg.utils.IEventCollector;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InputValue;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.utils.Constraints;
import scaleform.clik.utils.Padding;

public class CompaniesListWindow extends CompaniesWindowMeta implements ICompaniesWindowMeta {

    private static const MAX_WINDOW_WIDTH:int = 1024;

    private static const MAX_WINDOW_HEIGHT:int = 768;

    private static const TEAM_LIST:String = "teamList";

    public var channelComponent:ChannelComponent;

    public var topPanel:MovieClip;

    public var groupsScrollBar:ScrollBar;

    public var createButton:SoundButtonEx;

    public var cmpList:CompaniesScrollingList;

    public var refreshButton:IButtonIconLoader;

    public var filterButton:IButtonIconLoader;

    public var filterTextField:TextInput;

    public var filterInBattleCheckbox:CheckBox;

    public var division:DropdownMenu;

    private var companiesDP:DAAPIDataProvider;

    private var defaultFilterText:String = "";

    private var selectedFilterInBattleCheckbox:Boolean = false;

    private var defaultSelectedIndex:int = 0;

    private var windowContentPadding:Padding;

    public function CompaniesListWindow() {
        this.windowContentPadding = new Padding(40, 10, 15, 10);
        super();
        isCentered = false;
        this.companiesDP = new DAAPIDataProvider();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        canClose = true;
        enabledCloseBtn = false;
        canDrag = true;
        canResize = true;
        canMinimize = true;
        showWindowBgForm = false;
        var _loc1_:Padding = window.contentPadding as Padding;
        _loc1_.top = this.windowContentPadding.top;
        _loc1_.left = this.windowContentPadding.left;
        _loc1_.right = this.windowContentPadding.right;
        _loc1_.bottom = this.windowContentPadding.bottom;
        window.setMaxWidth(MAX_WINDOW_WIDTH);
        window.setMaxHeight(MAX_WINDOW_HEIGHT);
        window.setTitleIcon(TEAM_LIST);
        window.title = CHAT.CHANNELS_COMPANY;
        geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = window.width - window.contentPadding.left - window.contentPadding.right;
            _loc2_ = window.height - window.contentPadding.top - window.contentPadding.bottom;
            _width = _loc1_;
            _height = _loc2_;
            constraints.update(_loc1_, _loc2_);
            this.channelComponent.invalidate(InvalidationType.SIZE);
        }
    }

    override protected function configUI():void {
        super.configUI();
        registerFlashComponentS(this.channelComponent, Aliases.CHANNEL_COMPONENT);
        this.refreshButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_REFRESH;
        this.filterButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_FILTER;
        this.createButton.label = PREBATTLE.BUTTONS_COMPANY_CREATE;
        constraints = new Constraints(this, ConstrainMode.REFLOW);
        var _loc1_:DisplayObject = this.channelComponent.messageArea;
        constraints.addElement(_loc1_.name, _loc1_, Constraints.ALL);
        _loc1_ = this.channelComponent.messageInput;
        constraints.addElement(_loc1_.name, _loc1_, Constraints.BOTTOM | Constraints.LEFT | Constraints.RIGHT);
        _loc1_ = this.channelComponent.sendButton as DisplayObject;
        constraints.addElement(_loc1_.name, _loc1_, Constraints.BOTTOM | Constraints.RIGHT);
        constraints.addElement(this.cmpList.name, this.cmpList, Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
        constraints.addElement(this.topPanel.name, this.topPanel, Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
        constraints.addElement(this.refreshButton.name, this.refreshButton as DisplayObject, Constraints.TOP | Constraints.RIGHT);
        constraints.addElement(this.filterButton.name, this.filterButton as DisplayObject, Constraints.TOP | Constraints.RIGHT);
        constraints.addElement(this.filterTextField.name, this.filterTextField, Constraints.TOP | Constraints.RIGHT | Constraints.LEFT);
        constraints.addElement(this.filterInBattleCheckbox.name, this.filterInBattleCheckbox, Constraints.TOP | Constraints.RIGHT);
        constraints.addElement(this.groupsScrollBar.name, this.groupsScrollBar, Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
        constraints.addElement(this.division.name, this.division, Constraints.TOP | Constraints.RIGHT);
        this.refreshButton.addEventListener(ButtonEvent.CLICK, this.refreshButton_buttonClickHandler);
        this.cmpList.addEventListener(CompanyEvent.SELECTED_ITEM, this.selectedItemHandler);
        this.cmpList.dataProvider = this.companiesDP;
        this.cmpList.addEventListener(CompanyEvent.DROP_LIST_CLICK, this.groupsList_listClickHandler);
        this.division.dataProvider = new DataProvider(getDivisionsListS());
        this.division.selectedIndex = this.defaultSelectedIndex;
        this.division.enabled = false;
        this.division.addEventListener(ListEvent.INDEX_CHANGE, this.handleDivisionsChange);
        this.createButton.addEventListener(ButtonEvent.CLICK, this.handleCreateButtonClick);
        this.filterTextField.addEventListener(FocusEvent.FOCUS_IN, this.filterTextField_focusInHandler);
        this.filterTextField.addEventListener(Event.CHANGE, this.filterTextField_changeHandler);
        this.filterTextField.addEventListener(InputEvent.INPUT, this.filterTextField_inputHandler);
        this.filterButton.addEventListener(ButtonEvent.CLICK, this.onFilterButtonPress);
        this.filterButton.addEventListener(MouseEvent.MOUSE_OVER, this.onFilterButtonOver);
        this.filterButton.addEventListener(MouseEvent.MOUSE_OUT, this.onFilterButtonOut);
        this.filterInBattleCheckbox.selected = this.selectedFilterInBattleCheckbox;
        this.filterTextField.text = this.defaultFilterText;
        addEventListener(CompanyDropDownEvent.SHOW_DROP_DOWN, this.onShowDropwDownHandler);
        this.channelComponent.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        this.cmpList.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.enableFilterButtons);
        removeEventListener(CompanyDropDownEvent.SHOW_DROP_DOWN, this.onShowDropwDownHandler);
        this.channelComponent.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        this.channelComponent.dispose();
        this.channelComponent = null;
        this.refreshButton.removeEventListener(ButtonEvent.CLICK, this.refreshButton_buttonClickHandler);
        this.refreshButton.dispose();
        this.refreshButton = null;
        this.cmpList.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        this.cmpList.removeEventListener(CompanyEvent.DROP_LIST_CLICK, this.groupsList_listClickHandler);
        this.cmpList.removeEventListener(CompanyEvent.SELECTED_ITEM, this.selectedItemHandler);
        this.cmpList.dispose();
        this.cmpList = null;
        this.division.removeEventListener(ListEvent.INDEX_CHANGE, this.handleDivisionsChange);
        this.division.dataProvider.cleanUp();
        this.division.dataProvider = null;
        this.division.dispose();
        this.division = null;
        this.createButton.removeEventListener(ButtonEvent.CLICK, this.handleCreateButtonClick);
        this.createButton.dispose();
        this.createButton = null;
        this.filterTextField.removeEventListener(FocusEvent.FOCUS_IN, this.filterTextField_focusInHandler);
        this.filterTextField.removeEventListener(Event.CHANGE, this.filterTextField_changeHandler);
        this.filterTextField.removeEventListener(InputEvent.INPUT, this.filterTextField_inputHandler);
        this.filterTextField.dispose();
        this.filterButton.removeEventListener(ButtonEvent.CLICK, this.onFilterButtonPress);
        this.filterButton.removeEventListener(MouseEvent.MOUSE_OVER, this.onFilterButtonOver);
        this.filterButton.removeEventListener(MouseEvent.MOUSE_OUT, this.onFilterButtonOut);
        this.filterButton.dispose();
        this.filterButton = null;
        this.filterInBattleCheckbox.dispose();
        this.filterInBattleCheckbox = null;
        this.groupsScrollBar.dispose();
        this.groupsScrollBar = null;
        this.companiesDP = null;
        this.topPanel = null;
        this.filterTextField = null;
        super.onDispose();
    }

    public function as_disableCreateButton(param1:Boolean):void {
        if (this.createButton != null) {
            this.createButton.enabled = !param1;
        }
    }

    public function as_getCompaniesListDP():Object {
        return this.companiesDP;
    }

    public function as_setDefaultFilter(param1:String, param2:Boolean, param3:uint):void {
        this.defaultFilterText = param1;
        this.selectedFilterInBattleCheckbox = param2;
        this.defaultSelectedIndex = param3;
    }

    public function as_setRefreshCoolDown(param1:Number):void {
        this.coolDownProcess(param1 * 1000);
    }

    public function as_showPlayersList(param1:uint):void {
        if (this.cmpList) {
            this.cmpList.setIndexCompany = param1;
        }
    }

    private function coolDownProcess(param1:Number):void {
        this.enableFilterButtons(false);
        App.utils.scheduler.scheduleTask(this.enableFilterButtons, param1, true);
    }

    private function enableFilterButtons(param1:Boolean):void {
        if (!param1) {
            if (this.filterTextField.hasEventListener(InputEvent.INPUT)) {
                this.filterTextField.removeEventListener(InputEvent.INPUT, this.filterTextField_inputHandler);
            }
        }
        else {
            this.filterTextField.addEventListener(InputEvent.INPUT, this.filterTextField_inputHandler);
        }
        var _loc2_:Number = this.getSelectedDivisionData();
        this.refreshButton.enabled = param1;
        this.filterButton.enabled = param1 && _loc2_ == 0 ? this.filterTextField.text != "" : false;
        this.division.enabled = param1;
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

    override public function handleInput(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN) {
            if (this.cmpList.isOpenedState) {
                this.cmpList.unselectedRenderers();
                param1.preventDefault();
                param1.stopImmediatePropagation();
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

    private function onFilterButtonOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onFilterButtonOver(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.PREBATTLE_NAMEFILTERBUTTON);
    }

    private function onRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(IFocusContainer(param1.target).getComponentForFocus());
    }

    private function handleDivisionsChange(param1:ListEvent):void {
        refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
        var _loc2_:Number = this.getSelectedDivisionData();
        this.filterButton.enabled = this.refreshButton.enabled && _loc2_ == 0 ? this.filterTextField.text != "" : false;
    }

    private function refreshButton_buttonClickHandler(param1:ButtonEvent):void {
        refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
    }

    private function groupsList_listClickHandler(param1:CompanyEvent):void {
        joinCompanyS(param1.prbID);
        this.cmpList.updateRenderer();
    }

    private function handleCreateButtonClick(param1:ButtonEvent):void {
        createCompanyS();
    }

    private function filterTextField_changeHandler(param1:Event):void {
        var _loc2_:Number = this.getSelectedDivisionData();
        this.filterButton.enabled = this.refreshButton.enabled && _loc2_ == 0 ? this.filterTextField.text != "" : false;
    }

    private function onFilterButtonPress(param1:ButtonEvent):void {
        refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
    }

    private function selectedItemHandler(param1:CompanyEvent):void {
        if (param1.prbID > -1) {
            requestPlayersListS(param1.prbID);
        }
    }

    private function filterTextField_focusInHandler(param1:FocusEvent):void {
    }

    private function filterTextField_inputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ENTER) {
            param1.handled = true;
            this.filterButton.selected = true;
            refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
            this.filterTextField.removeEventListener(InputEvent.INPUT, this.filterTextField_inputHandler);
        }
    }

    private function onShowDropwDownHandler(param1:CompanyDropDownEvent):void {
        var _loc2_:Point = globalToLocal(new Point(param1.dropDownref.x, param1.dropDownref.y));
        var _loc3_:IEventCollector = App.utils.events;
        _loc3_.disableDisposingForObj(param1.dropDownref);
        addChild(param1.dropDownref);
        _loc3_.enableDisposingForObj(param1.dropDownref);
        param1.dropDownref.x = _loc2_.x;
        param1.dropDownref.y = _loc2_.y;
    }
}
}

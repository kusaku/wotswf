package net.wg.gui.cyberSport.staticFormation {
import flash.events.Event;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.SortableHeaderButtonBar;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.NormalSortingButton;
import net.wg.gui.components.controls.SortableTableList;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TextInput;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsDataProvider;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsVO;
import net.wg.gui.cyberSport.staticFormation.events.InvitesAndRequestsAcceptEvent;
import net.wg.gui.events.SortingEvent;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.infrastructure.base.meta.IStaticFormationInvitesAndRequestsMeta;
import net.wg.infrastructure.base.meta.impl.StaticFormationInvitesAndRequestsMeta;

import scaleform.clik.constants.InputValue;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.utils.Padding;

public class InvitesAndRequestsWindow extends StaticFormationInvitesAndRequestsMeta implements IStaticFormationInvitesAndRequestsMeta {

    private static const DESCRIPTION_STATE_NONE:int = 0;

    private static const DESCRIPTION_STATE_STATIC_VIEW:int = 1;

    private static const DESCRIPTION_STATE_INTERACTIVE_VIEW:int = 2;

    private static const DESCRIPTION_STATE_EDIT:int = 3;

    private static const SCROLLBAR_PADDING:Padding = new Padding(11, 9, 10, 0);

    public var title:TextField;

    public var windowDescription:TextField;

    public var teamDescriptionTF:TextField;

    public var editDescriptionButton:IButtonIconLoader;

    public var descriptionInput:TextInput;

    public var editCommitButton:IButtonIconLoader;

    public var teamDescriptionStatic:TextField;

    public var invitesOnlyCheckbox:CheckBox;

    public var tableHeader:SortableHeaderButtonBar;

    public var tableList:SortableTableList;

    public var closeBtn:SoundButtonEx;

    private var _teamDescriptionState:int = 0;

    private var _dp:InvitesAndRequestsDataProvider = null;

    public function InvitesAndRequestsWindow() {
        super();
        isModal = true;
        isCentered = true;
        canClose = false;
        this.teamDescriptionStatic.visible = false;
        this.teamDescriptionTF.visible = false;
        this._dp = new InvitesAndRequestsDataProvider();
    }

    override protected function configUI():void {
        super.configUI();
        this.title.text = CYBERSPORT.INVITESANDREQUESTSWINDOW_TITLE;
        this.invitesOnlyCheckbox.label = CYBERSPORT.INVITESANDREQUESTSWINDOW_ONLYINVITESCHECKBOX;
        this.closeBtn.label = MENU.AWARDWINDOW_OKBUTTON;
        this.editCommitButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ENTERWHITE;
        this.editDescriptionButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_PEN;
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClick);
        this.invitesOnlyCheckbox.addEventListener(Event.SELECT, this.onInvitesOnlyCheckboxSelect);
        this.tableList.addEventListener(InvitesAndRequestsAcceptEvent.TYPE, this.onTableItemAccept);
        this.tableHeader.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED, this.onSortDirectionChangedHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = CYBERSPORT.INVITESANDREQUESTSWINDOW_WINDOWTITLE;
        window.useBottomBtns = true;
    }

    override protected function onDispose():void {
        this.setTeamDescriptionState(DESCRIPTION_STATE_NONE);
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClick);
        this.invitesOnlyCheckbox.removeEventListener(Event.SELECT, this.onInvitesOnlyCheckboxSelect);
        this.tableList.removeEventListener(InvitesAndRequestsAcceptEvent.TYPE, this.onTableItemAccept);
        this.tableHeader.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED, this.onSortDirectionChangedHandler);
        this.title = null;
        this.windowDescription = null;
        this.teamDescriptionTF = null;
        this.editDescriptionButton.dispose();
        this.editDescriptionButton = null;
        this.descriptionInput.dispose();
        this.descriptionInput = null;
        this.editCommitButton.dispose();
        this.editCommitButton = null;
        this.teamDescriptionStatic = null;
        this.invitesOnlyCheckbox.dispose();
        this.invitesOnlyCheckbox = null;
        this.tableHeader.dispose();
        this.tableHeader = null;
        this.tableList.dispose();
        this.tableList = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        this._dp.cleanUp();
        this._dp = null;
        super.onDispose();
    }

    override protected function setStaticData(param1:InvitesAndRequestsVO):void {
        this.windowDescription.text = param1.windowDescription;
        if (param1.isTeamDescriptionEditable) {
            this.teamDescriptionTF.text = param1.teamDescription;
            this.setTeamDescriptionState(DESCRIPTION_STATE_INTERACTIVE_VIEW);
        }
        else {
            this.teamDescriptionStatic.text = param1.teamDescription;
            this.setTeamDescriptionState(DESCRIPTION_STATE_STATIC_VIEW);
        }
        this.initTable(new DataProvider(App.utils.data.vectorToArray(param1.tableHeader)));
    }

    public function as_getDataProvider():Object {
        return this._dp;
    }

    public function as_setTeamDescription(param1:String):void {
        this.teamDescriptionTF.text = param1;
        this.setTeamDescriptionState(DESCRIPTION_STATE_INTERACTIVE_VIEW);
    }

    private function initTable(param1:DataProvider):void {
        this.tableHeader.itemRendererName = Linkages.NORMAL_SORT_BTN_UI;
        this.tableHeader.dataProvider = param1;
        this.tableList.scrollBar = Linkages.SCROLL_BAR;
        this.tableList.sbPadding = SCROLLBAR_PADDING;
        this.tableList.dataProvider = this._dp;
    }

    private function onInputAccepted():void {
        setDescriptionS(this.descriptionInput.text);
    }

    private function setTeamDescriptionState(param1:int):void {
        if (this._teamDescriptionState != param1) {
            switch (this._teamDescriptionState) {
                case DESCRIPTION_STATE_STATIC_VIEW:
                    this.teamDescriptionStatic.visible = false;
                    break;
                case DESCRIPTION_STATE_INTERACTIVE_VIEW:
                    this.teamDescriptionTF.visible = false;
                    this.editDescriptionButton.visible = false;
                    this.editDescriptionButton.removeEventListener(ButtonEvent.CLICK, this.onEditDescriptionBtnClick);
                    break;
                case DESCRIPTION_STATE_EDIT:
                    this.descriptionInput.visible = false;
                    this.descriptionInput.removeEventListener(InputEvent.INPUT, this.descriptionInputHandler);
                    this.editCommitButton.visible = false;
                    this.editCommitButton.removeEventListener(ButtonEvent.CLICK, this.onEditCommitBtnClick);
            }
            this._teamDescriptionState = param1;
            switch (this._teamDescriptionState) {
                case DESCRIPTION_STATE_STATIC_VIEW:
                    this.teamDescriptionStatic.visible = true;
                    setFocus(this.closeBtn);
                    break;
                case DESCRIPTION_STATE_INTERACTIVE_VIEW:
                    this.teamDescriptionTF.visible = true;
                    this.editDescriptionButton.visible = true;
                    this.editDescriptionButton.addEventListener(ButtonEvent.CLICK, this.onEditDescriptionBtnClick);
                    setFocus(this.closeBtn);
                    break;
                case DESCRIPTION_STATE_EDIT:
                    this.descriptionInput.visible = true;
                    this.descriptionInput.text = Values.EMPTY_STR;
                    this.descriptionInput.addEventListener(InputEvent.INPUT, this.descriptionInputHandler);
                    this.editCommitButton.visible = true;
                    this.editCommitButton.addEventListener(ButtonEvent.CLICK, this.onEditCommitBtnClick);
                    setFocus(this.descriptionInput);
            }
        }
    }

    private function onTableItemAccept(param1:InvitesAndRequestsAcceptEvent):void {
        resolvePlayerRequestS(param1.playerId, param1.isAccepted);
    }

    private function onInvitesOnlyCheckboxSelect(param1:Event):void {
        setShowOnlyInvitesS(this.invitesOnlyCheckbox.selected);
    }

    private function descriptionInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && this.descriptionInput.visible) {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.setTeamDescriptionState(DESCRIPTION_STATE_INTERACTIVE_VIEW);
        }
        if (param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN) {
            param1.handled = true;
            this.onInputAccepted();
        }
    }

    private function onEditCommitBtnClick(param1:ButtonEvent):void {
        this.onInputAccepted();
    }

    private function onEditDescriptionBtnClick(param1:ButtonEvent):void {
        this.setTeamDescriptionState(DESCRIPTION_STATE_EDIT);
    }

    private function onCloseBtnClick(param1:ButtonEvent):void {
        handleWindowClose();
    }

    private function onSortDirectionChangedHandler(param1:SortingEvent):void {
        var _loc2_:NormalSortingButton = NormalSortingButton(param1.target);
        if (_loc2_.sortDirection != SortingInfo.WITHOUT_SORT) {
            this.tableList.sortByField(_loc2_.id, _loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
        }
    }
}
}

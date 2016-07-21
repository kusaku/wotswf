package net.wg.gui.prebattle.company {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.COMPANY_ALIASES;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TextInput;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.prebattle.company.VO.CompanyRoomHeaderBaseVO;
import net.wg.gui.prebattle.company.VO.CompanyRoomHeaderVO;
import net.wg.gui.prebattle.company.VO.CompanyRoomInvalidVehiclesVO;
import net.wg.gui.prebattle.controls.TeamMemberRenderer;
import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
import net.wg.infrastructure.base.meta.ICompanyRoomMeta;
import net.wg.infrastructure.base.meta.impl.CompanyRoomMeta;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;
import net.wg.infrastructure.interfaces.IViewStackContent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InputValue;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.FocusHandlerEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.utils.Padding;
import scaleform.gfx.MouseEventEx;

public class CompanyRoomView extends CompanyRoomMeta implements ICompanyRoomMeta {

    public var hiddenItemRenderer:TeamMemberRenderer;

    public var addToAssignBtn:IButtonIconLoader;

    public var removeFromAssignBtn:IButtonIconLoader;

    public var commitEditButton:IButtonIconLoader;

    public var editButton:IButtonIconLoader;

    public var headerViewStack:ViewStack;

    public var listTitle:MovieClip;

    public var commentInput:TextInput;

    public var commentText:TextField;

    public var crewStuffField:TextField;

    public var queueLabel:TextField;

    public var totalCurrentLevelField:TextField;

    public var leaveButton:SoundButtonEx;

    public var readyButton:SoundButtonEx;

    public var inviteButton:SoundButtonEx;

    public var division:DropdownMenu;

    public var unassignedList:ScrollingListEx;

    public var assignedList:ScrollingListEx;

    public var unassignedDataProvider:DataProvider;

    public var assignedDataProvider:DataProvider;

    public var isOpenCheckbox:CheckBox;

    public var _commentDefaultTextColor:uint = 4473918;

    private var _commentNormalTextColor:Number;

    private var _canSendInvite:Boolean;

    private var _canKickPlayer:Boolean;

    private var _canAssignPlayer:Boolean;

    private var _canChangeComment:Boolean;

    private var _canMakeOpenedClosed:Boolean;

    private var _canUnassignedPlayer:Boolean = false;

    private var _isPlayerReady:Boolean = false;

    private var _canChangeDivision:Boolean = false;

    private var _editState:Boolean = false;

    private var _isDefaultComment:Boolean = false;

    private var _isPlayerCreator:Boolean = false;

    private var _lastComment:String = "";

    private var _buttonsUpdated:Boolean = false;

    private var _headerVO:CompanyRoomHeaderBaseVO = null;

    private var _viewType:int = -1;

    private var _invalidVehiclesVOs:Vector.<CompanyRoomInvalidVehiclesVO> = null;

    public function CompanyRoomView() {
        this.unassignedDataProvider = new DataProvider();
        this.assignedDataProvider = new DataProvider();
        super();
    }

    override public function as_enableLeaveBtn(param1:Boolean):void {
        this.updateLeaveBtn(param1);
    }

    override public function as_enableReadyBtn(param1:Boolean):void {
        this.enableReadyButton(param1);
    }

    override public function as_refreshPermissions():void {
        this.updatePermissions();
    }

    override public function as_resetReadyButtonCoolDown():void {
        App.utils.scheduler.cancelTask(this.enableReadyButton);
    }

    override public function as_setCoolDownForReadyButton(param1:uint):void {
        this.enableReadyButton(false);
        App.utils.scheduler.scheduleTask(this.enableReadyButton, param1 * 1000, true);
    }

    override public function as_setPlayerState(param1:int, param2:Boolean, param3:Object):void {
        var _loc8_:Object = null;
        var _loc4_:Array = [];
        var _loc5_:DataProvider = !!param2 ? DataProvider(this.assignedList.dataProvider) : DataProvider(this.unassignedList.dataProvider);
        var _loc6_:uint = _loc5_.length;
        var _loc7_:int = 0;
        while (_loc7_ < _loc6_) {
            _loc8_ = _loc5_.requestItemAt(_loc7_);
            if (_loc8_.dbID == param3.dbID) {
                _loc8_.state = param3.state;
                _loc8_.vShortName = param3.vShortName;
                _loc8_.vLevel = param3.vLevel;
                _loc8_.icon = param3.icon;
                _loc8_.vType = param3.vType;
                _loc8_.igrType = param3.igrType;
            }
            _loc4_.push(_loc8_);
            _loc7_++;
        }
        if (param2) {
            this.updateAssignList(_loc4_);
        }
        else {
            this.updateUnassignList(_loc4_);
        }
    }

    override public function as_setRosterList(param1:int, param2:Boolean, param3:Array):void {
        var _loc5_:int = 0;
        var _loc6_:Object = null;
        var _loc7_:int = 0;
        var _loc4_:Array = [];
        if (param3.length > 0) {
            _loc5_ = param3.length;
            _loc7_ = 0;
            while (_loc7_ < _loc5_) {
                _loc6_ = param3[_loc7_] as Object;
                _loc6_["orderNumber"] = _loc7_ + 1;
                _loc4_.push(new PlayerPrbInfoVO(_loc6_));
                _loc7_++;
            }
        }
        if (param2) {
            this.updateAssignList(_loc4_);
        }
        else {
            this.updateUnassignList(_loc4_);
        }
        this.updateMoveButtons();
    }

    override public function as_toggleReadyBtn(param1:Boolean):void {
        this.readyButton.label = !!param1 ? PREBATTLE.DIALOGS_BUTTONS_READY : PREBATTLE.DIALOGS_BUTTONS_NOTREADY;
    }

    override public function getComponentForFocus():InteractiveObject {
        return channelComponent.getComponentForFocus();
    }

    override protected function onDispose():void {
        this.cleanupHeaderVO();
        this.cleanupInvalidVehiclesVO();
        this.commentText = null;
        this.crewStuffField = null;
        this.queueLabel = null;
        this.totalCurrentLevelField = null;
        this.headerViewStack.removeEventListener(ViewStackEvent.NEED_UPDATE, this.onUpdateHandler);
        this.headerViewStack.dispose();
        this.headerViewStack = null;
        this.removeEventListener(InputEvent.INPUT, this.escInputHandler);
        this.commentInput.removeEventListener(FocusHandlerEvent.FOCUS_IN, this.handleFocusInCommentInput);
        this.commentInput.removeEventListener(InputEvent.INPUT, this.commentInput_inputHandler);
        this.commentInput.dispose();
        this.commentInput = null;
        this.commitEditButton.removeEventListener(ButtonEvent.PRESS, this.handleCommitEditClick);
        this.commitEditButton.dispose();
        this.commitEditButton = null;
        this.editButton.removeEventListener(ButtonEvent.PRESS, this.handleCommitEditClick);
        this.editButton.dispose();
        this.editButton = null;
        this.readyButton.removeEventListener(ButtonEvent.CLICK, this.handleReadyClick);
        this.readyButton.dispose();
        this.readyButton = null;
        this.leaveButton.removeEventListener(ButtonEvent.CLICK, this.handleLeaveClick);
        this.leaveButton.dispose();
        this.leaveButton = null;
        this.inviteButton.removeEventListener(ButtonEvent.CLICK, this.onInviteBtnClick);
        this.inviteButton.dispose();
        this.inviteButton = null;
        if (this._canUnassignedPlayer) {
            this.assignedList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK, this.assignedList_itemDoubleClickHandler);
            this.removeFromAssignBtn.removeEventListener(ButtonEvent.CLICK, this.handleDownClick);
        }
        if (this._canAssignPlayer) {
            this.unassignedList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK, this.handleMember17ItemDoubleClick);
            this.addToAssignBtn.removeEventListener(ButtonEvent.CLICK, this.handleUpClick);
        }
        this.addToAssignBtn.dispose();
        this.addToAssignBtn = null;
        this.removeFromAssignBtn.dispose();
        this.removeFromAssignBtn = null;
        this.unassignedList.removeEventListener(ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
        this.unassignedList.dispose();
        this.unassignedList = null;
        this.unassignedDataProvider.cleanUp();
        this.unassignedDataProvider = null;
        this.assignedList.removeEventListener(ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
        this.assignedList.dispose();
        this.assignedList = null;
        this.assignedDataProvider.cleanUp();
        this.assignedDataProvider = null;
        this.listTitle = null;
        if (this.division.hasEventListener(ListEvent.INDEX_CHANGE)) {
            this.division.removeEventListener(ListEvent.INDEX_CHANGE, this.handleDivisionChange);
        }
        this.division.dispose();
        this.division = null;
        if (this.isOpenCheckbox.hasEventListener(ButtonEvent.CLICK)) {
            this.isOpenCheckbox.removeEventListener(ButtonEvent.CLICK, this.handleIsOpenChange);
        }
        this.isOpenCheckbox.dispose();
        this.isOpenCheckbox = null;
        App.utils.scheduler.cancelTask(this.enableReadyButton);
        App.utils.scheduler.cancelTask(this.enableChangeSettings);
        App.utils.scheduler.cancelTask(this.changeVisibleState);
        if (isFlashComponentRegisteredS(Aliases.CHANNEL_COMPONENT)) {
            unregisterFlashComponentS(Aliases.CHANNEL_COMPONENT);
        }
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.headerViewStack.addEventListener(ViewStackEvent.NEED_UPDATE, this.onUpdateHandler);
        registerFlashComponent(channelComponent, Aliases.CHANNEL_COMPONENT);
        this.initComponentProperties();
        this.updatePermissions();
    }

    override protected function configUI():void {
        super.configUI();
        this.addToAssignBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_ARROW_FORMATION_RIGHT;
        this.removeFromAssignBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_ARROW_FORMATION_LEFT;
        this.commitEditButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ENTERWHITE;
        this.editButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_PEN;
        this.hiddenItemRenderer.visible = false;
        var _loc1_:String = "fullName";
        this.assignedList.labelField = _loc1_;
        this.unassignedList.labelField = _loc1_;
        this.unassignedList.dataProvider = this.unassignedDataProvider;
        this.unassignedList.selectedIndex = -1;
        this.unassignedList.addEventListener(ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
        this.assignedList.addEventListener(ListEventEx.ITEM_CLICK, this.showAssignContextMenu);
        this.readyButton.addEventListener(ButtonEvent.CLICK, this.handleReadyClick);
        this.leaveButton.addEventListener(ButtonEvent.CLICK, this.handleLeaveClick);
        this._commentNormalTextColor = this.commentInput.textField.textColor;
        this.commentInput.defaultTextFormat.color = this._commentDefaultTextColor;
        this.commentInput.textField.textColor = this._commentDefaultTextColor;
        this.commentInput.defaultTextFormat.italic = false;
        this.commentInput.defaultText = PREBATTLE.LABELS_COMPANY_DEFAULTTEXT;
        this.commentInput.addEventListener(InputEvent.INPUT, this.commentInput_inputHandler);
        this.commentInput.addEventListener(FocusHandlerEvent.FOCUS_IN, this.handleFocusInCommentInput);
        if (this.listTitle) {
            this.listTitle.player.text = PREBATTLE.LABELS_PLAYER;
            this.listTitle.vehicle.text = PREBATTLE.LABELS_VEHICLE;
            this.listTitle.level.text = PREBATTLE.LABELS_LEVEL;
        }
        this.queueLabel.text = PREBATTLE.LABELS_COMPANY_QUEUE;
        this.addEventListener(InputEvent.INPUT, this.escInputHandler);
    }

    override protected function draw():void {
        super.draw();
    }

    public function as_setChangeSettingCoolDown(param1:uint):void {
        this.disableSettings(param1 * 1000);
    }

    public function as_setComment(param1:String):void {
        param1 = StringUtils.trim(param1);
        this._lastComment = param1;
        if (!param1) {
            if (canChangeCommentS()) {
                this.commentText.visible = true;
                this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                this._isDefaultComment = true;
                this.changeAlign(this._isDefaultComment);
            }
            else {
                this.commentText.text = "";
                this.commentText.visible = false;
            }
            return;
        }
        var _loc2_:Boolean = canChangeCommentS();
        if (param1 == "" && !_loc2_) {
            this.commentText.text = "";
            this.commentText.visible = false;
        }
        else if (param1 != "") {
            this.commentText.visible = true;
        }
        if (param1 == "") {
            param1 = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
            this._isDefaultComment = true;
        }
        else {
            this._isDefaultComment = false;
        }
        this.commentText.text = param1;
        this.changeAlign(this._isDefaultComment);
        if (this.commentInput && !this._isDefaultComment) {
            this.commentInput.text = param1;
            this.commentInput.enabled = _loc2_;
        }
    }

    public function as_setDivision(param1:uint):void {
        this.autoSelectDivision(param1);
    }

    public function as_setDivisionsList(param1:Array, param2:uint):void {
        if (!this.division) {
            return;
        }
        this.division.dataProvider = new DataProvider(param1);
        this.division.labelField = "label";
        this.division.menuOffset = new Padding(-4, -3, 0, 3);
        this.division.rowCount = param1.length;
        this.autoSelectDivision(param2);
        this.updateDivision();
        this.leaveButton.label = !!isPlayerCreatorS() ? MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_DISMISS : MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_LEAVE;
        this.updateReadyButton();
    }

    public function as_setHeaderData(param1:int, param2:Object):void {
        var _loc3_:IViewStackContent = null;
        if (!param2) {
            return;
        }
        this.cleanupHeaderVO();
        this._viewType = param1;
        this._headerVO = this.makeHeaderVO(param1, param2);
        App.utils.asserter.assertNotNull(this._headerVO, " Incorrect _headerVO : " + Errors.CANT_NULL);
        if (this.headerViewStack.currentLinkage != this._headerVO.viewLinkage) {
            this.headerViewStack.show(this._headerVO.viewLinkage);
        }
        else {
            _loc3_ = this.headerViewStack.currentView as IViewStackContent;
            App.utils.asserter.assertNotNull(_loc3_, " headerViewStack.currentView :" + Errors.CANT_NULL);
            this.updateHeaderView(_loc3_, this._headerVO);
        }
    }

    public function as_setInvalidVehicles(param1:Array):void {
        var _loc2_:Object = null;
        this.cleanupInvalidVehiclesVO();
        this._invalidVehiclesVOs = new Vector.<CompanyRoomInvalidVehiclesVO>(0);
        for each(_loc2_ in param1) {
            this._invalidVehiclesVOs.push(new CompanyRoomInvalidVehiclesVO(_loc2_));
        }
        this.refreshInvalidVehicles();
    }

    public function as_setMaxCountLimitLabel(param1:String):void {
        if (this.crewStuffField) {
            this.crewStuffField.htmlText = param1;
        }
    }

    public function as_setOpened(param1:Boolean):void {
        if (this.isOpenCheckbox) {
            this.isOpenCheckbox.removeEventListener(ButtonEvent.CLICK, this.handleIsOpenChange);
            this.isOpenCheckbox.selected = param1;
            this.isOpenCheckbox.enabled = canMakeOpenedClosedS();
            this.isOpenCheckbox.addEventListener(ButtonEvent.CLICK, this.handleIsOpenChange);
        }
    }

    public function as_setTotalLimitLabels(param1:String):void {
        this.totalCurrentLevelField.htmlText = param1;
    }

    private function updateHeaderView(param1:IViewStackContent, param2:IDAAPIDataClass):void {
        param1.update(param2);
    }

    private function makeHeaderVO(param1:int, param2:Object):CompanyRoomHeaderBaseVO {
        if (param1 == COMPANY_ALIASES.STANDARD_TYPE) {
            return new CompanyRoomHeaderVO(param2);
        }
        return null;
    }

    private function cleanupHeaderVO():void {
        if (this._headerVO) {
            this._headerVO.dispose();
            this._headerVO = null;
        }
    }

    private function updateLeaveBtn(param1:Boolean):void {
        this.leaveButton.enabled = param1;
    }

    private function updateDivision():void {
        this.division.enabled = this._canChangeDivision;
    }

    private function changeAlign(param1:Boolean):void {
        var _loc2_:TextFormat = this.commentText.getTextFormat();
        _loc2_.align = !!param1 ? TextFormatAlign.RIGHT : TextFormatAlign.CENTER;
        this.commentText.setTextFormat(_loc2_);
    }

    private function updateCommentedStates(param1:Boolean = true):void {
        var _loc2_:String = null;
        this._editState = !this._editState;
        if (this._editState) {
            this.commentText.visible = false;
            this.forceSetTextToTextInput(this._lastComment);
            if (!this.commentInput.focused) {
                App.utils.focusHandler.setFocus(this.commentInput);
            }
            App.utils.scheduler.scheduleOnNextFrame(this.changeVisibleState);
        }
        else {
            this.changeVisibleState();
            this.commentText.visible = true;
            if (param1) {
                _loc2_ = StringUtils.trim(this.commentInput.text);
                if (_loc2_ != "") {
                    this.commentText.text = this.commentInput.text;
                    this._lastComment = this.commentInput.text;
                    this.changeAlign(false);
                    this._isDefaultComment = false;
                }
                else {
                    this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
                    this.changeAlign(true);
                    this._isDefaultComment = true;
                }
                this.commentInput.text = _loc2_;
                this._lastComment = _loc2_;
                requestToChangeCommentS(_loc2_);
            }
        }
        this.changeEditIcon(this._editState);
    }

    private function changeVisibleState():void {
        if (this.commentInput.visible != this._editState) {
            this.commentInput.visible = this._editState;
        }
    }

    private function forceSetTextToTextInput(param1:String = ""):void {
        var _loc2_:uint = this.commentInput.textField.getTextFormat()["color"];
        if (_loc2_ == this._commentDefaultTextColor) {
            this.commentInput.textField.textColor = this._commentNormalTextColor;
            this.commentInput.text = param1;
        }
    }

    private function cleanupInvalidVehiclesVO():void {
        var _loc1_:CompanyRoomInvalidVehiclesVO = null;
        if (this._invalidVehiclesVOs) {
            for each(_loc1_ in this._invalidVehiclesVOs) {
                _loc1_.dispose();
                _loc1_ = null;
            }
            this._invalidVehiclesVOs.splice(0, this._invalidVehiclesVOs.length);
            this._invalidVehiclesVOs = null;
        }
    }

    private function refreshInvalidVehicles():void {
        this.updateVehicles(this._invalidVehiclesVOs, this.assignedList);
        this.updateVehicles(this._invalidVehiclesVOs, this.unassignedList);
    }

    private function updateVehicles(param1:Vector.<CompanyRoomInvalidVehiclesVO>, param2:ScrollingListEx):void {
        var _loc5_:TeamMemberRenderer = null;
        var _loc3_:uint = param2.dataProvider.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = param2.getRendererAt(_loc4_) as TeamMemberRenderer;
            if (_loc5_ && _loc5_.model) {
                this.updateRoster(param1, _loc5_);
            }
            _loc4_++;
        }
    }

    private function updateRoster(param1:Vector.<CompanyRoomInvalidVehiclesVO>, param2:TeamMemberRenderer):void {
        var _loc4_:CompanyRoomInvalidVehiclesVO = null;
        var _loc3_:Number = param2.model.accID;
        for each(_loc4_ in param1) {
            if (_loc4_.accID == _loc3_) {
                param2.toolTipStr = _loc4_.tooltip;
                param2.isVehicleValid = false;
                return;
            }
        }
        param2.isVehicleValid = true;
    }

    private function disableSettings(param1:uint):void {
        this.enableChangeSettings(false);
        App.utils.scheduler.scheduleTask(this.enableChangeSettings, param1, true);
    }

    private function enableChangeSettings(param1:Boolean = false):void {
        if (_baseDisposed) {
            return;
        }
        if (!param1) {
            if (this.commentInput.hasEventListener(InputEvent.INPUT)) {
                this.commentInput.removeEventListener(InputEvent.INPUT, this.commentInput_inputHandler);
            }
        }
        else {
            this.commentInput.addEventListener(InputEvent.INPUT, this.commentInput_inputHandler);
        }
        this.commitEditButton.enabled = param1;
        this.isOpenCheckbox.enabled = param1;
        if (param1) {
            this.division.enabled = this._canChangeDivision;
        }
        else {
            this.division.enabled = param1;
        }
    }

    private function requestToAssignImp(param1:Object):void {
        if (this._canAssignPlayer) {
            requestToAssignS(param1.accID);
        }
    }

    private function requestToUnassignImp(param1:Object):void {
        if (this._canUnassignedPlayer) {
            requestToUnassignS(param1.accID);
        }
    }

    private function changeEditIcon(param1:Boolean):void {
        var _loc2_:Boolean = this._canChangeComment;
        this.editButton.visible = _loc2_ && !param1;
        this.commitEditButton.visible = _loc2_ && param1;
    }

    private function initComponentProperties():void {
        this._canSendInvite = false;
        this._canKickPlayer = false;
        this._canAssignPlayer = false;
        this._canChangeComment = false;
        this._canMakeOpenedClosed = false;
    }

    private function enableReadyButton(param1:Boolean):void {
        this.readyButton.enabled = param1;
    }

    private function autoSelectDivision(param1:uint):void {
        var _loc4_:Object = null;
        this.division.removeEventListener(ListEvent.INDEX_CHANGE, this.handleDivisionChange);
        var _loc2_:int = this.division.dataProvider.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this.division.dataProvider.requestItemAt(_loc3_);
            if (_loc4_.data == param1) {
                this.division.selectedIndex = _loc3_;
            }
            _loc3_++;
        }
        this.division.addEventListener(ListEvent.INDEX_CHANGE, this.handleDivisionChange);
    }

    private function updateMoveButtons():void {
        if (this.addToAssignBtn) {
            this.addToAssignBtn.enabled = this.unassignedList.dataProvider.length > 0 && this._canAssignPlayer;
            this.removeFromAssignBtn.enabled = this.assignedList.dataProvider.length > 0 && this._canUnassignedPlayer;
        }
    }

    private function updateAssignList(param1:Array):void {
        this.assignedDataProvider = new DataProvider(param1);
        this.assignedList.dataProvider = this.assignedDataProvider;
        if (this.assignedList.selectedIndex == -1 && this._isPlayerCreator) {
            this.assignedList.selectedIndex = 0;
        }
        this.assignedList.validateNow();
    }

    private function updateUnassignList(param1:Array):void {
        this.unassignedDataProvider = new DataProvider(param1);
        this.unassignedList.dataProvider = this.unassignedDataProvider;
        if (this.unassignedList.selectedIndex == -1 && this._isPlayerCreator) {
            this.unassignedList.selectedIndex = 0;
        }
        this.unassignedList.validateNow();
    }

    private function updateOpenedCompany():void {
        this.isOpenCheckbox.enabled = this._canMakeOpenedClosed;
    }

    private function updateCommentBtns():void {
        if (this._canChangeComment) {
            this.commitEditButton.addEventListener(ButtonEvent.PRESS, this.handleCommitEditClick);
            this.editButton.addEventListener(ButtonEvent.PRESS, this.handleCommitEditClick);
            this.commitEditButton.enabled = true;
            this.clearCommentEditState();
        }
        else {
            if (this._isDefaultComment) {
                this.commentText.text = "";
            }
            this.commentInput.visible = false;
            this.commentText.visible = true;
        }
    }

    private function clearCommentEditState():void {
        this._editState = false;
        this.commentInput.visible = false;
        this.changeEditIcon(false);
        if (this._isDefaultComment) {
            this.commentText.text = PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT;
        }
        else {
            this.commentText.text = StringUtils.trim(this._lastComment) == "" ? PREBATTLE.LABELS_COMPANY_DEFAULTCOMMENT : this._lastComment;
        }
        this.changeAlign(this._isDefaultComment);
        if (this._canChangeComment) {
            this.commentText.visible = true;
        }
    }

    private function updateAssignUnassignBtns():void {
        if (this._canAssignPlayer) {
            this.unassignedList.useRightButton = true;
            this.unassignedList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK, this.handleMember17ItemDoubleClick);
            this.addToAssignBtn.addEventListener(ButtonEvent.CLICK, this.handleUpClick);
        }
        if (this._canUnassignedPlayer) {
            this.assignedList.useRightButton = true;
            this.assignedList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK, this.assignedList_itemDoubleClickHandler);
            this.removeFromAssignBtn.addEventListener(ButtonEvent.CLICK, this.handleDownClick);
        }
        this.updateMoveButtons();
    }

    private function updateInviteBtn():void {
        if (this._canSendInvite) {
            this.inviteButton.addEventListener(ButtonEvent.CLICK, this.onInviteBtnClick);
        }
        else if (this.inviteButton.hasEventListener(ButtonEvent.CLICK)) {
            this.inviteButton.removeEventListener(ButtonEvent.CLICK, this.onInviteBtnClick);
        }
        if (this._isPlayerCreator) {
            this.inviteButton.enabled = this._canSendInvite;
        }
        else {
            this.inviteButton.visible = this._canSendInvite;
        }
    }

    private function updatePermissions():void {
        this._canAssignPlayer = canMoveToAssignedS();
        this._canUnassignedPlayer = canMoveToUnassignedS();
        this._canSendInvite = canSendInviteS();
        this._canChangeComment = canChangeCommentS();
        this._canKickPlayer = canKickPlayerS();
        this._canMakeOpenedClosed = canMakeOpenedClosedS();
        this._isPlayerReady = isPlayerReadyS();
        this._canChangeDivision = canChangeDivisionS();
        this._isPlayerCreator = isPlayerCreatorS();
        var _loc1_:Boolean = isReadyBtnEnabledS();
        var _loc2_:Boolean = isLeaveBtnEnabledS();
        this.changeEditIcon(this._editState);
        this.updateReadyButton();
        this.enableReadyButton(_loc1_);
        this.updateMoveButtons();
        this.updateLeaveBtn(_loc2_);
        this.updateInviteBtn();
        this.updateAssignUnassignBtns();
        if (!this._buttonsUpdated) {
            this.updateCommentBtns();
            this._buttonsUpdated = true;
        }
        this.updateDivision();
        this.updateOpenedCompany();
    }

    private function updateReadyButton():void {
        this.readyButton.label = !!this._isPlayerReady ? PREBATTLE.DIALOGS_BUTTONS_NOTREADY : PREBATTLE.DIALOGS_BUTTONS_READY;
    }

    override public function handleInput(param1:InputEvent):void {
        if (param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP && this._editState && this.commentInput.focused) {
            return;
        }
        super.handleInput(param1);
    }

    private function handleCommitEditClick(param1:ButtonEvent = null):void {
        this.updateCommentedStates();
    }

    private function handleFocusInCommentInput(param1:FocusHandlerEvent = null):void {
        this.forceSetTextToTextInput();
    }

    private function handleUpClick(param1:ButtonEvent = null):void {
        var _loc2_:Object = null;
        if (this.unassignedList.dataProvider.length > 0) {
            if (this.unassignedList.selectedIndex > -1) {
                _loc2_ = this.unassignedList.dataProvider[this.unassignedList.selectedIndex];
                this.requestToAssignImp(_loc2_);
                this.clearCommentEditState();
            }
        }
    }

    private function handleDownClick(param1:Event = null):void {
        var _loc2_:Object = null;
        if (this.assignedList.dataProvider.length > 0) {
            if (this.assignedList.selectedIndex > -1) {
                _loc2_ = this.assignedList.dataProvider[this.assignedList.selectedIndex];
                this.requestToUnassignImp(_loc2_);
                this.clearCommentEditState();
            }
        }
    }

    private function handleMember17ItemDoubleClick(param1:ListEventEx):void {
        if (this.unassignedList.useRightButtonForSelect == false && param1.buttonIdx != MouseEventEx.LEFT_BUTTON) {
            return;
        }
        this.handleUpClick();
    }

    private function assignedList_itemDoubleClickHandler(param1:ListEventEx):void {
        if (this.assignedList.useRightButtonForSelect == false && param1.buttonIdx != MouseEventEx.LEFT_BUTTON) {
            return;
        }
        this.handleDownClick();
    }

    private function showAssignContextMenu(param1:ListEventEx):void {
        var _loc2_:Object = null;
        if (!param1.itemData) {
            return;
        }
        if (param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            _loc2_ = param1.itemData;
            if (_loc2_.accID > -1) {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.PREBATTLE_USER, this, _loc2_);
            }
            else {
                App.contextMenuMgr.hide();
            }
        }
    }

    private function handleDivisionChange(param1:ListEvent):void {
        if (this.division.enabled && param1.itemData) {
            requestToChangeDivisionS(param1.itemData.data);
            this.clearCommentEditState();
        }
    }

    private function handleLeaveClick(param1:ButtonEvent):void {
        requestToLeaveS();
    }

    private function handleReadyClick(param1:ButtonEvent):void {
        requestToReadyS(this.readyButton.label == PREBATTLE.DIALOGS_BUTTONS_READY);
        this.clearCommentEditState();
    }

    private function handleIsOpenChange(param1:ButtonEvent):void {
        requestToChangeOpenedS(param1.target.selected);
        this.clearCommentEditState();
    }

    private function onInviteBtnClick(param1:ButtonEvent):void {
        showPrebattleSendInvitesWindowS();
    }

    private function commentInput_inputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && this._editState) {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.updateCommentedStates(false);
        }
        if (param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN) {
            param1.handled = true;
            this.updateCommentedStates(true);
        }
    }

    private function escInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN && this._editState && this.commentInput.focused) {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.updateCommentedStates(false);
        }
    }

    private function onUpdateHandler(param1:ViewStackEvent):void {
        this.updateHeaderView(param1.view, this._headerVO);
    }
}
}

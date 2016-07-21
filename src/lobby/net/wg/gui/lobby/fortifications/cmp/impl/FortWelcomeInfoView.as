package net.wg.gui.lobby.fortifications.cmp.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.Aliases;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.HyperLink;
import net.wg.gui.components.miniclient.LinkedMiniClientComponent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.IFortWelcomeInfoView;
import net.wg.gui.lobby.fortifications.data.FortConstants;
import net.wg.gui.lobby.fortifications.data.FortWelcomeViewVO;
import net.wg.infrastructure.base.meta.IFortWelcomeInfoViewMeta;
import net.wg.infrastructure.base.meta.impl.FortWelcomeInfoViewMeta;
import net.wg.infrastructure.exceptions.NullPointerException;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;
import net.wg.utils.IUtils;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class FortWelcomeInfoView extends FortWelcomeInfoViewMeta implements IFortWelcomeInfoViewMeta, IFortWelcomeInfoView, IFocusContainer {

    private static const TEXT_V_ALIGN_START_POSITION_Y:uint = 0;

    private static const WARNING_OFFSET_Y:uint = 8;

    private static const REQUIREMENT_TEXT_OFFSET_Y:int = 41;

    private static const CREATE_BTN_OFFSET_Y:int = 30;

    private static const DESCRIPTION_TF_HEIGHT:int = 72;

    private static const DETAIL_OFFSET_Y:int = -1;

    private static const SEARCH_CLAN_BTN_OFFSET_Y:int = -8;

    private static const CREATE_CLAN_TEXT_OFFSET_Y:int = 9;

    private static const CREATE_CLAN_OFFSET_X:int = 174;

    private static const MAIN_V_ALIGN_THRESHOLD:int = 2;

    private static const NAVIGATE_FORTDESCRIPTION_KEY:String = "fortDescription";

    private static const NAVIGATE_CLANCREATE_KEY:String = "clanCreate";

    private static const NAVIGATE_CLANSEARCH_KEY:String = "clanSearch";

    public var createFortBtn:ISoundButtonEx = null;

    public var searchClanBtn:ISoundButtonEx = null;

    public var buildingAndUpgradeTitleTextField:TextField = null;

    public var buildingAndUpgradeBodyTextField:TextField = null;

    public var bonusesTitleTextField:TextField = null;

    public var bonusesBodyTextField:TextField = null;

    public var warForResourcesTitleTextField:TextField = null;

    public var warForResourcesBodyTextField:TextField = null;

    public var detail:HyperLink = null;

    public var warningText:TextField = null;

    public var requirementText:TextField = null;

    public var searchClanText:HyperLink = null;

    public var createClanText:HyperLink = null;

    public var createClanOrText:TextField = null;

    private var _miniClientCmp:LinkedMiniClientComponent = null;

    private var _isMiniClientCmpExists:Boolean = false;

    private var _rightAlignedControls:Vector.<DisplayObject> = null;

    private var _allAlignedControls:Vector.<DisplayObject> = null;

    private var _data:FortWelcomeViewVO = null;

    private var _disabledBtnTooltip:String = null;

    private var _utils:IUtils = null;

    private var _relativityHeight:uint = 0;

    private var _maxHeight:uint = 0;

    private var _clanSearchTooltip:String = "";

    public function FortWelcomeInfoView() {
        super();
        this._utils = App.utils;
        this.detail.visible = false;
        this.searchClanBtn.visible = false;
        this.createFortBtn.visible = false;
        this.searchClanText.visible = false;
        this.createClanText.visible = false;
        this.createClanOrText.visible = false;
        this.warningText.visible = false;
    }

    private static function onMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onDetailMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_WELCOME_DETAILS);
    }

    private static function onCreateClanTextMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_WELCOME_CLANCREATE);
    }

    override protected function configUI():void {
        super.configUI();
        this._rightAlignedControls = new <DisplayObject>[this.buildingAndUpgradeTitleTextField, this.buildingAndUpgradeBodyTextField, this.bonusesTitleTextField, this.bonusesBodyTextField, this.warForResourcesTitleTextField, this.warForResourcesBodyTextField];
        this.createFortBtn.addEventListener(ButtonEvent.CLICK, this.onCreateFortBtnClickHandler);
        this.detail.autoSize = TextFieldAutoSize.LEFT;
        this.searchClanText.autoSize = TextFieldAutoSize.LEFT;
        this.createLinks();
        this.initTexts();
        this.searchClanBtn.addEventListener(MouseEvent.MOUSE_OVER, this.onSearchClanMouseOverHandler);
        this.searchClanBtn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.searchClanBtn.addEventListener(MouseEvent.CLICK, this.onSearchClanBtnClickHandler);
    }

    override protected function setCommonData(param1:FortWelcomeViewVO):void {
        this._data = param1;
        invalidateData();
        invalidateSize();
        validateNow();
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        var _loc2_:Boolean = false;
        var _loc3_:Boolean = false;
        var _loc4_:Boolean = false;
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._data.canCreateFort();
            _loc2_ = this._data.canRoleCreateFortRest;
            _loc3_ = this._data.clanSearchAvailable;
            _loc4_ = !this._isMiniClientCmpExists && this._data.joinClanAvailable;
            this.createFortBtn.visible = _loc2_ && !this._isMiniClientCmpExists;
            this.createFortBtn.enabled = _loc1_;
            this.createFortBtn.tooltip = !!_loc1_ ? TOOLTIPS.FORTIFICATION_WELCOME_CREATEFORT : this._disabledBtnTooltip;
            this.detail.visible = true;
            this.requirementText.visible = this.createClanText.visible = _loc4_;
            this.createClanOrText.visible = this.searchClanBtn.visible = _loc4_ && _loc3_;
            this.searchClanText.visible = _loc4_ && !_loc3_;
            this.createClanText.autoSize = !!_loc1_ ? TextFieldAutoSize.RIGHT : TextFieldAutoSize.LEFT;
            this.createClanText.label = !!_loc3_ ? FORTIFICATIONS.FORTWELCOMEVIEW_CLANCREATE : FORTIFICATIONS.FORTWELCOMEVIEW_CLANCREATELABEL;
            this._clanSearchTooltip = !!_loc3_ ? TOOLTIPS.FORTIFICATION_WELCOME_CLANSEARCH : TOOLTIPS.FORTIFICATION_WELCOME_CLANSEARCHLABEL;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateControlPositions();
        }
    }

    override protected function onDispose():void {
        this._miniClientCmp = null;
        this._data = null;
        this.disposeLinks();
        this.createFortBtn.removeEventListener(ButtonEvent.CLICK, this.onCreateFortBtnClickHandler);
        this.createFortBtn.dispose();
        this.createFortBtn = null;
        this.buildingAndUpgradeTitleTextField = null;
        this.buildingAndUpgradeBodyTextField = null;
        this.bonusesTitleTextField = null;
        this.bonusesBodyTextField = null;
        this.warForResourcesTitleTextField = null;
        this.warForResourcesBodyTextField = null;
        this.detail.dispose();
        this.detail = null;
        this.warningText = null;
        this._rightAlignedControls.splice(0, this._rightAlignedControls.length);
        this._rightAlignedControls = null;
        this.clearAlignedControlsList();
        this.requirementText = null;
        this.searchClanBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.onSearchClanMouseOverHandler);
        this.searchClanBtn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.searchClanBtn.removeEventListener(MouseEvent.CLICK, this.onSearchClanBtnClickHandler);
        this.searchClanBtn.dispose();
        this.searchClanBtn = null;
        this.createClanText.dispose();
        this.createClanText = null;
        this.createClanOrText = null;
        this.searchClanText.dispose();
        this.searchClanText = null;
        this._utils = null;
        super.onDispose();
    }

    public function as_setRequirementText(param1:String):void {
        this._utils.asserter.assertNotNull(param1, "text" + Errors.CANT_NULL, NullPointerException);
        this.requirementText.htmlText = param1;
    }

    public function as_setWarningText(param1:String, param2:String):void {
        this._utils.asserter.assertNotNull(param1, "text" + Errors.CANT_NULL, NullPointerException);
        this.warningText.htmlText = param1;
        this.warningText.visible = StringUtils.isNotEmpty(param1);
        this._disabledBtnTooltip = param2;
        invalidateData();
        invalidateSize();
    }

    public function as_showMiniClientInfo(param1:String, param2:String):void {
        this._miniClientCmp = LinkedMiniClientComponent(this._utils.classFactory.getComponent(Linkages.LINKED_MINI_CLIENT_COMPONENT, LinkedMiniClientComponent));
        addChild(this._miniClientCmp);
        this._miniClientCmp.update(param1, param2);
        invalidateData();
        registerFlashComponentS(this._miniClientCmp, Aliases.MINI_CLIENT_LINKED);
        this._isMiniClientCmpExists = true;
    }

    public function getComponentForFocus():InteractiveObject {
        return InteractiveObject(this.createFortBtn);
    }

    public function setGapBetweenTextBlocks(param1:Number):void {
        this.buildingAndUpgradeBodyTextField.height = DESCRIPTION_TF_HEIGHT + param1;
        this.bonusesBodyTextField.height = DESCRIPTION_TF_HEIGHT + param1;
        invalidateSize();
    }

    private function clearAlignedControlsList():void {
        if (this._allAlignedControls != null) {
            this._allAlignedControls.splice(0, this._allAlignedControls.length);
            this._allAlignedControls = null;
        }
    }

    private function updateControlPositions():void {
        var _loc1_:DisplayObject = null;
        var _loc4_:* = 0;
        var _loc6_:Number = NaN;
        App.utils.asserter.assert(this._relativityHeight > 0, "relativityHeight" + Errors.CANT_NAN);
        this._maxHeight = 0;
        this.clearAlignedControlsList();
        this._allAlignedControls = new Vector.<DisplayObject>(0);
        var _loc2_:uint = 0;
        var _loc3_:uint = TEXT_V_ALIGN_START_POSITION_Y;
        for each(_loc1_ in this._rightAlignedControls) {
            if (_loc1_.visible) {
                _loc1_.x = _loc2_;
                this.setChildY(_loc1_, _loc3_);
                _loc3_ = _loc3_ + _loc1_.height;
            }
        }
        this.createFortBtn.x = _loc2_;
        this.setChildY(this.detail, this.warForResourcesBodyTextField.y + this.warForResourcesBodyTextField.height + DETAIL_OFFSET_Y);
        this.setChildY(this.requirementText, this.detail.y + this.detail.height + REQUIREMENT_TEXT_OFFSET_Y);
        _loc4_ = this.detail.y + this.detail.height + CREATE_BTN_OFFSET_Y >> 0;
        this.setChildY(InteractiveObject(this.createFortBtn), _loc4_);
        this.warningText.x = this.searchClanBtn.x;
        this.setChildY(this.warningText, this.createFortBtn.y + this.createFortBtn.height + WARNING_OFFSET_Y);
        if (this._data != null) {
            _loc6_ = 0;
            if (this._data.clanSearchAvailable) {
                this.setChildY(InteractiveObject(this.searchClanBtn), this.requirementText.y + this.requirementText.height + SEARCH_CLAN_BTN_OFFSET_Y);
                _loc6_ = this.searchClanBtn.y + this.searchClanBtn.height + CREATE_CLAN_TEXT_OFFSET_Y;
                this.setChildY(this.createClanText, _loc6_);
                this.setChildY(this.createClanOrText, _loc6_);
                this.createClanText.x = this.createClanOrText.x + this.createClanOrText.width;
            }
            else {
                this.searchClanText.x = this.warningText.x;
                this.createClanText.x = this.searchClanText.x + CREATE_CLAN_OFFSET_X;
                _loc6_ = this.requirementText.y + this.requirementText.height + SEARCH_CLAN_BTN_OFFSET_Y;
                this.setChildY(this.searchClanText, _loc6_);
                this.setChildY(this.createClanText, _loc6_);
            }
        }
        if (this._miniClientCmp) {
            this._miniClientCmp.x = _loc2_;
            this.setChildY(this._miniClientCmp, _loc4_);
        }
        var _loc5_:uint = (this._relativityHeight - this._maxHeight) / MAIN_V_ALIGN_THRESHOLD >> 0;
        for each(_loc1_ in this._allAlignedControls) {
            _loc1_.y = _loc1_.y + _loc5_;
        }
    }

    private function createLinks():void {
        this.detail.addEventListener(MouseEvent.MOUSE_OVER, onDetailMouseOverHandler);
        this.detail.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.detail.addEventListener(ButtonEvent.CLICK, this.onDetailClickHandler);
        this.createClanText.addEventListener(MouseEvent.MOUSE_OVER, onCreateClanTextMouseOverHandler);
        this.createClanText.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.createClanText.addEventListener(ButtonEvent.CLICK, this.onCreateClanTextClickHandler);
        this.searchClanText.addEventListener(MouseEvent.MOUSE_OVER, this.onSearchClanMouseOverHandler);
        this.searchClanText.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.searchClanText.addEventListener(ButtonEvent.CLICK, this.onSearchClanTextClickHandler);
    }

    private function disposeLinks():void {
        this.detail.removeEventListener(MouseEvent.MOUSE_OVER, onDetailMouseOverHandler);
        this.detail.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.detail.removeEventListener(ButtonEvent.CLICK, this.onDetailClickHandler);
        this.createClanText.removeEventListener(MouseEvent.MOUSE_OVER, onCreateClanTextMouseOverHandler);
        this.createClanText.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.createClanText.removeEventListener(ButtonEvent.CLICK, this.onCreateClanTextClickHandler);
        this.searchClanText.removeEventListener(MouseEvent.MOUSE_OVER, this.onSearchClanMouseOverHandler);
        this.searchClanText.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        this.searchClanText.removeEventListener(ButtonEvent.CLICK, this.onSearchClanTextClickHandler);
    }

    private function initTexts():void {
        this.searchClanBtn.label = FORTIFICATIONS.FORTWELCOMEVIEW_CLANSEARCH;
        this.createFortBtn.label = FORTIFICATIONS.FORTWELCOMEVIEW_CREATEFORTBTN;
        this.buildingAndUpgradeTitleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BUILDINGANDUPGRADING_TITLE;
        this.buildingAndUpgradeBodyTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BUILDINGANDUPGRADING_BODY;
        this.bonusesTitleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BONUSES_TITLE;
        this.bonusesBodyTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_BONUSES_BODY;
        this.warForResourcesTitleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_WARFORRESOURCES_TITLE;
        this.warForResourcesBodyTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_WARFORRESOURCES_BODY;
        this.createClanOrText.text = FORTIFICATIONS.FORTWELCOMEVIEW_CLANCREATE_OR;
        this.searchClanText.label = FORTIFICATIONS.FORTWELCOMEVIEW_CLANSEARCH;
        this.detail.label = FORTIFICATIONS.FORTWELCOMEVIEW_HYPERLINK_MORE;
        App.utils.commons.updateTextFieldSize(this.createClanOrText);
    }

    private function setChildY(param1:DisplayObject, param2:Number):void {
        if (param1.visible) {
            param1.y = param2;
            if (param1.y + param1.height > this._maxHeight) {
                this._maxHeight = param1.y + param1.height;
            }
            this._allAlignedControls.push(param1);
        }
    }

    public function set relativityHeight(param1:uint):void {
        if (this._relativityHeight != param1) {
            this._relativityHeight = param1;
            invalidate(InvalidationType.SIZE);
        }
    }

    private function onDetailClickHandler(param1:ButtonEvent):void {
        onNavigateS(NAVIGATE_FORTDESCRIPTION_KEY);
    }

    private function onCreateClanTextClickHandler(param1:ButtonEvent):void {
        onNavigateS(NAVIGATE_CLANCREATE_KEY);
    }

    private function onSearchClanTextClickHandler(param1:ButtonEvent):void {
        onNavigateS(NAVIGATE_CLANSEARCH_KEY);
    }

    private function onSearchClanMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._clanSearchTooltip);
    }

    private function onSearchClanBtnClickHandler(param1:MouseEvent):void {
        openClanResearchS();
    }

    private function onCreateFortBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new Event(FortConstants.ON_FORT_CREATE_EVENT, true));
        onCreateBtnClickS();
    }
}
}

package net.wg.gui.lobby.fortifications.intelligence.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.components.advanced.interfaces.ISearchInput;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.FortIntelFilterVO;
import net.wg.gui.lobby.fortifications.intelligence.FortIntelligenceWindowHelper;
import net.wg.gui.lobby.fortifications.intelligence.IFortIntelFilter;
import net.wg.infrastructure.base.meta.impl.FortIntelFilterMeta;
import net.wg.infrastructure.events.FocusRequestEvent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InputValue;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.FocusHandlerEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.MouseEventEx;

public class FortIntelFilter extends FortIntelFilterMeta implements IFortIntelFilter {

    private static const FILTER_ICON_PNG:String = "filter.png";

    private static const SEARCH_ICON_PNG:String = "search.png";

    private static const MAX_CLAN_ABBREVIATE_LEN_DEF:int = 7;

    private static const SEARCH_BRACKETS_TEXT_LENGTH:int = 2;

    private static const FORT_RESULT_TEXT_OFFSET_X:int = 7;

    private static const FORT_RESULT_TEXT_DEFAULT_X:int = 17;

    private static const FILTER_BUTTON_ICON_OFFSET_LEFT:int = 10;

    private static const FILTER_BUTTON_ICON_OFFSET_TOP:int = 1;

    public var clanTypeDropDn:DropdownMenu = null;

    public var filterResultTextField:TextField = null;

    public var filterButtonStatusTextField:TextField = null;

    public var filterButtonStatusTextFieldWithEffect:TextField = null;

    public var tagSearchButton:IconTextButton = null;

    public var filterButton:IconTextButton = null;

    public var tagSearchInput:ISearchInput = null;

    public var clearFilterBtn:ISoundButtonEx = null;

    private var _isSearchTextMaxCharsSetted:Boolean = false;

    private var _tagTooltip:String = "#tooltips:fortification/intelligenceWindow/tagSearchTextInput";

    public function FortIntelFilter() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
        this.filterButton.addEventListener(ButtonEvent.CLICK, this.onFilterButtonClickHandler);
        this.filterButton.tooltip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_FILTERBUTTON;
        this.filterButton.iconOffsetLeft = FILTER_BUTTON_ICON_OFFSET_LEFT;
        this.filterButton.iconOffsetTop = FILTER_BUTTON_ICON_OFFSET_TOP;
        this.filterButton.icon = FILTER_ICON_PNG;
        this.tagSearchButton.addEventListener(ButtonEvent.CLICK, this.onTagSearchButtonClickHandler);
        this.tagSearchButton.tooltip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_TAGSEARCHBUTTON;
        this.tagSearchButton.icon = SEARCH_ICON_PNG;
        this.clearFilterBtn.addEventListener(ButtonEvent.CLICK, this.onClearFilterBtnClickHandler);
        this.clearFilterBtn.tooltip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_CLEARFILTERBTN;
        this.clearFilterBtn.label = FORTIFICATIONS.FORTINTELLIGENCE_CLEARFILTERBTN_TITLE;
        this.clearFilterBtn.visible = false;
        this.updateClearButtonVisibility();
        this.clanTypeDropDn.addEventListener(ListEvent.INDEX_CHANGE, this.onClanTypeDropDnIndexChangeHandler);
        if (!this._isSearchTextMaxCharsSetted) {
            this.tagSearchInput.maxChars = MAX_CLAN_ABBREVIATE_LEN_DEF;
        }
        this.tagSearchInput.addEventListener(FocusHandlerEvent.FOCUS_IN, this.onTagSearchInputFocusInHandler);
        this.tagSearchInput.addEventListener(InputEvent.INPUT, this.onTagSearchInputInputHandler);
        this.tagSearchInput.addEventListener(MouseEvent.MOUSE_OVER, this.onTagSearchInputMouseOverHandler);
        this.tagSearchInput.addEventListener(MouseEvent.MOUSE_OUT, this.onTagSearchInputMouseOutHandler);
        this.tagSearchInput.isSearchIconVisible = false;
        this.tagSearchInput.defaultText = FORTIFICATIONS.FORTINTELLIGENCE_TAGSEARCHTEXTINPUT_DEFAULT;
    }

    override protected function setData(param1:FortIntelFilterVO):void {
        this.clanTypeDropDn.dataProvider = new DataProvider(param1.clanTypes);
        this.clanTypeDropDn.removeEventListener(ListEvent.INDEX_CHANGE, this.onClanTypeDropDnIndexChangeHandler);
        this.clanTypeDropDn.selectedIndex = param1.selectedFilterType;
        this.clanTypeDropDn.addEventListener(ListEvent.INDEX_CHANGE, this.onClanTypeDropDnIndexChangeHandler);
        this.updateControlsVisibility(param1.selectedFilterType);
        if (StringUtils.isNotEmpty(param1.tagTooltip)) {
            this._tagTooltip = param1.tagTooltip;
        }
    }

    override protected function onDispose():void {
        this.tagSearchInput.removeEventListener(FocusHandlerEvent.FOCUS_IN, this.onTagSearchInputFocusInHandler);
        this.tagSearchInput.removeEventListener(InputEvent.INPUT, this.onTagSearchInputInputHandler);
        this.tagSearchInput.removeEventListener(MouseEvent.MOUSE_OVER, this.onTagSearchInputMouseOverHandler);
        this.tagSearchInput.removeEventListener(MouseEvent.MOUSE_OUT, this.onTagSearchInputMouseOutHandler);
        this.tagSearchInput.dispose();
        this.tagSearchInput = null;
        this.tagSearchButton.removeEventListener(ButtonEvent.CLICK, this.onTagSearchButtonClickHandler);
        this.tagSearchButton.dispose();
        this.tagSearchButton = null;
        this.clearFilterBtn.removeEventListener(ButtonEvent.CLICK, this.onClearFilterBtnClickHandler);
        this.clearFilterBtn.dispose();
        this.clearFilterBtn = null;
        this.filterButton.removeEventListener(ButtonEvent.CLICK, this.onFilterButtonClickHandler);
        this.filterButton.dispose();
        this.filterButton = null;
        this.clanTypeDropDn.removeEventListener(ListEvent.INDEX_CHANGE, this.onClanTypeDropDnIndexChangeHandler);
        this.clanTypeDropDn.dispose();
        this.clanTypeDropDn = null;
        this.filterResultTextField = null;
        this.filterButtonStatusTextField = null;
        this._tagTooltip = null;
        this.filterButtonStatusTextFieldWithEffect = null;
        super.onDispose();
    }

    public function as_setClanAbbrev(param1:String):void {
        this.clearTagSearchInput();
        this.tagSearchInput.text = param1;
        this.updateClearButtonVisibility();
    }

    public function as_setFilterButtonStatus(param1:String, param2:Boolean):void {
        App.utils.asserter.assertNotNull(param1, "filterButtonStatus" + Errors.CANT_NULL);
        this.filterButtonStatusTextFieldWithEffect.visible = param2;
        this.filterButtonStatusTextField.visible = !param2;
        this.filterButtonStatusTextField.htmlText = this.filterButtonStatusTextFieldWithEffect.htmlText = param1;
    }

    public function as_setFilterStatus(param1:String):void {
        App.utils.asserter.assertNotNull(param1, "filterButtonStatus" + Errors.CANT_NULL);
        this.filterResultTextField.htmlText = param1;
    }

    public function as_setMaxClanAbbreviateLength(param1:uint):void {
        this.tagSearchInput.maxChars = param1 + SEARCH_BRACKETS_TEXT_LENGTH;
        this._isSearchTextMaxCharsSetted = true;
    }

    public function as_setSearchResult(param1:String):void {
        this.tagSearchInput.highlight = param1 != null && this.tagSearchInput.text;
    }

    public function as_setupCooldown(param1:Boolean):void {
        this.filterButton.enabled = this.clearFilterBtn.enabled = this.tagSearchButton.enabled = !param1;
        this.clanTypeDropDn.enabled = this.tagSearchInput.enabled = !param1;
        if (param1) {
            this.tagSearchInput.removeEventListener(InputEvent.INPUT, this.onTagSearchInputInputHandler);
        }
        else {
            this.tagSearchInput.addEventListener(InputEvent.INPUT, this.onTagSearchInputInputHandler);
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this.clanTypeDropDn;
    }

    public function getHitArea():DisplayObject {
        return this.filterButton;
    }

    public function getTargetButton():DisplayObject {
        return this.filterButton;
    }

    private function getClanTagWithoutBrackets():String {
        var _loc1_:String = this.tagSearchInput.text;
        if (_loc1_.charAt(0) == "[") {
            _loc1_ = _loc1_.substr(1);
        }
        if (_loc1_.length > 1 && _loc1_.charAt(_loc1_.length - 1) == "]") {
            _loc1_ = _loc1_.substr(0, _loc1_.length - 1);
        }
        return App.utils.toUpperOrLowerCase(_loc1_, true);
    }

    private function updateClearButtonVisibility():void {
        this.clearFilterBtn.visible = this.clanTypeDropDn.selectedIndex == 0 && !this.tagSearchInput.isPromptShow;
        if (this.clearFilterBtn.visible) {
            this.filterResultTextField.x = this.clearFilterBtn.x + this.clearFilterBtn.width + FORT_RESULT_TEXT_OFFSET_X;
        }
        else {
            this.filterResultTextField.x = FORT_RESULT_TEXT_DEFAULT_X;
        }
    }

    private function applyFilter():void {
        var _loc1_:String = "selected index in clanTypeDropDn can not be equals -1";
        App.utils.asserter.assert(this.clanTypeDropDn.selectedIndex != -1, _loc1_);
        onTryToSearchByClanAbbrS(this.getClanTagWithoutBrackets(), this.clanTypeDropDn.selectedIndex);
        this.updateClearButtonVisibility();
    }

    private function tryToApplyFilter():void {
        if (!this.tagSearchInput.isPromptShow) {
            this.applyFilter();
        }
    }

    private function clearTagSearchInput():void {
        this.tagSearchInput.highlight = false;
        this.tagSearchInput.text = "";
        this.tagSearchInput.validateNow();
    }

    private function updateControlsVisibility(param1:int):void {
        var _loc2_:* = param1 == FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_ALL;
        this.tagSearchInput.visible = this.filterButton.visible = this.tagSearchButton.visible = _loc2_;
        this.filterButtonStatusTextFieldWithEffect.alpha = this.filterButtonStatusTextField.alpha = !!_loc2_ ? Number(1) : Number(0);
    }

    private function onTagSearchInputMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onTagSearchInputMouseOverHandler(param1:MouseEvent):void {
        FortIntelligenceWindowHelper.getInstance().assertHandlerTarget(this._tagTooltip != null, param1.currentTarget);
        App.toolTipMgr.showComplex(this._tagTooltip);
    }

    private function onTagSearchInputFocusInHandler(param1:FocusHandlerEvent):void {
        if (this.tagSearchInput.isPromptShow) {
            this.clearTagSearchInput();
        }
    }

    private function onTagSearchInputInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.ENTER && param1.details.value == InputValue.KEY_DOWN) {
            this.tryToApplyFilter();
            param1.handled = true;
        }
    }

    private function onTagSearchButtonClickHandler(param1:ButtonEvent):void {
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            this.tryToApplyFilter();
        }
    }

    private function onClearFilterBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:String = null;
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            this.clearTagSearchInput();
            this.updateClearButtonVisibility();
            if (this.clanTypeDropDn.selectedIndex != FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_ALL) {
                _loc2_ = "clearFilterBtn need to ListEvent.INDEX_CHANGE handling!";
                App.utils.asserter.assert(this.clanTypeDropDn.hasEventListener(ListEvent.INDEX_CHANGE), _loc2_);
                this.clanTypeDropDn.selectedIndex = FORTIFICATION_ALIASES.CLAN_TYPE_FILTER_STATE_ALL;
            }
            else {
                this.applyFilter();
            }
        }
    }

    private function onFilterButtonClickHandler(param1:ButtonEvent):void {
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            App.popoverMgr.show(this, FORTIFICATION_ALIASES.FORT_INTELLIGENCE_CLAN_FILTER_POPOVER_ALIAS);
        }
    }

    private function onClanTypeDropDnIndexChangeHandler(param1:ListEvent):void {
        this.updateControlsVisibility(param1.index);
        this.applyFilter();
    }
}
}

package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.popovers.PopOver;
import net.wg.gui.lobby.fortifications.data.FortInvalidationType;
import net.wg.gui.lobby.fortifications.data.settings.DayOffPopoverVO;
import net.wg.infrastructure.base.meta.IFortSettingsDayoffPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortSettingsDayoffPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;

public class FortSettingsDayoffPopover extends FortSettingsDayoffPopoverMeta implements IFortSettingsDayoffPopoverMeta {

    private static const DEFAULT_CONTENT_WIDTH:int = 300;

    private static const PADDING_BEFORE_SEPARATOR:int = -15;

    private static const PADDING_BEFORE_DROPDOWN:int = 22;

    private static const DEFAULT_PADDING:int = 18;

    private static const POPOVER_REDESIGN_PADDING:int = 9;

    private static const DROPDOWN_AND_DESCRIPTION_DIFF_Y:int = -3;

    private static const DROPDOWN_AND_DESCRIPTION_MARGIN:int = 2;

    private static const BUTTON_CENTER_MARGIN:int = 2;

    private static const TEXT_SIZE_EXTRA:int = 5;

    private static const BOTTOM_PADDING:int = 10;

    private static const BOTTOM_SEPARATOR_PADDING:int = 17;

    public var descriptionTF:TextField = null;

    public var dayOffTF:TextField = null;

    public var dropdownMenu:DropdownMenu = null;

    public var separator:Sprite = null;

    public var separatorBottom:Sprite = null;

    public var applyBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    private var _disabledApplyButtonTooltip:String = "";

    private var _enabledApplyButtonTooltip:String = "";

    private var _data:DayOffPopoverVO;

    public function FortSettingsDayoffPopover() {
        super();
    }

    private static function onCancelBtnClick(param1:ButtonEvent):void {
        App.popoverMgr.hide();
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    override protected function configUI():void {
        this.applyBtn.mouseEnabledOnDisabled = true;
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyBtnClick);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, onCancelBtnClick);
        super.configUI();
    }

    override protected function onPopulate():void {
        this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE, this.onListIndexChange);
        super.onPopulate();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.dropdownMenu);
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SIZE)) {
            this.descriptionTF.height = this.descriptionTF.textHeight + TEXT_SIZE_EXTRA;
            this.separator.y = this.descriptionTF.y + this.descriptionTF.height + PADDING_BEFORE_SEPARATOR;
            this.dayOffTF.y = this.separator.y + this.separator.height + PADDING_BEFORE_DROPDOWN;
            this.dropdownMenu.y = this.dayOffTF.y + DROPDOWN_AND_DESCRIPTION_DIFF_Y;
            this.dayOffTF.width = this.dayOffTF.textWidth + TEXT_SIZE_EXTRA;
            this.dropdownMenu.x = this.dayOffTF.x + this.dayOffTF.width + DROPDOWN_AND_DESCRIPTION_MARGIN;
            this.applyBtn.y = this.cancelBtn.y = this.dropdownMenu.y + this.dropdownMenu.height + DEFAULT_PADDING + POPOVER_REDESIGN_PADDING;
            this.separatorBottom.y = this.applyBtn.y + BOTTOM_SEPARATOR_PADDING;
            setSize(DEFAULT_CONTENT_WIDTH > this.actualWidth ? Number(DEFAULT_CONTENT_WIDTH) : Number(this.actualWidth + DEFAULT_PADDING), this.applyBtn.y + this.applyBtn.height + BOTTOM_PADDING);
            this.applyBtn.x = (this.width >> 1) - this.applyBtn.width - BUTTON_CENTER_MARGIN;
            this.cancelBtn.x = (this.width >> 1) + BUTTON_CENTER_MARGIN;
            this.separator.width = this.width;
            this.separatorBottom.width = this.width;
        }
        if (isInvalid(FortInvalidationType.INVALID_ENABLING)) {
            this.applyBtn.enabled = this.getSelectedDayId() != this._data.currentDayOff;
            this.applyBtn.tooltip = !!this.applyBtn.enabled ? this._enabledApplyButtonTooltip : this._disabledApplyButtonTooltip;
        }
        super.draw();
    }

    override protected function onDispose():void {
        this.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE, this.onListIndexChange);
        this.dropdownMenu.dispose();
        this.dropdownMenu = null;
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyBtnClick);
        this.applyBtn.dispose();
        this.applyBtn = null;
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, onCancelBtnClick);
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.descriptionTF = null;
        this.dayOffTF = null;
        this.separator = null;
        this.separatorBottom = null;
        this._data = null;
        super.onDispose();
    }

    override protected function setData(param1:DayOffPopoverVO):void {
        var _loc3_:Object = null;
        var _loc4_:* = null;
        this._data = param1;
        this.dropdownMenu.dataProvider = new DataProvider(param1.daysList);
        var _loc2_:int = 0;
        for each(_loc3_ in param1.daysList) {
            if (_loc3_.id == param1.currentDayOff) {
                break;
            }
            _loc2_++;
        }
        _loc4_ = "No such elemnt with id = " + param1.currentDayOff + " in dropDown.dataProvider";
        App.utils.asserter.assert(_loc2_ < param1.daysList.length, _loc4_);
        this.dropdownMenu.selectedIndex = _loc2_;
        invalidate(InvalidationType.DATA);
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    public function as_setDescriptionsText(param1:String, param2:String):void {
        this.descriptionTF.htmlText = param1;
        this.dayOffTF.htmlText = param2;
        invalidate(InvalidationType.SIZE);
    }

    public function as_setButtonsText(param1:String, param2:String):void {
        this.applyBtn.label = param1;
        this.cancelBtn.label = param2;
    }

    public function as_setButtonsTooltips(param1:String, param2:String):void {
        this._enabledApplyButtonTooltip = param1;
        this._disabledApplyButtonTooltip = param2;
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    private function getSelectedDayId():int {
        if (this.dropdownMenu.selectedIndex >= 0) {
            return this.dropdownMenu.dataProvider.requestItemAt(this.dropdownMenu.selectedIndex).id;
        }
        return -1;
    }

    private function onApplyBtnClick(param1:ButtonEvent):void {
        var _loc2_:IDataProvider = null;
        var _loc3_:int = 0;
        if (this.dropdownMenu.selectedIndex >= 0) {
            _loc2_ = this.dropdownMenu.dataProvider;
            _loc3_ = _loc2_[this.dropdownMenu.selectedIndex].id;
        }
        onApplyS(_loc3_);
        App.popoverMgr.hide();
    }

    private function onListIndexChange(param1:ListEvent):void {
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }
}
}

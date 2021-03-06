package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Time;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.events.DropdownMenuEvent;
import net.wg.gui.components.popovers.PopOver;
import net.wg.gui.components.popovers.PopOverConst;
import net.wg.gui.lobby.fortifications.data.settings.VacationPopoverVO;
import net.wg.infrastructure.base.meta.IFortSettingsVacationPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortSettingsVacationPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ScrollingList;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.TextFieldEx;

public class FortSettingsVacationPopover extends FortSettingsVacationPopoverMeta implements IFortSettingsVacationPopoverMeta {

    private static const DEFAULT_CONTENT_WIDTH:uint = 300;

    private static const DATE_MINIMUM:int = 1;

    private static const DURATION_MINIMUM:uint = 3;

    private static const DURATION_MAXIMUM:uint = 14;

    private static const DEFAULT_PADDING:int = 10;

    public var descriptionTF:TextField = null;

    public var vacationStartTF:TextField = null;

    public var vacationDurationTF:TextField = null;

    public var ofDaysTF:TextField = null;

    public var vacationResultTF:TextField = null;

    public var dateStepper:NumericStepper = null;

    public var durationStepper:NumericStepper = null;

    public var applyBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var separatorTop:MovieClip = null;

    public var separatorBottom:MovieClip = null;

    public var monthDropdown:DropdownMenu = null;

    private var isAmericanStyle:Boolean = false;

    private var startVacationDate:Date = null;

    private var showMonth:int = 12;

    private var endVacationDate:Date = null;

    private var monthOffset:uint = 0;

    private var startDay:Date = null;

    private var scrollBar:ScrollBar = null;

    public function FortSettingsVacationPopover() {
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
        super.configUI();
        TextFieldEx.setVerticalAlign(this.vacationResultTF, TextFieldEx.VALIGN_CENTER);
        this.dateStepper.minimum = DATE_MINIMUM;
        this.dateStepper.maximum = Time.MAX_MONTH_DAYS_COUNT;
        this.durationStepper.minimum = DURATION_MINIMUM;
        this.durationStepper.maximum = DURATION_MAXIMUM;
        this.durationStepper.emptyFieldPattern = "--";
        this.durationStepper.value = NumericStepper.NAN_VALUE;
        this.monthDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.monthDropdownMenuSelectHandler);
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyBtnClick);
        this.applyBtn.mouseEnabledOnDisabled = true;
        this.applyBtn.tooltip = TOOLTIPS.FORTIFICATION_FORTSETTINGSVACATIONPOPOVER_APPLYBTN;
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, onCancelBtnClick);
        this.dateStepper.addEventListener(IndexEvent.INDEX_CHANGE, this.dateStepperChangeHandler);
        this.durationStepper.addEventListener(IndexEvent.INDEX_CHANGE, this.durationStepperChangeHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
    }

    override protected function onDispose():void {
        this.monthDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.monthDropdownMenuSelectHandler);
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyBtnClick);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, onCancelBtnClick);
        this.dateStepper.removeEventListener(IndexEvent.INDEX_CHANGE, this.dateStepperChangeHandler);
        this.durationStepper.removeEventListener(IndexEvent.INDEX_CHANGE, this.durationStepperChangeHandler);
        this.descriptionTF = null;
        this.vacationStartTF = null;
        this.vacationDurationTF = null;
        this.ofDaysTF = null;
        this.vacationResultTF = null;
        this.applyBtn.dispose();
        this.applyBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.separatorTop = null;
        this.separatorBottom = null;
        this.dateStepper.dispose();
        this.dateStepper = null;
        this.durationStepper.dispose();
        this.durationStepper = null;
        this.monthDropdown.dispose();
        this.monthDropdown = null;
        this.startDay = null;
        if (this.scrollBar) {
            this.scrollBar.dispose();
            this.scrollBar = null;
        }
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            setSize(DEFAULT_CONTENT_WIDTH > this.width ? Number(DEFAULT_CONTENT_WIDTH) : Number(this.width), this.applyBtn.y + this.applyBtn.height + DEFAULT_PADDING);
            this.separatorTop.width = this.width;
            this.separatorBottom.width = this.width;
        }
        if (isInvalid(InvalidationType.DATA)) {
            this.startDay = App.utils.dateTime.shiftDate(this.startVacationDate, -2 * Time.WEEK);
            this.startDay.setHours(0, 0, 0, 0);
            this.createStartDate();
            this.changeVacationResultText();
            _loc1_ = this.dateStepper.x < this.monthDropdown.x ? Number(this.dateStepper.x) : Number(this.monthDropdown.x);
            _loc2_ = this.dateStepper.x < this.monthDropdown.x ? Number(this.monthDropdown.x - this.dateStepper.x - this.dateStepper.width) : Number(this.dateStepper.x - this.monthDropdown.x - this.monthDropdown.width);
            if (this.isAmericanStyle) {
                this.monthDropdown.x = _loc1_;
                this.dateStepper.x = this.monthDropdown.x + this.monthDropdown.width + _loc2_;
            }
            else {
                this.dateStepper.x = _loc1_;
                this.monthDropdown.x = this.dateStepper.x + this.dateStepper.width + _loc2_;
            }
        }
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_LEFT;
        super.initLayout();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.dateStepper);
    }

    override protected function setTexts(param1:VacationPopoverVO):void {
        this.descriptionTF.htmlText = param1.descriptionText;
        this.vacationStartTF.htmlText = param1.vacationStartText;
        this.vacationDurationTF.htmlText = param1.vacationDurationText;
        this.ofDaysTF.htmlText = param1.ofDaysText;
        this.applyBtn.label = param1.applyBtnLabel;
        this.cancelBtn.label = param1.cancelBtnLabel;
    }

    override protected function setData(param1:VacationPopoverVO):void {
        this.startVacationDate = App.utils.dateTime.fromPyTimestamp(param1.startVacation);
        this.endVacationDate = App.utils.dateTime.fromPyTimestamp(param1.startVacation + param1.vacationDuration * Time.DAY);
        this.isAmericanStyle = param1.isAmericanStyle;
        this.durationStepper.value = param1.vacationDuration;
        this.showMonth = param1.showMonth;
        invalidateData();
    }

    override protected function onShowDropdownHandler(param1:DropdownMenuEvent):void {
        var _loc2_:ScrollingList = param1.dropDownRef as ScrollingList;
        App.utils.asserter.assertNotNull(_loc2_, "dropDownRef" + Errors.CANT_NULL);
        var _loc3_:Point = localToGlobal(new Point(this.monthDropdown.x, this.monthDropdown.y + this.monthDropdown.height));
        var _loc4_:uint = Math.floor((App.appHeight - _loc3_.y) / _loc2_.rowHeight);
        if (this.monthDropdown.rowCount != _loc4_ && this.monthDropdown.dataProvider) {
            this.monthDropdown.rowCount = _loc4_ > this.monthDropdown.dataProvider.length ? int(this.monthDropdown.dataProvider.length) : int(_loc4_);
            this.monthDropdown.invalidate();
        }
        super.onShowDropdownHandler(param1);
    }

    private function createStartDate():void {
        var _loc1_:Array = [];
        this.monthOffset = this.startVacationDate.month;
        var _loc2_:int = 0;
        while (_loc2_ < this.showMonth) {
            _loc1_[_loc2_] = App.utils.dateTime.getMonthName(this.getRealMonthIndex(_loc2_), false);
            _loc2_++;
        }
        this.monthDropdown.dataProvider = new DataProvider(_loc1_);
        this.monthDropdown.selectedIndex = 0;
        this.dateStepper.value = this.startVacationDate.date;
        this.correctStartDate();
    }

    private function changeVacationResultText():void {
        this.endVacationDate = App.utils.dateTime.shiftDate(this.startVacationDate, this.durationStepper.value * Time.DAY);
        var _loc1_:String = App.utils.locale.longDate(App.utils.dateTime.toPyTimestamp(this.startVacationDate));
        var _loc2_:String = App.utils.locale.longDate(App.utils.dateTime.toPyTimestamp(this.endVacationDate));
        this.vacationResultTF.htmlText = App.utils.locale.makeString(FORTIFICATIONS.SETTINGSVACATIONPOPOVER_VACATIONRESULT, {
            "startDate": _loc1_,
            "endDate": _loc2_
        });
        var _loc3_:* = this.durationStepper.value != NumericStepper.NAN_VALUE;
        this.vacationResultTF.visible = _loc3_;
        this.applyBtn.enabled = _loc3_;
        this.applyBtn.tooltip = !!_loc3_ ? TOOLTIPS.FORTIFICATION_FORTSETTINGSVACATIONPOPOVER_APPLYBTN : TOOLTIPS.FORTIFICATION_FORTSETTINGSVACATIONPOPOVER_APPLYBTN_DISABLE;
    }

    private function correctStartDate():void {
        this.startVacationDate.fullYear = App.utils.dateTime.now().fullYear;
        this.setNewDateValues();
        if (this.startVacationDate < App.utils.dateTime.shiftDate(this.startDay, 2 * Time.WEEK)) {
            this.startVacationDate.fullYear++;
            this.setNewDateValues();
        }
    }

    private function setNewDateValues():void {
        this.startVacationDate.date = 1;
        this.startVacationDate.month = this.getRealMonthIndex(this.monthDropdown.selectedIndex);
        if (App.utils.dateTime.isSameMonth(App.utils.dateTime.shiftDate(this.startDay, 2 * Time.WEEK), this.startVacationDate)) {
            this.dateStepper.minimum = App.utils.dateTime.shiftDate(this.startDay, 2 * Time.WEEK).date;
        }
        else {
            this.dateStepper.minimum = DATE_MINIMUM;
        }
        this.dateStepper.maximum = App.utils.dateTime.getMonthDaysCount(this.startVacationDate);
        this.startVacationDate.date = this.dateStepper.value;
    }

    private function getRealMonthIndex(param1:uint):uint {
        return param1 + this.monthOffset < Time.MONTHS_IN_YEAR ? uint(param1 + this.monthOffset) : uint(param1 + this.monthOffset - Time.MONTHS_IN_YEAR);
    }

    private function monthDropdownMenuSelectHandler(param1:ListEvent):void {
        this.correctStartDate();
        this.changeVacationResultText();
    }

    private function dateStepperChangeHandler(param1:IndexEvent):void {
        this.correctStartDate();
        this.changeVacationResultText();
    }

    private function durationStepperChangeHandler(param1:IndexEvent):void {
        this.changeVacationResultText();
    }

    private function onApplyBtnClick(param1:ButtonEvent):void {
        var _loc2_:VacationPopoverVO = new VacationPopoverVO({
            "startVacation": App.utils.dateTime.toPyTimestamp(this.startVacationDate),
            "vacationDuration": this.durationStepper.value
        });
        onApplyS(_loc2_);
        App.popoverMgr.hide();
    }
}
}

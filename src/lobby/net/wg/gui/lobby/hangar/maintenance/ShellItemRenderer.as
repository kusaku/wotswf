package net.wg.gui.lobby.hangar.maintenance {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.events.ShellRendererEvent;
import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceShellVO;
import net.wg.utils.IEventCollector;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.events.SliderEvent;
import scaleform.gfx.MouseEventEx;

public class ShellItemRenderer extends SoundListItemRenderer {

    private static const RENDERER_HEIGHT:Number = 45;

    private static const MULTY_CHARS:String = " x ";

    private static const TO_BUY_POS:int = 775;

    private static const DEFAULT_ALPHA:Number = 0.3;

    private static const CHANGED_LABEL_ALPHA:Number = 1;

    private static const BUY_LEFT_PADDING:int = 10;

    public var initCounterBgWidth:int = 0;

    public var select:MaintenanceDropDown;

    public var countLabel:TextField;

    public var toBuy:IconText;

    public var price:IconText;

    public var toBuyTf:TextField;

    public var toBuyDropdown:DropdownMenu;

    public var countSliderBg:MovieClip;

    public var countSlider:Slider;

    public var countStepper:NumericStepper;

    public var nameLbl:TextField;

    public var descrLbl:TextField;

    public var icon:UILoaderAlt;

    public var emptyFocusIndicator:MovieClip;

    public var actionPrice:ActionPrice;

    public function ShellItemRenderer() {
        super();
        this.select.handleScroll = false;
        soundType = "shellItemRenderer";
        this.initCounterBgWidth = this.countSliderBg.width;
        this.select.focusIndicator = this.emptyFocusIndicator;
        this.nameLbl.autoSize = TextFieldAutoSize.LEFT;
    }

    override public function setData(param1:Object):void {
        var _loc2_:IEventCollector = App.utils.events;
        if (this.shell) {
            _loc2_.removeEvent(this.shell, ShellRendererEvent.USER_COUNT_CHANGED, this.onUserCountChange, false);
        }
        super.setData(param1);
        if (this.shell) {
            _loc2_.addEvent(this.shell, ShellRendererEvent.USER_COUNT_CHANGED, this.onUserCountChange, false, 0, true);
        }
        invalidate(InvalidationType.DATA);
    }

    override protected function onDispose():void {
        var _loc1_:IEventCollector = App.utils.events;
        _loc1_.removeEvent(this.countSlider, SliderEvent.VALUE_CHANGE, this.onSliderValueChange);
        _loc1_.removeEvent(this.countSlider, MouseEvent.ROLL_OVER, this.onRollOutHandler);
        _loc1_.removeEvent(this.countStepper, IndexEvent.INDEX_CHANGE, this.onStepperValueChange);
        _loc1_.removeEvent(this.toBuyDropdown, ListEvent.INDEX_CHANGE, this.onShellCurrencyChanged);
        _loc1_.removeEvent(this.select, ListEvent.INDEX_CHANGE, this.onShellOrderChange);
        _loc1_.removeEvent(this, MouseEvent.ROLL_OVER, this.onRollOverHandler);
        _loc1_.removeEvent(this, MouseEvent.ROLL_OUT, this.onRollOutHandler);
        _loc1_.removeEvent(this, MouseEvent.CLICK, this.onClickHandler);
        this.select.dispose();
        this.select = null;
        this.countLabel = null;
        this.toBuy.dispose();
        this.toBuy = null;
        this.price.dispose();
        this.price = null;
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.toBuyTf = null;
        this.toBuyDropdown.dispose();
        this.toBuyDropdown = null;
        this.countSliderBg = null;
        this.countSlider.dispose();
        this.countSlider = null;
        this.countStepper.dispose();
        this.countStepper = null;
        this.nameLbl = null;
        this.descrLbl = null;
        this.icon.dispose();
        this.icon = null;
        this.emptyFocusIndicator = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        focusTarget = this.select;
        _focusable = tabEnabled = tabChildren = mouseChildren = true;
        this.countSliderBg.mouseEnabled = this.countSliderBg.mouseChildren = false;
        this.icon.mouseEnabled = this.icon.mouseChildren = false;
        this.nameLbl.mouseEnabled = false;
        this.descrLbl.mouseEnabled = false;
        this.countLabel.mouseEnabled = false;
        this.toBuy.mouseEnabled = this.toBuy.mouseChildren = false;
        this.toBuyTf.mouseEnabled = false;
        this.price.mouseEnabled = this.price.mouseChildren = false;
        var _loc1_:IEventCollector = App.utils.events;
        _loc1_.addEvent(this.countSlider, SliderEvent.VALUE_CHANGE, this.onSliderValueChange);
        _loc1_.addEvent(this.countSlider, MouseEvent.ROLL_OVER, this.onRollOutHandler);
        _loc1_.addEvent(this.countStepper, IndexEvent.INDEX_CHANGE, this.onStepperValueChange);
        _loc1_.addEvent(this.toBuyDropdown, ListEvent.INDEX_CHANGE, this.onShellCurrencyChanged);
        _loc1_.addEvent(this.select, ListEvent.INDEX_CHANGE, this.onShellOrderChange);
        _loc1_.addEvent(this, MouseEvent.ROLL_OVER, this.onRollOverHandler);
        _loc1_.addEvent(this, MouseEvent.ROLL_OUT, this.onRollOutHandler);
        _loc1_.addEvent(this, MouseEvent.CLICK, this.onClickHandler);
    }

    override protected function draw():void {
        var _loc1_:ILocale = null;
        var _loc2_:ActionPriceVO = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            mouseChildren = true;
            this.icon.mouseEnabled = false;
            this.nameLbl.mouseEnabled = false;
            this.descrLbl.mouseEnabled = false;
            focusable = true;
            if (this.shell) {
                this.icon.source = this.shell.icon;
                if (this.actionPrice) {
                    this.actionPrice.visible = false;
                }
                if (this.shell.prices[1] > 0 && this.shell.prices[0] > 0 && this.shell.goldShellsForCredits) {
                    this.toBuyDropdown.visible = this.shell.goldShellsForCredits;
                    this.toBuyTf.visible = this.shell.goldShellsForCredits;
                    this.toBuy.visible = !this.shell.goldShellsForCredits;
                    _loc1_ = App.utils.locale;
                    this.toBuyDropdown.dataProvider = new DataProvider([_loc1_.htmlTextWithIcon(_loc1_.integer(this.shell.prices[0]), Currencies.CREDITS), _loc1_.htmlTextWithIcon(_loc1_.gold(this.shell.prices[1]), Currencies.GOLD)]);
                    this.toBuyDropdown.selectedIndex = this.shell.currency == Currencies.CREDITS ? 0 : 1;
                    this.price.icon = this.shell.currency;
                    _loc2_ = null;
                    if (this.shell.actionPriceData) {
                        _loc2_ = new ActionPriceVO(this.shell.actionPriceData);
                        _loc2_.forCredits = this.shell.currency == Currencies.CREDITS;
                    }
                    this.actionPrice.setData(_loc2_);
                    this.actionPrice.setup(this);
                    this.price.visible = !this.actionPrice.visible;
                }
                else {
                    this.toBuyDropdown.visible = false;
                    this.toBuyTf.visible = false;
                    this.toBuy.visible = true;
                }
                this.nameLbl.text = this.shell.ammoName;
                this.descrLbl.text = this.shell.tableName;
                this.onUserCountChange();
                this.select.menuRowCount = data.list.length;
                this.select.dataProvider = new DataProvider(data.list);
                this.select.menuOffset.top = -RENDERER_HEIGHT - ((data.list.length - 1) * RENDERER_HEIGHT >> 1);
                this.select.selectedIndex = -1;
                visible = true;
                if (this.select.isOpen()) {
                    this.select.close();
                    this.select.open();
                }
                if (this.select.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
                    this.onRollOverHandler();
                }
            }
            else {
                visible = false;
            }
        }
    }

    private function updateShellsPrice():void {
        var _loc1_:int = this.shell.buyShellsCount;
        var _loc2_:int = 0;
        var _loc3_:String = "";
        var _loc4_:ILocale = App.utils.locale;
        if (this.toBuyDropdown.visible) {
            _loc2_ = this.shell.prices[this.toBuyDropdown.selectedIndex];
        }
        else {
            _loc2_ = this.shell.prices[this.shell.currency == Currencies.CREDITS ? 0 : 1];
            _loc3_ = this.shell.currency == Currencies.CREDITS ? _loc4_.integer(_loc2_) : _loc4_.gold(_loc2_);
        }
        var _loc5_:Number = _loc2_ * _loc1_;
        this.toBuy.icon = this.shell.currency;
        this.price.icon = this.shell.currency;
        this.toBuy.textColor = Currencies.TEXT_COLORS[this.shell.currency];
        this.price.textColor = Currencies.TEXT_COLORS[_loc5_ > this.shell.userCredits[this.shell.currency] ? Currencies.ERROR : this.shell.currency];
        this.toBuyTf.text = _loc1_ + MULTY_CHARS;
        this.toBuy.text = _loc1_ + MULTY_CHARS + _loc3_;
        this.price.text = this.shell.currency == Currencies.CREDITS ? _loc4_.integer(_loc5_) : _loc4_.gold(_loc5_);
        var _loc6_:ActionPriceVO = null;
        if (this.shell.actionPriceData) {
            _loc6_ = new ActionPriceVO(this.shell.actionPriceData);
            _loc6_.forCredits = this.shell.currency == Currencies.CREDITS;
            if (_loc6_.forCredits) {
                _loc6_.newPrice = _loc1_ * _loc6_.newPrices[0];
                _loc6_.oldPrice = _loc1_ * _loc6_.oldPrices[0];
            }
            else {
                _loc6_.newPrice = _loc1_ * _loc6_.newPrices[1];
                _loc6_.oldPrice = _loc1_ * _loc6_.oldPrices[1];
            }
            this.actionPrice.textColorType = _loc5_ > this.shell.userCredits[this.shell.currency] ? ActionPrice.TEXT_COLOR_TYPE_ERROR : ActionPrice.TEXT_COLOR_TYPE_ICON;
        }
        this.actionPrice.setData(_loc6_);
        this.price.visible = !this.actionPrice.visible;
        this.toBuy.enabled = this.price.enabled = _loc1_ != 0;
        this.toBuy.mouseEnabled = this.price.mouseEnabled = false;
        this.toBuyTf.alpha = _loc1_ == 0 ? Number(DEFAULT_ALPHA) : Number(CHANGED_LABEL_ALPHA);
        this.toBuy.validateNow();
        this.toBuy.x = TO_BUY_POS - this.toBuy.width + (this.toBuy.textField.textWidth >> 1) + BUY_LEFT_PADDING ^ 0;
        dispatchEvent(new ShellRendererEvent(ShellRendererEvent.TOTAL_PRICE_CHANGED));
    }

    private function get shell():MaintenanceShellVO {
        return data as MaintenanceShellVO;
    }

    private function onSliderValueChange(param1:SliderEvent):void {
        App.toolTipMgr.hide();
        if (this.countStepper.value != this.countSlider.value) {
            this.shell.userCount = this.countStepper.value = this.countSlider.value;
        }
    }

    private function onStepperValueChange(param1:IndexEvent):void {
        if (this.countStepper.value != this.countSlider.value) {
            this.shell.userCount = this.countSlider.value = this.countStepper.value;
        }
    }

    private function onShellCurrencyChanged(param1:ListEvent):void {
        this.price.icon = this.toBuyDropdown.selectedIndex == 0 ? Currencies.CREDITS : Currencies.GOLD;
        this.actionPrice.ico = this.toBuyDropdown.selectedIndex == 0 ? IconsTypes.CREDITS : IconsTypes.GOLD;
        var _loc2_:String = this.toBuyDropdown.selectedIndex == 0 ? Currencies.CREDITS : Currencies.GOLD;
        if (this.shell.currency != _loc2_) {
            dispatchEvent(new ShellRendererEvent(ShellRendererEvent.CURRENCY_CHANGED));
        }
        this.shell.currency = _loc2_;
        this.onUserCountChange();
    }

    private function onShellOrderChange(param1:ListEvent):void {
        if (this.select.selectedIndex == -1 || this.shell.id == this.shell.list[this.select.selectedIndex].id) {
            return;
        }
        dispatchEvent(new ShellRendererEvent(ShellRendererEvent.CHANGE_ORDER, this.shell, this.shell.list[this.select.selectedIndex]));
    }

    private function onUserCountChange(param1:ShellRendererEvent = null):void {
        var _loc2_:IEventCollector = App.utils.events;
        _loc2_.removeEvent(this.countStepper, IndexEvent.INDEX_CHANGE, this.onStepperValueChange);
        _loc2_.removeEvent(this.countSlider, SliderEvent.VALUE_CHANGE, this.onSliderValueChange);
        this.countSlider.snapInterval = this.countStepper.stepSize = this.shell.step;
        this.countSlider.maximum = this.countStepper.maximum = this.shell.maxAmmo;
        _loc2_.addEvent(this.countStepper, IndexEvent.INDEX_CHANGE, this.onStepperValueChange);
        _loc2_.addEvent(this.countSlider, SliderEvent.VALUE_CHANGE, this.onSliderValueChange);
        this.countSlider.value = this.countStepper.value = this.shell.userCount;
        this.countSliderBg.width = this.initCounterBgWidth * (this.shell.possibleMax / this.shell.maxAmmo);
        var _loc3_:Number = data.count - this.countSlider.value + data.inventoryCount;
        this.countLabel.text = App.utils.locale.integer(_loc3_ > 0 ? _loc3_ : 0);
        this.countLabel.alpha = _loc3_ > 0 ? Number(CHANGED_LABEL_ALPHA) : Number(DEFAULT_ALPHA);
        this.updateShellsPrice();
    }

    private function onRollOverHandler(param1:MouseEvent = null):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_SHELL, null, data.id, data.prices, data.inventoryCount, data.count);
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onClickHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        if (param1 is MouseEventEx) {
            if (App.utils.commons.isRightButton(param1)) {
                dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO, MaintenanceShellVO(data).id));
            }
        }
    }
}
}

package net.wg.gui.lobby.tankman {
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.gui.components.carousels.CarouselBase;
import net.wg.gui.components.carousels.PortraitsCarousel;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.events.PersonalCaseEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class PersonalCaseDocs extends UIComponentEx implements IViewStackContent {

    public var gold:IconText = null;

    public var credits:IconText = null;

    public var actionPriceGold:ActionPrice = null;

    public var actionPriceCredits:ActionPrice = null;

    public var submitBtn:SoundButtonEx = null;

    public var firstnames:PersonalCaseInputList = null;

    public var lastnames:PersonalCaseInputList = null;

    public var portraitsCarousel:PortraitsCarousel = null;

    private var model:PersonalCaseDocsModel = null;

    private var isDataProviderUpdated:Boolean = false;

    private var selectedFirstName:Object = null;

    private var selectedLastName:Object = null;

    private var selectedIcon:Object = null;

    public function PersonalCaseDocs() {
        super();
    }

    override protected function onDispose():void {
        if (this.submitBtn) {
            this.submitBtn.removeEventListener(ButtonEvent.CLICK, this.submitBtn_buttonClickHandler);
        }
        if (this.firstnames) {
            this.firstnames.removeEventListener(PersonalCaseInputList.NAME_SELECTED, this.firstnames_nameSelectedHandler);
            this.firstnames.dispose();
        }
        if (this.lastnames) {
            this.lastnames.removeEventListener(PersonalCaseInputList.NAME_SELECTED, this.lastnames_nameSelectedHandler);
            this.lastnames.dispose();
        }
        if (this.portraitsCarousel) {
            this.portraitsCarousel.removeEventListener(ListEvent.INDEX_CHANGE, this.portraitsCarousel_listIndexChangeHandler);
            this.portraitsCarousel.dispose();
            this.portraitsCarousel = null;
        }
        this.cleanTempData();
        this.firstnames = null;
        this.lastnames = null;
        this.model = null;
        this.submitBtn = null;
        this.gold = null;
        this.credits = null;
        this.actionPriceGold.dispose();
        this.actionPriceCredits.dispose();
        super.onDispose();
    }

    public function update(param1:Object):void {
        if (param1 == null) {
            return;
        }
        this.model = param1 as PersonalCaseDocsModel;
        App.utils.asserter.assertNotNull(this.model, "model" + Errors.CANT_NULL);
        this.firstnames.updateData(this.model.firstNames, this.model.currentTankmanFirstName);
        this.firstnames.searchText.maxChars = this.model.fistNameMaxChars;
        this.lastnames.updateData(this.model.lastNames, this.model.currentTankmanLastName);
        this.lastnames.searchText.maxChars = this.model.lastNameMaxChars;
        this.gold.text = this.model.priceOfGold.toString();
        this.credits.text = this.model.priceOfCredits.toString();
        this.actionPriceGold.setData(this.model.actionPriceDataGoldVo);
        this.actionPriceCredits.setData(this.model.actionPriceDataCreditsVo);
        this.gold.visible = !this.actionPriceGold.visible;
        this.credits.visible = !this.actionPriceCredits.visible && this.model.priceOfCredits;
        this.updateTextColor();
        if (!this.isDataProviderUpdated) {
            this.updatePortraitsDocs();
            this.isDataProviderUpdated = true;
        }
        this.checkSelectedItems();
    }

    override protected function draw():void {
        super.draw();
    }

    override protected function configUI():void {
        super.configUI();
        this.submitBtn.addEventListener(ButtonEvent.CLICK, this.submitBtn_buttonClickHandler);
        this.firstnames.addEventListener(PersonalCaseInputList.NAME_SELECTED, this.firstnames_nameSelectedHandler);
        this.lastnames.addEventListener(PersonalCaseInputList.NAME_SELECTED, this.lastnames_nameSelectedHandler);
    }

    private function cleanTempData():void {
        this.selectedFirstName = null;
        this.selectedLastName = null;
        this.selectedIcon = null;
    }

    private function updatePortraitsDocs():void {
        this.portraitsCarousel.addEventListener(ListEvent.INDEX_CHANGE, this.portraitsCarousel_listIndexChangeHandler);
        this.portraitsCarousel.dataProvider = new DataProvider(this.model.icons);
        this.portraitsCarousel.invalidate(CarouselBase.INIT_CAROUSEL);
    }

    private function updateTextColor():void {
        var _loc1_:Boolean = this.isHasMoney();
        this.gold.textColor = !!_loc1_ ? Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.GOLD]) : Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.ERROR]);
        this.credits.textColor = !!this.model.useOnlyGold ? Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.CREDITS]) : !!_loc1_ ? Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.CREDITS]) : Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.ERROR]);
        this.actionPriceGold.textColorType = !!_loc1_ ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
        this.actionPriceCredits.textColorType = !!this.model.useOnlyGold ? ActionPrice.TEXT_COLOR_TYPE_ICON : !!_loc1_ ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
    }

    private function isHasMoney():Boolean {
        if (this.model.useOnlyGold) {
            return this.model.userGold >= this.model.priceOfGold;
        }
        return this.model.userGold >= this.model.priceOfGold || this.model.userCredits >= this.model.priceOfCredits;
    }

    private function checkSelectedItems():void {
        this.submitBtn.enabled = this.checkAllData();
    }

    private function checkAllData():Boolean {
        if (!this.isHasMoney()) {
            return false;
        }
        if (this.selectedFirstName && this.selectedFirstName.value != this.model.currentTankmanFirstName) {
            return true;
        }
        if (this.selectedLastName && this.selectedLastName.value != this.model.currentTankmanLastName) {
            return true;
        }
        if (this.selectedIcon && this.selectedIcon.value != null && this.checkOriginalIcon(this.selectedIcon.value)) {
            return true;
        }
        return false;
    }

    private function checkOriginalIcon(param1:String = null):Boolean {
        if (this.model.originalIconFile.indexOf(param1, 0) == -1) {
            return true;
        }
        return false;
    }

    private function firstnames_nameSelectedHandler(param1:Event):void {
        this.selectedFirstName = this.firstnames.selectedItem;
        this.checkSelectedItems();
    }

    private function lastnames_nameSelectedHandler(param1:Event):void {
        this.selectedLastName = this.lastnames.selectedItem;
        this.checkSelectedItems();
    }

    private function submitBtn_buttonClickHandler(param1:ButtonEvent):void {
        var _loc2_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.CHANGE_PASSPORT, true);
        _loc2_.newTankmanFirstName = !!this.selectedFirstName ? this.selectedFirstName : this.firstnames.selectedItem;
        _loc2_.newTankmanLastName = !!this.selectedLastName ? this.selectedLastName : this.lastnames.selectedItem;
        if (!this.selectedIcon) {
            this.selectedIcon = {};
            this.selectedIcon.id = -1;
            this.selectedIcon.group = 0;
        }
        if (!_loc2_.newTankmanFirstName) {
            _loc2_.newTankmanFirstName = {
                "id": -1,
                "group": 0
            };
        }
        if (!_loc2_.newTankmanLastName) {
            _loc2_.newTankmanLastName = {
                "id": -1,
                "group": 0
            };
        }
        _loc2_.newIcon = this.selectedIcon;
        dispatchEvent(_loc2_);
    }

    private function portraitsCarousel_listIndexChangeHandler(param1:ListEvent):void {
        if (param1.itemData == null) {
            return;
        }
        if (param1.itemData && this.checkOriginalIcon(param1.itemData.value)) {
            this.selectedIcon = {};
            this.selectedIcon.id = param1.itemData.id;
            this.selectedIcon.value = param1.itemData.value;
            this.selectedIcon.group = param1.itemData.group;
        }
        else {
            this.selectedIcon = null;
        }
        this.checkSelectedItems();
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function canShowAutomatically():Boolean {
        return true;
    }
}
}

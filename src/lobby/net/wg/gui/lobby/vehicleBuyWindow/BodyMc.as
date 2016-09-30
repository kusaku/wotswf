package net.wg.gui.lobby.vehicleBuyWindow {
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.TankmanTrainingButton;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ILocale;

import scaleform.clik.controls.Button;
import scaleform.clik.controls.ButtonGroup;

public class BodyMc extends UIComponentEx {

    public static const BUTTONS_GROUP_SELECTION_CHANGED:String = "selChanged";

    private static const SCHOOL_GROUP_NAME:String = "scoolGroup";

    private static const TRAINING_TYPE_ACADEMY:String = "academy";

    private static const TRAINING_TYPE_SCOOL:String = "scool";

    private static const TRAINING_TYPE_FREE:String = "free";

    private static const TRAINING_TYPES:Array = [TRAINING_TYPE_FREE, TRAINING_TYPE_SCOOL, TRAINING_TYPE_ACADEMY];

    public var freeRentSlot:TextField;

    public var slotCheckbox:CheckBox;

    public var ammoCheckbox:CheckBox;

    public var crewCheckbox:CheckBox;

    public var tankmenLabel:TextField;

    public var slotPrice:IconText;

    public var ammoPrice:IconText;

    public var crewInVehicle:TextField;

    public var slotActionPrice:ActionPrice;

    public var ammoActionPrice:ActionPrice;

    public var academyBtn:TankmanTrainingButton;

    public var scoolBtn:TankmanTrainingButton;

    public var freeBtn:TankmanTrainingButton;

    private var _btnGroup:ButtonGroup;

    private var _lastSelectedButton:Button;

    public function BodyMc() {
        super();
    }

    override protected function onDispose():void {
        this.freeRentSlot = null;
        this.slotCheckbox.dispose();
        this.slotCheckbox = null;
        this.ammoCheckbox.dispose();
        this.ammoCheckbox = null;
        this.crewCheckbox.dispose();
        this.crewCheckbox = null;
        this.tankmenLabel = null;
        this.slotPrice.dispose();
        this.slotPrice = null;
        this.ammoPrice.dispose();
        this.ammoPrice = null;
        this.crewInVehicle = null;
        this.slotActionPrice.dispose();
        this.slotActionPrice = null;
        this.ammoActionPrice.dispose();
        this.ammoActionPrice = null;
        this.academyBtn.dispose();
        this.academyBtn = null;
        this.scoolBtn.dispose();
        this.scoolBtn = null;
        this.freeBtn.dispose();
        this.freeBtn = null;
        this._btnGroup.removeEventListener(Event.CHANGE, this.onBtnGroupChangeHandler);
        this._btnGroup.dispose();
        this._btnGroup = null;
        this._lastSelectedButton = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:String = SCHOOL_GROUP_NAME;
        this._btnGroup = new ButtonGroup(_loc1_, this);
        this._btnGroup.addButton(this.academyBtn);
        this._btnGroup.addButton(this.scoolBtn);
        this._btnGroup.addButton(this.freeBtn);
        this.academyBtn.groupName = _loc1_;
        this.scoolBtn.groupName = _loc1_;
        this.freeBtn.groupName = _loc1_;
        this._btnGroup.addEventListener(Event.CHANGE, this.onBtnGroupChangeHandler, false, 0, true);
        var _loc2_:ILocale = App.utils.locale;
        this.slotCheckbox.label = _loc2_.makeString(DIALOGS.BUYVEHICLEDIALOG_SLOTCHECKBOX);
        this.ammoCheckbox.label = _loc2_.makeString(DIALOGS.BUYVEHICLEDIALOG_AMMOCHECKBOX);
        this.crewInVehicle.text = DIALOGS.BUYVEHICLEDIALOG_CREWINVEHICLE;
        this.freeRentSlot.text = DIALOGS.BUYVEHICLEDIALOG_FREERENTSLOT;
        this.academyBtn.toggle = true;
        this.academyBtn.allowDeselect = false;
        this.scoolBtn.toggle = true;
        this.scoolBtn.allowDeselect = false;
        this.freeBtn.toggle = true;
        this.freeBtn.allowDeselect = false;
        this.freeBtn.selected = true;
        this.academyBtn.soundType = SoundTypes.RNDR_NORMAL;
        this.scoolBtn.soundType = SoundTypes.RNDR_NORMAL;
        this.freeBtn.soundType = SoundTypes.RNDR_NORMAL;
    }

    public function get selectedPrice():Number {
        if (this._btnGroup != null && this._btnGroup.selectedButton) {
            return Number(TankmanTrainingButton(this._btnGroup.selectedButton).data);
        }
        return NaN;
    }

    public function get isGoldPriceSelected():Boolean {
        if (this._btnGroup && this._btnGroup.selectedButton) {
            return TankmanTrainingButton(this._btnGroup.selectedButton).type == TRAINING_TYPE_ACADEMY;
        }
        return false;
    }

    public function get lastItemSelected():Boolean {
        if (this._lastSelectedButton) {
            return this._lastSelectedButton.selected;
        }
        return false;
    }

    public function set lastItemSelected(param1:Boolean):void {
        if (this.lastItemSelected == param1) {
            return;
        }
        if (this._lastSelectedButton != null) {
            this._lastSelectedButton.selected = param1;
        }
        if (!param1) {
            this._btnGroup.selectedButton = null;
        }
    }

    public function get crewType():int {
        var _loc1_:TankmanTrainingButton = null;
        if (this._btnGroup != null && this._btnGroup.selectedButton) {
            _loc1_ = TankmanTrainingButton(this._btnGroup.selectedButton);
            return TRAINING_TYPES.indexOf(_loc1_.type);
        }
        return -1;
    }

    private function onBtnGroupChangeHandler(param1:Event):void {
        if (this._btnGroup.selectedButton) {
            this._lastSelectedButton = this._btnGroup.selectedButton;
        }
        dispatchEvent(new Event(BUTTONS_GROUP_SELECTION_CHANGED));
    }
}
}

package net.wg.gui.lobby.tankman {
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.DashLineTextItem;
import net.wg.gui.components.advanced.TankmanCard;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.tankman.vo.RoleChangeVO;
import net.wg.infrastructure.base.meta.IRoleChangeMeta;
import net.wg.infrastructure.base.meta.impl.RoleChangeMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class RoleChangeWindow extends RoleChangeMeta implements IRoleChangeMeta {

    private static const TOTAL_PRICE_WIDTH:int = 367;

    public var tankmanCard:TankmanCard;

    public var vehicleSelection:RoleChangeVehicleSelection;

    public var roleItems:RoleChangeItems;

    public var totalPrice:DashLineTextItem;

    public var cancelBtn:SoundButtonEx;

    public var acceptBtn:SoundButtonEx;

    public var vehicleSelectLabel:TextField;

    public var roleSelectLabel:TextField;

    public var footerInfo:TextField;

    public var infoIcon:InfoIcon;

    private var _isEnoughGold:Boolean = true;

    private var _currentVehicleId:int = -1;

    private var _currentRoleId:String;

    public function RoleChangeWindow() {
        super();
        isCentered = true;
        isModal = true;
        canDrag = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.acceptBtn.addEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.vehicleSelection.addEventListener(ListEvent.INDEX_CHANGE, this.onVehicleSelectionIndexChangeHandler);
        this.roleItems.addEventListener(Event.CHANGE, this.onRoleItemsChangeHandler);
        this.vehicleSelectLabel.text = CREW_OPERATIONS.ROLECHANGE_VEHICLESELECTLABEL;
        this.roleSelectLabel.text = CREW_OPERATIONS.ROLECHANGE_ROLESELECTLABEL;
        this.footerInfo.text = CREW_OPERATIONS.ROLECHANGE_FOOTERINFO;
        this.totalPrice.label = RETRAIN_CREW.LABEL_RESULT;
        this.acceptBtn.label = CREW_OPERATIONS.ROLECHANGE_ACCEPTBUTTON;
        this.cancelBtn.label = MENU.TANKMANTRAININGWINDOW_CLOSEBTN;
        this.infoIcon.tooltip = TOOLTIPS.ROLECHANGE_FOOTERINFO;
        this.totalPrice.width = TOTAL_PRICE_WIDTH;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = CREW_OPERATIONS.ROLECHANGE_WINDOWTITLE;
        window.useBottomBtns = true;
        setFocus(this.acceptBtn);
    }

    override protected function onDispose():void {
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.acceptBtn.removeEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.vehicleSelection.removeEventListener(ListEvent.INDEX_CHANGE, this.onVehicleSelectionIndexChangeHandler);
        this.roleItems.removeEventListener(Event.CHANGE, this.onRoleItemsChangeHandler);
        this.tankmanCard.dispose();
        this.tankmanCard = null;
        this.vehicleSelection.dispose();
        this.vehicleSelection = null;
        this.roleItems.dispose();
        this.roleItems = null;
        this.infoIcon.dispose();
        this.infoIcon = null;
        this.totalPrice.dispose();
        this.totalPrice = null;
        this.acceptBtn.dispose();
        this.acceptBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.vehicleSelectLabel = null;
        this.roleSelectLabel = null;
        this.footerInfo = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.updateAcceptButtonState();
        }
    }

    override protected function setCommonData(param1:RoleChangeVO):void {
        this.tankmanCard.model = param1.tankmanModel;
        this.vehicleSelection.update(param1.vehicles);
        this._currentVehicleId = this.vehicleSelection.currentVehicleId;
    }

    public function as_setPrice(param1:String, param2:Boolean):void {
        this.totalPrice.value = param1;
        this._isEnoughGold = param2;
        invalidate(InvalidationType.DATA);
    }

    public function as_setRoles(param1:Array):void {
        this.roleItems.update(param1);
        param1.splice(0);
    }

    private function updateAcceptButtonState():void {
        this.acceptBtn.enabled = this._isEnoughGold && this._currentRoleId != null && this._currentVehicleId != Values.DEFAULT_INT;
        if (this.acceptBtn.focused && this.acceptBtn.enabled) {
            setFocus(this.cancelBtn);
        }
    }

    private function onRoleItemsChangeHandler(param1:Event):void {
        if (param1.target == this.roleItems) {
            if (this._currentRoleId != this.roleItems.currentRoleId) {
                this._currentRoleId = this.roleItems.currentRoleId;
                invalidate(InvalidationType.DATA);
            }
        }
    }

    private function onAcceptBtnClickHandler(param1:ButtonEvent):void {
        if (this._isEnoughGold && this.roleItems.currentRoleId != null && this.vehicleSelection.currentVehicleId != Values.DEFAULT_INT) {
            changeRoleS(this.roleItems.currentRoleId, this.vehicleSelection.currentVehicleId);
        }
    }

    private function onVehicleSelectionIndexChangeHandler(param1:ListEvent):void {
        if (this._currentVehicleId != this.vehicleSelection.currentVehicleId) {
            this._currentVehicleId = this.vehicleSelection.currentVehicleId;
            onVehicleSelectedS(this._currentVehicleId);
            invalidate(InvalidationType.DATA);
        }
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}

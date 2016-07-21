package net.wg.gui.prebattle.squads.fallout {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.VO.ExtendedUserVO;
import net.wg.data.constants.Errors;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
import net.wg.gui.rally.controls.VoiceRallySlotRenderer;
import net.wg.gui.rally.events.RallyViewsEvent;

public class FalloutSlotRenderer extends VoiceRallySlotRenderer {

    public var inviteIndicator:InviteIndicator = null;

    public var vehicleNo1:TextField = null;

    public var vehicleNo2:TextField = null;

    public var vehicleNo3:TextField = null;

    public var vehicleNotify1:TextField = null;

    public var vehicleNotify2:TextField = null;

    public var vehicleNotify3:TextField = null;

    public var vehicleBtn2:IVehicleButton = null;

    public var vehicleBtn3:IVehicleButton = null;

    private var _vehiclesNotify:Vector.<TextField> = null;

    private var _vehicleNo:Vector.<TextField> = null;

    private var _vehicleBtns:Vector.<IVehicleButton> = null;

    public function FalloutSlotRenderer() {
        super();
        this._vehiclesNotify = Vector.<TextField>([this.vehicleNotify1, this.vehicleNotify2, this.vehicleNotify3]);
        this._vehicleNo = Vector.<TextField>([this.vehicleNo1, this.vehicleNo2, this.vehicleNo3]);
        this._vehicleBtns = Vector.<IVehicleButton>([vehicleBtn, this.vehicleBtn2, this.vehicleBtn3]);
        this.hideVehiclesNotify();
    }

    override public function setStatus(param1:int):String {
        var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
        if (param1 < STATUSES.length && param1) {
            _loc2_ = STATUSES[param1];
        }
        statusIndicator.status = _loc2_;
        return _loc2_;
    }

    override protected function configUI():void {
        super.configUI();
        this.initVehiclesNumber();
        addTooltipSubscriber(statusIndicator);
        addTooltipSubscriber(commander);
        commander.visible = false;
        this.vehicleBtn2.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER, this.onMedallionRollOverHandler);
        this.vehicleBtn2.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT, this.onMedallionRollOutHandler);
        this.vehicleBtn3.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER, this.onMedallionRollOverHandler);
        this.vehicleBtn3.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT, this.onMedallionRollOutHandler);
    }

    override protected function onDispose():void {
        this._vehicleNo.splice(0, this._vehicleNo.length);
        this._vehicleNo = null;
        this.vehicleNo1 = null;
        this.vehicleNo2 = null;
        this.vehicleNo3 = null;
        this._vehiclesNotify.splice(0, this._vehiclesNotify.length);
        this._vehiclesNotify = null;
        this.vehicleNotify1 = null;
        this.vehicleNotify2 = null;
        this.vehicleNotify3 = null;
        this.vehicleBtn2.removeEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER, this.onMedallionRollOverHandler);
        this.vehicleBtn2.removeEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT, this.onMedallionRollOutHandler);
        this.vehicleBtn3.removeEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER, this.onMedallionRollOverHandler);
        this.vehicleBtn3.removeEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT, this.onMedallionRollOutHandler);
        this._vehicleBtns.splice(0, this._vehicleBtns.length);
        this._vehicleBtns = null;
        this.vehicleBtn2.dispose();
        this.vehicleBtn2 = null;
        this.vehicleBtn3.dispose();
        this.vehicleBtn3 = null;
        removeTooltipSubscriber(statusIndicator);
        this.inviteIndicator.dispose();
        this.inviteIndicator = null;
        removeTooltipSubscriber(commander);
        super.onDispose();
    }

    public function getVehicleBtnByNum(param1:int):IVehicleButton {
        App.utils.asserter.assertNotNull(this._vehicleBtns[param1], "_vehicleBtns[vehicleNum] [vehicleNum = " + param1 + "]" + Errors.CANT_NULL);
        return this._vehicleBtns[param1];
    }

    public function getVehicleIndexByVehicleBtn(param1:IVehicleButton):Number {
        App.utils.asserter.assertNotNull(this._vehicleBtns, "_vehicleBtns" + Errors.CANT_NULL);
        return this._vehicleBtns.indexOf(param1);
    }

    public function getVehicleNotifyByNum(param1:int):TextField {
        App.utils.asserter.assertNotNull(this._vehiclesNotify[param1], "_vehiclesNotify[notifyNum] [notifyNum = " + param1 + "]" + Errors.CANT_NULL);
        if (param1 < this._vehiclesNotify.length) {
            return this._vehiclesNotify[param1];
        }
        return null;
    }

    public function hideVehiclesNotify():void {
        var _loc1_:int = 0;
        var _loc2_:int = this._vehiclesNotify.length;
        _loc1_ = 0;
        while (_loc1_ < _loc2_) {
            this._vehiclesNotify[_loc1_].visible = false;
            _loc1_++;
        }
    }

    public function setVehiclesNotify(param1:Vector.<String>):void {
        App.utils.asserter.assertNotNull(param1, "statuses" + Errors.CANT_NULL);
        var _loc2_:int = 0;
        var _loc3_:int = param1.length;
        App.utils.asserter.assert(_loc3_ == this._vehiclesNotify.length, "notifications.length must be equal _vehiclesNotify.length");
        _loc2_ = 0;
        while (_loc2_ < _loc3_) {
            this._vehiclesNotify[_loc2_].htmlText = !!param1[_loc2_] ? param1[_loc2_] : Values.EMPTY_STR;
            _loc2_++;
        }
    }

    private function initVehiclesNumber():void {
        var _loc1_:int = this._vehicleNo.length;
        var _loc2_:int = 0;
        _loc2_ = 0;
        while (_loc2_ < _loc1_) {
            this._vehicleNo[_loc2_].visible = false;
            this._vehicleNo[_loc2_].text = (_loc2_ + 1).toString();
            _loc2_++;
        }
    }

    public function set showVehiclesNumber(param1:Boolean):void {
        var _loc2_:int = this._vehicleNo.length;
        var _loc3_:int = 0;
        _loc3_ = 0;
        while (_loc3_ < _loc2_) {
            this._vehicleNo[_loc3_].visible = param1;
            _loc3_++;
        }
    }

    override protected function onContextMenuAreaClick(param1:MouseEvent):void {
        var _loc2_:ExtendedUserVO = !!slotData ? slotData.player as ExtendedUserVO : null;
        if (_loc2_ && !UserTags.isCurrentPlayer(_loc2_.tags) && _loc2_.accID > -1) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.UNIT_USER, this, _loc2_);
        }
    }

    private function onMedallionRollOverHandler(param1:RallyViewsEvent):void {
        medallionDispatchEvent(param1);
    }

    private function onMedallionRollOutHandler(param1:Event):void {
        hideTooltip();
    }
}
}

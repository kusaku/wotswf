package net.wg.gui.battle.views.falloutRespawnView {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.views.falloutRespawnView.VO.FalloutRespawnViewVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleSlotVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleStateVO;
import net.wg.gui.battle.views.falloutRespawnView.interfaces.IFalloutRespawnView;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.meta.impl.FalloutRespawnViewMeta;

import scaleform.clik.events.ButtonEvent;

public class FalloutRespawnView extends FalloutRespawnViewMeta implements IFalloutRespawnView {

    private static const PADDING:Number = 170;

    private static const INVALIDATE_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALIDATE_TIMER_TEXT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const INVALIDATE_SELECTED_VEHICLE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    private var _stageWidth:int = 0;

    private var _stageHeight:int = 0;

    private var _timeStr:String = "";

    private var _selectedVehicleStr:String = "";

    private var _data:FalloutRespawnViewVO;

    public var bgImg:Sprite = null;

    public var slot0:RespawnVehicleSlot = null;

    public var slot1:RespawnVehicleSlot = null;

    public var slot2:RespawnVehicleSlot = null;

    private var _slots:Vector.<RespawnVehicleSlot> = null;

    public var titleTextTF:TextField = null;

    public var selectedVehicleTF:TextField = null;

    public var mainTimerTF:TextField = null;

    public var helpTextTF:TextField = null;

    public var postmortemBtn:SoundButtonEx = null;

    public var helpInfoBg:Sprite = null;

    public function FalloutRespawnView() {
        super();
        this._slots = new <RespawnVehicleSlot>[this.slot0, this.slot1, this.slot2];
        visible = false;
    }

    override protected function initializeComponent(param1:FalloutRespawnViewVO, param2:Vector.<VehicleSlotVO>):void {
        var _loc3_:int = this._slots.length;
        var _loc4_:RespawnVehicleSlot = null;
        var _loc5_:int = param2.length;
        var _loc6_:uint = 0;
        while (_loc6_ < _loc3_) {
            _loc4_ = this._slots[_loc6_];
            if (_loc6_ < _loc5_) {
                _loc4_.setData(param2[_loc6_]);
            }
            else {
                _loc4_.setData(null);
            }
            _loc4_.addClickCallBack(this);
            _loc6_++;
        }
        this._data = param1;
        invalidate(InvalidationType.DATA);
    }

    override protected function update(param1:String, param2:Vector.<VehicleStateVO>):void {
        if (param1) {
            this._selectedVehicleStr = param1;
            invalidate(INVALIDATE_SELECTED_VEHICLE);
        }
        this.setStateData(param2);
    }

    public function as_showGasAttackMode():void {
        this.showGasAttackMode();
    }

    private function setStateData(param1:Vector.<VehicleStateVO>):void {
        var _loc2_:Number = param1.length;
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            this._slots[_loc3_].setDynamicState(param1[_loc3_]);
            _loc3_++;
        }
    }

    override protected function updateTimer(param1:String, param2:Vector.<VehicleStateVO>):void {
        this._timeStr = param1;
        invalidate(INVALIDATE_TIMER_TEXT);
        this.setStateData(param2);
    }

    public function updateStage(param1:Number, param2:Number):void {
        this._stageWidth = param1;
        this._stageHeight = param2;
        invalidate(INVALIDATE_POSITION);
    }

    private function showGasAttackMode():void {
        this.postmortemBtn.visible = true;
        this.titleTextTF.visible = false;
        this.selectedVehicleTF.visible = false;
        this.mainTimerTF.visible = false;
        this.helpInfoBg.visible = false;
        this.helpTextTF.visible = false;
    }

    private function onPosmortemBtnClickHandler(param1:ButtonEvent):void {
        onPostmortemBtnClickS();
    }

    public function onButtonClick(param1:Object):void {
        onVehicleSelectedS(param1.vehicleID);
    }

    override public function setCompVisible(param1:Boolean):void {
        super.setCompVisible(param1);
        invalidate(INVALIDATE_POSITION);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_POSITION)) {
            x = this._stageWidth >> 1;
            y = this._stageHeight - height + PADDING >> 1;
            this.bgImg.width = this._stageWidth;
            this.bgImg.height = this._stageHeight;
            this.bgImg.x = -this._stageWidth >> 1;
            this.bgImg.y = -y;
        }
        if (isInvalid(INVALIDATE_TIMER_TEXT)) {
            this.mainTimerTF.text = this._timeStr;
        }
        if (isInvalid(INVALIDATE_SELECTED_VEHICLE)) {
            this.selectedVehicleTF.htmlText = this._selectedVehicleStr;
        }
        if (this._data && isInvalid(InvalidationType.DATA)) {
            this.titleTextTF.htmlText = this._data.titleMsg;
            this.selectedVehicleTF.htmlText = this._data.selectedVehicle;
            this.helpTextTF.htmlText = this._data.helpTextStr;
            this.postmortemBtn.visible = this._data.isPostmortemViewBtnEnabled;
            this.postmortemBtn.label = this._data.postmortemBtnLbl;
            this.postmortemBtn.validateNow();
            this.postmortemBtn.addEventListener(ButtonEvent.CLICK, this.onPosmortemBtnClickHandler);
        }
    }

    override protected function onDispose():void {
        this.bgImg = null;
        this._data = null;
        var _loc1_:RespawnVehicleSlot = null;
        while (this._slots.length) {
            _loc1_ = this._slots.pop();
            _loc1_.dispose();
            _loc1_ = null;
        }
        this._slots = null;
        if (this.slot0) {
            this.slot0.dispose();
        }
        this.slot0 = null;
        if (this.slot1) {
            this.slot1.dispose();
        }
        this.slot1 = null;
        if (this.slot2) {
            this.slot2.dispose();
        }
        this.slot2 = null;
        this.titleTextTF = null;
        this.selectedVehicleTF = null;
        this.mainTimerTF = null;
        this.helpTextTF = null;
        this.postmortemBtn.removeEventListener(ButtonEvent.CLICK, this.onPosmortemBtnClickHandler);
        this.postmortemBtn.dispose();
        this.postmortemBtn = null;
        this.helpInfoBg = null;
        super.onDispose();
    }
}
}

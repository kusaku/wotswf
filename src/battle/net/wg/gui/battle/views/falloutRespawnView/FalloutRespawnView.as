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

    public function as_initialize(param1:Object, param2:Array):void {
        var _loc7_:VehicleSlotVO = null;
        var _loc3_:FalloutRespawnViewVO = new FalloutRespawnViewVO(param1);
        var _loc4_:Vector.<VehicleSlotVO> = new Vector.<VehicleSlotVO>();
        var _loc5_:int = param2.length;
        var _loc6_:uint = 0;
        while (_loc6_ < _loc5_) {
            _loc7_ = new VehicleSlotVO(param2[_loc6_]);
            _loc4_.push(_loc7_);
            _loc6_++;
        }
        this.init(_loc3_, _loc4_);
    }

    public function as_updateTimer(param1:String, param2:Array):void {
        this.updateTimer(param1, param2);
    }

    public function as_update(param1:String, param2:Array):void {
        var _loc6_:VehicleStateVO = null;
        var _loc3_:Vector.<VehicleStateVO> = new Vector.<VehicleStateVO>();
        var _loc4_:int = param2.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = new VehicleStateVO(param2[_loc5_]);
            _loc3_.push(_loc6_);
            _loc5_++;
        }
        if (param1) {
            this._selectedVehicleStr = param1;
            invalidate(INVALIDATE_SELECTED_VEHICLE);
        }
        this.setStateData(_loc3_);
    }

    public function as_showGasAttackMode():void {
        this.showGasAttackMode();
    }

    public function init(param1:FalloutRespawnViewVO, param2:Vector.<VehicleSlotVO>):void {
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
        this.titleTextTF.htmlText = param1.titleMsg;
        this.selectedVehicleTF.htmlText = param1.selectedVehicle;
        this.helpTextTF.htmlText = param1.helpTextStr;
        this.postmortemBtn.visible = param1.isPostmortemViewBtnEnabled;
        this.postmortemBtn.label = param1.postmortemBtnLbl;
        this.postmortemBtn.validateNow();
        this.postmortemBtn.addEventListener(ButtonEvent.CLICK, this.onPosmortemBtnClickHandler);
    }

    private function setStateData(param1:Vector.<VehicleStateVO>):void {
        var _loc2_:Number = param1.length;
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            this._slots[_loc3_].setDynamicState(param1[_loc3_]);
            _loc3_++;
        }
    }

    private function updateTimer(param1:String, param2:Array):void {
        var _loc6_:VehicleStateVO = null;
        this._timeStr = param1;
        invalidate(INVALIDATE_TIMER_TEXT);
        var _loc3_:Vector.<VehicleStateVO> = new Vector.<VehicleStateVO>();
        var _loc4_:int = param2.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = new VehicleStateVO(param2[_loc5_]);
            _loc3_.push(_loc6_);
            _loc5_++;
        }
        this.setStateData(_loc3_);
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
    }

    override protected function onDispose():void {
        this.bgImg = null;
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

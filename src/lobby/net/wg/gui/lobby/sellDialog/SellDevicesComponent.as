package net.wg.gui.lobby.sellDialog {
import flash.display.MovieClip;

import net.wg.data.VO.SellDialogElement;
import net.wg.data.VO.SellDialogItem;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.interfaces.ISaleItemBlockRenderer;
import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleOptionalDeviceVo;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class SellDevicesComponent extends UIComponentEx {

    private static const PADDING_FOR_NEXT_ELEMENT:uint = 5;

    private static const COMPLEX_DEVICE_WIDTH:int = 477;

    public var complexDevice:SellDialogListItemRenderer = null;

    public var complDevBg:MovieClip = null;

    private var _removeActionPriceDataVo:ActionPriceVO = null;

    private var _complexDevicesArr:SellDialogItem = null;

    private var _sellData:Array;

    private var _removePrice:Number = 0;

    public function SellDevicesComponent() {
        this._sellData = [];
        super();
    }

    override protected function onDispose():void {
        this.complexDevice.dispose();
        this.complexDevice = null;
        this.complDevBg = null;
        this._removeActionPriceDataVo = null;
        this._complexDevicesArr.dispose();
        this._complexDevicesArr = null;
        this._sellData.splice(0, this._sellData.length);
        this._sellData = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.complexDevice.scrollingRenderrBg.visible = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._complexDevicesArr != null) {
            visible = this.complDevBg.visible = this.complexDevice.visible = this.isActive;
        }
    }

    public function getNextPosition():int {
        return this.complexDevice.y + this.complexDevice.height + PADDING_FOR_NEXT_ELEMENT;
    }

    public function setData(param1:Vector.<SellOnVehicleOptionalDeviceVo>):void {
        var _loc6_:SellDialogElement = null;
        if (this._complexDevicesArr != null) {
            this._complexDevicesArr.dispose();
        }
        this._complexDevicesArr = new SellDialogItem();
        var _loc2_:SellDialogItem = new SellDialogItem();
        var _loc3_:Number = param1.length;
        var _loc4_:SellOnVehicleOptionalDeviceVo = null;
        var _loc5_:Number = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = param1[_loc5_];
            _loc6_ = new SellDialogElement();
            _loc6_.id = _loc4_.userName;
            _loc6_.type = FITTING_TYPES.OPTIONAL_DEVICE;
            _loc6_.intCD = _loc4_.intCD;
            _loc6_.count = _loc4_.count;
            _loc6_.moneyValue = _loc4_.sellPrice[0];
            _loc6_.sellActionPriceVo = _loc4_.actionVo;
            _loc6_.removeActionPriceVo = this._removeActionPriceDataVo;
            _loc6_.isRemovable = _loc4_.isRemovable;
            _loc6_.toInventory = _loc4_.toInventory;
            if (_loc4_.isRemovable) {
                _loc2_.elements.push(_loc6_);
            }
            else {
                _loc6_.removePrice = this.removePrice;
                this._complexDevicesArr.elements.push(_loc6_);
            }
            _loc5_++;
        }
        if (_loc2_.elements.length != 0) {
            _loc2_.header = DIALOGS.VEHICLESELLDIALOG_OPTIONALDEVICE;
            this._sellData.push(_loc2_);
        }
        if (this._complexDevicesArr.elements.length != 0) {
            this._complexDevicesArr.header = DIALOGS.VEHICLESELLDIALOG_COMPLEXOPTIONALDEVICE;
            this.complexDevice.setData(this._complexDevicesArr);
            this.complexDevice.setSize(COMPLEX_DEVICE_WIDTH, this.complexDevice.height);
            this.complexDevice.validateNow();
        }
        invalidateData();
    }

    public function setRemoveActionPriceData(param1:ActionPriceVO):void {
        if (this._removeActionPriceDataVo == param1) {
            return;
        }
        this._removeActionPriceDataVo = param1;
    }

    public function get isActive():Boolean {
        return this._complexDevicesArr.elements.length != 0;
    }

    public function get removePrice():Number {
        return this._removePrice;
    }

    public function set removePrice(param1:Number):void {
        if (this._removePrice == param1) {
            return;
        }
        this._removePrice = param1;
        invalidateData();
    }

    public function get sellData():Array {
        return this._sellData;
    }

    public function get deviceItemRenderer():Vector.<ISaleItemBlockRenderer> {
        return this.complexDevice.getRenderers();
    }
}
}

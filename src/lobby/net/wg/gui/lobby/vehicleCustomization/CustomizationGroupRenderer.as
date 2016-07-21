package net.wg.gui.lobby.vehicleCustomization {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsGroupVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class CustomizationGroupRenderer extends UIComponentEx implements ISlotsPanelRenderer {

    private static var DEFAULT_GAP:int = 0;

    private static const SELECTOR_GAP:int = 10;

    private static const SLOT_RIGHT_PADDING:int = 4;

    public var header:TextField = null;

    public var slots:CustomizationSlotsPanel = null;

    private var _data:CustomizationSlotsGroupVO = null;

    private var _id:int = -1;

    private var _ownerId:int = -1;

    public function CustomizationGroupRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.header.autoSize = TextFieldAutoSize.LEFT;
        this.slots.ownerId = this.id;
        DEFAULT_GAP = this.slots.gap;
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:* = false;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        super.draw();
        if (this._data != null && isInvalid(InvalidationType.DATA)) {
            this.header.htmlText = this._data.header;
            this.slots.setData(new DataProvider(App.utils.data.vectorToArray(this._data.data)));
        }
        if (this._data && isInvalid(InvalidationType.SIZE)) {
            _loc1_ = this.slots.width - SLOT_RIGHT_PADDING;
            _loc2_ = this.header.width > _loc1_;
            _loc3_ = !!_loc2_ ? Number(this.header.width) : Number(_loc1_);
            _loc4_ = this.slots.y + this.slots.height;
            _originalWidth = _loc3_;
            _originalHeight = _loc4_;
            setActualSize(_loc3_, _loc4_);
            setActualScale(1, 1);
            if (_loc2_) {
                this.slots.x = (width - _loc1_ >> 1) + SLOT_RIGHT_PADDING;
            }
            else {
                this.header.x = width - this.header.width >> 1;
            }
        }
    }

    override protected function onDispose():void {
        this.header = null;
        this.slots.dispose();
        this.slots = null;
        this._data = null;
        super.onDispose();
    }

    public function hide():void {
        this.visible = false;
    }

    public function setData(param1:DAAPIDataClass):void {
        this._data = CustomizationSlotsGroupVO(param1);
        invalidateData();
        invalidateSize();
        validateNow();
    }

    public function setState(param1:String):void {
    }

    public function show():void {
        this.header.visible = true;
        this.visible = true;
        this.slots.gap = DEFAULT_GAP;
        this.slots.setRenderersState(CustomizationHelper.RENDER_STATE_BASE_MODE);
    }

    public function showPartly():void {
        this.visible = true;
        this.header.visible = false;
        this.slots.gap = SELECTOR_GAP;
        this.slots.setRenderersState(CustomizationHelper.RENDER_STATE_BUY_MODE);
    }

    public function update(param1:Object):void {
        var _loc2_:CustomizationSlotUpdateVO = CustomizationSlotUpdateVO(param1);
        this.slots.updateSlot(_loc2_.idx, _loc2_);
    }

    override public function set visible(param1:Boolean):void {
        super.visible = param1;
        this.header.visible = visible;
    }

    public function get ownerId():int {
        return this._ownerId;
    }

    public function set ownerId(param1:int):void {
        this._ownerId = param1;
    }

    public function get id():int {
        return this._id;
    }

    public function set id(param1:int):void {
        this._id = param1;
    }

    public function get selectId():int {
        return 0;
    }

    public function set selectId(param1:int):void {
    }
}
}

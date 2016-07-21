package net.wg.gui.lobby.vehicleCustomization {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.CloseButtonText;
import net.wg.gui.components.tooltips.helpers.TankTypeIco;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class CustomizationHeader extends UIComponentEx {

    private static const OFFSET:int = 22;

    private static const ELITE_OFFSET:int = 33;

    private static const ICON_OFFSET_LEFT:int = 10;

    public var title:TextField = null;

    public var tankName:TextField = null;

    public var tankIcon:TankTypeIco = null;

    public var closeBtn:CloseButtonText = null;

    public var background:Sprite = null;

    private var _data:CustomizationHeaderVO = null;

    private var _actualWidth:int = -1;

    public function CustomizationHeader() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
        _deferredDispose = true;
    }

    override protected function configUI():void {
        super.configUI();
        this.title.mouseEnabled = false;
        this.title.mouseWheelEnabled = false;
        this.title.autoSize = TextFieldAutoSize.LEFT;
        this.tankName.autoSize = TextFieldAutoSize.LEFT;
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        super.draw();
        if (this._data != null && isInvalid(InvalidationType.DATA)) {
            this.tankIcon.type = this._data.tankType;
            this.title.htmlText = this._data.titleText;
            this.tankName.htmlText = this._data.tankName;
            this.closeBtn.tooltip = this._data.closeBtnTooltip;
            invalidateSize();
        }
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = !!this._data.isElite ? int(ELITE_OFFSET) : int(OFFSET);
            _loc2_ = this.title.textWidth + this.tankIcon.width + this.tankName.width + _loc1_ + OFFSET;
            this.title.x = this._actualWidth - _loc2_ >> 1;
            this.tankIcon.x = this.title.x + this.title.textWidth + _loc1_ + ICON_OFFSET_LEFT;
            this.tankName.x = this.tankIcon.x + _loc1_;
            this.closeBtn.x = this._actualWidth - this.closeBtn.width - OFFSET;
            this.background.width = this._actualWidth;
        }
    }

    override protected function onBeforeDispose():void {
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.enabled = false;
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.title = null;
        this.tankName = null;
        this.background = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this._data = null;
        super.onDispose();
    }

    public function setData(param1:CustomizationHeaderVO):void {
        this._data = param1;
        invalidateData();
    }

    public function updateSize(param1:Number):void {
        this._actualWidth = param1;
        invalidateSize();
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CustomizationEvent(CustomizationEvent.CLOSE_VIEW));
    }
}
}

package net.wg.gui.lobby.hangar.tcarousel {
import flash.events.MouseEvent;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.hangar.tcarousel.data.FalloutVehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.event.SlotEvent;

import scaleform.clik.events.ButtonEvent;

public class FalloutTankCarouselItemRenderer extends TankCarouselItemRenderer {

    public var selectBtn:SoundButtonEx = null;

    private var _falloutData:FalloutVehicleCarouselVO = null;

    private var _falloutSlot:FalloutTankCarouselRendererSlot = null;

    public function FalloutTankCarouselItemRenderer() {
        super();
        this._falloutSlot = FalloutTankCarouselRendererSlot(slot);
    }

    override protected function configUI():void {
        super.configUI();
        this.selectBtn.addEventListener(ButtonEvent.CLICK, this.onSelectBtnClickHandler);
        this.selectBtn.addEventListener(MouseEvent.ROLL_OVER, this.onSelectBtnRollOverHandler);
        this.selectBtn.addEventListener(MouseEvent.ROLL_OUT, this.onSelectBtnRollOutHandler);
    }

    override protected function updateData():void {
        super.updateData();
        if (this._falloutData != null) {
            this._falloutSlot.updateFalloutData(this._falloutData.falloutSelected, this._falloutData.falloutCanBeSelected);
            if (this._falloutData.falloutSelected || this._falloutData.falloutCanBeSelected) {
                this.selectBtn.label = this._falloutData.selectButtonLabel;
                this.selectBtn.selected = !this._falloutData.falloutSelected;
                this.selectBtn.enabled = !this._falloutData.falloutButtonDisabled;
                this.selectBtn.visible = true;
            }
            else {
                this.selectBtn.visible = false;
            }
        }
    }

    override protected function onDispose():void {
        this.selectBtn.removeEventListener(ButtonEvent.CLICK, this.onSelectBtnClickHandler);
        this.selectBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onSelectBtnRollOverHandler);
        this.selectBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onSelectBtnRollOutHandler);
        this.selectBtn.dispose();
        this.selectBtn = null;
        this._falloutData = null;
        this._falloutSlot = null;
        super.onDispose();
    }

    override public function set data(param1:Object):void {
        if (param1 != null) {
            this._falloutData = FalloutVehicleCarouselVO(param1);
        }
        else {
            this.selectBtn.visible = false;
        }
        super.data = param1;
    }

    private function onSelectBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new SlotEvent(SlotEvent.TYPE_SELECT, this._falloutData.id));
    }

    private function onSelectBtnRollOverHandler(param1:MouseEvent):void {
        if (!this.selectBtn.enabled && this.selectBtn.selected) {
            App.toolTipMgr.show(this._falloutData.selectButtonTooltip);
        }
    }

    private function onSelectBtnRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}

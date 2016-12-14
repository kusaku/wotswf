package net.wg.gui.lobby.hangar.tcarousel {
import net.wg.data.ListDAAPIDataProvider;
import net.wg.gui.lobby.hangar.tcarousel.data.FalloutVehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionInfoVO;
import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionSlotVO;
import net.wg.gui.lobby.hangar.tcarousel.event.SlotEvent;
import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import net.wg.infrastructure.base.meta.IFalloutTankCarouselMeta;
import net.wg.infrastructure.base.meta.impl.FalloutTankCarouselMeta;

import scaleform.clik.constants.InvalidationType;

public class FalloutTankCarousel extends FalloutTankCarouselMeta implements IFalloutTankCarouselMeta {

    public var multiselectionSlots:MultiselectionSlots = null;

    public function FalloutTankCarousel() {
        super();
    }

    override public function as_rowCount(param1:int):void {
    }

    override protected function configUI():void {
        super.configUI();
        scrollList.addEventListener(SlotEvent.TYPE_SELECT, this.onScrollListTypeSelectHandler);
        this.multiselectionSlots.addEventListener(SlotEvent.TYPE_SELECT, this.onMultiselectionSlotsTypeSelectHandler);
        this.multiselectionSlots.addEventListener(SlotEvent.TYPE_SHIFT, this.onMultiselectionSlotsTypeShiftHandler);
        this.multiselectionSlots.addEventListener(SlotEvent.TYPE_DEACTIVATED, this.onMultiselectionSlotsTypeDeactivatedHandler);
    }

    override protected function onDispose():void {
        scrollList.removeEventListener(SlotEvent.TYPE_SELECT, this.onScrollListTypeSelectHandler);
        this.multiselectionSlots.removeEventListener(SlotEvent.TYPE_SELECT, this.onMultiselectionSlotsTypeSelectHandler);
        this.multiselectionSlots.removeEventListener(SlotEvent.TYPE_SHIFT, this.onMultiselectionSlotsTypeShiftHandler);
        this.multiselectionSlots.removeEventListener(SlotEvent.TYPE_DEACTIVATED, this.onMultiselectionSlotsTypeDeactivatedHandler);
        this.multiselectionSlots.dispose();
        this.multiselectionSlots = null;
        super.onDispose();
    }

    override protected function getNewHelper():ITankCarouselHelper {
        var _loc1_:ITankCarouselHelper = helper;
        if (!(_loc1_ is FalloutTankCarousel)) {
            _loc1_ = new TankCarouselHelper();
            invalidate(InvalidationType.SETTINGS);
        }
        return _loc1_;
    }

    override protected function getRendererVo():Class {
        return FalloutVehicleCarouselVO;
    }

    override protected function setMultiselectionInfo(param1:MultiselectionInfoVO):void {
        this.multiselectionSlots.setData(param1);
    }

    override protected function updateLayout(param1:Number, param2:Number = 0):void {
        this.multiselectionSlots.setWidth(param1);
        super.updateLayout(param1, param2);
    }

    public function as_getMultiselectionDP():Object {
        var _loc1_:ListDAAPIDataProvider = new ListDAAPIDataProvider(MultiselectionSlotVO);
        this.multiselectionSlots.dataProvider = _loc1_;
        return _loc1_;
    }

    private function onScrollListTypeSelectHandler(param1:SlotEvent):void {
        changeVehicleS(param1.vehicleId);
    }

    private function onMultiselectionSlotsTypeSelectHandler(param1:SlotEvent):void {
        selectVehicleS(param1.vehicleId);
        updateSelectedIndex();
    }

    private function onMultiselectionSlotsTypeShiftHandler(param1:SlotEvent):void {
        shiftSlotS(param1.vehicleId);
    }

    private function onMultiselectionSlotsTypeDeactivatedHandler(param1:SlotEvent):void {
        clearSlotS(param1.vehicleId);
    }
}
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;

import scaleform.clik.utils.Padding;

class TankCarouselHelper implements ITankCarouselHelper {

    private static const PADDING:Padding = new Padding(68, 10, 10, 10);

    function TankCarouselHelper() {
        super();
    }

    public function get linkRenderer():String {
        return "FalloutTankCarouselItemRendererUI";
    }

    public function get rendererWidth():Number {
        return 173;
    }

    public function get rendererHeight():Number {
        return 136;
    }

    public function get gap():Number {
        return 4;
    }

    public function get padding():Padding {
        return PADDING;
    }
}

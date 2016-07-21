package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionInfoVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class FalloutTankCarouselMeta extends TankCarousel {

    public var changeVehicle:Function;

    public var clearSlot:Function;

    public var shiftSlot:Function;

    private var _multiselectionInfoVO:MultiselectionInfoVO;

    public function FalloutTankCarouselMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._multiselectionInfoVO) {
            this._multiselectionInfoVO.dispose();
            this._multiselectionInfoVO = null;
        }
        super.onDispose();
    }

    public function changeVehicleS(param1:int):void {
        App.utils.asserter.assertNotNull(this.changeVehicle, "changeVehicle" + Errors.CANT_NULL);
        this.changeVehicle(param1);
    }

    public function clearSlotS(param1:int):void {
        App.utils.asserter.assertNotNull(this.clearSlot, "clearSlot" + Errors.CANT_NULL);
        this.clearSlot(param1);
    }

    public function shiftSlotS(param1:int):void {
        App.utils.asserter.assertNotNull(this.shiftSlot, "shiftSlot" + Errors.CANT_NULL);
        this.shiftSlot(param1);
    }

    public function as_setMultiselectionInfo(param1:Object):void {
        if (this._multiselectionInfoVO) {
            this._multiselectionInfoVO.dispose();
        }
        this._multiselectionInfoVO = new MultiselectionInfoVO(param1);
        this.setMultiselectionInfo(this._multiselectionInfoVO);
    }

    protected function setMultiselectionInfo(param1:MultiselectionInfoVO):void {
        var _loc2_:String = "as_setMultiselectionInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

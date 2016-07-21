package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleBuyWindow.BuyingVehicleVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class VehicleBuyWindowMeta extends AbstractWindowView {

    public var submit:Function;

    public var storeSettings:Function;

    private var _buyingVehicleVO:BuyingVehicleVO;

    public function VehicleBuyWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._buyingVehicleVO) {
            this._buyingVehicleVO.dispose();
            this._buyingVehicleVO = null;
        }
        super.onDispose();
    }

    public function submitS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.submit, "submit" + Errors.CANT_NULL);
        this.submit(param1);
    }

    public function storeSettingsS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.storeSettings, "storeSettings" + Errors.CANT_NULL);
        this.storeSettings(param1);
    }

    public function as_setInitData(param1:Object):void {
        if (this._buyingVehicleVO) {
            this._buyingVehicleVO.dispose();
        }
        this._buyingVehicleVO = new BuyingVehicleVO(param1);
        this.setInitData(this._buyingVehicleVO);
    }

    protected function setInitData(param1:BuyingVehicleVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

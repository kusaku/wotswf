package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.ButtonPropertiesVO;
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartPopoverInitDataVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class VehicleCompareCartPopoverMeta extends SmartPopOverView {

    public var remove:Function;

    public var removeAll:Function;

    public var gotoCompareView:Function;

    private var _buttonPropertiesVO1:ButtonPropertiesVO;

    private var _vehicleCompareCartPopoverInitDataVO:VehicleCompareCartPopoverInitDataVO;

    private var _buttonPropertiesVO:ButtonPropertiesVO;

    public function VehicleCompareCartPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._buttonPropertiesVO1) {
            this._buttonPropertiesVO1.dispose();
            this._buttonPropertiesVO1 = null;
        }
        if (this._vehicleCompareCartPopoverInitDataVO) {
            this._vehicleCompareCartPopoverInitDataVO.dispose();
            this._vehicleCompareCartPopoverInitDataVO = null;
        }
        if (this._buttonPropertiesVO) {
            this._buttonPropertiesVO.dispose();
            this._buttonPropertiesVO = null;
        }
        super.onDispose();
    }

    public function removeS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.remove, "remove" + Errors.CANT_NULL);
        this.remove(param1);
    }

    public function removeAllS():void {
        App.utils.asserter.assertNotNull(this.removeAll, "removeAll" + Errors.CANT_NULL);
        this.removeAll();
    }

    public function gotoCompareViewS():void {
        App.utils.asserter.assertNotNull(this.gotoCompareView, "gotoCompareView" + Errors.CANT_NULL);
        this.gotoCompareView();
    }

    public function as_setInitData(param1:Object):void {
        if (this._vehicleCompareCartPopoverInitDataVO) {
            this._vehicleCompareCartPopoverInitDataVO.dispose();
        }
        this._vehicleCompareCartPopoverInitDataVO = new VehicleCompareCartPopoverInitDataVO(param1);
        this.setInitData(this._vehicleCompareCartPopoverInitDataVO);
    }

    public function as_updateToCmpBtnProps(param1:Object):void {
        if (this._buttonPropertiesVO) {
            this._buttonPropertiesVO.dispose();
        }
        this._buttonPropertiesVO = new ButtonPropertiesVO(param1);
        this.updateToCmpBtnProps(this._buttonPropertiesVO);
    }

    public function as_updateClearBtnProps(param1:Object):void {
        if (this._buttonPropertiesVO1) {
            this._buttonPropertiesVO1.dispose();
        }
        this._buttonPropertiesVO1 = new ButtonPropertiesVO(param1);
        this.updateClearBtnProps(this._buttonPropertiesVO1);
    }

    protected function setInitData(param1:VehicleCompareCartPopoverInitDataVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateToCmpBtnProps(param1:ButtonPropertiesVO):void {
        var _loc2_:String = "as_updateToCmpBtnProps" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateClearBtnProps(param1:ButtonPropertiesVO):void {
        var _loc2_:String = "as_updateClearBtnProps" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

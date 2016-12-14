package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleCompare.data.VehicleModulesWindowInitDataVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class VehicleModulesWindowMeta extends AbstractWindowView {

    public var onModuleHover:Function;

    public var onModuleClick:Function;

    public var onResetBtnBtnClick:Function;

    public var onCompareBtnClick:Function;

    private var _array:Array;

    private var _vehicleModulesWindowInitDataVO:VehicleModulesWindowInitDataVO;

    public function VehicleModulesWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        if (this._vehicleModulesWindowInitDataVO) {
            this._vehicleModulesWindowInitDataVO.dispose();
            this._vehicleModulesWindowInitDataVO = null;
        }
        super.onDispose();
    }

    public function onModuleHoverS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onModuleHover, "onModuleHover" + Errors.CANT_NULL);
        this.onModuleHover(param1);
    }

    public function onModuleClickS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onModuleClick, "onModuleClick" + Errors.CANT_NULL);
        this.onModuleClick(param1);
    }

    public function onResetBtnBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onResetBtnBtnClick, "onResetBtnBtnClick" + Errors.CANT_NULL);
        this.onResetBtnBtnClick();
    }

    public function onCompareBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onCompareBtnClick, "onCompareBtnClick" + Errors.CANT_NULL);
        this.onCompareBtnClick();
    }

    public final function as_setInitData(param1:Object):void {
        var _loc2_:VehicleModulesWindowInitDataVO = this._vehicleModulesWindowInitDataVO;
        this._vehicleModulesWindowInitDataVO = new VehicleModulesWindowInitDataVO(param1);
        this.setInitData(this._vehicleModulesWindowInitDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setNodesStates(param1:Array):void {
        var _loc2_:Array = this._array;
        this._array = param1;
        this.setNodesStates(this._array);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setInitData(param1:VehicleModulesWindowInitDataVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setNodesStates(param1:Array):void {
        var _loc2_:String = "as_setNodesStates" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.boosters.data.BoostersWindowStaticVO;
import net.wg.gui.lobby.boosters.data.BoostersWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class BoostersWindowMeta extends AbstractWindowView {

    public var requestBoostersArray:Function;

    public var onBoosterActionBtnClick:Function;

    public var onFiltersChange:Function;

    public var onResetFilters:Function;

    private var _boostersWindowStaticVO:BoostersWindowStaticVO;

    private var _boostersWindowVO:BoostersWindowVO;

    public function BoostersWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._boostersWindowStaticVO) {
            this._boostersWindowStaticVO.dispose();
            this._boostersWindowStaticVO = null;
        }
        if (this._boostersWindowVO) {
            this._boostersWindowVO.dispose();
            this._boostersWindowVO = null;
        }
        super.onDispose();
    }

    public function requestBoostersArrayS(param1:int):void {
        App.utils.asserter.assertNotNull(this.requestBoostersArray, "requestBoostersArray" + Errors.CANT_NULL);
        this.requestBoostersArray(param1);
    }

    public function onBoosterActionBtnClickS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.onBoosterActionBtnClick, "onBoosterActionBtnClick" + Errors.CANT_NULL);
        this.onBoosterActionBtnClick(param1, param2);
    }

    public function onFiltersChangeS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onFiltersChange, "onFiltersChange" + Errors.CANT_NULL);
        this.onFiltersChange(param1);
    }

    public function onResetFiltersS():void {
        App.utils.asserter.assertNotNull(this.onResetFilters, "onResetFilters" + Errors.CANT_NULL);
        this.onResetFilters();
    }

    public function as_setData(param1:Object):void {
        if (this._boostersWindowVO) {
            this._boostersWindowVO.dispose();
        }
        this._boostersWindowVO = new BoostersWindowVO(param1);
        this.setData(this._boostersWindowVO);
    }

    public function as_setStaticData(param1:Object):void {
        if (this._boostersWindowStaticVO) {
            this._boostersWindowStaticVO.dispose();
        }
        this._boostersWindowStaticVO = new BoostersWindowStaticVO(param1);
        this.setStaticData(this._boostersWindowStaticVO);
    }

    protected function setData(param1:BoostersWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setStaticData(param1:BoostersWindowStaticVO):void {
        var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

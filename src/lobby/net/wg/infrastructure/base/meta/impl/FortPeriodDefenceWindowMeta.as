package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.PeriodDefenceInitVO;
import net.wg.gui.lobby.fortifications.data.PeriodDefenceVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortPeriodDefenceWindowMeta extends AbstractWindowView {

    public var onApply:Function;

    public var onCancel:Function;

    private var _periodDefenceInitVO:PeriodDefenceInitVO;

    private var _periodDefenceVO:PeriodDefenceVO;

    public function FortPeriodDefenceWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._periodDefenceInitVO) {
            this._periodDefenceInitVO.dispose();
            this._periodDefenceInitVO = null;
        }
        if (this._periodDefenceVO) {
            this._periodDefenceVO.dispose();
            this._periodDefenceVO = null;
        }
        super.onDispose();
    }

    public function onApplyS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.onApply, "onApply" + Errors.CANT_NULL);
        this.onApply(param1);
    }

    public function onCancelS():void {
        App.utils.asserter.assertNotNull(this.onCancel, "onCancel" + Errors.CANT_NULL);
        this.onCancel();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:PeriodDefenceVO = this._periodDefenceVO;
        this._periodDefenceVO = new PeriodDefenceVO(param1);
        this.setData(this._periodDefenceVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setInitData(param1:Object):void {
        var _loc2_:PeriodDefenceInitVO = this._periodDefenceInitVO;
        this._periodDefenceInitVO = new PeriodDefenceInitVO(param1);
        this.setInitData(this._periodDefenceInitVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:PeriodDefenceVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setInitData(param1:PeriodDefenceInitVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

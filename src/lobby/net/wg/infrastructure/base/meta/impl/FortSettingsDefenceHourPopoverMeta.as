package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.settings.DefenceHourPopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortSettingsDefenceHourPopoverMeta extends SmartPopOverView {

    public var onApply:Function;

    private var _defenceHourPopoverVO:DefenceHourPopoverVO;

    private var _defenceHourPopoverVO1:DefenceHourPopoverVO;

    public function FortSettingsDefenceHourPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._defenceHourPopoverVO) {
            this._defenceHourPopoverVO.dispose();
            this._defenceHourPopoverVO = null;
        }
        if (this._defenceHourPopoverVO1) {
            this._defenceHourPopoverVO1.dispose();
            this._defenceHourPopoverVO1 = null;
        }
        super.onDispose();
    }

    public function onApplyS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onApply, "onApply" + Errors.CANT_NULL);
        this.onApply(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:DefenceHourPopoverVO = this._defenceHourPopoverVO;
        this._defenceHourPopoverVO = new DefenceHourPopoverVO(param1);
        this.setData(this._defenceHourPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setTexts(param1:Object):void {
        var _loc2_:DefenceHourPopoverVO = this._defenceHourPopoverVO1;
        this._defenceHourPopoverVO1 = new DefenceHourPopoverVO(param1);
        this.setTexts(this._defenceHourPopoverVO1);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:DefenceHourPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTexts(param1:DefenceHourPopoverVO):void {
        var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

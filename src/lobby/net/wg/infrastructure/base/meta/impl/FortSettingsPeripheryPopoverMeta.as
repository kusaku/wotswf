package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.settings.PeripheryPopoverVO;
import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortSettingsPeripheryPopoverMeta extends PopoverWithDropdown {

    public var onApply:Function;

    private var _peripheryPopoverVO:PeripheryPopoverVO;

    private var _peripheryPopoverVO1:PeripheryPopoverVO;

    public function FortSettingsPeripheryPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._peripheryPopoverVO) {
            this._peripheryPopoverVO.dispose();
            this._peripheryPopoverVO = null;
        }
        if (this._peripheryPopoverVO1) {
            this._peripheryPopoverVO1.dispose();
            this._peripheryPopoverVO1 = null;
        }
        super.onDispose();
    }

    public function onApplyS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onApply, "onApply" + Errors.CANT_NULL);
        this.onApply(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:PeripheryPopoverVO = this._peripheryPopoverVO;
        this._peripheryPopoverVO = new PeripheryPopoverVO(param1);
        this.setData(this._peripheryPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setTexts(param1:Object):void {
        var _loc2_:PeripheryPopoverVO = this._peripheryPopoverVO1;
        this._peripheryPopoverVO1 = new PeripheryPopoverVO(param1);
        this.setTexts(this._peripheryPopoverVO1);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:PeripheryPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTexts(param1:PeripheryPopoverVO):void {
        var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

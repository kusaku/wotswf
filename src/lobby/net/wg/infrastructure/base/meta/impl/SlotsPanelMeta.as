package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.VO.SlotsPanelPropsVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class SlotsPanelMeta extends BaseDAAPIComponent {

    public var getSlotTooltipBody:Function;

    private var _slotsPanelPropsVO:SlotsPanelPropsVO;

    public function SlotsPanelMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._slotsPanelPropsVO) {
            this._slotsPanelPropsVO.dispose();
            this._slotsPanelPropsVO = null;
        }
        super.onDispose();
    }

    public function getSlotTooltipBodyS(param1:String):String {
        App.utils.asserter.assertNotNull(this.getSlotTooltipBody, "getSlotTooltipBody" + Errors.CANT_NULL);
        return this.getSlotTooltipBody(param1);
    }

    public function as_setPanelProps(param1:Object):void {
        if (this._slotsPanelPropsVO) {
            this._slotsPanelPropsVO.dispose();
        }
        this._slotsPanelPropsVO = new SlotsPanelPropsVO(param1);
        this.setPanelProps(this._slotsPanelPropsVO);
    }

    protected function setPanelProps(param1:SlotsPanelPropsVO):void {
        var _loc2_:String = "as_setPanelProps" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

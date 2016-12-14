package net.wg.gui.lobby.christmas.controls.slots {
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import net.wg.data.constants.Values;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlot;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

public class ChristmasSlot extends UIComponentEx implements IChristmasSlot {

    private var _data:SlotVO;

    private var _tooltipMgr:ITooltipMgr;

    public function ChristmasSlot() {
        this._tooltipMgr = App.toolTipMgr;
        super();
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:IEventDispatcher = this.getMouseTarget();
        _loc1_.addEventListener(MouseEvent.ROLL_OVER, this.onMouseTargetRollOverHandler);
        _loc1_.addEventListener(MouseEvent.ROLL_OUT, this.onMouseTargetRollOutHandler);
    }

    override protected function onDispose():void {
        var _loc1_:IEventDispatcher = this.getMouseTarget();
        _loc1_.removeEventListener(MouseEvent.ROLL_OVER, this.onMouseTargetRollOverHandler);
        _loc1_.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseTargetRollOutHandler);
        this._tooltipMgr = null;
        this._data = null;
        super.onDispose();
    }

    public function getMouseTarget():IEventDispatcher {
        return this;
    }

    public function setData(param1:SlotVO):void {
        this._data = param1;
        this.hideTooltip();
    }

    private function hideTooltip():void {
        this._tooltipMgr.hide();
    }

    public function get data():Object {
        return this._data;
    }

    public function get slotId():int {
        return this._data != null ? int(this._data.slotId) : int(Values.DEFAULT_INT);
    }

    protected function get slotData():SlotVO {
        return this._data;
    }

    private function onMouseTargetRollOverHandler(param1:MouseEvent):void {
        if (this._data != null && StringUtils.isNotEmpty(this._data.tooltip)) {
            if (this._data.isEmpty) {
                this._tooltipMgr.showComplex(this._data.tooltip);
            }
            else {
                this._tooltipMgr.showSpecial(this._data.tooltip, null, this._data.decorationId);
            }
        }
    }

    private function onMouseTargetRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }
}
}

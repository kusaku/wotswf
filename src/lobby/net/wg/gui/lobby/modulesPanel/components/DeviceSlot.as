package net.wg.gui.lobby.modulesPanel.components {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.AmmunitionButton;
import net.wg.gui.lobby.modulesPanel.data.DeviceSlotVO;
import net.wg.gui.lobby.modulesPanel.interfaces.IDeviceSlot;
import net.wg.infrastructure.events.IconLoaderEvent;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class DeviceSlot extends AmmunitionButton implements IDeviceSlot {

    private static const EXTRA_ICON_PADDING:int = 2;

    private var _slotData:DeviceSlotVO = null;

    private var _extraIcon:ExtraIcon = null;

    private var _type:String = null;

    private var _slotIndex:Number = 0;

    private var _tooltip:String = null;

    private var _toolTipMgr:ITooltipMgr = null;

    public function DeviceSlot() {
        _deferredDispose = true;
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._toolTipMgr = App.toolTipMgr;
        mouseEnabledOnDisabled = true;
        mouseChildren = false;
        useFocusedAsSelect = true;
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
    }

    override protected function onDispose():void {
        this.removeExtraIcon();
        this._toolTipMgr = null;
        this._slotData = null;
        super.onDispose();
    }

    override protected function onBeforeDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        super.onBeforeDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._slotData != null) {
            this.updateExtraIcon();
        }
    }

    public function getHitArea():DisplayObject {
        return this;
    }

    public function getTargetButton():DisplayObject {
        return this;
    }

    public function update(param1:Object):void {
        this._slotData = DeviceSlotVO(param1);
        invalidate(InvalidationType.DATA);
    }

    protected function createExtraIcon():void {
        this._extraIcon = new ExtraIcon();
        this._extraIcon.addEventListener(IconLoaderEvent.ICON_LOADED, this.onExtraIconIconLoadedHandler);
        this._extraIcon.mouseChildren = false;
        this._extraIcon.mouseEnabled = false;
        addChild(this._extraIcon);
    }

    protected function isEmpty():Boolean {
        return isNaN(this._slotData.id);
    }

    private function removeExtraIcon():void {
        if (this._extraIcon != null) {
            this._extraIcon.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onExtraIconIconLoadedHandler);
            this._extraIcon.dispose();
            removeChild(this._extraIcon);
            this._extraIcon = null;
        }
    }

    private function updateExtraIcon():void {
        if (!this.isEmpty() && StringUtils.isNotEmpty(this._slotData.extraModuleInfo)) {
            if (this._extraIcon == null) {
                this.createExtraIcon();
            }
            this._extraIcon.setSource(this._slotData.extraModuleInfo);
        }
        else if (this._extraIcon) {
            this._extraIcon.clear();
        }
    }

    private function hideToolTip():void {
        this._toolTipMgr.hide();
    }

    override public function get enabled():Boolean {
        return super.enabled;
    }

    public function get type():String {
        return this._type;
    }

    public function set type(param1:String):void {
        this._type = param1;
    }

    public function get slotIndex():Number {
        return this._slotIndex;
    }

    public function set slotIndex(param1:Number):void {
        this._slotIndex = param1;
    }

    public function get tooltip():String {
        return this._tooltip;
    }

    public function set tooltip(param1:String):void {
        this._tooltip = param1;
    }

    public function get id():Number {
        return this._slotData != null ? Number(this._slotData.id) : Number(NaN);
    }

    public function get slotData():DeviceSlotVO {
        return this._slotData;
    }

    private function onExtraIconIconLoadedHandler(param1:IconLoaderEvent):void {
        this._extraIcon.x = width - this._extraIcon.width - EXTRA_ICON_PADDING | 0;
        this._extraIcon.y = height - this._extraIcon.height - EXTRA_ICON_PADDING | 0;
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._slotData.tooltipType)) {
            if (TOOLTIPS_CONSTANTS.COMPLEX == this._slotData.tooltipType) {
                this._toolTipMgr.showComplex(this._slotData.tooltip);
            }
            else if (!this.isEmpty()) {
                this._toolTipMgr.showSpecial(this._slotData.tooltipType, null, this._slotData.id, this._slotData.slotIndex);
            }
        }
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        this.hideToolTip();
    }
}
}

package net.wg.gui.lobby.fortifications.cmp.orders.impl {
import flash.display.DisplayObject;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.constants.generated.ORDER_TYPES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ShellButton;
import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
import net.wg.gui.components.controls.VO.SlotVO;
import net.wg.gui.components.controls.VO.SlotsPanelPropsVO;
import net.wg.gui.components.controls.slotsPanel.impl.BaseSlotsPanel;
import net.wg.gui.lobby.fortifications.cmp.orders.IOrdersPanel;
import net.wg.gui.lobby.fortifications.data.OrderVO;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.managers.IPopoverManager;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IUtils;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.MouseEventEx;

public class OrdersPanel extends BaseSlotsPanel implements IOrdersPanel {

    private static const DEFAULT_POPOVER_ALIAS:String = FORTIFICATION_ALIASES.FORT_ORDER_POPOVER_ALIAS;

    private static const ORDER_UIID_OFFSET:int = 88;

    private var _popOverHasBeenOpened:Boolean = false;

    private var _lastClickedBtn:ICooldownSlot = null;

    private var _popoverMgr:IPopoverManager;

    private var _utils:IUtils;

    private var _toolTipMgr:ITooltipMgr;

    public function OrdersPanel() {
        this._popoverMgr = App.popoverMgr;
        this._utils = App.utils;
        this._toolTipMgr = App.toolTipMgr;
        super(ORDER_TYPES.FORT_ORDER_ALL_GROUP);
    }

    override protected function setSlots(param1:Vector.<SlotVO>):void {
        var _loc3_:int = 0;
        var _loc4_:OrderVO = null;
        super.setSlots(param1);
        var _loc2_:int = param1.length;
        _loc3_ = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = OrderVO(param1[_loc3_]);
            if (_loc4_.group != ORDER_TYPES.FORT_ORDER_CONSUMABLES_GROUP) {
                _loc4_.orderUIID = _loc3_ + ORDER_UIID_OFFSET;
            }
            _loc3_++;
        }
    }

    override protected function setPanelProps(param1:SlotsPanelPropsVO):void {
        super.setPanelProps(param1);
        if (props != null && props.popoverAlias == Values.EMPTY_STR) {
            props.popoverAlias = DEFAULT_POPOVER_ALIAS;
        }
    }

    override protected function setupSlot(param1:ICooldownSlot, param2:SlotVO):void {
        super.setupSlot(param1, param2);
        var _loc3_:ShellButton = ShellButton(param1);
        _loc3_.tooltipType = TOOLTIPS_CONSTANTS.COMPLEX;
        var _loc4_:OrderVO = OrderVO(param2);
        param1.focusable = !_loc4_.isInactive;
        param1.isInactive = _loc4_.isInactive;
        if (!param1.isInactive) {
            param1.addEventListener(ButtonEvent.CLICK, this.onSlotClickHandler);
        }
    }

    override protected function getSlotVO(param1:Object):SlotVO {
        return new OrderVO(param1);
    }

    override protected function createSlot(param1:SlotVO):ICooldownSlot {
        return this._utils.classFactory.getComponent(Linkages.SHELL_BUTTON, ICooldownSlot);
    }

    override protected function cleanUpSlot(param1:ICooldownSlot):void {
        super.cleanUpSlot(param1);
        if (!param1.isInactive) {
            param1.removeEventListener(ButtonEvent.CLICK, this.onSlotClickHandler);
        }
    }

    override protected function setSlotData(param1:ICooldownSlot, param2:SlotVO):void {
        super.setSlotData(param1, param2);
        var _loc3_:OrderVO = OrderVO(param2);
        var _loc4_:ShellButton = ShellButton(param1);
        _loc4_.level = _loc3_.level;
        _loc4_.count = _loc3_.count != Values.DEFAULT_INT ? _loc3_.count.toString() : Values.EMPTY_STR;
        _loc4_.highlightCounter(_loc3_.inProgress);
        _loc4_.isPassive = !_loc3_.enabled;
        if (_loc3_.isRecharged) {
            _loc4_.playRechargeAnimation();
            _loc3_.isRecharged = false;
        }
    }

    override protected function onDispose():void {
        this._lastClickedBtn = null;
        this._popoverMgr = null;
        this._utils = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    override protected function drawSlots():void {
        var _loc2_:ICooldownSlot = null;
        super.drawSlots();
        var _loc1_:Boolean = false;
        var _loc3_:Vector.<ICooldownSlot> = this.slots;
        for each(_loc2_ in _loc3_) {
            if (this._lastClickedBtn && this._lastClickedBtn.id == _loc2_.id) {
                _loc1_ = true;
                this._lastClickedBtn = _loc2_;
            }
        }
        if (!_loc1_ && this._popOverHasBeenOpened) {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
            this._popoverMgr.hide();
        }
    }

    override protected function showSlotTooltip(param1:ICooldownSlot):void {
        var _loc2_:OrderVO = OrderVO(param1.data);
        if (_loc2_.group == ORDER_TYPES.FORT_ORDER_CONSUMABLES_GROUP && param1.id != ORDER_TYPES.EMPTY_ORDER) {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_CONSUMABLE_ORDER, null, _loc2_.fortOrderTypeID, _loc2_.level);
        }
        else if (tooltip.length > 0) {
            this._toolTipMgr.showComplex(tooltip);
        }
    }

    public function getHitArea():DisplayObject {
        this._utils.asserter.assertNotNull(this._lastClickedBtn, "_lastClickedBtn" + Errors.CANT_NULL);
        return this._lastClickedBtn.displayObject;
    }

    public function getTargetButton():DisplayObject {
        this._utils.asserter.assertNotNull(this._lastClickedBtn, "_lastClickedBtn" + Errors.CANT_NULL);
        return this._lastClickedBtn.displayObject;
    }

    public function onPopoverClose():void {
        this._popOverHasBeenOpened = false;
    }

    public function onPopoverOpen():void {
        this._popOverHasBeenOpened = true;
    }

    private function onSlotClickHandler(param1:ButtonEvent):void {
        var _loc3_:OrderVO = null;
        var _loc4_:Object = null;
        var _loc2_:ShellButton = ShellButton(param1.target);
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            if (_loc2_) {
                this._lastClickedBtn = _loc2_;
                if (props.popoverAlias == DEFAULT_POPOVER_ALIAS) {
                    this._popoverMgr.show(this, DEFAULT_POPOVER_ALIAS, _loc2_.id, this);
                }
                else {
                    _loc3_ = OrderVO(_loc2_.data);
                    _loc4_ = {
                        "slotID": _loc3_.slotID,
                        "panelAlias": props.panelAlias
                    };
                    this._popoverMgr.show(this, props.popoverAlias, _loc4_);
                }
            }
        }
    }
}
}

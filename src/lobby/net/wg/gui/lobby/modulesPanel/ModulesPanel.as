package net.wg.gui.lobby.modulesPanel {
import flash.events.IEventDispatcher;

import net.wg.data.Aliases;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
import net.wg.gui.lobby.modulesPanel.components.ModuleSlot;
import net.wg.gui.lobby.modulesPanel.data.DeviceSlotVO;
import net.wg.gui.lobby.modulesPanel.data.DevicesDataVO;
import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
import net.wg.infrastructure.base.meta.impl.ModulesPanelMeta;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IUtils;

import scaleform.clik.controls.Button;
import scaleform.clik.controls.ButtonGroup;
import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.MouseEventEx;

public class ModulesPanel extends ModulesPanelMeta implements IModulesPanel {

    private static const INV_BUTTONS_ENABLED:String = "InvButtonsEnabled";

    private static const INV_SELECTION:String = "InvSelection";

    private static const MODULES_PANEL_BTN_GROUP:String = "ModulesPanelBtnGroup";

    public var gun:ModuleSlot = null;

    public var turret:ModuleSlot = null;

    public var engine:ModuleSlot = null;

    public var chassis:ModuleSlot = null;

    public var radio:ModuleSlot = null;

    private var _hasTurret:Boolean = false;

    private var _slots:Vector.<DeviceSlot> = null;

    private var _modules:Vector.<DeviceSlot> = null;

    private var _toolTipMgr:ITooltipMgr;

    private var _utils:IUtils;

    private var _modulesEnabled:Boolean = false;

    public function ModulesPanel() {
        this._toolTipMgr = App.toolTipMgr;
        this._utils = App.utils;
        super();
        this._slots = new Vector.<DeviceSlot>(0);
        this.addSlots(this.gun, this.turret, this.chassis, this.engine, this.radio);
        this._modules = new <DeviceSlot>[this.gun, this.turret, this.chassis, this.engine, this.radio];
    }

    override protected function configUI():void {
        var _loc1_:DeviceSlot = null;
        super.configUI();
        _deferredDispose = true;
        for each(_loc1_ in this._slots) {
            this.configSlot(_loc1_);
        }
        for each(_loc1_ in this._modules) {
            _loc1_.type = FITTING_TYPES.MANDATORY_SLOTS[this._modules.indexOf(_loc1_)];
            _loc1_.addEventListener(ButtonEvent.CLICK, this.onModuleSlotClickHandler);
        }
    }

    override protected function onBeforeDispose():void {
        var _loc1_:DeviceSlot = null;
        var _loc2_:IEventDispatcher = null;
        for each(_loc1_ in this._slots) {
            this.clearSlot(_loc1_);
            _loc1_.dispose();
        }
        this._slots.splice(0, this._slots.length);
        this._slots = null;
        for each(_loc2_ in this._modules) {
            _loc2_.removeEventListener(ButtonEvent.CLICK, this.onModuleSlotClickHandler);
        }
        this._modules.splice(0, this._modules.length);
        this._modules = null;
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._toolTipMgr = null;
        this._utils = null;
        this.gun = null;
        this.turret = null;
        this.chassis = null;
        this.engine = null;
        this.radio = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:ButtonGroup = null;
        super.draw();
        if (isInvalid(INV_BUTTONS_ENABLED)) {
            this.updateButtonsEnabled();
        }
        if (isInvalid(INV_SELECTION)) {
            _loc1_ = ButtonGroup.getGroup(MODULES_PANEL_BTN_GROUP, this);
            if (_loc1_ != null) {
                _loc1_.clearSelectedButton();
            }
        }
    }

    override protected function setData(param1:DevicesDataVO):void {
        this.resetSelection();
        this.setupDevices(param1.devices);
    }

    public function as_setModulesEnabled(param1:Boolean):void {
        this.modulesEnabled = param1;
        this.resetSelection();
        this.invalidateButtonsEnabled();
    }

    public function as_setVehicleHasTurret(param1:Boolean):void {
        this._hasTurret = param1;
        this.turret.enabled = this._hasTurret && this.modulesEnabled;
    }

    public function setItemsEnabled(param1:Vector.<DeviceSlot>, param2:Boolean):void {
        var _loc3_:DeviceSlot = null;
        for each(_loc3_ in param1) {
            if (_loc3_ == this.turret) {
                _loc3_.enabled = param2 && this._hasTurret;
            }
            else {
                _loc3_.enabled = param2;
            }
        }
    }

    protected function addToButtonGroup(param1:Button):void {
        param1.groupName = MODULES_PANEL_BTN_GROUP;
    }

    protected function invalidateButtonsEnabled():void {
        invalidate(INV_BUTTONS_ENABLED);
    }

    protected function addSlots(...rest):void {
        this._slots.push.apply(this._slots, rest);
    }

    protected function configSlot(param1:DeviceSlot):void {
        param1.addEventListener(ButtonEvent.CLICK, this.onSlotClickHandler);
        this.addToButtonGroup(param1);
    }

    protected function clearSlot(param1:DeviceSlot):void {
        param1.removeEventListener(ButtonEvent.CLICK, this.onSlotClickHandler);
    }

    protected function updateButtonsEnabled():void {
        this.setItemsEnabled(this._slots, this.modulesEnabled);
    }

    protected function trySetupDevice(param1:DeviceSlotVO):Boolean {
        var _loc2_:int = FITTING_TYPES.MANDATORY_SLOTS.indexOf(param1.slotType);
        if (_loc2_ != -1) {
            this._slots[_loc2_].update(param1);
            return true;
        }
        return false;
    }

    protected function resetSelection():void {
        invalidate(INV_SELECTION);
    }

    protected function showFittingPopover(param1:DeviceSlot):void {
        var _loc2_:Object = new FittingSelectPopoverParams(param1.type, param1.slotIndex);
        App.popoverMgr.show(param1, Aliases.FITTING_SELECT_POPOVER, _loc2_);
    }

    private function setupDevices(param1:Vector.<DeviceSlotVO>):void {
        var _loc2_:DeviceSlotVO = null;
        for each(_loc2_ in param1) {
            if (!this.trySetupDevice(_loc2_)) {
                this._utils.asserter.assert(false, "Undefined slotType: " + _loc2_.slotType);
            }
        }
    }

    protected function get modulesEnabled():Boolean {
        return this._modulesEnabled;
    }

    protected function set modulesEnabled(param1:Boolean):void {
        this._modulesEnabled = param1;
    }

    private function onModuleSlotClickHandler(param1:ButtonEvent):void {
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            this.showFittingPopover(DeviceSlot(param1.currentTarget));
        }
    }

    private function onSlotClickHandler(param1:ButtonEvent):void {
        var _loc2_:Number = NaN;
        this._toolTipMgr.hide();
        if (param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            _loc2_ = DeviceSlot(param1.currentTarget).id;
            if (!isNaN(_loc2_)) {
                showModuleInfoS(String(_loc2_));
            }
        }
    }
}
}

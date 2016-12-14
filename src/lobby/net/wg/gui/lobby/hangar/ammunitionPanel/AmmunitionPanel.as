package net.wg.gui.lobby.hangar.ammunitionPanel {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;

import net.wg.data.constants.Directions;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.advanced.ShellButton;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.hangar.ammunitionPanel.data.ShellButtonVO;
import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
import net.wg.gui.lobby.modulesPanel.data.DeviceSlotVO;
import net.wg.infrastructure.base.meta.impl.AmmunitionPanelMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.managers.ITooltipFormatter;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IUtils;
import net.wg.utils.helpLayout.HelpLayoutVO;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.MouseEventEx;

public class AmmunitionPanel extends AmmunitionPanelMeta implements IAmmunitionPanel {

    private static const VEHICLE_STATUS_INVALID:String = "vehicleStatusInvalid";

    private static const TO_RENT_LEFT_MARGIN:int = 10;

    private static const INV_SHELL_BUTTONS:String = "InvShellButtons";

    private static const INV_MAINTENANCE_STATE:String = "InvMaintenanceState";

    private static const OFFSET_BTN_TO_RENT:Number = 5;

    private static const AMMUNITION_PANEL_BOTTOM_PADDING:int = 9;

    private static const SHELLS_VO_SIZE_CORRECTION:int = 10;

    private static const HELP_LAYOUT_ID_DELIMITER:String = "_";

    public var vehicleStateMsg:VehicleStateMsg = null;

    public var maintenanceBtn:IconTextButton = null;

    public var tuningBtn:IconTextButton = null;

    public var optionalDevice1:EquipmentSlot = null;

    public var optionalDevice2:EquipmentSlot = null;

    public var optionalDevice3:EquipmentSlot = null;

    public var equipment1:EquipmentSlot = null;

    public var equipment2:EquipmentSlot = null;

    public var equipment3:EquipmentSlot = null;

    public var shell1:ShellButton = null;

    public var shell2:ShellButton = null;

    public var shell3:ShellButton = null;

    public var lastElementFocusFix:EquipmentSlot = null;

    public var toRent:SoundButtonEx = null;

    private var _modulesHelpLayoutId:String = "";

    private var _devicesHelpLayoutId:String = "";

    private var _shellsHelpLayoutId:String = "";

    private var _equipmentHelpLayoutId:String = "";

    private var _panelEnabled:Boolean = true;

    private var _maintenanceTooltip:String = "";

    private var _tuningTooltip:String = "";

    private var _optionalDevices:Vector.<DeviceSlot> = null;

    private var _equipment:Vector.<DeviceSlot> = null;

    private var _shells:Vector.<ShellButton> = null;

    private var _shellsData:Vector.<ShellButtonVO> = null;

    private var _maintenanceStateWarning:Boolean = false;

    private var _toolTipMgr:ITooltipMgr;

    private var _utils:IUtils;

    private var _msgVo:VehicleMessageVO = null;

    public function AmmunitionPanel() {
        this._toolTipMgr = App.toolTipMgr;
        this._utils = App.utils;
        super();
        addSlots(this.optionalDevice1, this.optionalDevice2, this.optionalDevice3, this.equipment1, this.equipment2, this.equipment3);
        this._optionalDevices = new <DeviceSlot>[this.optionalDevice1, this.optionalDevice2, this.optionalDevice3];
        this._equipment = new <DeviceSlot>[this.equipment1, this.equipment2, this.equipment3];
        this._shells = new <ShellButton>[this.shell1, this.shell2, this.shell3];
    }

    override protected function onBeforeDispose():void {
        this.tuningBtn.removeEventListener(ButtonEvent.CLICK, this.onTuningBtnClickHandler);
        this.tuningBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOverHandler);
        this.tuningBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOutHandler);
        this.disposeSlots();
        this._shellsData = null;
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        removeEventListener(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE, this.onAmmunitionPanelVehicleStateMsgResizeHandler);
        this.maintenanceBtn.removeEventListener(ButtonEvent.CLICK, this.onMaintenanceBtnClickHandler);
        this.maintenanceBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOverHandler);
        this.maintenanceBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOutHandler);
        this.toRent.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOverHandler);
        this.toRent.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOutHandler);
        this.toRent.removeEventListener(ButtonEvent.CLICK, this.onToRentClickHandler);
        this.maintenanceBtn.dispose();
        this.maintenanceBtn = null;
        this.tuningBtn.dispose();
        this.tuningBtn = null;
        this.vehicleStateMsg.dispose();
        this.vehicleStateMsg = null;
        this.toRent.dispose();
        this.toRent = null;
        this._modulesHelpLayoutId = null;
        this._devicesHelpLayoutId = null;
        this._shellsHelpLayoutId = null;
        this._equipmentHelpLayoutId = null;
        this._msgVo = null;
        this._toolTipMgr = null;
        this._utils = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(VEHICLE_STATUS_INVALID) && this._msgVo != null) {
            this.setVehicleStatus();
        }
        if (isInvalid(INV_SHELL_BUTTONS) && this._shellsData) {
            this.updateShellButtons();
        }
        if (isInvalid(INV_MAINTENANCE_STATE)) {
            this.maintenanceBtn.alertMC.visible = this._maintenanceStateWarning;
        }
    }

    override protected function configUI():void {
        var _loc1_:DeviceSlot = null;
        var _loc2_:ShellButton = null;
        super.configUI();
        this.tuningBtn.label = MENU.HANGAR_AMMUNITIONPANEL_TUNINGBTN;
        this.maintenanceBtn.label = MENU.HANGAR_AMMUNITIONPANEL_MAITENANCEBTN;
        this.maintenanceBtn.addEventListener(ButtonEvent.CLICK, this.onMaintenanceBtnClickHandler);
        this.maintenanceBtn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOverHandler);
        this.maintenanceBtn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOutHandler);
        this.tuningBtn.addEventListener(ButtonEvent.CLICK, this.onTuningBtnClickHandler);
        this.tuningBtn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOverHandler);
        this.tuningBtn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOutHandler);
        this.maintenanceBtn.mouseEnabledOnDisabled = true;
        this.tuningBtn.mouseEnabledOnDisabled = true;
        for each(_loc1_ in this._optionalDevices) {
            _loc1_.slotIndex = this._optionalDevices.indexOf(_loc1_);
            _loc1_.type = FITTING_TYPES.OPTIONAL_DEVICE;
            _loc1_.addEventListener(ButtonEvent.CLICK, this.onOptDeviceSlotClickHandler);
        }
        for each(_loc1_ in this._equipment) {
            _loc1_.type = FITTING_TYPES.EQUIPMENT;
            _loc1_.addEventListener(ButtonEvent.CLICK, this.onEquipmentSlotClickHandler);
        }
        for each(_loc2_ in this._shells) {
            _loc2_.mouseEnabledOnDisabled = true;
            _loc2_.addEventListener(ButtonEvent.CLICK, this.onShellSlotClickHandler);
            addToButtonGroup(_loc2_);
        }
        this.toRent.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOverHandler);
        this.toRent.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOutHandler);
        this.toRent.addEventListener(ButtonEvent.CLICK, this.onToRentClickHandler);
        this._utils.asserter.assert(width - this.lastElementFocusFix.x < this.lastElementFocusFix.width << 1, "lastElementFocusFix must be the last element in AmmunitionPanel " + "for property focus work, WOTD-40089");
        addEventListener(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE, this.onAmmunitionPanelVehicleStateMsgResizeHandler);
        this._utils.helpLayout.registerComponent(this);
        _deferredDispose = true;
    }

    override protected function updateVehicleStatus(param1:VehicleMessageVO):void {
        this._msgVo = param1;
        invalidate(VEHICLE_STATUS_INVALID);
    }

    override protected function updateButtonsEnabled():void {
        super.updateButtonsEnabled();
        this.maintenanceBtn.enabled = this._panelEnabled;
        setItemsEnabled(this._optionalDevices, this._panelEnabled);
        setItemsEnabled(this._equipment, this._panelEnabled);
    }

    override protected function trySetupDevice(param1:DeviceSlotVO):Boolean {
        if (super.trySetupDevice(param1)) {
            return true;
        }
        if (FITTING_TYPES.OPTIONAL_DEVICE == param1.slotType) {
            this._optionalDevices[param1.slotIndex].update(param1);
            return true;
        }
        if (FITTING_TYPES.EQUIPMENT == param1.slotType) {
            this._equipment[param1.slotIndex].update(param1);
            return true;
        }
        return false;
    }

    override protected function setAmmo(param1:Vector.<ShellButtonVO>, param2:Boolean):void {
        this._shellsData = param1;
        invalidate(INV_SHELL_BUTTONS);
        this._maintenanceStateWarning = param2;
        invalidate(INV_MAINTENANCE_STATE);
    }

    public function disposeSlots():void {
        var _loc1_:IUIComponentEx = null;
        for each(_loc1_ in this._optionalDevices) {
            _loc1_.removeEventListener(ButtonEvent.CLICK, this.onOptDeviceSlotClickHandler);
        }
        for each(_loc1_ in this._equipment) {
            _loc1_.removeEventListener(ButtonEvent.CLICK, this.onEquipmentSlotClickHandler);
        }
        for each(_loc1_ in this._shells) {
            _loc1_.removeEventListener(ButtonEvent.CLICK, this.onShellSlotClickHandler);
            _loc1_.dispose();
        }
        this._optionalDevices.splice(0, this._optionalDevices.length);
        this._optionalDevices = null;
        this._equipment.splice(0, this._equipment.length);
        this._equipment = null;
        this._shells.splice(0, this._shells.length);
        this._shells = null;
        this.optionalDevice1 = null;
        this.optionalDevice2 = null;
        this.optionalDevice3 = null;
        this.equipment1 = null;
        this.equipment2 = null;
        this.equipment3 = null;
        this.shell1 = null;
        this.shell2 = null;
        this.shell3 = null;
        this.lastElementFocusFix.dispose();
        this.lastElementFocusFix = null;
    }

    public function getBottomPosY():int {
        var _loc1_:int = this.vehicleStateMsg.y;
        return height + _loc1_ + AMMUNITION_PANEL_BOTTOM_PADDING;
    }

    public function getComponentForFocus():InteractiveObject {
        return this.toRent;
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        this.setHelpLayoutIds();
        var _loc1_:HelpLayoutVO = this.createHelpLayoutData(gun.x, gun.y, radio.x + radio.width - gun.x, gun.height, LOBBY_HELP.HANGAR_MODULES, this._modulesHelpLayoutId);
        var _loc2_:HelpLayoutVO = this.createHelpLayoutData(this.optionalDevice1.x, this.optionalDevice1.y, this.optionalDevice3.x + this.optionalDevice3.width - this.optionalDevice1.x, this.optionalDevice1.height, LOBBY_HELP.HANGAR_OPTIONAL_DEVICES, this._devicesHelpLayoutId);
        var _loc3_:HelpLayoutVO = this.createHelpLayoutData(this.shell1.x, this.shell1.y, this.shell3.x + this.shell3.width - this.shell1.x - SHELLS_VO_SIZE_CORRECTION, this.shell1.height - SHELLS_VO_SIZE_CORRECTION, LOBBY_HELP.HANGAR_SHELLS, this._shellsHelpLayoutId);
        var _loc4_:HelpLayoutVO = this.createHelpLayoutData(this.equipment1.x, this.equipment1.y, this.equipment3.x + this.equipment3.width - this.equipment1.x, this.equipment1.height, LOBBY_HELP.HANGAR_EQUIPMENT, this._equipmentHelpLayoutId);
        return new <HelpLayoutVO>[_loc1_, _loc2_, _loc3_, _loc4_];
    }

    public function updateAmmunitionPanel(param1:Boolean, param2:String):void {
        this._panelEnabled = param1;
        this._maintenanceTooltip = param2;
        invalidateButtonsEnabled();
    }

    public function updateStage(param1:Number, param2:Number):void {
        this.vehicleStateMsg.updateStage(param1, param2);
    }

    public function updateTuningButton(param1:Boolean, param2:String):void {
        this.tuningBtn.enabled = param1;
        this._tuningTooltip = param2;
    }

    private function setHelpLayoutIds():void {
        if (this._modulesHelpLayoutId == Values.EMPTY_STR) {
            this._modulesHelpLayoutId = this.generateHelpLayoutId();
        }
        if (this._devicesHelpLayoutId == Values.EMPTY_STR) {
            this._devicesHelpLayoutId = this.generateHelpLayoutId();
        }
        if (this._shellsHelpLayoutId == Values.EMPTY_STR) {
            this._shellsHelpLayoutId = this.generateHelpLayoutId();
        }
        if (this._equipmentHelpLayoutId == Values.EMPTY_STR) {
            this._equipmentHelpLayoutId = this.generateHelpLayoutId();
        }
    }

    private function createHelpLayoutData(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String):HelpLayoutVO {
        var _loc7_:HelpLayoutVO = new HelpLayoutVO();
        _loc7_.x = param1;
        _loc7_.y = param2;
        _loc7_.width = param3;
        _loc7_.height = param4;
        _loc7_.extensibilityDirection = Directions.RIGHT;
        _loc7_.message = param5;
        _loc7_.id = param6;
        _loc7_.scope = this;
        return _loc7_;
    }

    private function generateHelpLayoutId():String {
        return name + HELP_LAYOUT_ID_DELIMITER + Math.random();
    }

    private function updateShellButtons():void {
        var _loc3_:ShellButton = null;
        var _loc4_:ShellButtonVO = null;
        this._toolTipMgr.hide();
        var _loc1_:uint = this._shells.length;
        var _loc2_:uint = this._shellsData.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc1_) {
            _loc3_ = this._shells[_loc5_];
            _loc3_.clear();
            _loc3_.enabled = false;
            if (_loc5_ < _loc2_) {
                _loc4_ = this._shellsData[_loc5_];
                _loc3_.enabled = this._panelEnabled;
                _loc3_.id = _loc4_.id;
                _loc3_.ammunitionType = _loc4_.type;
                _loc3_.icon = _loc4_.icon;
                _loc3_.count = String(_loc4_.count);
                _loc3_.inventoryCount = _loc4_.inventoryCount;
                _loc3_.label = _loc4_.label;
                _loc3_.tooltip = _loc4_.tooltip;
                _loc3_.tooltipType = _loc4_.tooltipType;
            }
            _loc5_++;
        }
    }

    private function setVehicleStatus():void {
        this.vehicleStateMsg.setVehicleStatus(this._msgVo);
        if (this._msgVo.rentAvailable) {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
        }
    }

    override protected function get modulesEnabled():Boolean {
        return super.modulesEnabled && this._panelEnabled;
    }

    private function onShellSlotClickHandler(param1:ButtonEvent):void {
        this._toolTipMgr.hide();
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            showTechnicalMaintenanceS();
        }
        else if (param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            showModuleInfoS(ShellButton(param1.currentTarget).id);
        }
    }

    private function onEquipmentSlotClickHandler(param1:ButtonEvent):void {
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            showTechnicalMaintenanceS();
        }
    }

    private function onOptDeviceSlotClickHandler(param1:ButtonEvent):void {
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            showFittingPopover(DeviceSlot(param1.currentTarget));
        }
    }

    private function onAmmunitionPanelVehicleStateMsgResizeHandler(param1:AmmunitionPanelEvents):void {
        if (this._msgVo != null) {
            this.toRent.x = this.vehicleStateMsg.textX + this.vehicleStateMsg.x + TO_RENT_LEFT_MARGIN ^ 0;
            this.toRent.y = this.vehicleStateMsg.textY + OFFSET_BTN_TO_RENT;
            this.toRent.visible = this._msgVo.rentAvailable;
        }
    }

    private function onMaintenanceBtnClickHandler(param1:ButtonEvent):void {
        showTechnicalMaintenanceS();
    }

    private function onTuningBtnClickHandler(param1:ButtonEvent):void {
        showCustomizationS();
    }

    private function onBtnRollOverHandler(param1:MouseEvent):void {
        var _loc2_:String = null;
        var _loc3_:ITooltipFormatter = null;
        if (param1.target == this.toRent) {
            _loc3_ = this._toolTipMgr.getNewFormatter();
            _loc3_.addBody(TOOLTIPS.HANGAR_STATUS_TORENT, true);
            _loc2_ = _loc3_.make();
        }
        else if (param1.target == this.maintenanceBtn) {
            _loc2_ = this._maintenanceTooltip;
        }
        else if (param1.target == this.tuningBtn) {
            _loc2_ = this._tuningTooltip;
        }
        this._toolTipMgr.showComplex(_loc2_);
    }

    private function onBtnRollOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onToRentClickHandler(param1:ButtonEvent):void {
        if (this._msgVo.rentAvailable) {
            toRentContinueS();
        }
    }
}
}

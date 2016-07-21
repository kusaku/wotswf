package net.wg.gui.battle.views.falloutRespawnView {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.InteractiveStates;
import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.components.buttons.BattleToolTipButton;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleSlotVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleStateVO;
import net.wg.gui.battle.views.falloutRespawnView.components.EmptyInfo;
import net.wg.gui.components.controls.UILoaderAlt;

import scaleform.gfx.TextFieldEx;

public class RespawnVehicleSlot extends BattleToolTipButton {

    private static const REGULAR_TYPE_POS_X:int = 3;

    private static const REGULAR_TYPE_POS_Y:int = 2;

    private static const REGULAR_LEVEL_POS_X:int = 15;

    private static const ELITE_TYPE_POS_X:int = -1;

    private static const ELITE_TYPE_POS_Y:int = -4;

    private static const ELITE_LEVEL_POS_X:int = 19;

    private static const COOLDOWN_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    public var flagLoader:UILoaderAlt = null;

    public var vehicleLoader:UILoaderAlt = null;

    public var vehicleType:UILoaderAlt = null;

    public var vehicleLevel:UILoaderAlt = null;

    public var vehicleNameTF:TextField = null;

    public var premiumVehicleNameTF:TextField = null;

    public var cooldownTimerTF:TextField = null;

    public var hitAreaSpr:Sprite = null;

    public var selectedSpr:Sprite = null;

    public var emptySlotInfo:EmptyInfo = null;

    public var emptySlotBg:Sprite = null;

    private var _isSelected:Boolean = false;

    private var _isEmpty:Boolean = false;

    public var vehicleID:int = -1;

    private var _coolDownStr:String = "";

    public function RespawnVehicleSlot() {
        super();
        this.emptySlotInfo.visible = false;
        this.emptySlotBg.visible = false;
        this.selectedSpr.visible = false;
        isAllowedToShowToolTipOnDisabledState = true;
    }

    public function setData(param1:VehicleSlotVO):void {
        if (param1) {
            this.setEmpty(false);
            this.flagLoader.source = param1.flagIcon;
            this.vehicleLoader.source = param1.vehicleIcon;
            this.vehicleType.source = param1.vehicleType;
            this.vehicleLevel.source = param1.vehicleLevel;
            this.setVehicleName(param1.vehicleName, param1.isPremium);
            this.vehicleID = param1.vehicleID;
            this.vehicleType.x = !!param1.isElite ? Number(ELITE_TYPE_POS_X) : Number(REGULAR_TYPE_POS_X);
            this.vehicleType.y = !!param1.isElite ? Number(ELITE_TYPE_POS_Y) : Number(REGULAR_TYPE_POS_Y);
            this.vehicleLevel.x = !!param1.isElite ? Number(ELITE_LEVEL_POS_X) : Number(REGULAR_LEVEL_POS_X);
        }
        else {
            enabled = false;
            state = InteractiveStates.UP;
            this.setEmptyData();
        }
    }

    private function setEmptyData():void {
        this.setEmpty(true);
        TextFieldEx.setVerticalAlign(this.emptySlotInfo.infoTF, TextFieldEx.VALIGN_CENTER);
        this.emptySlotInfo.infoTF.text = INGAME_GUI.RESPAWNVIEW_EMPTYSLOTINFO;
        tooltipStr = App.toolTipMgr.getNewFormatter().addBody(INGAME_GUI.RESPAWNVIEW_EMPTYSLOTINFOTOOLTIP, true).make();
    }

    private function setEmpty(param1:Boolean):void {
        this._isEmpty = param1;
        this.emptySlotBg.visible = param1;
        this.emptySlotInfo.visible = param1;
        this.flagLoader.visible = !param1;
        this.vehicleLoader.visible = !param1;
        this.vehicleType.visible = !param1;
        this.vehicleNameTF.visible = !param1;
    }

    private function setVehicleName(param1:String, param2:Boolean):void {
        this.premiumVehicleNameTF.visible = param2;
        this.vehicleNameTF.visible = !param2;
        if (param2) {
            this.premiumVehicleNameTF.htmlText = param1;
        }
        else {
            this.vehicleNameTF.htmlText = param1;
        }
    }

    public function setDynamicState(param1:VehicleStateVO):void {
        var _loc4_:String = null;
        var _loc2_:Boolean = false;
        var _loc3_:Boolean = false;
        if (param1) {
            _loc2_ = param1.enabled;
            _loc3_ = param1.selected;
            _loc4_ = param1.cooldown;
            this.cooldownTimerTF.visible = !_loc2_ && _loc4_ != null;
            if (this.cooldownTimerTF.visible) {
                this._coolDownStr = _loc4_;
                invalidate(COOLDOWN_VALIDATION);
            }
        }
        this.setEnabledState(_loc2_);
        this.setSelectedState(_loc3_);
    }

    private function setEnabledState(param1:Boolean):void {
        var _loc2_:Boolean = false;
        if (enabled != param1) {
            _loc2_ = this._isEmpty || param1;
            enabled = param1;
            state = !!_loc2_ ? InteractiveStates.UP : InteractiveStates.DISABLED;
        }
    }

    private function setSelectedState(param1:Boolean):void {
        if (this._isSelected != param1) {
            this.selectedSpr.visible = param1;
            this._isSelected = param1;
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(COOLDOWN_VALIDATION)) {
            this.cooldownTimerTF.text = this._coolDownStr;
        }
    }

    override protected function onDispose():void {
        this.flagLoader.dispose();
        this.vehicleLoader.dispose();
        this.vehicleType.dispose();
        this.vehicleLevel.dispose();
        this.flagLoader = null;
        this.vehicleLoader = null;
        this.vehicleType = null;
        this.vehicleLevel = null;
        this.vehicleNameTF = null;
        this.premiumVehicleNameTF = null;
        this.cooldownTimerTF = null;
        this.hitAreaSpr = null;
        this.selectedSpr = null;
        this.emptySlotInfo.dispose();
        this.emptySlotInfo = null;
        this.emptySlotBg = null;
        super.onDispose();
    }
}
}

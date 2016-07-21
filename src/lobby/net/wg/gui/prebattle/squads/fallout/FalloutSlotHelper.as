package net.wg.gui.prebattle.squads.fallout {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.cyberSport.controls.CSVehicleButton;
import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
import net.wg.gui.prebattle.squads.fallout.vo.FalloutRallySlotVO;
import net.wg.gui.rally.constants.PlayerStatus;
import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
import net.wg.gui.rally.controls.SlotRendererHelper;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.gui.rally.vo.VehicleVO;
import net.wg.infrastructure.managers.ITooltipFormatter;

public class FalloutSlotHelper extends SlotRendererHelper {

    public function FalloutSlotHelper() {
        super();
        chooseVehicleText = Values.EMPTY_STR;
    }

    override public function initControlsState(param1:IRallySimpleSlotRenderer):void {
        super.initControlsState(param1);
        var _loc2_:FalloutSlotRenderer = FalloutSlotRenderer(param1);
        _loc2_.inviteIndicator.visible = false;
    }

    override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null):void {
        var _loc12_:Number = NaN;
        var _loc13_:VehicleVO = null;
        var _loc5_:FalloutRallySlotVO = FalloutRallySlotVO(param3);
        var _loc6_:FalloutSlotRenderer = FalloutSlotRenderer(param2);
        if (!_loc5_) {
            return;
        }
        var _loc7_:ITooltipFormatter = null;
        var _loc8_:String = Values.EMPTY_STR;
        var _loc9_:Boolean = false;
        var _loc10_:Number = Values.DEFAULT_INT;
        var _loc11_:IVehicleButton = null;
        switch (param1) {
            case _loc6_.statusIndicator:
                _loc8_ = TOOLTIPS.squadwindow_status(RallySimpleSlotRenderer.STATUSES[_loc5_.playerStatus]);
                _loc7_ = App.toolTipMgr.getNewFormatter();
                _loc7_.addBody(_loc8_, true);
                break;
            case _loc6_.commander:
                _loc8_ = TOOLTIPS.SQUADWINDOW_STATUS_COMMANDER;
                _loc7_ = App.toolTipMgr.getNewFormatter();
                _loc7_.addBody(_loc8_, true);
                break;
            case _loc6_.vehicleBtn:
            case _loc6_.vehicleBtn2:
            case _loc6_.vehicleBtn3:
                _loc11_ = IVehicleButton(param1);
                _loc10_ = _loc11_.currentState;
                if (_loc10_ == CSVehicleButton.SELECTED_VEHICLE) {
                    _loc12_ = _loc6_.getVehicleIndexByVehicleBtn(_loc11_);
                    _loc13_ = _loc5_.selectedVehicles[_loc12_];
                    if (_loc13_ != null) {
                        if (_loc11_.showAlertIcon) {
                            App.toolTipMgr.showComplex(_loc13_.tooltip);
                        }
                        else {
                            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SQUAD_SLOT_VEHICLE_SELECTED, null, param2.index, _loc5_.rallyIdx);
                        }
                    }
                    _loc9_ = true;
                }
        }
        if (!_loc9_) {
            if (_loc7_) {
                App.toolTipMgr.showComplex(_loc7_.make());
            }
            else {
                super.onControlRollOver(param1, param2, param3, param4);
            }
        }
    }

    override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO):void {
        var _loc3_:FalloutSlotRenderer = FalloutSlotRenderer(param1);
        var _loc4_:FalloutRallySlotVO = param2 as FalloutRallySlotVO;
        App.utils.asserter.assertNotNull(_loc4_, "unitSlotData" + Errors.CANT_NULL);
        _loc3_.showVehiclesNumber = _loc4_.player != null;
        _loc3_.slotLabel.width = !!_loc3_.vehicleNo1.visible ? Number(_loc3_.vehicleNo1.x - _loc3_.slotLabel.x) : Number(_loc3_.width - _loc3_.slotLabel.x);
        super.updateComponents(param1, param2);
        var _loc5_:Boolean = false;
        if (_loc4_.player) {
            _loc5_ = UserTags.isCurrentPlayer(_loc4_.player.tags);
            _loc3_.setVehiclesNotify(_loc4_.vehiclesNotify);
        }
        else {
            _loc3_.hideVehiclesNotify();
        }
        if (!_loc4_.isClosed) {
            this.updateVehicles(_loc3_, _loc4_);
        }
        if (_loc4_.player && _loc4_.player.isOffline) {
            _loc3_.setStatus(RallySimpleSlotRenderer.STATUSES.indexOf(IndicationOfStatus.STATUS_NORMAL));
        }
        else {
            _loc3_.setStatus(_loc4_.playerStatus);
        }
        if (_loc3_.contextMenuArea) {
            _loc3_.contextMenuArea.visible = _loc4_ && _loc4_.player;
            _loc3_.contextMenuArea.buttonMode = _loc3_.contextMenuArea.useHandCursor = _loc4_ && _loc4_.player && !_loc5_;
            _loc3_.contextMenuArea.width = _loc3_.slotLabel.width;
        }
        if (_loc4_.player) {
            _loc3_.setSpeakers(_loc4_.player.isPlayerSpeaking, true);
            _loc3_.commander.visible = _loc4_.player.isCommander;
            _loc3_.selfBg.visible = _loc5_;
        }
        else {
            _loc3_.setSpeakers(false, true);
            _loc3_.commander.visible = false;
            _loc3_.selfBg.visible = false;
        }
        _loc3_.updateVoiceWave();
    }

    private function updateVehicles(param1:FalloutSlotRenderer, param2:FalloutRallySlotVO):void {
        var _loc9_:* = false;
        var _loc3_:int = 0;
        var _loc4_:int = param2.selectedVehicles.length;
        var _loc5_:IVehicleButton = null;
        var _loc6_:TextField = null;
        var _loc7_:Boolean = false;
        var _loc8_:Boolean = !!param2.player ? Boolean(UserTags.isCurrentPlayer(param2.player.tags)) : false;
        _loc3_ = 0;
        while (_loc3_ < _loc4_) {
            _loc5_ = param1.getVehicleBtnByNum(_loc3_);
            _loc6_ = param1.getVehicleNotifyByNum(_loc3_);
            _loc9_ = param2.selectedVehicles[_loc3_] != null;
            _loc5_.visible = _loc9_;
            if (_loc6_) {
                _loc6_.visible = !_loc9_ && _loc8_;
            }
            if (_loc9_) {
                _loc5_.enabled = false;
                _loc5_.setVehicle(param2.selectedVehicles[_loc3_]);
                if (param2.player) {
                    _loc7_ = (param2.isFallout || param2.selectedVehicles[_loc3_].isFalloutVehicle) && param2.playerStatus != PlayerStatus.STATUS_IN_BATTLE;
                    _loc5_.showAlertIcon = _loc8_ && _loc7_;
                }
                _loc5_.visible = true;
            }
            _loc3_++;
        }
    }
}
}

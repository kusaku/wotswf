package net.wg.gui.cyberSport.views.respawn {
import flash.display.InteractiveObject;

import net.wg.data.constants.UserTags;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.cyberSport.controls.CSVehicleButton;
import net.wg.gui.rally.controls.BaseRallySlotHelper;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.infrastructure.managers.ITooltipFormatter;

public class RespawnSlotHelper extends BaseRallySlotHelper {

    private static var ALLY_LEVEL_ALPHA:Number = 0.33;

    public function RespawnSlotHelper() {
        super();
    }

    override public function initControlsState(param1:IRallySimpleSlotRenderer):void {
        super.initControlsState(param1);
        var _loc2_:RespawnTeamSlot = param1 as RespawnTeamSlot;
        _loc2_.levelLbl.visible = true;
        _loc2_.levelLbl.text = "0";
        _loc2_.levelLbl.alpha = ALLY_LEVEL_ALPHA;
    }

    override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null):void {
        var _loc7_:ITooltipFormatter = null;
        super.onControlRollOver(param1, param2, param3, param4);
        var _loc5_:IRallySlotVO = param3 as IRallySlotVO;
        var _loc6_:RespawnTeamSlot = param2 as RespawnTeamSlot;
        if (!_loc5_) {
            return;
        }
        switch (param1) {
            case _loc6_.slotLabel:
                if (_loc5_.isClosed) {
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELCLOSED);
                }
                else if (_loc5_.compatibleVehiclesCount == 0 && !_loc5_.player && !_loc5_.isCommanderState) {
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELUNAVAILABLE);
                }
                else if (_loc5_.player) {
                    App.toolTipMgr.show(_loc5_.player.getToolTip());
                }
                break;
            case _loc6_.vehicleBtn:
                if (_loc6_.vehicleBtn.currentState == CSVehicleButton.CHOOSE_VEHICLE) {
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_SELECTVEHICLE);
                }
                else if (_loc6_.vehicleBtn.currentState == CSVehicleButton.DEFAULT_STATE) {
                    App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
                }
                else if (_loc6_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE) {
                    if (param4 && param4.type == "alert") {
                        _loc7_ = App.toolTipMgr.getNewFormatter();
                        _loc7_.addHeader(param4.state);
                        _loc7_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY, true);
                        App.toolTipMgr.showComplex(_loc7_.make());
                    }
                    else {
                        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT_SELECTED, null, param2.index, _loc5_.rallyIdx);
                    }
                }
                else {
                    App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT, null, param2.index, _loc5_.rallyIdx);
                }
        }
    }

    override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO):void {
        super.updateComponents(param1, param2);
        var _loc3_:RespawnTeamSlot = param1 as RespawnTeamSlot;
        _loc3_.slotLabel.visible = true;
        var _loc4_:IRallySlotVO = param2 as IRallySlotVO;
        if (_loc3_ && _loc4_) {
            _loc3_.levelLbl.text = String(_loc4_.selectedVehicleLevel);
            _loc3_.levelLbl.alpha = !!_loc4_.selectedVehicleLevel ? Number(1) : Number(ALLY_LEVEL_ALPHA);
            if (_loc4_.player) {
                _loc3_.setSpeakers(_loc4_.player.isPlayerSpeaking, true);
                _loc3_.selfBg.visible = UserTags.isCurrentPlayer(_loc4_.player.tags);
                _loc3_.commander.visible = _loc4_.player.isCommander;
            }
            else {
                _loc3_.commander.visible = false;
                _loc3_.selfBg.visible = false;
                _loc3_.setSpeakers(false, true);
            }
        }
    }
}
}

package net.wg.gui.lobby.fortifications.battleRoom {
import flash.display.InteractiveObject;
import flash.utils.getQualifiedClassName;

import net.wg.data.constants.UserTags;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.cyberSport.controls.CSVehicleButton;
import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
import net.wg.gui.rally.constants.PlayerStatus;
import net.wg.gui.rally.controls.BaseRallySlotHelper;
import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
import net.wg.gui.rally.controls.RallySlotRenderer;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.gui.rally.vo.RallySlotVO;
import net.wg.gui.utils.VO.UnitSlotProperties;
import net.wg.infrastructure.managers.ITooltipFormatter;

public class SortieSlotHelper extends BaseRallySlotHelper {

    private var _removeBtnProps:UnitSlotProperties;

    private var _lockBtnProps:UnitSlotProperties;

    public function SortieSlotHelper() {
        super();
        this._removeBtnProps = new UnitSlotProperties(237, 21);
        this._lockBtnProps = new UnitSlotProperties(273, 147);
    }

    private static function updateSlotRemoveBtn(param1:SortieSlot, param2:Boolean, param3:String, param4:UnitSlotProperties, param5:String = ""):void {
        if (param1 != null && param1.removeBtn != null) {
            param1.removeBtn.visible = param2;
            param1.removeBtn.icon = param3;
            param1.removeBtn.width = param4.width;
            param1.removeBtn.x = param4.x;
            param1.removeBtn.label = param5;
        }
    }

    private static function onCommanderRollOverHandler():void {
        App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_COMMANDER);
    }

    private static function onStatusIndicatorRollOverHandler(param1:RallySimpleSlotRenderer):void {
        if (param1.statusIndicator.currentFrameLabel == IndicationOfStatus.STATUS_READY) {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_ISREADY);
        }
        else if (param1.statusIndicator.currentFrameLabel == IndicationOfStatus.STATUS_NORMAL) {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_NOTREADY);
        }
    }

    private static function onSlotLabelRollOverHandler(param1:IRallySlotVO):void {
        if (param1 != null) {
            if (param1.player) {
                App.toolTipMgr.show(param1.player.getToolTip());
            }
        }
    }

    private static function onTakePlaceFirstTimeBtnRollOverHandler():void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
    }

    private static function onTakePlaceBtnRollOverHandler():void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
    }

    private static function onVehicleBtnRollOverHandler(param1:RallySimpleSlotRenderer, param2:IRallySlotVO, param3:* = null):void {
        var _loc4_:ITooltipFormatter = null;
        switch (param1.vehicleBtn.currentState) {
            case CSVehicleButton.CHOOSE_VEHICLE:
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_SELECTVEHICLE);
                break;
            case CSVehicleButton.DEFAULT_STATE:
                App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
                break;
            case CSVehicleButton.SELECTED_VEHICLE:
                if (param3 && param3.type == CSVehicleButton.ALERT_DATA_TYPE) {
                    _loc4_ = App.toolTipMgr.getNewFormatter();
                    _loc4_.addHeader(param3.state);
                    _loc4_.addBody(TOOLTIPS.FORTIFICATION_SORTIE_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY, true);
                    App.toolTipMgr.showComplex(_loc4_.make());
                }
                else if (param2.player) {
                    if (!UserTags.isCurrentPlayer(param2.player.tags)) {
                        App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_VEHICLE);
                    }
                    else if (param2.playerStatus != PlayerStatus.STATUS_READY) {
                        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_CHANGEVEHICLE);
                    }
                    else {
                        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_CANCELREADY);
                    }
                }
                break;
            default:
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT, null, param1.index, param2.rallyIdx);
        }
    }

    override public function initControlsState(param1:IRallySimpleSlotRenderer):void {
        var _loc3_:RallySimpleSlotRenderer = null;
        var _loc4_:* = false;
        var _loc5_:SortieSimpleSlot = null;
        var _loc6_:SortieSlot = null;
        var _loc7_:RallySlotRenderer = null;
        var _loc8_:RallyLockableSlotRenderer = null;
        var _loc9_:LegionariesSortieSlot = null;
        super.initControlsState(param1);
        var _loc2_:Boolean = false;
        if (param1 is RallySimpleSlotRenderer) {
            _loc2_ = true;
            _loc3_ = RallySimpleSlotRenderer(param1);
            _loc4_ = param1.index == 0;
            _loc3_.orderNo.visible = !_loc4_;
            _loc3_.commander.visible = false;
        }
        if (param1 is SortieSimpleSlot) {
            _loc5_ = SortieSimpleSlot(param1);
            _loc2_ = true;
            _loc5_.commander.visible = _loc4_;
            _loc5_.lockBackground.visible = true;
        }
        if (param1 is SortieSlot) {
            _loc2_ = true;
            _loc6_ = SortieSlot(param1);
            _loc6_.commander.visible = _loc4_;
        }
        if (param1 is RallySlotRenderer) {
            _loc2_ = true;
            _loc7_ = RallySlotRenderer(param1);
            _loc7_.removeBtn.visible = false;
            _loc7_.selfBg.visible = false;
        }
        if (param1 is RallyLockableSlotRenderer) {
            _loc2_ = true;
            _loc8_ = RallyLockableSlotRenderer(param1);
            _loc8_.lockBackground.visible = true;
            _loc8_.setSlotLabelHtmlText(Values.EMPTY_STR);
        }
        if (param1 is LegionariesSortieSlot) {
            _loc2_ = true;
            _loc9_ = LegionariesSortieSlot(param1);
            _loc9_.legionariesIcon.visible = false;
        }
        if (!_loc2_) {
            App.utils.asserter.assert(false, "Wrong slot type passed \'" + getQualifiedClassName(param1));
        }
    }

    override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null):void {
        var _loc6_:LegionariesSortieSlot = null;
        var _loc7_:RallySimpleSlotRenderer = null;
        var _loc8_:SortieSlot = null;
        var _loc5_:Boolean = false;
        if (param2 is LegionariesSortieSlot) {
            _loc5_ = true;
            _loc6_ = LegionariesSortieSlot(param2);
            switch (param1) {
                case _loc6_.legionariesIcon:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_TEAMSECTION);
                    return;
            }
        }
        super.onControlRollOver(param1, param2, param3, param4);
        if (param2 is RallySimpleSlotRenderer) {
            _loc5_ = true;
            _loc7_ = RallySimpleSlotRenderer(param2);
            switch (param1) {
                case _loc7_.commander:
                    onCommanderRollOverHandler();
                    break;
                case _loc7_.statusIndicator:
                    onStatusIndicatorRollOverHandler(_loc7_);
                    break;
                case _loc7_.slotLabel:
                    onSlotLabelRollOverHandler(param3);
                    break;
                case _loc7_.takePlaceFirstTimeBtn:
                    onTakePlaceFirstTimeBtnRollOverHandler();
                    break;
                case _loc7_.takePlaceBtn:
                    onTakePlaceBtnRollOverHandler();
                    break;
                case _loc7_.vehicleBtn:
                    onVehicleBtnRollOverHandler(_loc7_, param3, param4);
            }
        }
        if (param2 is SortieSlot) {
            _loc5_ = true;
            _loc8_ = SortieSlot(param2);
            if (param1 == _loc8_.removeBtn && _loc8_.removeBtn.icon == ButtonIconTextTransparent.ICON_CROSS) {
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_REMOVEBTN);
            }
        }
        if (!_loc5_) {
            App.utils.asserter.assert(false, "Wrong slot type passed \'" + getQualifiedClassName(param2));
        }
    }

    override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO):void {
        var _loc4_:SortieSimpleSlot = null;
        var _loc5_:RallyLockableSlotRenderer = null;
        var _loc6_:RallySimpleSlotRenderer = null;
        var _loc7_:SortieSlot = null;
        var _loc8_:RallySlotVO = null;
        var _loc9_:Boolean = false;
        if (!param2) {
            return;
        }
        super.updateComponents(param1, param2);
        var _loc3_:Boolean = false;
        if (param1 is SortieSimpleSlot) {
            _loc3_ = true;
            _loc4_ = SortieSimpleSlot(param1);
            _loc4_.lockBackground.visible = false;
        }
        if (param1 is RallyLockableSlotRenderer) {
            _loc3_ = true;
            _loc5_ = RallyLockableSlotRenderer(param1);
            _loc5_.lockBackground.visible = false;
        }
        if (param1 is RallySimpleSlotRenderer) {
            _loc3_ = true;
            _loc6_ = RallySimpleSlotRenderer(param1);
            _loc6_.commander.visible = param1.index == 0;
        }
        if (param1 is SortieSlot) {
            _loc3_ = true;
            _loc7_ = SortieSlot(param1);
            _loc8_ = RallySlotVO(param2);
            _loc7_.setStatus(_loc8_.playerStatus);
            if (!_loc8_.isClosed) {
                if (_loc8_.isCommanderState) {
                    if (_loc8_.player) {
                        updateSlotRemoveBtn(_loc7_, _loc7_.index > 0, ButtonIconTextTransparent.ICON_CROSS, this._removeBtnProps);
                    }
                    else {
                        _loc7_.removeBtn.visible = false;
                    }
                }
                else {
                    _loc9_ = _loc8_.player && UserTags.isCurrentPlayer(_loc8_.player.tags);
                    _loc7_.removeBtn.visible = _loc9_;
                    if (_loc9_) {
                        updateSlotRemoveBtn(_loc7_, _loc9_, ButtonIconTextTransparent.ICON_CROSS, this._removeBtnProps);
                    }
                }
                _loc7_.statusIndicator.visible = true;
            }
            else {
                updateSlotRemoveBtn(_loc7_, _loc8_.isCommanderState, ButtonIconTextTransparent.ICON_NO_ICON, this._lockBtnProps, CYBERSPORT.WINDOW_UNIT_UNLOCKSLOT);
                _loc7_.statusIndicator.visible = false;
            }
            if (_loc8_.player) {
                _loc7_.setSpeakers(_loc8_.player.isPlayerSpeaking, true);
                _loc7_.selfBg.visible = UserTags.isCurrentPlayer(_loc8_.player.tags);
            }
            else {
                _loc7_.selfBg.visible = false;
                _loc7_.setSpeakers(false, true);
            }
            _loc7_.updateVoiceWave();
        }
        if (!_loc3_) {
            App.utils.asserter.assert(false, "Wrong slot type passed \'" + getQualifiedClassName(param1));
        }
    }

    override protected function isShowSlotRestrictions(param1:RallySimpleSlotRenderer, param2:IRallySlotVO):Boolean {
        return false;
    }

    override protected function onDispose():void {
        this._removeBtnProps = null;
        this._lockBtnProps = null;
        super.onDispose();
    }
}
}

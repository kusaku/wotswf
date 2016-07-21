package net.wg.gui.prebattle.squads.fallout {
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.managers.impl.ToolTipParams;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.prebattle.squads.SquadTeamSectionBase;
import net.wg.gui.prebattle.squads.fallout.vo.FalloutRallySlotVO;
import net.wg.gui.rally.controls.RallyInvalidationType;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
import net.wg.gui.rally.interfaces.IRallySlotVO;

import org.idmedia.as3commons.util.StringUtils;

public class FalloutTeamSection extends SquadTeamSectionBase {

    public var teamVehiclesInfoIcon:InfoIcon;

    private var _tooltipId:String;

    private var _toolTipParams:ToolTipParams;

    public function FalloutTeamSection() {
        super();
    }

    override public function setVehiclesInfoTooltipId(param1:String, param2:Object, param3:Object):void {
        this._tooltipId = param1;
        this.teamVehiclesInfoIcon.visible = this._tooltipId.length > 0;
        if (!StringUtils.isEmpty(this._tooltipId)) {
            if (this._toolTipParams != null) {
                this._toolTipParams.dispose();
            }
            this._toolTipParams = new ToolTipParams(param2, param3);
        }
    }

    override protected function getSlotsUI():Vector.<IRallySimpleSlotRenderer> {
        var _loc2_:IRallySimpleSlotRenderer = null;
        var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[slot0, slot1, slot2];
        var _loc3_:ISlotRendererHelper = new FalloutSlotHelper();
        for each(_loc2_ in _loc1_) {
            _loc2_.helper = _loc3_;
        }
        return _loc1_;
    }

    override protected function getSlotVO(param1:Object):IRallySlotVO {
        return new FalloutRallySlotVO(param1);
    }

    override protected function updateComponents():void {
        var _loc2_:IRallySimpleSlotRenderer = null;
        var _loc3_:FalloutSlotRenderer = null;
        var _loc1_:Array = !!rallyData ? rallyData.slotsArray : null;
        for each(_loc2_ in _slotsUi) {
            _loc2_.slotData = !!_loc1_ ? _loc1_[_slotsUi.indexOf(_loc2_)] : null;
            _loc3_ = _loc2_ as FalloutSlotRenderer;
            App.utils.asserter.assertNotNull(_loc3_, "falloutSlot" + Errors.CANT_NULL);
        }
    }

    override protected function onDispose():void {
        this.teamVehiclesInfoIcon.removeEventListener(MouseEvent.ROLL_OVER, this.teamVehiclesInfoIconRollOverHandler);
        this.teamVehiclesInfoIcon.removeEventListener(MouseEvent.ROLL_OUT, this.teamVehiclesInfoIconRollOutHandler);
        this.teamVehiclesInfoIcon.dispose();
        this.teamVehiclesInfoIcon = null;
        if (this._toolTipParams) {
            this._toolTipParams.dispose();
            this._toolTipParams = null;
        }
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.teamVehiclesInfoIcon.addEventListener(MouseEvent.ROLL_OVER, this.teamVehiclesInfoIconRollOverHandler);
        this.teamVehiclesInfoIcon.addEventListener(MouseEvent.ROLL_OUT, this.teamVehiclesInfoIconRollOutHandler);
    }

    override protected function draw():void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc1_:Boolean = isInvalid(RallyInvalidationType.VEHICLE_LABEL);
        super.draw();
        if (_loc1_) {
            _loc2_ = 5;
            _loc3_ = 9;
            App.utils.commons.moveDsiplObjToEndOfText(this.teamVehiclesInfoIcon, lblTeamVehicles, _loc2_, _loc3_);
        }
    }

    private function teamVehiclesInfoIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function teamVehiclesInfoIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplexWithParams(this._tooltipId, this._toolTipParams);
    }
}
}

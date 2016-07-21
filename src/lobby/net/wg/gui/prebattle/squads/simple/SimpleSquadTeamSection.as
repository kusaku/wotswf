package net.wg.gui.prebattle.squads.simple {
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.prebattle.squads.SquadTeamSectionBase;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
import net.wg.gui.rally.controls.RallyInvalidationType;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.gfx.TextFieldEx;

public class SimpleSquadTeamSection extends SquadTeamSectionBase {

    public var infoIcon:InfoIcon = null;

    public var headerIcon:UILoaderAlt = null;

    public var headerMessage:TextField = null;

    private var _sectionData:SimpleSquadTeamSectionVO = null;

    private var _tooltipMgr:ITooltipMgr;

    public function SimpleSquadTeamSection() {
        super();
        lblTeamVehicles.autoSize = TextFieldAutoSize.LEFT;
        TextFieldEx.setVerticalAlign(this.headerMessage, TextFieldEx.VALIGN_CENTER);
    }

    override protected function configUI():void {
        super.configUI();
        vehiclesLabel = MESSENGER.DIALOGS_SQUADCHANNEL_VEHICLESLBL;
        this.infoIcon.addEventListener(MouseEvent.ROLL_OVER, this.onInfoIconRollOverHandler);
        this.infoIcon.addEventListener(MouseEvent.ROLL_OUT, this.onInfoIconRollOutHandler);
        this._tooltipMgr = App.toolTipMgr;
    }

    override protected function getSlotVO(param1:Object):IRallySlotVO {
        return new SimpleSquadRallySlotVO(param1);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(RallyInvalidationType.VEHICLE_LABEL) && this.infoIcon.visible) {
            this.infoIcon.x = lblTeamVehicles.x + lblTeamVehicles.width ^ 0;
        }
    }

    override protected function getSlotsUI():Vector.<IRallySimpleSlotRenderer> {
        var _loc2_:IRallySimpleSlotRenderer = null;
        var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[slot0, slot1, slot2];
        var _loc3_:ISlotRendererHelper = new SimpleSquadSlotHelper();
        for each(_loc2_ in _loc1_) {
            _loc2_.helper = _loc3_;
        }
        return _loc1_;
    }

    override protected function onDispose():void {
        lblTeamVehicles.removeEventListener(MouseEvent.ROLL_OVER, this.onLabelRollOverHandler);
        lblTeamVehicles.removeEventListener(MouseEvent.ROLL_OUT, this.onLabelRollOutHandler);
        this._sectionData = null;
        this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onInfoIconRollOverHandler);
        this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onInfoIconRollOutHandler);
        this.infoIcon.dispose();
        this.infoIcon = null;
        this.headerIcon.removeEventListener(UILoaderEvent.COMPLETE, this.onHeaderIconCompleteHandler);
        this.headerIcon.dispose();
        this.headerIcon = null;
        this.headerMessage = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function updateComponents():void {
        var _loc2_:IRallySimpleSlotRenderer = null;
        var _loc3_:SimpleSquadSlotRenderer = null;
        var _loc1_:Array = !!rallyData ? rallyData.slotsArray : null;
        for each(_loc2_ in _slotsUi) {
            _loc2_.slotData = !!_loc1_ ? _loc1_[_slotsUi.indexOf(_loc2_)] : null;
            _loc3_ = _loc2_ as SimpleSquadSlotRenderer;
            App.utils.asserter.assertNotNull(_loc3_, "simpleSquadSlot" + Errors.CANT_NULL);
        }
    }

    public function setSimpleSquadTeamSectionVO(param1:SimpleSquadTeamSectionVO):void {
        this._sectionData = param1;
        this.infoIcon.visible = this._sectionData.isVisibleInfoIcon;
        if (this.infoIcon.visible) {
            lblTeamVehicles.addEventListener(MouseEvent.ROLL_OVER, this.onLabelRollOverHandler);
            lblTeamVehicles.addEventListener(MouseEvent.ROLL_OUT, this.onLabelRollOutHandler);
        }
        this.headerIcon.visible = this._sectionData.isVisibleHeaderIcon;
        this.headerIcon.addEventListener(UILoaderEvent.COMPLETE, this.onHeaderIconCompleteHandler);
        this.headerIcon.source = this._sectionData.headerIconSource;
        this.headerMessage.htmlText = this._sectionData.headerMessageText;
        this.headerMessage.visible = this._sectionData.isVisibleHeaderMessage;
    }

    private function onInfoIconRollOverHandler(param1:MouseEvent):void {
        if (this._sectionData.infoIconTooltipType == TOOLTIPS_CONSTANTS.SPECIAL) {
            this._tooltipMgr.showSpecial(this._sectionData.infoIconTooltip, null);
        }
        else {
            this._tooltipMgr.showComplex(this._sectionData.infoIconTooltip);
        }
    }

    private function onInfoIconRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onLabelRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onLabelRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(this._sectionData.infoIconTooltip);
    }

    private function hideTooltip():void {
        this._tooltipMgr.hide();
    }

    private function onHeaderIconCompleteHandler(param1:UILoaderEvent):void {
        this.headerIcon.x = this.width - this.headerIcon.width - this._sectionData.icoXPadding ^ 0;
        this.headerIcon.y = this._sectionData.icoYPadding ^ 0;
    }
}
}

package net.wg.gui.lobby.fortifications.battleRoom {
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
import net.wg.gui.rally.controls.RallyInvalidationType;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.gui.rally.views.room.BaseTeamSection;
import net.wg.infrastructure.base.meta.IFortRoomMeta;
import net.wg.infrastructure.base.meta.impl.FortRoomMeta;
import net.wg.infrastructure.managers.ITooltipFormatter;

import scaleform.clik.events.ButtonEvent;

public class FortRoomView extends FortRoomMeta implements IFortRoomMeta {

    private static const CHANGE_UNIT_STATE:int = 24;

    private static const SET_PLAYER_STATE:int = 6;

    private static const DIVISION_INFO_GAP_LEFT:int = 0;

    private static const DIVISION_INFO_GAP_RIGHT:int = 5;

    private static const LEGIONARIES_TEXT_GAP:int = 15;

    private static const LEGIONARIES_TEXT_WIDTH_GAP:int = 4;

    private static const LEGIONARIES_COUNT_STATE_INV:String = "legionariesCount";

    public var changeDivisionBtn:SoundButtonEx = null;

    public var filterInfo:InfoIcon = null;

    public var divisionInfoText:TextField = null;

    public var tooltipMessage:TextField = null;

    public var legionariesCount:TextField = null;

    private var _legionariesCountTooltipBody:String = "";

    public function FortRoomView() {
        super();
        this.tooltipMessage.htmlText = FORTIFICATIONS.FORTBATTLEROOM_LEGIONARIESTOOLTIPMSG;
        this.tooltipMessage.visible = false;
        this.legionariesCount.visible = false;
        ordersBg.visible = false;
    }

    override protected function getRallyVO(param1:Object):IRallyVO {
        return new LegionariesSortieVO(param1);
    }

    override protected function getTitleStr():String {
        return FORTIFICATIONS.SORTIE_ROOM_TITLE;
    }

    override protected function getRallyViewAlias():String {
        return FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_VIEW_UI;
    }

    override protected function coolDownControls(param1:Boolean, param2:int):void {
        if (param2 == CHANGE_UNIT_STATE) {
            IChatSectionWithDescription(chatSection).enableEditCommitButton(param1);
        }
        else if (param2 == SET_PLAYER_STATE) {
            teamSection.enableFightButton(param1);
        }
        super.coolDownControls(param1, param2);
    }

    override protected function configUI():void {
        super.configUI();
        this.changeDivisionBtn.visible = false;
        titleLbl.text = FORTIFICATIONS.SORTIE_ROOM_TITLE;
        descrLbl.text = FORTIFICATIONS.SORTIE_ROOM_DESCRIPTION;
        backBtn.label = FORTIFICATIONS.SORTIE_ROOM_LEAVEBTN;
        this.changeDivisionBtn.label = FORTIFICATIONS.SORTIE_ROOM_CHANGEDIVISION;
        this.changeDivisionBtn.addEventListener(ButtonEvent.CLICK, this.onChangeDivisionClickHandler);
        this.changeDivisionBtn.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.changeDivisionBtn.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.legionariesCount.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.legionariesCount.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.filterInfo.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.filterInfo.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.divisionInfoText.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.divisionInfoText.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
    }

    override protected function onDispose():void {
        this.changeDivisionBtn.removeEventListener(ButtonEvent.CLICK, this.onChangeDivisionClickHandler);
        this.changeDivisionBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.changeDivisionBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.changeDivisionBtn.dispose();
        this.changeDivisionBtn = null;
        this.filterInfo.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.filterInfo.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.filterInfo.dispose();
        this.filterInfo = null;
        this.legionariesCount.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.legionariesCount.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.legionariesCount = null;
        this.divisionInfoText.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.divisionInfoText.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.divisionInfoText = null;
        this.tooltipMessage = null;
        super.onDispose();
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        onControlRollOut();
    }

    override protected function registerOrdersPanel():void {
        registerFlashComponentS(ordersPanel, FORTIFICATION_ALIASES.FORT_SORTIE_ORDERS_PANEL_COMPONENT_ALIAS);
    }

    override protected function draw():void {
        var _loc1_:BaseTeamSection = null;
        var _loc2_:Point = null;
        var _loc3_:Point = null;
        super.draw();
        if (isInvalid(RallyInvalidationType.RALLY_DATA) && rallyData) {
            this.divisionInfoText.htmlText = SortieVO(rallyData).divisionLbl;
            this.divisionInfoText.width = this.divisionInfoText.textWidth;
            if (this.changeDivisionBtn != null) {
                this.changeDivisionBtn.visible = rallyData.isCommander;
            }
            this.layoutDivisionInfo();
        }
        if (isInvalid(LEGIONARIES_COUNT_STATE_INV)) {
            _loc1_ = BaseTeamSection(teamSection);
            _loc1_.validateNow();
            _loc2_ = new Point(_loc1_.lblTeamMembers.x, _loc1_.lblTeamMembers.y);
            _loc3_ = globalToLocal(_loc1_.localToGlobal(_loc2_));
            this.legionariesCount.x = _loc3_.x + _loc1_.lblTeamMembers.textWidth + LEGIONARIES_TEXT_GAP;
            if (_loc1_.actionButtonData != null) {
                tabChildren = focusable = !_loc1_.actionButtonData.isReady;
            }
        }
    }

    public function as_setChangeDivisionButtonEnabled(param1:Boolean):void {
        this.changeDivisionBtn.enabled = param1;
    }

    public function as_showLegionariesCount(param1:Boolean, param2:String, param3:String):void {
        this.legionariesCount.visible = param1;
        this.legionariesCount.htmlText = param2;
        this.legionariesCount.width = this.legionariesCount.textWidth + LEGIONARIES_TEXT_WIDTH_GAP;
        this._legionariesCountTooltipBody = param3;
        invalidate(LEGIONARIES_COUNT_STATE_INV);
    }

    public function as_showLegionariesToolTip(param1:Boolean):void {
        if (this.tooltipMessage.visible != param1) {
            this.tooltipMessage.visible = param1;
        }
    }

    public function as_showOrdersBg(param1:Boolean):void {
        ordersBg.visible = param1;
    }

    private function layoutDivisionInfo():void {
        var _loc1_:Number = NaN;
        if (this.filterInfo != null) {
            _loc1_ = this.changeDivisionBtn.x + (!!rallyData.isCommander ? -DIVISION_INFO_GAP_RIGHT : this.changeDivisionBtn.width);
            this.filterInfo.x = _loc1_ - this.filterInfo.width;
            this.divisionInfoText.x = this.filterInfo.x - DIVISION_INFO_GAP_LEFT - this.divisionInfoText.width;
        }
    }

    override protected function onToggleReadyStateRequest(param1:RallyViewsEvent):void {
        super.onToggleReadyStateRequest(param1);
    }

    override protected function onChooseVehicleRequest(param1:RallyViewsEvent):void {
        super.onChooseVehicleRequest(param1);
    }

    private function onControlRollOverHandler(param1:MouseEvent):void {
        this.controlRollOverPerformer(param1);
    }

    override protected function controlRollOverPerformer(param1:MouseEvent = null):void {
        var _loc2_:ITooltipFormatter = null;
        super.controlRollOverPerformer(param1);
        if (param1 == null) {
            return;
        }
        switch (param1.target) {
            case backBtn:
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_LEAVEBTN);
                break;
            case this.changeDivisionBtn:
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_CHANGEDIVISION);
                break;
            case this.filterInfo:
            case this.divisionInfoText:
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SORTIE_DIVISION, null);
                break;
            case this.legionariesCount:
                _loc2_ = App.toolTipMgr.getNewFormatter();
                _loc2_.addHeader(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_LEGIONARIESCOUNT_HEADER, true);
                _loc2_.addBody(this._legionariesCountTooltipBody);
                App.toolTipMgr.showComplex(_loc2_.make());
        }
    }

    private function onChangeDivisionClickHandler(param1:ButtonEvent):void {
        showChangeDivisionWindowS();
    }
}
}

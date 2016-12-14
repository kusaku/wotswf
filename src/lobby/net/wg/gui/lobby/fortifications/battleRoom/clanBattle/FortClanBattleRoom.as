package net.wg.gui.lobby.fortifications.battleRoom.clanBattle {
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.ConnectedDirctns;
import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.base.meta.IFortClanBattleRoomMeta;
import net.wg.infrastructure.base.meta.impl.FortClanBattleRoomMeta;

import org.idmedia.as3commons.util.StringUtils;

public class FortClanBattleRoom extends FortClanBattleRoomMeta implements IFortClanBattleRoomMeta {

    private static const CHANGE_UNIT_STATE:int = 24;

    private static const SET_PLAYER_STATE:int = 6;

    public var mineClanName:TextField = null;

    public var enemyClanName:TextField = null;

    public var mineClanIcon:ClanEmblem = null;

    public var enemyClanIcon:ClanEmblem = null;

    public var mineReadyStatus:IndicationOfStatus = null;

    public var enemyReadyStatus:IndicationOfStatus = null;

    public var timer:IClanBattleTimer = null;

    public var headerDescr:TextField = null;

    public var ordersDisabled:TextField = null;

    public var connectedDirections:ConnectedDirctns;

    private var _model:FortClanBattleRoomVO = null;

    public function FortClanBattleRoom() {
        super();
    }

    override protected function setBattleRoomData(param1:FortClanBattleRoomVO):void {
        this._model = param1;
        this.headerDescr.htmlText = param1.headerDescr;
        this.mineClanName.htmlText = param1.mineClanName;
        this.enemyClanName.htmlText = param1.enemyClanName;
        ordersBg.visible = param1.isOrdersBgVisible;
        this.ordersDisabled.visible = StringUtils.isNotEmpty(param1.ordersDisabledMessage);
        if (this.ordersDisabled.visible) {
            this.ordersDisabled.htmlText = param1.ordersDisabledMessage;
        }
    }

    override protected function setTimerDelta(param1:ClanBattleTimerVO):void {
        this.timer.setData(param1);
    }

    override protected function updateDirections(param1:ConnectedDirectionsVO):void {
        this.connectedDirections.setData(param1);
    }

    override protected function configUI():void {
        super.configUI();
        backBtn.tooltip = TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_LEAVEBTN;
        this.headerDescr.autoSize = TextFieldAutoSize.RIGHT;
        this.timer.addEventListener(ClanBattleTimerEvent.ALERT_TICK, this.onTimerAlertTickHandler);
        this.headerDescr.addEventListener(MouseEvent.ROLL_OVER, this.onHeaderDescrRollOverHandler);
        this.headerDescr.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.ordersDisabled.addEventListener(MouseEvent.ROLL_OVER, this.onOrdersDisabledRollOverHandler);
        this.ordersDisabled.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.connectedDirections.connectionIcon.useOverlay = false;
        this.connectedDirections.leftDirection.alwaysShowLevels = true;
        this.connectedDirections.rightDirection.alwaysShowLevels = true;
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        onControlRollOut();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        backBtn.label = FORTIFICATIONS.SORTIE_ROOM_LEAVEBTN;
    }

    override protected function registerOrdersPanel():void {
        registerFlashComponentS(ordersPanel, FORTIFICATION_ALIASES.FORT_BATTLEROOM_ORDERS_PANEL_COMPONENT_ALIAS);
    }

    override protected function onDispose():void {
        this.timer.removeEventListener(ClanBattleTimerEvent.ALERT_TICK, this.onTimerAlertTickHandler);
        this.timer = null;
        this.headerDescr.removeEventListener(MouseEvent.ROLL_OVER, this.onHeaderDescrRollOverHandler);
        this.headerDescr.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.headerDescr = null;
        this.ordersDisabled.removeEventListener(MouseEvent.ROLL_OVER, this.onOrdersDisabledRollOverHandler);
        this.ordersDisabled.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.ordersDisabled = null;
        this.mineClanIcon.dispose();
        this.mineClanIcon = null;
        this.enemyClanIcon.dispose();
        this.enemyClanIcon = null;
        this.connectedDirections.dispose();
        this.connectedDirections = null;
        this._model = null;
        this.mineReadyStatus.dispose();
        this.mineReadyStatus = null;
        this.enemyReadyStatus.dispose();
        this.enemyReadyStatus = null;
        this.mineClanName = null;
        this.enemyClanName = null;
        super.onDispose();
    }

    override protected function getRallyViewAlias():String {
        return FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI;
    }

    override protected function getTitleStr():String {
        return FORTIFICATIONS.SORTIE_ROOM_TITLE;
    }

    override protected function getIRallyVO(param1:Object):IRallyVO {
        return new SortieVO(param1);
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

    public function as_setEnemyClanIcon(param1:String):void {
        if (!_baseDisposed && this.enemyClanIcon && StringUtils.isNotEmpty(param1)) {
            this.enemyClanIcon.setImage(param1);
        }
    }

    public function as_setMineClanIcon(param1:String):void {
        if (!_baseDisposed && this.mineClanIcon && StringUtils.isNotEmpty(param1)) {
            this.mineClanIcon.setImage(param1);
        }
    }

    public function as_updateReadyStatus(param1:Boolean, param2:Boolean):void {
        this.mineReadyStatus.status = this.getIndicatorStatus(param1);
        this.enemyReadyStatus.status = this.getIndicatorStatus(param2);
    }

    public function as_updateTeamHeaderText(param1:String):void {
        FortClanBattleTeamSection(teamSection).updateTeamHeaderText(param1);
    }

    private function getIndicatorStatus(param1:Boolean):String {
        return !!param1 ? IndicationOfStatus.STATUS_READY : IndicationOfStatus.STATUS_NORMAL;
    }

    private function onTimerAlertTickHandler(param1:ClanBattleTimerEvent):void {
        onTimerAlertS();
    }

    private function onHeaderDescrRollOverHandler(param1:MouseEvent):void {
        if (this._model && this._model.mapID != -1) {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.MAP, null, this._model.mapID);
        }
    }

    private function onOrdersDisabledRollOverHandler(param1:MouseEvent):void {
        if (this._model && StringUtils.isNotEmpty(this._model.ordersDisabledTooltip)) {
            App.toolTipMgr.showComplex(this._model.ordersDisabledTooltip);
        }
    }
}
}

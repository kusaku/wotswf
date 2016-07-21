package net.wg.gui.prebattle.squads.simple {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.VO.ExtendedUserVO;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
import net.wg.gui.rally.controls.VoiceRallySlotRenderer;

import scaleform.gfx.TextFieldEx;

public class SimpleSquadSlotRenderer extends VoiceRallySlotRenderer {

    public var playerMessage:TextField = null;

    public var inviteIndicator:InviteIndicator = null;

    public var notificationInfoIcon:UILoaderAlt = null;

    private var _notificationIconTooltip:String = null;

    public function SimpleSquadSlotRenderer() {
        super();
        this.notificationInfoIcon.visible = false;
        TextFieldEx.setVerticalAlign(this.playerMessage, TextFieldEx.VALIGN_CENTER);
    }

    override public function setStatus(param1:int):String {
        var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
        if (param1 < STATUSES.length && param1) {
            _loc2_ = STATUSES[param1];
        }
        statusIndicator.status = _loc2_;
        return _loc2_;
    }

    override public function updateComponents():void {
        super.updateComponents();
        var _loc1_:SimpleSquadRallySlotVO = SimpleSquadRallySlotVO(slotData);
        var _loc2_:Boolean = _loc1_.isVisibleAdtMsg;
        if (this.playerMessage.visible != _loc2_) {
            this.playerMessage.visible = _loc2_;
        }
        if (_loc2_) {
            this.playerMessage.htmlText = _loc1_.additionalMsg;
        }
        var _loc3_:String = _loc1_.slotNotificationIcon;
        if (_loc3_ != Values.EMPTY_STR) {
            this.notificationInfoIcon.source = _loc3_;
            this._notificationIconTooltip = _loc1_.slotNotificationIconTooltip;
            this.notificationInfoIcon.visible = true;
            this.addTooltipListeners();
        }
        else {
            this._notificationIconTooltip = Values.EMPTY_STR;
            this.notificationInfoIcon.visible = false;
            this.removeTooltipListeners();
        }
    }

    override protected function configUI():void {
        super.configUI();
        addTooltipSubscriber(statusIndicator);
        addTooltipSubscriber(commander);
        commander.visible = false;
    }

    override protected function onDispose():void {
        removeTooltipSubscriber(statusIndicator);
        this.playerMessage = null;
        this.inviteIndicator.dispose();
        this.inviteIndicator = null;
        removeTooltipSubscriber(commander);
        this.removeTooltipListeners();
        this.notificationInfoIcon.dispose();
        this.notificationInfoIcon = null;
        super.onDispose();
    }

    private function removeTooltipListeners():void {
        this.notificationInfoIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onNotificationIconRollHandler);
        this.notificationInfoIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onNotificationIconRollHandler);
    }

    private function addTooltipListeners():void {
        this.notificationInfoIcon.addEventListener(MouseEvent.ROLL_OVER, this.onNotificationIconRollHandler);
        this.notificationInfoIcon.addEventListener(MouseEvent.ROLL_OUT, this.onNotificationIconRollHandler);
    }

    override protected function onContextMenuAreaClick(param1:MouseEvent):void {
        var _loc2_:ExtendedUserVO = !!slotData ? slotData.player as ExtendedUserVO : null;
        if (_loc2_ && !UserTags.isCurrentPlayer(_loc2_.tags) && _loc2_.accID > -1) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.UNIT_USER, this, _loc2_);
        }
    }

    private function onNotificationIconRollHandler(param1:MouseEvent):void {
        if (param1.type == MouseEvent.ROLL_OVER && this._notificationIconTooltip != Values.EMPTY_STR) {
            App.toolTipMgr.showComplex(this._notificationIconTooltip);
        }
        else if (param1.type == MouseEvent.ROLL_OUT) {
            App.toolTipMgr.hide();
        }
    }
}
}

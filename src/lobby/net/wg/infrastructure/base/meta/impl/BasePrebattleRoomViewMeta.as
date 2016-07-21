package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.rally.AbstractRallyView;

public class BasePrebattleRoomViewMeta extends AbstractRallyView {

    public var requestToReady:Function;

    public var requestToLeave:Function;

    public var showPrebattleSendInvitesWindow:Function;

    public var canSendInvite:Function;

    public var canKickPlayer:Function;

    public var isPlayerReady:Function;

    public var isPlayerCreator:Function;

    public var isReadyBtnEnabled:Function;

    public var isLeaveBtnEnabled:Function;

    public var getClientID:Function;

    public function BasePrebattleRoomViewMeta() {
        super();
    }

    public function requestToReadyS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.requestToReady, "requestToReady" + Errors.CANT_NULL);
        this.requestToReady(param1);
    }

    public function requestToLeaveS():void {
        App.utils.asserter.assertNotNull(this.requestToLeave, "requestToLeave" + Errors.CANT_NULL);
        this.requestToLeave();
    }

    public function showPrebattleSendInvitesWindowS():void {
        App.utils.asserter.assertNotNull(this.showPrebattleSendInvitesWindow, "showPrebattleSendInvitesWindow" + Errors.CANT_NULL);
        this.showPrebattleSendInvitesWindow();
    }

    public function canSendInviteS():Boolean {
        App.utils.asserter.assertNotNull(this.canSendInvite, "canSendInvite" + Errors.CANT_NULL);
        return this.canSendInvite();
    }

    public function canKickPlayerS():Boolean {
        App.utils.asserter.assertNotNull(this.canKickPlayer, "canKickPlayer" + Errors.CANT_NULL);
        return this.canKickPlayer();
    }

    public function isPlayerReadyS():Boolean {
        App.utils.asserter.assertNotNull(this.isPlayerReady, "isPlayerReady" + Errors.CANT_NULL);
        return this.isPlayerReady();
    }

    public function isPlayerCreatorS():Boolean {
        App.utils.asserter.assertNotNull(this.isPlayerCreator, "isPlayerCreator" + Errors.CANT_NULL);
        return this.isPlayerCreator();
    }

    public function isReadyBtnEnabledS():Boolean {
        App.utils.asserter.assertNotNull(this.isReadyBtnEnabled, "isReadyBtnEnabled" + Errors.CANT_NULL);
        return this.isReadyBtnEnabled();
    }

    public function isLeaveBtnEnabledS():Boolean {
        App.utils.asserter.assertNotNull(this.isLeaveBtnEnabled, "isLeaveBtnEnabled" + Errors.CANT_NULL);
        return this.isLeaveBtnEnabled();
    }

    public function getClientIDS():Number {
        App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + Errors.CANT_NULL);
        return this.getClientID();
    }
}
}
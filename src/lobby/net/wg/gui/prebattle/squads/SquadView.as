package net.wg.gui.prebattle.squads {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.SQUADTYPES;
import net.wg.gui.components.assets.NewIndicator;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.prebattle.squads.ev.SquadViewEvent;
import net.wg.gui.prebattle.squads.fallout.vo.FalloutRallyVO;
import net.wg.gui.prebattle.squads.interfaces.ISquadAbstractFactory;
import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
import net.wg.gui.prebattle.squads.simple.SquadViewHeaderVO;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallyVO;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.base.meta.ISquadViewMeta;
import net.wg.infrastructure.base.meta.impl.SquadViewMeta;

import scaleform.clik.constants.InvalidationType;

public class SquadView extends SquadViewMeta implements ISquadViewMeta {

    private static const ADDITIONAL_INFO_TEAM_SECTION:String = "additionalInfoTeamSection";

    private static const INVITE_BTN_Y_SIMPLE_SQUAD:Number = 280;

    private static const INVITE_BTN_Y_FALLOUT_SQUAD:Number = 375;

    private static const CHAT_SECTION_X_POS:Number = 411;

    private static const CHANGE_READY_STATE:int = 1;

    private static const SET_ES_PLAYER_STATE:int = 35;

    public var battleType:TextField = null;

    public var newIndicator:NewIndicator = null;

    public var inviteBtn:SoundButtonEx = null;

    public var leaveSquadBtn:SoundButtonEx = null;

    private var _isFallout:Boolean = false;

    private var _headerVO:SquadViewHeaderVO;

    private var _data:SimpleSquadTeamSectionVO = null;

    public function SquadView() {
        super();
        this.newIndicator.visible = false;
    }

    override protected function updateRally(param1:IRallyVO):void {
        super.updateRally(param1);
        this.inviteBtn.visible = rallyData.isCommander;
        if (rallyData.isCommander) {
            this.inviteBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_INVITE;
            this.inviteBtn.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_INVITE;
        }
        else {
            this.inviteBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_RECOMMEND;
            this.inviteBtn.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_RECOMMEND;
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.initBattleType();
        dispatchEvent(new SquadViewEvent(SquadViewEvent.ON_POPULATED));
    }

    override protected function configUI():void {
        super.configUI();
        this.leaveSquadBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_DISMISS;
        this.leaveSquadBtn.addEventListener(MouseEvent.CLICK, this.onLeaveBtnClickHandler);
        this.inviteBtn.addEventListener(MouseEvent.CLICK, this.onInviteTbnClickHandler);
    }

    override protected function onDispose():void {
        this._data = null;
        this._headerVO = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        this.leaveSquadBtn.removeEventListener(MouseEvent.CLICK, this.onLeaveBtnClickHandler);
        this.inviteBtn.removeEventListener(MouseEvent.CLICK, this.onInviteTbnClickHandler);
        this.battleType = null;
        this.leaveSquadBtn.dispose();
        this.leaveSquadBtn = null;
        this.inviteBtn.dispose();
        this.inviteBtn = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        super.draw();
        if (this._headerVO && isInvalid(InvalidationType.DATA)) {
            if (this.battleType) {
                this.battleType.htmlText = this._headerVO.battleTypeName;
            }
            _loc1_ = this._headerVO.isNew;
            this.newIndicator.visible = _loc1_;
            if (_loc1_) {
                this.newIndicator.shine();
            }
            this.leaveSquadBtn.tooltip = this._headerVO.leaveBtnTooltip;
        }
        if (this._data && isInvalid(ADDITIONAL_INFO_TEAM_SECTION)) {
            SimpleSquadTeamSection(teamSection).setSimpleSquadTeamSectionVO(this._data);
        }
    }

    override protected function getIRallyVO(param1:Object):IRallyVO {
        if (this._isFallout) {
            return new FalloutRallyVO(param1);
        }
        return new SimpleSquadRallyVO(param1);
    }

    override protected function setSimpleTeamSectionData(param1:SimpleSquadTeamSectionVO):void {
        if (!this._isFallout) {
            this._data = param1;
            invalidate(ADDITIONAL_INFO_TEAM_SECTION);
        }
    }

    override protected function coolDownControls(param1:Boolean, param2:int):void {
        if (param2 == CHANGE_READY_STATE || param2 == SET_ES_PLAYER_STATE) {
            teamSection.enableFightButton(param1);
        }
        super.coolDownControls(param1, param2);
    }

    override protected function updateBattleType(param1:SquadViewHeaderVO):void {
        this._headerVO = param1;
        invalidateData();
    }

    public function as_isFallout(param1:Boolean):void {
        this._isFallout = param1;
    }

    public function as_setCoolDownForReadyButton(param1:Number):void {
        as_setCoolDown(param1, CHANGE_READY_STATE);
    }

    public function as_updateInviteBtnState(param1:Boolean):void {
        this.inviteBtn.enabled = param1;
    }

    private function initBattleType():void {
        var _loc1_:String = !!this._isFallout ? SQUADTYPES.SQUAD_TYPE_FALLOUT : SQUADTYPES.SQUAD_TYPE_SIMPLE;
        this.inviteBtn.y = !!this._isFallout ? Number(INVITE_BTN_Y_FALLOUT_SQUAD) : Number(INVITE_BTN_Y_SIMPLE_SQUAD);
        var _loc2_:ISquadAbstractFactory = new SquadAbstractFactory(_loc1_);
        teamSection = _loc2_.getTeamSection();
        chatSection = _loc2_.getChatSection();
        chatSection.x = CHAT_SECTION_X_POS;
        this.addChildAt(DisplayObject(chatSection), 0);
        this.addChildAt(DisplayObject(teamSection), 0);
        setSize(this.actualWidth, this.actualHeight);
    }

    private function onInviteTbnClickHandler(param1:MouseEvent):void {
        inviteFriendRequestS();
    }

    private function onLeaveBtnClickHandler(param1:MouseEvent):void {
        leaveSquadS();
    }
}
}

package net.wg.gui.cyberSport.views.unit {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.data.CandidatesDataProvider;
import net.wg.gui.rally.views.room.BaseWaitListSection;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;
import scaleform.gfx.TextFieldEx;

public class WaitListSection extends BaseWaitListSection {

    private static const COMMANDER_STATE:Object = {
        "height": 310,
        "paddingTop": 0
    };

    private static const CANDIDATE_STATE:Object = {
        "height": 400,
        "paddingTop": 0
    };

    private static const BOTTOM:String = "bottom";

    public var lblTeamAvailability:TextField;

    public var btnCloseRoom:SoundButtonEx;

    public function WaitListSection() {
        super();
    }

    override protected function initializeDP():void {
        candidatesDP = new CandidatesDataProvider();
    }

    override protected function configUI():void {
        super.configUI();
        lblCandidatesHeader.text = CYBERSPORT.WINDOW_UNIT_CANDIDATES;
        this.lblTeamAvailability.text = Values.EMPTY_STR;
        btnInviteFriend.label = CYBERSPORT.WINDOW_UNIT_INVITEFRIEND;
        this.btnCloseRoom.addEventListener(ButtonEvent.CLICK, this.onChangeStateClick);
        this.lblTeamAvailability.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.lblTeamAvailability.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.btnCloseRoom.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.btnCloseRoom.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        TextFieldEx.setVerticalAlign(this.lblTeamAvailability, BOTTOM);
    }

    override protected function updateControls():void {
        this.lblTeamAvailability.htmlText = !!_rallyData ? _rallyData.statusLbl : Values.EMPTY_STR;
        this.btnCloseRoom.label = _rallyData && _rallyData.statusValue ? CYBERSPORT.WINDOW_UNIT_CLOSEROOM : CYBERSPORT.WINDOW_UNIT_OPENROOM;
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        var _loc2_:Padding = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = this.isCloseRoomButtonVisible();
            this.btnCloseRoom.visible = this.lblTeamAvailability.visible = _loc1_;
            if (_rallyData) {
                _loc2_ = candidates.padding;
                if (_loc1_) {
                    _loc2_.top = COMMANDER_STATE.paddingTop;
                    candidates.height = COMMANDER_STATE.height;
                }
                else {
                    _loc2_.top = CANDIDATE_STATE.paddingTop;
                    candidates.height = CANDIDATE_STATE.height;
                }
            }
        }
    }

    override protected function onDispose():void {
        this.lblTeamAvailability.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.lblTeamAvailability.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.btnCloseRoom.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.btnCloseRoom.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.btnCloseRoom.removeEventListener(ButtonEvent.CLICK, this.onChangeStateClick);
        super.onDispose();
    }

    public function enableCloseButton(param1:Boolean):void {
        if (this.btnCloseRoom) {
            this.btnCloseRoom.enabled = param1;
        }
    }

    protected function isCloseRoomButtonVisible():Boolean {
        return !!_rallyData ? Boolean(_rallyData.isCommander) : false;
    }

    private function showTooltip(param1:String, param2:String):void {
        var _loc3_:String = App.toolTipMgr.getNewFormatter().addHeader(param1, true).addBody(param2, true).make();
        if (_loc3_.length > 0) {
            App.toolTipMgr.showComplex(_loc3_);
        }
    }

    override protected function onControlRollOver(param1:MouseEvent):void {
        var _loc2_:String = null;
        var _loc3_:String = null;
        super.onControlRollOver(param1);
        switch (param1.target) {
            case btnInviteFriend:
                App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_INVITEBTN);
                break;
            case this.btnCloseRoom:
                _loc2_ = TOOLTIPS.CYBERSPORT_UNIT_ACCESS_HEADER;
                _loc3_ = _rallyData && !_rallyData.statusValue ? TOOLTIPS.CYBERSPORT_UNIT_ACCESS_BODYCLOSED : TOOLTIPS.CYBERSPORT_UNIT_ACCESS_BODYOPEN;
                this.showTooltip(_loc2_, _loc3_);
        }
    }

    private function onChangeStateClick(param1:ButtonEvent):void {
        dispatchEvent(new CSComponentEvent(CSComponentEvent.TOGGLE_STATUS_REQUEST));
    }
}
}

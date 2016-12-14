package net.wg.gui.cyberSport.staticFormation.views {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.CYBER_SPORT_HELP_IDS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationUnitViewHeaderVO;
import net.wg.gui.cyberSport.views.events.CSShowHelpEvent;
import net.wg.gui.cyberSport.views.unit.CyberSportTeamSectionBase;
import net.wg.gui.cyberSport.views.unit.StaticFormationUnitViewHeader;
import net.wg.gui.cyberSport.views.unit.StaticFormationWaitListSection;
import net.wg.gui.cyberSport.views.unit.WaitListSection;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.base.meta.IStaticFormationUnitMeta;
import net.wg.infrastructure.base.meta.impl.StaticFormationUnitMeta;

import scaleform.clik.events.ButtonEvent;

public class StaticFormationUnitView extends StaticFormationUnitMeta implements IStaticFormationUnitMeta {

    private static const CHANGE_UNIT_STATE:int = 24;

    private static const SET_PLAYER_STATE:int = 6;

    private static const CLOSE_SLOT:int = 17;

    private static const CHANGE_RATED:int = 33;

    public var teamCardBtn:SoundButtonEx = null;

    public var header:StaticFormationUnitViewHeader = null;

    public var leagueIcon:UILoaderAlt = null;

    public var helpLabel:TextField = null;

    public var helpLink:SoundButtonEx = null;

    private var _staticFormationWaitingListSection:StaticFormationWaitListSection = null;

    private var _staticFormationData:StaticFormationUnitViewHeaderVO = null;

    public function StaticFormationUnitView() {
        super();
        this._staticFormationWaitingListSection = StaticFormationWaitListSection(waitingListSection);
    }

    private static function onLeagueIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST, this.onToggleStatusRequestHandler);
        this.leagueIcon.addEventListener(MouseEvent.MOUSE_OVER, this.onLeagueIconRollOverHandler);
        this.leagueIcon.addEventListener(MouseEvent.MOUSE_OUT, onLeagueIconRollOutHandler);
        this.helpLabel.text = MENU.INGAME_MENU_BUTTONS_HELP;
        backBtn.label = CYBERSPORT.WINDOW_UNIT_LEAVE;
        this.teamCardBtn.label = CYBERSPORT.STATICFORMATION_LADDERVIEW_SHOWFORMATIONPROFILEBTN_TEXT;
        this.header.modeChangeBtn.addEventListener(ButtonEvent.CLICK, this.onModeChangeBtnSelectHandler);
        this.teamCardBtn.addEventListener(ButtonEvent.CLICK, this.onTeamCardClickHandler);
        this.helpLink.addEventListener(ButtonEvent.CLICK, this.onHelpLinkClickHandler);
    }

    override protected function onDispose():void {
        removeEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST, this.onToggleStatusRequestHandler);
        this.leagueIcon.removeEventListener(MouseEvent.MOUSE_OVER, this.onLeagueIconRollOverHandler);
        this.leagueIcon.removeEventListener(MouseEvent.MOUSE_OUT, onLeagueIconRollOutHandler);
        this.helpLink.removeEventListener(ButtonEvent.CLICK, this.onHelpLinkClickHandler);
        this.header.modeChangeBtn.removeEventListener(Event.SELECT, this.onModeChangeBtnSelectHandler);
        this.teamCardBtn.removeEventListener(ButtonEvent.CLICK, this.onTeamCardClickHandler);
        this.teamCardBtn.dispose();
        this.teamCardBtn = null;
        this.header.dispose();
        this.header = null;
        this.leagueIcon.dispose();
        this.leagueIcon = null;
        this.helpLabel = null;
        this.helpLink.dispose();
        this.helpLink = null;
        this._staticFormationWaitingListSection = null;
        this._staticFormationData = null;
        super.onDispose();
    }

    override protected function getIRallyVO(param1:Object):IRallyVO {
        return new LegionariesSortieVO(param1);
    }

    override protected function coolDownControls(param1:Boolean, param2:int):void {
        if (param2 == CHANGE_UNIT_STATE) {
            WaitListSection(waitingListSection).enableCloseButton(param1);
            IChatSectionWithDescription(chatSection).enableEditCommitButton(param1);
        }
        else if (param2 == SET_PLAYER_STATE) {
            teamSection.enableFightButton(param1);
        }
        else if (param2 == CLOSE_SLOT) {
            teamSection.cooldownSlots(param1);
        }
        else if (param2 == CHANGE_RATED) {
            this.header.enableModeChangeBtn(param1);
        }
        super.coolDownControls(param1, param2);
    }

    override protected function setHeaderData(param1:StaticFormationUnitViewHeaderVO):void {
        this._staticFormationData = param1;
        this.header.update(param1);
        this.leagueIcon.source = param1.bgSource;
        this._staticFormationWaitingListSection.setRankedMode(param1.isRankedMode);
    }

    public function as_closeSlot(param1:uint, param2:uint, param3:String):void {
        if (rallyData) {
            this.unitTeamSection.closeSlot(param1, false, param2, param3, true, -1);
        }
    }

    public function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint):void {
        if (rallyData) {
            this.unitTeamSection.closeSlot(param1, param2, 0, param3, false, param4);
        }
    }

    public function as_setLegionnairesCount(param1:Boolean, param2:String):void {
        this.header.legionnaireIcon.visible = param1;
        this.header.legionnairesCount.visible = param1;
        this.header.legionnairesCount.htmlText = param2;
    }

    public function as_setOpened(param1:Boolean, param2:String):void {
        if (rallyData) {
            waitingListSection.updateRallyStatus(param1, param2);
        }
    }

    public function as_setTeamIcon(param1:String):void {
        this.header.teamIcon.setImage(param1);
    }

    public function as_setTotalLabel(param1:Boolean, param2:String, param3:int):void {
        if (rallyData) {
            this.unitTeamSection.updateTotalLabel(param1, param2, param3);
        }
    }

    private function get unitTeamSection():CyberSportTeamSectionBase {
        return CyberSportTeamSectionBase(teamSection);
    }

    private function onLeagueIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.LADDER, null, this._staticFormationData.clubId);
    }

    private function onTeamCardClickHandler(param1:ButtonEvent):void {
        showTeamCardS();
    }

    private function onModeChangeBtnSelectHandler(param1:Event):void {
        setRankedModeS(!this.header.modeChangeBtn.selected);
    }

    private function onToggleStatusRequestHandler(param1:CSComponentEvent):void {
        toggleStatusRequestS();
    }

    private function onHelpLinkClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CSShowHelpEvent(CYBER_SPORT_HELP_IDS.CYBERSPORT_STATIC_TEAM_ROOM_HELP));
    }
}
}

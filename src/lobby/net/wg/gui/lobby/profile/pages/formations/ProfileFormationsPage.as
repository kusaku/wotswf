package net.wg.gui.lobby.profile.pages.formations {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.NormalSortingBtnVO;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.lobby.profile.pages.formations.data.ProfileFormationsVO;
import net.wg.infrastructure.base.meta.IProfileFormationsPageMeta;
import net.wg.infrastructure.base.meta.impl.ProfileFormationsPageMeta;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;

public class ProfileFormationsPage extends ProfileFormationsPageMeta implements IProfileFormationsPageMeta {

    private static const DATES_WIDTH:int = 170;

    private static const BATTLES_WIDTH:int = 115;

    private static const TEAM_WIDTH:int = 135;

    private static const HISTORY_POS_Y:int = 374;

    private static const HISTORY_NO_TEAM_POS_Y:int = 262;

    private static const HISTORY_BOTTOM_OFFSET_Y:int = 10;

    private static const NO_TEAM_POS_Y:int = 120;

    private static const NO_TEAM_NO_HISTORY_POS_Y:int = 261;

    public var clan:ClanInfo;

    public var team:TeamInfo;

    public var noClan:NoClan;

    public var noTeam:ErrorInfo;

    public var historyTitle:TextField;

    public var history:SortableTable;

    private var _arrayTableBtnInfo:Array;

    public function ProfileFormationsPage() {
        super();
        this.noClan.visible = false;
        this.noTeam.visible = false;
    }

    override public function as_responseDossier(param1:String, param2:Object, param3:String, param4:String):void {
        super.as_responseDossier(param1, new ProfileFormationsVO(param2), param3, param4);
    }

    override protected function configUI():void {
        this._arrayTableBtnInfo = [this.createTableBtnInfo(App.utils.locale.makeString(PROFILE.SECTION_FORMATIONS_HISTORY_DATES), DATES_WIDTH), this.createTableBtnInfo(App.utils.locale.makeString(PROFILE.SECTION_FORMATIONS_HISTORY_BATTLES), BATTLES_WIDTH), this.createTableBtnInfo(App.utils.locale.makeString(PROFILE.SECTION_FORMATIONS_HISTORY_TEAM), TEAM_WIDTH, true)];
        this.historyTitle.text = PROFILE.SECTION_FORMATIONS_HISTORY_TITLE;
        this.history.headerDP = new DataProvider(this._arrayTableBtnInfo);
        addEventListener(ShowTeamEvent.TYPE, this.onHistoryLinkClickedHandler);
        this.noClan.addEventListener(LinkNavigationEvent.TYPE, this.onNoClanTypeHandler);
        this.noTeam.link.addEventListener(ButtonEvent.CLICK, this.onNoTeamLinkClickHandler);
        this.clan.noFort.link.addEventListener(ButtonEvent.CLICK, this.onClanNoFortLinkClickHandler);
        super.configUI();
    }

    override protected function applyResizing():void {
        super.applyResizing();
        this.updateHistorySize();
    }

    override protected function applyData(param1:Object):void {
        var _loc2_:ProfileFormationsVO = ProfileFormationsVO(param1);
        var _loc3_:* = _loc2_.previousTeams.length > 0;
        var _loc4_:Boolean = _loc2_.isTeamAvailable;
        this.applyClanData(_loc2_);
        this.applyTeamData(_loc2_, _loc4_, _loc3_);
        this.applyHistoryData(_loc2_, _loc4_, _loc3_);
    }

    override protected function onDispose():void {
        var _loc2_:IDisposable = null;
        removeEventListener(ShowTeamEvent.TYPE, this.onHistoryLinkClickedHandler);
        this.noClan.removeEventListener(LinkNavigationEvent.TYPE, this.onNoClanTypeHandler);
        this.clan.noFort.link.removeEventListener(ButtonEvent.CLICK, this.onClanNoFortLinkClickHandler);
        this.noTeam.link.removeEventListener(ButtonEvent.CLICK, this.onNoTeamLinkClickHandler);
        var _loc1_:int = this._arrayTableBtnInfo.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc2_ = this._arrayTableBtnInfo[_loc3_] as IDisposable;
            App.utils.asserter.assertNotNull(_loc2_, "item " + Errors.CANT_NULL);
            _loc2_.dispose();
            _loc3_++;
        }
        this._arrayTableBtnInfo.splice(0, this._arrayTableBtnInfo.length);
        this._arrayTableBtnInfo = null;
        this.historyTitle = null;
        this.history.dispose();
        this.history = null;
        this.clan.dispose();
        this.clan = null;
        this.noClan.dispose();
        this.noClan = null;
        this.team.dispose();
        this.team = null;
        this.noTeam.dispose();
        this.noTeam = null;
        ProfileFormationsVO(currentData).dispose();
        super.onDispose();
    }

    public function as_setClanEmblem(param1:String):void {
        this.clan.header.icon.setImage(param1);
    }

    public function as_setClanInfo(param1:Object):void {
    }

    public function as_setClubEmblem(param1:String):void {
        this.team.header.icon.setImage(param1);
    }

    public function as_setClubHistory(param1:Array):void {
    }

    public function as_setClubInfo(param1:Object):void {
    }

    public function as_setFortInfo(param1:Object):void {
    }

    private function applyClanData(param1:ProfileFormationsVO):void {
        this.clan.visible = param1.isClanAvailable;
        this.noClan.visible = !param1.isClanAvailable;
        if (param1.isClanAvailable) {
            this.clan.update(param1);
        }
        else if (param1.isPersonalProfile) {
            this.noClan.title.text = PROFILE.SECTION_FORMATIONS_CLAN_NONE;
            this.noClan.initLinks(param1.searchClanLink, param1.createClanLink);
        }
        else {
            this.noClan.title.text = PROFILE.SECTION_FORMATIONS_CLAN_NONE_THIRDPERSON;
            this.noClan.hideLinks();
        }
    }

    private function applyTeamData(param1:ProfileFormationsVO, param2:Boolean, param3:Boolean):void {
        this.team.visible = param2;
        this.noTeam.visible = !param2;
        if (param1.isTeamAvailable) {
            this.team.update(param1);
        }
        else {
            this.noTeam.link.visible = param1.isPersonalProfile;
            if (param1.isPersonalProfile) {
                this.noTeam.init(PROFILE.SECTION_FORMATIONS_TEAM_NONE, PROFILE.SECTION_FORMATIONS_TEAM_FIND);
            }
            else {
                this.noTeam.init(PROFILE.SECTION_FORMATIONS_TEAM_NONE_THIRDPERSON);
            }
            this.noTeam.setTextPosY(!!param3 ? int(NO_TEAM_POS_Y) : int(NO_TEAM_NO_HISTORY_POS_Y));
        }
    }

    private function applyHistoryData(param1:ProfileFormationsVO, param2:Boolean, param3:Boolean):void {
        var _loc4_:int = 0;
        this.history.visible = param3;
        this.historyTitle.visible = param3;
        if (param3) {
            _loc4_ = this.history.y - this.historyTitle.y;
            this.historyTitle.y = !!param2 ? Number(HISTORY_POS_Y) : Number(HISTORY_NO_TEAM_POS_Y);
            this.history.y = this.historyTitle.y + _loc4_;
            this.updateHistorySize();
            this.history.listDP = new DataProvider(param1.previousTeams);
        }
    }

    private function updateHistorySize():void {
        this.history.height = currentDimension.y - HISTORY_BOTTOM_OFFSET_Y - this.history.y;
    }

    private function createTableBtnInfo(param1:String, param2:Number, param3:Boolean = true):NormalSortingBtnVO {
        var _loc4_:NormalSortingBtnVO = new NormalSortingBtnVO({});
        _loc4_.label = param1;
        _loc4_.buttonWidth = param2;
        _loc4_.textAlign = TextFieldAutoSize.LEFT;
        _loc4_.enabled = false;
        _loc4_.showSeparator = param3;
        _loc4_.buttonHeight = this.history.headerHeight;
        return _loc4_;
    }

    private function onClanNoFortLinkClickHandler(param1:ButtonEvent):void {
        createFortS();
    }

    private function onNoTeamLinkClickHandler(param1:ButtonEvent):void {
        searchStaticTeamsS();
    }

    private function onNoClanTypeHandler(param1:LinkNavigationEvent):void {
        onClanLinkNavigateS(param1.code);
    }

    private function onHistoryLinkClickedHandler(param1:ShowTeamEvent):void {
        showTeamS(param1.teamId);
    }
}
}

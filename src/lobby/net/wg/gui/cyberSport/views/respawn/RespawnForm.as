package net.wg.gui.cyberSport.views.respawn {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.components.MinimapLobby;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.base.meta.ICyberSportRespawnFormMeta;
import net.wg.infrastructure.base.meta.impl.CyberSportRespawnFormMeta;

public class RespawnForm extends CyberSportRespawnFormMeta implements ICyberSportRespawnFormMeta {

    private static var INVALID_ENEMY_STATUS:String = "invalidEnemyStatus";

    private static var INVALID_TEAM_EMBLEM:String = "invalidTeamEmblem";

    private static var INVALID_TEAM_NAME:String = "invalidTeamName";

    private static var INVALID_ARENA_TYPE_ID:String = "invalidArenaTypeId";

    private static var INVALID_TIMER:String = "invalidTimer";

    private static var INVALID_STATUS:String = "invalidStatus";

    public var minimap:MinimapLobby = null;

    public var mapHeader:TextField = null;

    public var enemyCrewHeader:TextField = null;

    public var enemyCrewStatusName:TextField = null;

    public var enemyStatus:IndicationOfStatus = null;

    public var timeLeftTf:TextField = null;

    public var statusHeader:TextField = null;

    public var statusIco:InfoIcon = null;

    public var teamEmblem:ClanEmblem = null;

    public var teamName:TextField = null;

    public var lipUp:MovieClip = null;

    public var lipDown:MovieClip = null;

    private var _teamEmblemId:String = null;

    private var _teamName:String = "";

    private var _arenaTypeID:Number = 0;

    private var _mapName:String = "";

    private var _timeLeft:String = "";

    private var _statusStr:String = "";

    private var _statusLevel:String = "";

    private var _statusTooltip:String = "";

    private var _enemyStatusId:String;

    private var _enemyStatusLabel:String = "";

    private const ENEMY_STATUS_TEXT_MARGIN:Number = -2;

    private const STATUS_TEXT_MARGIN:Number = 4;

    private const DEFAULT_TIME_LEFT:String = "00:00";

    private const TEAM_NAME_MARGIN:Number = 41;

    public function RespawnForm() {
        this._enemyStatusId = IndicationOfStatus.STATUS_NORMAL;
        super();
    }

    override protected function onDispose():void {
        this.mapHeader = null;
        this.enemyCrewHeader = null;
        this.enemyCrewStatusName = null;
        this.enemyStatus.dispose();
        this.enemyStatus = null;
        this.timeLeftTf = null;
        this.statusHeader = null;
        this.statusIco.dispose();
        this.statusIco = null;
        this.teamEmblem.loader.removeEventListener(UILoaderEvent.COMPLETE, this.onClanEmblemLoadedHandler);
        this.teamEmblem.loader.removeEventListener(UILoaderEvent.IOERROR, this.onClanEmblemIOERRORHandler);
        this.teamEmblem.dispose();
        this.teamEmblem = null;
        this.teamName = null;
        this.lipUp = null;
        this.lipDown = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.teamEmblem.visible = false;
        this.updateUserNamePos();
        this.teamEmblem.loader.addEventListener(UILoaderEvent.COMPLETE, this.onClanEmblemLoadedHandler);
        this.teamEmblem.loader.addEventListener(UILoaderEvent.IOERROR, this.onClanEmblemIOERRORHandler);
        this.enemyCrewHeader.text = CYBERSPORT.RESPAWN_ENEMYTEAMSTATUS_HEADER;
    }

    override protected function onPopulate():void {
        super.onPopulate();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_ENEMY_STATUS)) {
            this.enemyStatus.status = this._enemyStatusId;
            this.enemyCrewStatusName.htmlText = this._enemyStatusLabel;
            this.enemyStatus.x = this.enemyCrewStatusName.x + this.enemyCrewStatusName.width - (this.enemyCrewStatusName.textWidth + this.enemyStatus.width + this.ENEMY_STATUS_TEXT_MARGIN) ^ 0;
        }
        if (isInvalid(INVALID_TEAM_NAME)) {
            this.teamName.text = this._teamName;
        }
        if (isInvalid(INVALID_TEAM_EMBLEM)) {
            this.teamEmblem.visible = Boolean(this._teamEmblemId);
            if (this._teamEmblemId) {
                this.teamEmblem.setImage(this._teamEmblemId);
            }
        }
        if (isInvalid(INVALID_ARENA_TYPE_ID)) {
            this.minimap.setMapS(this._arenaTypeID);
            this.mapHeader.text = this._mapName;
        }
        if (isInvalid(INVALID_TIMER)) {
            this.timeLeftTf.htmlText = this._timeLeft == Values.EMPTY_STR ? this.DEFAULT_TIME_LEFT : this._timeLeft;
        }
        if (isInvalid(INVALID_STATUS)) {
            this.statusHeader.htmlText = this._statusStr;
            this.statusIco.visible = this._statusLevel != Values.EMPTY_STR;
            if (this.statusIco.visible) {
                this.statusIco.tooltip = this._statusTooltip;
                this.statusIco.icoType = this._statusLevel;
                this.repositionStatus();
            }
        }
    }

    override protected function getRallyVO(param1:Object):IRallyVO {
        return new LegionariesSortieVO(param1);
    }

    public function as_setArenaTypeId(param1:String, param2:Number):void {
        this._mapName = param1;
        this._arenaTypeID = param2;
        invalidate(INVALID_ARENA_TYPE_ID);
    }

    public function as_setTeamEmblem(param1:String):void {
        this._teamEmblemId = param1 && param1 != Values.EMPTY_STR ? param1 : null;
        invalidate(INVALID_TEAM_EMBLEM);
    }

    public function as_setTeamName(param1:String):void {
        this._teamName = param1;
        invalidate(INVALID_TEAM_NAME);
    }

    public function as_setTotalLabel(param1:Boolean, param2:String, param3:int):void {
        if (rallyData) {
            this.unitTeamSection.updateTotalLabel(param1, param2, param3);
        }
    }

    public function as_statusUpdate(param1:String, param2:String, param3:String):void {
        this._statusStr = param1;
        this._statusLevel = param2;
        this._statusTooltip = param3;
        invalidate(INVALID_STATUS);
    }

    public function as_timerUpdate(param1:String):void {
        this._timeLeft = param1;
        invalidate(INVALID_TIMER);
    }

    public function as_updateEnemyStatus(param1:String, param2:String):void {
        this._enemyStatusId = param1;
        this._enemyStatusLabel = param2;
        invalidate(INVALID_ENEMY_STATUS);
    }

    private function updateUserNamePos():void {
        this.teamName.x = !!this.teamEmblem.visible ? Number(this.teamEmblem.x + this.TEAM_NAME_MARGIN) : Number(this.teamEmblem.x);
    }

    private function repositionStatus():void {
        this.statusIco.x = this.statusHeader.x + (this.statusHeader.width + this.statusHeader.textWidth >> 1) + this.STATUS_TEXT_MARGIN;
    }

    public function get unitTeamSection():RespawnTeamSection {
        return teamSection as RespawnTeamSection;
    }

    private function onClanEmblemIOERRORHandler(param1:UILoaderEvent):void {
        this.teamEmblem.visible = false;
        this.updateUserNamePos();
    }

    private function onClanEmblemLoadedHandler(param1:UILoaderEvent):void {
        this.teamEmblem.visible = true;
        this.updateUserNamePos();
    }
}
}

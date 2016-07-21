package net.wg.gui.battle.random.views.fragCorrelationBar {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.PersonalStatus;
import net.wg.infrastructure.base.meta.IFragCorrelationBarMeta;
import net.wg.infrastructure.base.meta.impl.FragCorrelationBarMeta;
import net.wg.infrastructure.events.ColorSchemeEvent;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IColorScheme;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;
import net.wg.infrastructure.managers.IColorSchemeManager;

import scaleform.gfx.TextFieldEx;

public class FragCorrelationBar extends FragCorrelationBarMeta implements IFragCorrelationBarMeta, IBattleComponentDataController {

    private static const INVALID_FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALID_COLOR_SCHEME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const VEHICLE_SHOWN_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    public var allyTeamFragsField:TextField = null;

    public var enemyTeamFragsField:TextField = null;

    public var greenBackground:Sprite = null;

    public var redBackground:Sprite = null;

    public var purpleBackground:Sprite = null;

    public var teamFragsSeparatorField:TextField = null;

    private var _allyTeamFragsStr:String = "0";

    private var _enemyTeamFragsStr:String = "0";

    private var _lastTeamSeparatorState:int;

    private var _currentTeamSeparatorState:int;

    private var _winColorScheme:IColorScheme = null;

    private var _loseColorScheme:IColorScheme = null;

    private var _allyVehicleMarkersList:VehicleMarkersList;

    private var _enemyVehicleMarkersList:VehicleMarkersList;

    private var _colorSchemeMgr:IColorSchemeManager;

    private var _rightBg:Sprite = null;

    private var _isVehicleCounterShown:Boolean = true;

    private const FRAG_CORRELATION_WIN:String = "FragCorrelationWin";

    private const FRAG_CORRELATION_LOSE:String = "FragCorrelationLoose";

    private const RED:String = "red";

    private const FRAG_EQUAL:int = 0;

    private const FRAG_WIN:int = 1;

    private const FRAG_LOSE:int = 2;

    private const SEPARATOR_STR:String = ":";

    public function FragCorrelationBar() {
        this._lastTeamSeparatorState = this.FRAG_EQUAL;
        this._currentTeamSeparatorState = this.FRAG_EQUAL;
        this._colorSchemeMgr = App.colorSchemeMgr;
        super();
        this._rightBg = this.redBackground;
        TextFieldEx.setNoTranslate(this.allyTeamFragsField, true);
        TextFieldEx.setNoTranslate(this.enemyTeamFragsField, true);
        TextFieldEx.setNoTranslate(this.teamFragsSeparatorField, true);
        this._winColorScheme = this._colorSchemeMgr.getScheme(this.FRAG_CORRELATION_WIN);
        this._loseColorScheme = this._colorSchemeMgr.getScheme(this.FRAG_CORRELATION_LOSE);
        this._allyVehicleMarkersList = new VehicleMarkersList(this, false, this._winColorScheme.aliasColor);
        this._enemyVehicleMarkersList = new VehicleMarkersList(this, true, this._loseColorScheme.aliasColor);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_COLOR_SCHEME)) {
            this.greenBackground.filters = [this._winColorScheme.adjustOffset];
            this._rightBg.visible = false;
            this._rightBg = this._loseColorScheme.aliasColor == this.RED ? this.redBackground : this.purpleBackground;
            this._rightBg.filters = [this._loseColorScheme.adjustOffset];
            this._rightBg.visible = this._currentTeamSeparatorState == this.FRAG_LOSE;
        }
        if (isInvalid(INVALID_FRAGS)) {
            this.allyTeamFragsField.text = this._allyTeamFragsStr;
            this.enemyTeamFragsField.text = this._enemyTeamFragsStr;
            if (this._currentTeamSeparatorState != this._lastTeamSeparatorState) {
                this._lastTeamSeparatorState = this._currentTeamSeparatorState;
                this.greenBackground.visible = this._currentTeamSeparatorState == this.FRAG_WIN;
                this._rightBg.visible = this._currentTeamSeparatorState == this.FRAG_LOSE;
                this.teamFragsSeparatorField.visible = this._currentTeamSeparatorState == this.FRAG_EQUAL;
            }
        }
        if (isInvalid(VEHICLE_SHOWN_FLAG)) {
            if (this._isVehicleCounterShown) {
                this._allyVehicleMarkersList.showVehicleMarkers();
                this._enemyVehicleMarkersList.showVehicleMarkers();
            }
            else {
                this._allyVehicleMarkersList.hideVehicleMarkers();
                this._enemyVehicleMarkersList.hideVehicleMarkers();
            }
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.greenBackground.visible = false;
        this.redBackground.visible = false;
        this.purpleBackground.visible = false;
        this.teamFragsSeparatorField.text = this.SEPARATOR_STR;
        this.teamFragsSeparatorField.cacheAsBitmap = true;
        this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
    }

    private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent):void {
        this._winColorScheme = this._colorSchemeMgr.getScheme(this.FRAG_CORRELATION_WIN);
        this._loseColorScheme = this._colorSchemeMgr.getScheme(this.FRAG_CORRELATION_LOSE);
        this._allyVehicleMarkersList.color = this._winColorScheme.aliasColor;
        this._enemyVehicleMarkersList.color = this._loseColorScheme.aliasColor;
        invalidate(INVALID_COLOR_SCHEME);
    }

    override protected function onDispose():void {
        this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemasUpdatedHandler);
        this._colorSchemeMgr = null;
        this.allyTeamFragsField = null;
        this.enemyTeamFragsField = null;
        this.greenBackground = null;
        this.redBackground = null;
        this.purpleBackground = null;
        this.teamFragsSeparatorField = null;
        this._winColorScheme.dispose();
        this._winColorScheme = null;
        this._loseColorScheme.dispose();
        this._loseColorScheme = null;
        this._allyVehicleMarkersList.dispose();
        this._allyVehicleMarkersList = null;
        this._enemyVehicleMarkersList.dispose();
        this._enemyVehicleMarkersList = null;
        this._rightBg = null;
        super.onDispose();
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.rightVehicleInfos) {
            this._enemyVehicleMarkersList.addVehiclesInfo(_loc2_.rightVehicleInfos, _loc2_.rightCorrelationIDs);
        }
        if (_loc2_.leftVehicleInfos) {
            this._allyVehicleMarkersList.addVehiclesInfo(_loc2_.leftVehicleInfos, _loc2_.leftCorrelationIDs);
        }
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
        if (_loc2_.totalStats) {
            this.updateFrags(_loc2_.totalStats.leftScope, _loc2_.totalStats.rightScope);
        }
    }

    private function updateFrags(param1:int, param2:int):void {
        this._allyTeamFragsStr = param1.toString();
        this._enemyTeamFragsStr = param2.toString();
        if (param1 == param2) {
            this._currentTeamSeparatorState = this.FRAG_EQUAL;
        }
        else if (param1 > param2) {
            this._currentTeamSeparatorState = this.FRAG_WIN;
        }
        else {
            this._currentTeamSeparatorState = this.FRAG_LOSE;
        }
        invalidate(INVALID_FRAGS);
    }

    public function setVehiclesData(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.rightVehicleInfos) {
            this._enemyVehicleMarkersList.updateMarkers(_loc2_.rightVehicleInfos, _loc2_.rightCorrelationIDs);
        }
        if (_loc2_.leftVehicleInfos) {
            this._allyVehicleMarkersList.updateMarkers(_loc2_.leftVehicleInfos, _loc2_.leftCorrelationIDs);
        }
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        if (_loc2_.isEnemy) {
            this._enemyVehicleMarkersList.updateVehicleStatus(_loc2_.vehicleID, _loc2_.status, _loc2_.rightCorrelationIDs);
        }
        else {
            this._allyVehicleMarkersList.updateVehicleStatus(_loc2_.vehicleID, _loc2_.status, _loc2_.leftCorrelationIDs);
        }
        if (_loc2_.totalStats) {
            this.updateFrags(_loc2_.totalStats.leftScope, _loc2_.totalStats.rightScope);
        }
    }

    public function updateVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._allyVehicleMarkersList.updateVehiclesInfo(_loc2_.leftVehicleInfos, _loc2_.leftCorrelationIDs);
        }
        if (_loc2_.rightVehicleInfos) {
            this._enemyVehicleMarkersList.updateVehiclesInfo(_loc2_.rightVehicleInfos, _loc2_.rightCorrelationIDs);
        }
    }

    public function updatePersonalStatus(param1:uint, param2:uint):void {
        if (PersonalStatus.IS_VEHICLE_COUNTER_SHOWN == param1) {
            this._isVehicleCounterShown = true;
            invalidate(VEHICLE_SHOWN_FLAG);
        }
        else if (PersonalStatus.IS_VEHICLE_COUNTER_SHOWN == param2) {
            this._isVehicleCounterShown = false;
            invalidate(VEHICLE_SHOWN_FLAG);
        }
    }

    public function setPersonalStatus(param1:uint):void {
        var _loc2_:Boolean = PersonalStatus.isVehicleCounterShown(param1);
        if (this._isVehicleCounterShown != _loc2_) {
            this._isVehicleCounterShown = _loc2_;
            invalidate(VEHICLE_SHOWN_FLAG);
        }
    }

    public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
    }

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
    }

    public function updateVehiclesStats(param1:IDAAPIDataClass):void {
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
    }

    public function setArenaInfo(param1:IDAAPIDataClass):void {
    }
}
}

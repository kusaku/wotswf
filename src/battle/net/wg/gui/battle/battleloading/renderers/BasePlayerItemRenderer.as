package net.wg.gui.battle.battleloading.renderers {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.battleloading.BattleLoadingHelper;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.BattleUIComponentsHolder;
import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
import net.wg.gui.components.icons.PlayerActionMarker;
import net.wg.infrastructure.interfaces.IColorScheme;

import scaleform.gfx.TextFieldEx;

public class BasePlayerItemRenderer extends BattleUIComponentsHolder {

    private static const AVAILABLE_TEXT_COLOR:int = 16777215;

    private static const NOT_AVAILABLE_TEXT_COLOR:int = 5130300;

    private static const ACTION_MARKER_MYTEAM:String = "myteam";

    private static const ACTION_MARKER_ENEMY:String = "enemy";

    private static const DEF_PLAYER_ACTION:int = 0;

    private static const FIELD_WIDTH_COMPENSATION:int = 2;

    protected var _selfBg:BattleAtlasSprite;

    protected var _vehicleField:TextField;

    protected var _textField:TextField;

    protected var _vehicleIcon:BattleAtlasSprite;

    protected var _vehicleTypeIcon:BattleAtlasSprite;

    protected var _vehicleLevelIcon:BattleAtlasSprite;

    protected var _squad:BattleAtlasSprite;

    protected var _playerActionMarker:PlayerActionMarker;

    protected var _icoIGR:BattleAtlasSprite;

    protected var _model:DAAPIVehicleInfoVO;

    private var _defaultVehicleFieldXPosition:int;

    private var _defaultVehicleFieldWidth:int;

    private var _isEnemy:Boolean;

    public function BasePlayerItemRenderer(param1:RendererContainer, param2:int, param3:Boolean) {
        if (param3) {
            this._vehicleField = param1.vehicleFieldsEnemy[param2];
            this._textField = param1.textFieldsEnemy[param2];
            this._vehicleIcon = param1.vehicleIconsEnemy[param2];
            this._vehicleTypeIcon = param1.vehicleTypeIconsEnemy[param2];
            this._vehicleLevelIcon = param1.vehicleLevelIconsEnemy[param2];
            this._squad = param1.squadsEnemy[param2];
            this._playerActionMarker = param1.playerActionMarkersEnemy[param2];
            this._icoIGR = param1.icoIGRsEnemy[param2];
        }
        else {
            this._vehicleField = param1.vehicleFieldsAlly[param2];
            this._textField = param1.textFieldsAlly[param2];
            this._vehicleIcon = param1.vehicleIconsAlly[param2];
            this._vehicleTypeIcon = param1.vehicleTypeIconsAlly[param2];
            this._vehicleLevelIcon = param1.vehicleLevelIconsAlly[param2];
            this._squad = param1.squadsAlly[param2];
            this._playerActionMarker = param1.playerActionMarkersAlly[param2];
            this._icoIGR = param1.icoIGRsAlly[param2];
            this._selfBg = param1.selfBgs[param2];
        }
        this._defaultVehicleFieldXPosition = this._vehicleField.x;
        this._defaultVehicleFieldWidth = this._vehicleField.width;
        this._isEnemy = param3;
        this._vehicleField.autoSize = TextFieldAutoSize.LEFT;
        this._vehicleLevelIcon.isCetralize = true;
        super();
        TextFieldEx.setNoTranslate(this._vehicleField, true);
        TextFieldEx.setNoTranslate(this._textField, true);
    }

    public function setData(param1:Object):void {
        this._model = DAAPIVehicleInfoVO(param1);
        invalidate();
    }

    override protected function onDispose():void {
        this._selfBg = null;
        this._vehicleField = null;
        this._textField = null;
        this._vehicleTypeIcon = null;
        this._vehicleLevelIcon = null;
        this._vehicleIcon = null;
        this._squad = null;
        this._playerActionMarker.dispose();
        this._playerActionMarker = null;
        this._icoIGR = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        if (this._model != null) {
            this.setSelfBG();
            this._textField.visible = true;
            App.utils.commons.formatPlayerName(this._textField, App.utils.commons.getUserProps(this._model.playerName, this._model.clanAbbrev, this._model.region, 0, this._model.userTags));
            this._vehicleField.visible = true;
            this._vehicleField.text = this._model.vehicleName;
            this._icoIGR.visible = this._model.isIGR;
            if (this._icoIGR.visible) {
                this._icoIGR.imageName = BattleAtlasItem.ICO_IGR;
                if (this._isEnemy) {
                    this._icoIGR.x = this._defaultVehicleFieldXPosition;
                    this._vehicleField.x = this._icoIGR.x + this._icoIGR.width + FIELD_WIDTH_COMPENSATION >> 0;
                }
                else {
                    this._icoIGR.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._icoIGR.width >> 0;
                    this._vehicleField.x = this._icoIGR.x - this._vehicleField.width - FIELD_WIDTH_COMPENSATION >> 0;
                }
            }
            else if (this._isEnemy) {
                this._vehicleField.x = this._defaultVehicleFieldXPosition;
            }
            else {
                this._vehicleField.x = this._defaultVehicleFieldXPosition + this._defaultVehicleFieldWidth - this._vehicleField.width >> 0;
            }
            this.setVehicleIcon();
            this.setVehicleType();
            this.setVehicleLevel();
            this.setSquadState();
            this.setPlayerActionMarkerState();
            this.updateState();
        }
        else {
            if (this._selfBg != null) {
                this._selfBg.visible = false;
            }
            this._icoIGR.visible = false;
            this._squad.visible = false;
            this._textField.visible = false;
            this._vehicleField.visible = false;
            this._vehicleIcon.visible = false;
            this._vehicleTypeIcon.visible = false;
            this._vehicleLevelIcon.visible = false;
            if (this._playerActionMarker != null) {
                this._playerActionMarker.action = DEF_PLAYER_ACTION;
            }
        }
        super.draw();
    }

    protected function setSelfBG():void {
    }

    private function setPlayerActionMarkerState():void {
        if (this._playerActionMarker != null && this._model.vehicleAction) {
            this._playerActionMarker.action = this._model.vehicleAction;
            this._playerActionMarker.team = !!this._model.isPlayerTeam ? ACTION_MARKER_MYTEAM : ACTION_MARKER_ENEMY;
        }
    }

    private function setSquadState():void {
        if (this._squad != null) {
            if (this._model.isSquadMan()) {
                this._squad.visible = true;
                this._squad.imageName = BattleAtlasItem.getSquadIconName(this._model.isSquadPersonal(), this._model.squadIndex);
            }
            else {
                this._squad.visible = false;
            }
        }
    }

    private function setVehicleLevel():void {
        if (this._vehicleLevelIcon != null) {
            this._vehicleLevelIcon.visible = this._model.vehicleLevel > 0;
            if (this._vehicleLevelIcon.visible) {
                this._vehicleLevelIcon.imageName = BattleAtlasItem.getVehicleLevelName(this._model.vehicleLevel);
            }
        }
    }

    private function setVehicleType():void {
        var _loc1_:String = null;
        if (this._vehicleTypeIcon != null) {
            _loc1_ = BattleLoadingHelper.instance.getVehicleTypeIconId(this._model);
            if (_loc1_) {
                this._vehicleTypeIcon.imageName = BattleAtlasItem.getFullStatsVehicleTypeName(_loc1_);
                this._vehicleTypeIcon.visible = true;
            }
            else {
                this._vehicleTypeIcon.visible = false;
            }
        }
    }

    private function setVehicleIcon():void {
        if (this._vehicleIcon != null) {
            this._vehicleIcon.visible = true;
            this._vehicleIcon.setImageNames(BattleAtlasItem.getVehicleIconName(this._model.vehicleIconName), BattleAtlasItem.VEHICLE_TYPE_UNKNOWN);
        }
    }

    private function updateState():void {
        var _loc4_:Boolean = false;
        var _loc5_:Number = NaN;
        var _loc1_:Boolean = this._model.isAlive();
        var _loc2_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(this._model.isCurrentPlayer, this._model.isSquadPersonal(), this._model.isTeamKiller(), !_loc1_, !this._model.isReady());
        var _loc3_:IColorScheme = App.colorSchemeMgr.getScheme(_loc2_);
        if (_loc3_) {
            this._vehicleIcon.transform.colorTransform = _loc3_.colorTransform;
        }
        _loc2_ = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_loc1_);
        _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
        if (_loc3_) {
            this._vehicleLevelIcon.transform.colorTransform = _loc3_.colorTransform;
        }
        _loc2_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this._model.isCurrentPlayer, this._model.isSquadPersonal(), this._model.isTeamKiller(), !_loc1_, !this._model.isReady());
        _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
        if (_loc3_) {
            this._textField.textColor = _loc3_.rgb;
            this._vehicleField.textColor = _loc3_.rgb;
        }
        else {
            DebugUtils.LOG_ERROR("Color of text not found", this._model);
            _loc4_ = true;
            if (!this._model.isNotAvailable()) {
                _loc4_ = _loc1_ && this._model.isReady();
            }
            _loc5_ = !!_loc4_ ? Number(AVAILABLE_TEXT_COLOR) : Number(NOT_AVAILABLE_TEXT_COLOR);
            this._textField.textColor = _loc5_;
            this._vehicleField.textColor = _loc5_;
        }
    }
}
}

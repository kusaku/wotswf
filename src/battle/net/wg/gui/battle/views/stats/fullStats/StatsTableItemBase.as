package net.wg.gui.battle.views.stats.fullStats {
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.BattleUIComponentsHolder;
import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
import net.wg.infrastructure.interfaces.IColorScheme;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.gfx.TextFieldEx;

public class StatsTableItemBase extends BattleUIComponentsHolder {

    protected var deadBg:BattleAtlasSprite = null;

    protected var isOffline:Boolean = false;

    protected var isDead:Boolean = false;

    protected var isCurrentPlayer:Boolean = false;

    protected var isSquadPersonal:Boolean = false;

    protected var isTeamKiller:Boolean = false;

    private var _playerNameTF:TextField = null;

    private var _fragsTF:TextField = null;

    private var _vehicleNameTF:TextField = null;

    private var _vehicleTypeIcon:BattleAtlasSprite = null;

    private var _icoIGR:BattleAtlasSprite = null;

    private var _userProps:IUserProps = null;

    private var _vehicleName:String = null;

    private var _vehicleType:String = null;

    private var _isSelected:Boolean = false;

    private var _frags:int = 0;

    private var _isIGR:Boolean = false;

    public function StatsTableItemBase(param1:TextField, param2:TextField, param3:TextField, param4:BattleAtlasSprite, param5:BattleAtlasSprite, param6:BattleAtlasSprite) {
        super();
        this._playerNameTF = param1;
        this._vehicleNameTF = param2;
        this._fragsTF = param3;
        this._vehicleTypeIcon = param4;
        this.deadBg = param5;
        this._icoIGR = param6;
        this._playerNameTF.visible = false;
        this._vehicleNameTF.visible = false;
        this._fragsTF.visible = false;
        this._vehicleTypeIcon.visible = false;
        this.deadBg.visible = false;
        this._icoIGR.visible = false;
        TextFieldEx.setNoTranslate(this._playerNameTF, true);
        TextFieldEx.setNoTranslate(this._vehicleNameTF, true);
        TextFieldEx.setNoTranslate(this._fragsTF, true);
    }

    public function setPlayerName(param1:IUserProps):void {
        this._userProps = param1;
        invalidate(FullStatsValidationType.USER_PROPS);
        invalidate(FullStatsValidationType.COLORS);
    }

    public function setVehicleName(param1:String):void {
        if (this._vehicleNameTF.text == param1) {
            return;
        }
        this._vehicleName = param1;
        invalidate(FullStatsValidationType.VEHICLE_NAME);
    }

    public function setVehicleType(param1:String, param2:String):void {
        var _loc3_:String = BattleAtlasItem.getFullStatsVehicleTypeName(param1, param2);
        if (_loc3_ == this._vehicleType) {
            return;
        }
        this._vehicleType = _loc3_;
        invalidate(FullStatsValidationType.VEHICLE_TYPE);
    }

    public function setFrags(param1:int):void {
        if (this._frags == param1) {
            return;
        }
        this._frags = param1;
        invalidate(FullStatsValidationType.FRAGS);
    }

    public function setIsSelected(param1:Boolean):void {
        if (this._isSelected == param1) {
            return;
        }
        this._isSelected = param1;
        invalidate(FullStatsValidationType.SELECTED | FullStatsValidationType.COLORS);
    }

    public function setIsDead(param1:Boolean):void {
        if (this.isDead == param1) {
            return;
        }
        this.isDead = param1;
        this.deadBg.visible = param1 && !this._isSelected;
        invalidate(FullStatsValidationType.COLORS);
    }

    public function setIsCurrentPlayer(param1:Boolean):void {
        if (this.isCurrentPlayer == param1) {
            return;
        }
        this.isCurrentPlayer = param1;
        invalidate(FullStatsValidationType.COLORS);
    }

    public function setIsTeamKiller(param1:Boolean):void {
        if (this.isTeamKiller == param1) {
            return;
        }
        this.isTeamKiller = param1;
        invalidate(FullStatsValidationType.COLORS);
    }

    public function setIsSquadPersonal(param1:Boolean):void {
        if (this.isSquadPersonal == param1) {
            return;
        }
        this.isSquadPersonal = param1;
        invalidate(FullStatsValidationType.COLORS);
    }

    public function setIsOffline(param1:Boolean):void {
        if (this.isOffline == param1) {
            return;
        }
        this.isOffline = param1;
        invalidate(FullStatsValidationType.COLORS);
    }

    public function setIsIGR(param1:Boolean):void {
        if (this._isIGR == param1) {
            return;
        }
        this._isIGR = param1;
        invalidate(FullStatsValidationType.IS_IGR);
    }

    public function updateColorBlind():void {
        invalidate(FullStatsValidationType.COLORS);
    }

    public function reset():void {
        this._frags = 0;
        this._isSelected = false;
        this._userProps = null;
        this.isDead = false;
        this.isCurrentPlayer = false;
        this.isSquadPersonal = false;
        this.isOffline = false;
        this.isTeamKiller = false;
        this._vehicleName = null;
        this._vehicleType = null;
        this._isIGR = false;
        invalidate(InvalidationType.ALL);
    }

    override protected function onDispose():void {
        this._playerNameTF = null;
        this._vehicleNameTF = null;
        this._vehicleTypeIcon = null;
        this._fragsTF = null;
        this.deadBg = null;
        this._userProps = null;
        this._icoIGR = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:String = null;
        var _loc2_:IColorScheme = null;
        var _loc3_:Rectangle = null;
        super.draw();
        if (isInvalid(FullStatsValidationType.COLORS)) {
            _loc1_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this.isCurrentPlayer, this.isSquadPersonal, this.isTeamKiller, this.isDead, this.isOffline);
            _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
            if (_loc2_) {
                this.applyTextColor(_loc2_.rgb);
            }
        }
        if (isInvalid(FullStatsValidationType.USER_PROPS)) {
            if (this._userProps) {
                this._playerNameTF.visible = true;
                App.utils.commons.formatPlayerName(this._playerNameTF, this._userProps);
            }
            else {
                this._playerNameTF.visible = false;
            }
        }
        if (isInvalid(FullStatsValidationType.FRAGS)) {
            this._fragsTF.visible = this._frags != 0;
            if (this._frags) {
                this._fragsTF.text = this._frags.toString();
            }
        }
        if (isInvalid(FullStatsValidationType.SELECTED)) {
            this.deadBg.visible = this.isDead && !this._isSelected;
        }
        if (isInvalid(FullStatsValidationType.VEHICLE_NAME)) {
            if (this._vehicleName) {
                this._vehicleNameTF.visible = true;
                this._vehicleNameTF.text = this._vehicleName;
                if (this._icoIGR.visible) {
                    if (this._vehicleNameTF.getTextFormat().align == TextFormatAlign.RIGHT) {
                        this._icoIGR.x = this._vehicleNameTF.x - this._icoIGR.width >> 0;
                    }
                }
            }
            else {
                this._vehicleNameTF.visible = false;
            }
        }
        if (isInvalid(FullStatsValidationType.VEHICLE_TYPE)) {
            if (this._vehicleType) {
                this._vehicleTypeIcon.visible = true;
                this._vehicleTypeIcon.imageName = this._vehicleType;
            }
            else {
                this._vehicleTypeIcon.visible = false;
            }
        }
        if (isInvalid(FullStatsValidationType.IS_IGR)) {
            this._icoIGR.visible = this._isIGR;
            if (this._isIGR) {
                this._icoIGR.imageName = BattleAtlasItem.ICO_IGR;
                if (this._vehicleNameTF.getTextFormat().align == TextFormatAlign.RIGHT) {
                    _loc3_ = this._vehicleNameTF.getCharBoundaries(0);
                    this._icoIGR.x = this._vehicleNameTF.x + (!!_loc3_ ? _loc3_.x : 0) - this._icoIGR.width >> 0;
                }
                else {
                    this._icoIGR.x = this._vehicleNameTF.x;
                    this._vehicleNameTF.x = this._icoIGR.x + this._icoIGR.width >> 0;
                }
            }
            else if (this._vehicleNameTF.getTextFormat().align != TextFormatAlign.RIGHT) {
                this._vehicleNameTF.x = this._icoIGR.x;
            }
        }
    }

    protected function applyTextColor(param1:uint):void {
        this._playerNameTF.textColor = param1;
        this._vehicleNameTF.textColor = param1;
        this._fragsTF.textColor = param1;
    }
}
}

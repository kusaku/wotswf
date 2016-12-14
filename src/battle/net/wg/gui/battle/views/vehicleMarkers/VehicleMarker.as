package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.components.constants.InvalidationType;
import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;

import scaleform.gfx.TextFieldEx;

public class VehicleMarker extends BattleUIComponent implements IMarkerManagerHandler {

    private static const SHADOW_POSITIONS:Array = [null, new Point(-94, -122), new Point(-94, -122), new Point(-94, -122), new Point(-94, -122), new Point(-94, -122), new Point(-94, -122), new Point(-94, -122)];

    private static const ICON:String = "Icon";

    private static const LEVEL:String = "Level";

    private static const HEALTH_LBL:String = "Hp";

    private static const HEALTH_BAR:String = "HpIndicator";

    private static const P_NAME_LBL:String = "PlayerName";

    private static const V_NAME_LBL:String = "VehicleName";

    private static const DAMAGE_PANEL:String = "Damage";

    private static const MARKER:String = "marker";

    private static const ALT:String = "Alt";

    private static const BASE:String = "Base";

    private static const DEAD:String = "Dead";

    private static const ACTION_Y:int = -93;

    private static const ICON_Y:int = -86;

    private static const LEVEL_Y:int = -74;

    private static const V_NAME_LBL_Y:int = -62;

    private static const P_NAME_LBL_Y:int = -49;

    private static const HEALTH_BAR_Y:int = -29;

    private static const SQUAD_Y:int = -113;

    private static const FLAG_NO_SQUAD_Y:int = -128;

    private static const FLAG_WITH_SQUAD_Y:int = -152;

    private static const HP_FIELD_VERTICAL_OFFSET:int = -3;

    private static const EXPLOSION_HORIZONTAL_OFFSET:int = 15;

    private static const ICON_OFFSET:int = 15;

    private static const LEVEL_OFFSET:int = 3;

    private static const V_NAME_LBL_OFFSET:int = 13;

    private static const V_TYPE_ICON_Y:int = -7;

    private static const P_NAME_LBL_OFFSET:int = 13;

    private static const HEALTH_BAR_OFFSET:int = 13;

    private static const OFFSETS:Vector.<int> = new <int>[0, 0, ICON_OFFSET, LEVEL_OFFSET, V_NAME_LBL_OFFSET, P_NAME_LBL_OFFSET, HEALTH_BAR_OFFSET];

    private static const STATE_DEAD:String = "dead";

    private static const STATE_IMMEDIATE_DEAD:String = "immediate_dead";

    private static const PERCENT_STRING:String = "%";

    private static const SLASH_STRING:String = " / ";

    private static const SHADOW_TYPE_HBAR_OFFSET:int = 4;

    private static const VM_PREFIX:String = "vm_";

    private static const VM_DEAD_PREFIX:String = "vm_dead_";

    private static const MAX_HEALTH_PERCENT:int = 100;

    private static const VEHICLE_DESTROY_COLOR:Number = 6710886;

    public static const INVALIDATE_MANAGER_READY:uint = 1 << 17;

    public var vehicleIcon:MovieClip = null;

    public var hpFieldContainer:HPFieldContainer = null;

    public var actionMarker:VehicleActionMarker = null;

    public var marker:VehicleIconAnimation = null;

    public var hitLabel:HealthBarAnimatedLabel = null;

    public var hitExplosion:AnimateExplosion = null;

    public var vehicleNameField:TextField = null;

    public var playerNameField:TextField = null;

    public var healthBar:HealthBar = null;

    public var bgShadow:MovieClip = null;

    public var marker2:FlagContainer = null;

    public var levelIcon:MovieClip = null;

    public var squadIcon:MovieClip = null;

    private var _model:VehicleMarkerVO = null;

    private var _entityType:String = "enemy";

    private var _entityName:String = "enemy";

    private var _markerColor:String = "red";

    private var _markerState:String = "";

    private var _vehicleDestroyed:Boolean = false;

    private var _isPopulated:Boolean = false;

    private var _exInfoOverride:Boolean = false;

    private var _markerSettingsOverride:Object = null;

    private var _vmManager:VehicleMarkersManager = null;

    private var _maxHealthMult:Number = NaN;

    private var _colorSchemeName:String = "";

    private var _isFlagShown:Boolean = false;

    private var _isManagerReady:Boolean = false;

    public function VehicleMarker() {
        super();
        this._vmManager = VehicleMarkersManager.getInstance();
        this._isManagerReady = this._vmManager.isAtlasInited;
        if (!this._isManagerReady) {
            this._vmManager.addReadyHandler(this);
        }
        TextFieldEx.setNoTranslate(this.vehicleNameField, true);
        TextFieldEx.setNoTranslate(this.playerNameField, true);
    }

    public function managerReadyHandler():void {
        this._isManagerReady = true;
        if (!this._isPopulated) {
            invalidate(INVALIDATE_MANAGER_READY);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.healthBar.hitSplash.addEventListener(HealthBarAnimatedPart.HIDE, this.onSplashHideHandler);
        this._vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO, this.onShowExInfoHandler);
        this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS, this.onUpdateSettingsHandler);
        this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS, this.onUpdateColorsHandler);
    }

    override protected function draw():void {
        var _loc1_:String = null;
        super.draw();
        if (this._isManagerReady && isInvalid(InvalidationType.DATA) && this._model != null && !this._isPopulated) {
            this._markerColor = this._vmManager.getAliasColor(this._colorSchemeName);
            this.applyColor();
            if (this.getHealthPercents() >= 0) {
                this.healthBar.maxHealth = this._model.maxHealth;
                this.healthBar.currHealth = this._model.currHealth;
            }
            this.setupVehicleIcon();
            _loc1_ = VMAtlasItemName.getLevelIconName(this._model.vLevel);
            this._vmManager.drawWithCenterAlign(_loc1_, this.levelIcon.graphics, true, false);
            this.setupSquadIcon();
            if (this._model.vClass) {
                this.setVehicleType();
            }
            this.setMarkerState(this._markerState);
            this.updateMarkerSettings();
            this._isPopulated = true;
        }
    }

    public function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int):void {
        var _loc13_:int = 0;
        if (this._model) {
            _loc13_ = this._model.currHealth;
        }
        this._model = new VehicleMarkerVO();
        this._model.vClass = param1;
        this._model.vIconSource = param2;
        this._model.vType = param3;
        this._model.vLevel = param4;
        this._model.pFullName = param5;
        this._model.pName = param6;
        this._model.pClan = param7;
        this._model.pRegion = param8;
        this._model.maxHealth = param9;
        this._model.entityName = param10;
        this._model.hunt = param11;
        this._model.squadIndex = param12;
        this._model.currHealth = _loc13_;
        this._maxHealthMult = MAX_HEALTH_PERCENT / this._model.maxHealth;
        if (this._model.entityName != "") {
            this._entityName = this._model.entityName;
            this.actionMarker.entityName = this._entityName;
            this.makeColorSchemeName();
            if (this._entityName == VehicleMarkersConstants.ENTITY_NAME_ENEMY) {
                this._entityType = VehicleMarkersConstants.ENTITY_TYPE_ENEMY;
            }
            else {
                this._entityType = VehicleMarkersConstants.ENTITY_TYPE_ALLY;
            }
        }
        this._isPopulated = false;
        invalidateData();
    }

    public function isSpeaking():Boolean {
        return this._model.speaking;
    }

    public function setEntityName(param1:String):void {
        if (param1 == this._entityName) {
            return;
        }
        this.entityName = param1;
        this.update();
    }

    public function setSpeaking(param1:Boolean):void {
        if (this._model.speaking == param1) {
            return;
        }
        this._model.speaking = param1;
        if (initialized) {
            this.setVehicleType();
        }
    }

    public function settingsUpdate(param1:int):void {
        var _loc2_:String = VehicleMarkerFlags.DAMAGE_FROM[param1];
        this.setupVehicleIcon();
        this.update();
        this.hitLabel.fakeDamage = this._model.maxHealth - this._model.currHealth;
        this.hitLabel.imitationFlag = VehicleMarkerFlags.DAMAGE_COLOR[_loc2_][this._markerColor];
        this.hitLabel.imitation = this.getIsPartVisible(DAMAGE_PANEL);
    }

    public function showActionMarker(param1:String):void {
        this.actionMarker.showAction(param1);
    }

    public function showExInfo():void {
        this.updateMarkerSettings();
    }

    public function update():void {
        this.updateMarkerColor();
        this.updateMarkerSettings();
    }

    public function updateHealth(param1:int, param2:int, param3:String):void {
        var _loc4_:String = VehicleMarkerFlags.DAMAGE_FROM[param2];
        if (param1 < 0) {
            param3 = VehicleMarkerFlags.DAMAGE_EXPLOSION;
            param1 = 0;
        }
        var _loc5_:int = this._model.currHealth - param1;
        this._model.currHealth = param1;
        if (this._isPopulated) {
            if (this.getIsPartVisible(HEALTH_BAR)) {
                this.healthBar.updateHealth(param1, VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor]);
            }
            if (this.getIsPartVisible(DAMAGE_PANEL)) {
                this.hitLabel.damage(_loc5_, VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor]);
                if (VehicleMarkerFlags.checkAllowedDamages(param3)) {
                    this.hitExplosion.setColorAndDamageType(VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor], param3);
                    this.hitExplosion.x = Math.round(this.hitLabel.x + this.hitLabel.damageLabel.textWidth + EXPLOSION_HORIZONTAL_OFFSET);
                    this.hitExplosion.playShowTween();
                }
                this.hitLabel.playShowTween();
            }
            if (this.getIsPartVisible(HEALTH_LBL)) {
                if (this._vehicleDestroyed) {
                    this.setDestroyedColorForHP();
                }
                this.setHealthText();
            }
        }
    }

    public function setHealth(param1:int):void {
        if (param1 < 0) {
            param1 = 0;
        }
        this._model.currHealth = param1;
        if (this._isPopulated) {
            if (this.getIsPartVisible(HEALTH_BAR)) {
                this.healthBar.currHealth = param1;
            }
            if (this.getIsPartVisible(HEALTH_LBL)) {
                if (this._vehicleDestroyed) {
                    this.setDestroyedColorForHP();
                }
                this.setHealthText();
            }
        }
    }

    public function updateState(param1:String, param2:Boolean):void {
        if (this._vehicleDestroyed) {
            return;
        }
        if (param2 && param1 == STATE_DEAD) {
            param1 = STATE_IMMEDIATE_DEAD;
        }
        this.setMarkerState(param1);
    }

    public function updateTimer(param1:String):void {
    }

    private function makeColorSchemeName():void {
        this._colorSchemeName = (!!this._vehicleDestroyed ? VM_DEAD_PREFIX : VM_PREFIX) + this._entityName;
    }

    private function updateMarkerSettings():void {
        var _loc1_:Boolean = this.getIsPartVisible(ICON);
        var _loc2_:Boolean = this.getIsPartVisible(LEVEL);
        var _loc3_:Boolean = this.getIsPartVisible(P_NAME_LBL);
        var _loc4_:Boolean = this.getIsPartVisible(V_NAME_LBL);
        var _loc5_:Boolean = this.getIsPartVisible(HEALTH_BAR);
        var _loc6_:Boolean = this.getIsPartVisible(HEALTH_LBL);
        var _loc7_:Boolean = this.getIsPartVisible(DAMAGE_PANEL);
        this.playerNameField.visible = _loc3_;
        this.playerNameField.text = this._model.pName;
        this.vehicleNameField.visible = _loc4_;
        this.vehicleNameField.text = this._model.vType;
        if (_loc5_) {
            this.healthBar.currHealth = this._model.currHealth;
        }
        this.healthBar.visible = _loc5_;
        this.hpFieldContainer.visible = _loc6_;
        this.hpFieldContainer.setWithBarType(_loc5_);
        if (this._vehicleDestroyed) {
            this.setDestroyedColorForHP();
        }
        this.setHealthText();
        this.hitLabel.visible = _loc7_;
        this.hitExplosion.visible = _loc7_;
        this.levelIcon.visible = _loc2_;
        this.vehicleIcon.visible = _loc1_;
        var _loc8_:int = (_loc5_ || _loc6_ ? 1 : 0) + (_loc2_ || _loc1_ ? 1 : 0) + (!!_loc3_ ? 1 : 0) + (!!_loc4_ ? 1 : 0);
        if (_loc8_ == 4) {
            _loc8_ = 3;
        }
        if (_loc5_) {
            _loc8_ = _loc8_ + SHADOW_TYPE_HBAR_OFFSET;
        }
        var _loc9_:Point = SHADOW_POSITIONS[_loc8_];
        this._vmManager.drawGraphics(VMAtlasItemName.getShadowName(_loc8_), this.bgShadow.graphics, _loc9_);
        this.bgShadow.visible = _loc5_ || _loc6_ || _loc2_ || _loc1_ || _loc3_ || _loc4_;
        this.layoutParts(new <Boolean>[this._model.squadIndex != 0, this._isFlagShown, _loc1_, _loc2_, _loc4_, _loc3_, _loc5_ || _loc6_]);
    }

    private function updateMarkerColor():void {
        var _loc1_:String = this._vmManager.getAliasColor(this._colorSchemeName);
        if (this._markerColor == _loc1_) {
            return;
        }
        this._markerColor = _loc1_;
        this.applyColor();
        if (this._model.vClass) {
            this.setVehicleType();
        }
        this.setMarkerState(this._markerState);
        this.updateIconColor();
    }

    private function applyColor():void {
        this.healthBar.color = this._markerColor;
    }

    private function layoutParts(param1:Vector.<Boolean>):void {
        var _loc8_:int = 0;
        var _loc2_:Vector.<DisplayObject> = new <DisplayObject>[this.squadIcon, this.marker2, this.vehicleIcon, this.levelIcon, this.vehicleNameField, this.playerNameField, this.healthBar];
        if (this.squadIcon.visible) {
            this.squadIcon.y = SQUAD_Y;
            this.marker2.y = FLAG_WITH_SQUAD_Y;
        }
        else {
            this.marker2.y = FLAG_NO_SQUAD_Y;
        }
        this.actionMarker.y = ACTION_Y;
        this.vehicleIcon.y = ICON_Y;
        this.levelIcon.y = LEVEL_Y;
        this.vehicleNameField.y = V_NAME_LBL_Y;
        this.playerNameField.y = P_NAME_LBL_Y;
        this.healthBar.y = HEALTH_BAR_Y;
        this.hpFieldContainer.y = HEALTH_BAR_Y + HP_FIELD_VERTICAL_OFFSET;
        var _loc3_:Vector.<int> = new Vector.<int>(0);
        var _loc4_:int = _loc2_.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc3_.push(!!param1[_loc5_] ? 0 : OFFSETS[_loc5_]);
            _loc5_++;
        }
        var _loc6_:DisplayObject = null;
        var _loc7_:int = _loc3_.length;
        _loc5_ = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = _loc2_[_loc5_];
            if (_loc6_) {
                _loc8_ = _loc5_ + 1;
                while (_loc8_ < _loc7_) {
                    _loc6_.y = _loc6_.y + _loc3_[_loc8_];
                    _loc8_++;
                }
            }
            _loc5_++;
        }
        _loc2_.splice(0, _loc4_);
        _loc3_.splice(0, _loc7_);
        _loc2_ = null;
        _loc3_ = null;
    }

    private function setMarkerState(param1:String):void {
        var _loc2_:uint = 0;
        this._markerState = param1;
        this._vehicleDestroyed = this._markerState == STATE_DEAD || this._markerState == STATE_IMMEDIATE_DEAD;
        this.makeColorSchemeName();
        if (initialized) {
            if (this._model.speaking) {
                this.setVehicleType();
            }
            _loc2_ = this._vmManager.getRGB(this._colorSchemeName);
            if (!isNaN(_loc2_)) {
                this.playerNameField.textColor = _loc2_;
                this.vehicleNameField.textColor = _loc2_;
            }
            if (this._markerState != "") {
                if (this._vehicleDestroyed) {
                    this.actionMarker.stopAction();
                    this.updateIconColor();
                    this.setDestroyedColorForHP();
                    if (this._markerState == STATE_IMMEDIATE_DEAD) {
                        this.hitLabel.transform.colorTransform = this._vmManager.getTransform(this._colorSchemeName);
                    }
                }
                this.updateMarkerSettings();
                this.marker.gotoAndPlay(this._markerState);
            }
        }
    }

    private function getIsPartVisible(param1:String):Boolean {
        var _loc2_:* = false;
        var _loc3_:String = MARKER + (!!this.exInfo ? ALT : BASE) + param1;
        if (param1 == HEALTH_LBL) {
            _loc2_ = this.markerSettings[_loc3_] != HPDisplayMode.HIDDEN;
        }
        else {
            _loc2_ = Boolean(this.markerSettings[_loc3_]);
        }
        return _loc2_;
    }

    private function setDestroyedColorForHP():void {
        this.hpFieldContainer.setTextColor(VEHICLE_DESTROY_COLOR);
    }

    private function setHealthText():void {
        var _loc1_:String = Values.EMPTY_STR;
        var _loc2_:int = this.markerSettings[MARKER + (!!this.exInfo ? ALT : BASE) + HEALTH_LBL];
        switch (_loc2_) {
            case HPDisplayMode.PERCENTS:
                _loc1_ = this.getHealthPercents() + PERCENT_STRING;
                break;
            case HPDisplayMode.CURRENT_AND_MAXIMUM:
                _loc1_ = this._model.currHealth + SLASH_STRING + this._model.maxHealth;
                break;
            case HPDisplayMode.CURRENT:
                _loc1_ = this._model.currHealth.toString();
                break;
            default:
                _loc1_ = Values.EMPTY_STR;
        }
        this.hpFieldContainer.setText(_loc1_);
    }

    private function setVehicleType():void {
        var _loc1_:String = null;
        if (this._model.speaking && !this._vehicleDestroyed) {
            _loc1_ = VMAtlasItemName.SPEAKING_ICON;
        }
        else {
            _loc1_ = VMAtlasItemName.getVehicleTypeIconName(this._markerColor, this._model.vClass, this._model.hunt);
        }
        this._vmManager.drawWithCenterAlign(_loc1_, this.marker.vehicleTypeIcon.graphics, true, false, 0, V_TYPE_ICON_Y);
    }

    private function updateIconColor():void {
        this.vehicleIcon.transform.colorTransform = this._vmManager.getTransform(this._colorSchemeName);
    }

    override protected function onDispose():void {
        this.healthBar.hitSplash.removeEventListener(HealthBarAnimatedPart.HIDE, this.onSplashHideHandler);
        this._vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO, this.onShowExInfoHandler);
        this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS, this.onUpdateSettingsHandler);
        this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS, this.onUpdateColorsHandler);
        this.vehicleIcon = null;
        this.hpFieldContainer.dispose();
        this.hpFieldContainer = null;
        this.actionMarker.dispose();
        this.actionMarker = null;
        this.marker.dispose();
        this.marker = null;
        this.marker2.dispose();
        this.marker2 = null;
        this.hitLabel.dispose();
        this.hitLabel = null;
        this.hitExplosion.dispose();
        this.hitExplosion = null;
        this.vehicleNameField = null;
        this.playerNameField = null;
        this.healthBar.dispose();
        this.healthBar = null;
        this.bgShadow = null;
        this.levelIcon = null;
        this.squadIcon = null;
        this._model = null;
        if (this._markerSettingsOverride) {
            this._markerSettingsOverride = null;
        }
        this._vmManager = null;
        super.onDispose();
    }

    private function setupSquadIcon():void {
        var _loc1_:String = null;
        var _loc2_:String = null;
        if (this._model.squadIndex) {
            _loc1_ = this._vmManager.getAliasColor(this._colorSchemeName);
            _loc2_ = VMAtlasItemName.getSquadIconName(_loc1_, this._model.squadIndex);
            this._vmManager.drawWithCenterAlign(_loc2_, this.squadIcon.graphics, true, false);
        }
    }

    private function getHealthPercents():int {
        var _loc1_:int = Math.ceil(this._model.currHealth * this._maxHealthMult);
        return _loc1_ <= MAX_HEALTH_PERCENT ? int(_loc1_) : int(MAX_HEALTH_PERCENT);
    }

    private function setupVehicleIcon():void {
        var _loc1_:Array = this._model.vIconSource.split("/");
        var _loc2_:String = _loc1_[_loc1_.length - 1].replace(".png", "");
        this._vmManager.drawWithCenterAlign(_loc2_, this.vehicleIcon.graphics, true, false);
        this.updateIconColor();
    }

    private function onShowExInfoHandler(param1:VehicleMarkersManagerEvent):void {
        this.updateMarkerSettings();
    }

    private function onUpdateSettingsHandler(param1:VehicleMarkersManagerEvent):void {
        this.updateMarkerSettings();
    }

    private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent):void {
        this.updateMarkerColor();
        this.setupSquadIcon();
        this.updateMarkerSettings();
    }

    public function get markerSettings():Object {
        var _loc1_:Object = null;
        if (this._markerSettingsOverride) {
            _loc1_ = this._markerSettingsOverride;
        }
        else if (this._vehicleDestroyed) {
            _loc1_ = this._vmManager.markerSettings[STATE_DEAD];
        }
        else {
            _loc1_ = this._vmManager.markerSettings[this.entityType];
        }
        return _loc1_;
    }

    public function set markerSettings(param1:Object):void {
        this._markerSettingsOverride = param1;
    }

    public function get isEnabledExInfo():Boolean {
        var _loc1_:String = MARKER + (!!this.exInfo ? ALT : BASE) + DEAD;
        return this.markerSettings[_loc1_];
    }

    public function get exInfo():Boolean {
        return this._exInfoOverride || this._vmManager.showExInfo;
    }

    public function set exInfo(param1:Boolean):void {
        this._exInfoOverride = param1;
    }

    public function get entityName():String {
        return this._entityName;
    }

    public function set entityName(param1:String):void {
        this._entityName = param1;
        this._model.entityName = this._entityName;
        this.actionMarker.entityName = this._entityName;
        this.makeColorSchemeName();
    }

    public function get entityType():String {
        return this._entityType;
    }

    public function set entityType(param1:String):void {
        this._entityType = param1;
    }

    private function onSplashHideHandler(param1:Event):void {
        if (this._vehicleDestroyed || this._model.currHealth <= 0) {
            this.updateMarkerSettings();
        }
    }

    public function updateFlagBearerState(param1:Boolean):void {
        this._isFlagShown = param1;
        this.updateFlag();
    }

    private function updateFlag():void {
        if (this._isFlagShown) {
            if (this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ALLY) {
                this.marker2.showGreen();
            }
            else if (this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ENEMY) {
                if (this._vmManager.isColorBlind) {
                    this.marker2.showPurple();
                }
                else {
                    this.marker2.showRed();
                }
            }
        }
        else {
            this.marker2.hide();
        }
    }
}
}

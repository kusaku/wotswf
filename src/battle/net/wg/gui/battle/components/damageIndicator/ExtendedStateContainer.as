package net.wg.gui.battle.components.damageIndicator {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.Dictionary;

import net.wg.data.constants.generated.DAMAGE_INDICATOR_ATLAS_ITEMS;
import net.wg.data.constants.generated.TANK_TYPES;
import net.wg.utils.IDataUtils;

import scaleform.gfx.TextFieldEx;

public class ExtendedStateContainer extends StandardStateContainer {

    private static const STATE_BG_Y_PADDING:int = 200;

    private static const TANK_ICON_Y_PADDING:int = 16;

    private static const VALUE_LINE_Y_PADDING:int = -131;

    private static const TANKNAME_DEFAULT_POSITION:int = -315;

    private static const BASE_CIRCLES_Y_POSITION:int = -259;

    private static const TEXT_SIZE_WITH_LOW_SYMBOLS:int = 18;

    private static const DEFAULT_TEXT_SIZE_WITH_SYMBOLS:int = 16;

    private static const LOW_COUNT_SYMBOLS:int = 3;

    private static const BASE_CIRCLES:Vector.<String> = new <String>[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_CIRCLE_BLIND, DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCK_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRIT_CIRCLE];

    private static const CRITS_ITEMS_CIRCLES:Vector.<String> = new <String>[DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_GUN_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_TRIPLEX_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_TRACKS_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_AMMO_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_COMMANDER_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_DRIVER_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_ENGINE_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_GUNNER_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_RADIO_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_RADIOMAN_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_RELOADER_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_TANKS_CIRCLE, DAMAGE_INDICATOR_ATLAS_ITEMS.CRITS_TURRET_CIRCLE];

    private static const TANK_TYPE_ICONS:Vector.<String> = new <String>[TANK_TYPES.HEAVY_TANK, TANK_TYPES.MEDIUM_TANK, TANK_TYPES.LIGHT_TANK, TANK_TYPES.AT_SPG, TANK_TYPES.SPG];

    public var tankName:ItemWithRotation = null;

    public var tankNameTF:TextField = null;

    public var damage:ItemWithRotation = null;

    public var damageTF:TextField = null;

    public var tankIcon:Sprite = null;

    private var _valueLine:Shape = null;

    private var _tankTypeIconsMap:Dictionary = null;

    private var _circlesMap:Dictionary = null;

    private var _settingIsWithTankInfo:Boolean = true;

    private var _settingIsWithValue:Boolean = true;

    private var _currentCircle:Shape = null;

    private var _currentCircleStr:String;

    private var _currentTankIconStr:String;

    private var _currentTankIcon:Shape = null;

    private var _tankNameStr:String;

    private var _isBigTitle:Boolean = false;

    private var _damageTextFormat:TextFormat = null;

    public function ExtendedStateContainer() {
        super();
    }

    override public function dispose():void {
        var _loc1_:IDataUtils = App.utils.data;
        _loc1_.cleanupDynamicObject(this._tankTypeIconsMap);
        this._tankTypeIconsMap = null;
        _loc1_.cleanupDynamicObject(this._circlesMap);
        this._circlesMap = null;
        this.tankNameTF = null;
        this.damageTF = null;
        this.tankIcon = null;
        this._currentTankIcon = null;
        this.tankName.dispose();
        this.tankName = null;
        this.damage.dispose();
        this.damage = null;
        this._valueLine = null;
        this._damageTextFormat = null;
        this._currentCircle = null;
        super.dispose();
    }

    override public function init():void {
        super.init();
        this.tankNameTF = this.tankName.textField;
        this.damageTF = this.damage.textField;
        this._tankTypeIconsMap = createItemsFromAtlas(TANK_TYPE_ICONS, this.tankIcon, null);
        this._circlesMap = createItemsFromAtlas(BASE_CIRCLES, this, null);
        this.setNewPosition(this._circlesMap, BASE_CIRCLES_Y_POSITION);
        this._circlesMap = createItemsFromAtlas(CRITS_ITEMS_CIRCLES, this.damage, this._circlesMap);
        this._valueLine = createIndicatorAtlasShape(DAMAGE_INDICATOR_ATLAS_ITEMS.VALUE_LINE, this);
        statesBG = createItemsFromAtlas(this.stateNames, this, null);
        statesBG[DAMAGE_INDICATOR_ATLAS_ITEMS.CRIT] = createIndicatorAtlasShape(DAMAGE_INDICATOR_ATLAS_ITEMS.CRIT, this);
        currentState = statesBG[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_SMALL];
        this._currentTankIcon = this._tankTypeIconsMap[TANK_TYPES.LIGHT_TANK];
        this._currentCircle = this._circlesMap[DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCK_CIRCLE];
        this._valueLine.visible = true;
        this.tankNameTF.autoSize = TextFieldAutoSize.CENTER;
        this.damageTF.autoSize = TextFieldAutoSize.CENTER;
        TextFieldEx.setVerticalAlign(this.tankNameTF, TextFieldEx.VALIGN_CENTER);
        TextFieldEx.setVerticalAlign(this.damageTF, TextFieldEx.VALIGN_CENTER);
        this._damageTextFormat = this.damageTF.getTextFormat();
    }

    override protected function updatePosition():void {
        this.setNewPosition(this._tankTypeIconsMap, TANK_ICON_Y_PADDING);
        this.setNewPosition(statesBG, STATE_BG_Y_PADDING);
        this._valueLine.y = -this._valueLine.height + VALUE_LINE_Y_PADDING;
    }

    public function setExtendedData(param1:String, param2:String, param3:String, param4:String, param5:String):void {
        var _loc6_:* = false;
        updateBGState(param1);
        if (this._settingIsWithTankInfo) {
            if (this._currentTankIconStr != param4) {
                this._currentTankIcon.visible = false;
                if (param4 != "") {
                    this._currentTankIconStr = param4;
                    this._currentTankIcon = this._tankTypeIconsMap[param4];
                    this._currentTankIcon.visible = true;
                }
            }
            if (this._tankNameStr != param3) {
                this._tankNameStr = param3;
                this.tankNameTF.text = param3;
                this.tankNameTF.y = -this.tankNameTF.height >> 1;
                this.tankName.y = TANKNAME_DEFAULT_POSITION - (this.tankNameTF.textWidth >> 1);
            }
        }
        if (this._settingIsWithValue) {
            if (this._currentCircleStr != param2) {
                this._currentCircleStr = param2;
                this._currentCircle.visible = false;
                this._currentCircle = this._circlesMap[this._currentCircleStr];
                this._currentCircle.visible = true;
            }
            _loc6_ = param5.length > LOW_COUNT_SYMBOLS;
            if (this._isBigTitle != _loc6_) {
                this._isBigTitle = _loc6_;
                this._damageTextFormat.size = !!this._isBigTitle ? TEXT_SIZE_WITH_LOW_SYMBOLS : DEFAULT_TEXT_SIZE_WITH_SYMBOLS;
                this.damageTF.setTextFormat(this._damageTextFormat);
            }
            this.damageTF.text = param5;
            this.damageTF.y = -this.damageTF.height >> 1;
        }
    }

    public function updateSettings(param1:Boolean, param2:Boolean):void {
        if (param1 != this._settingIsWithTankInfo) {
            this._settingIsWithTankInfo = param1;
            this.tankName.visible = this._settingIsWithTankInfo;
            this.tankIcon.visible = this._settingIsWithTankInfo;
            this._currentTankIcon.visible = this._settingIsWithTankInfo;
        }
        if (param2 != this._settingIsWithValue) {
            this._settingIsWithValue = param2;
            this._valueLine.visible = this.damage.visible = this._settingIsWithValue;
            this._currentCircle.visible = this._settingIsWithValue;
        }
    }

    private function setNewPosition(param1:Object, param2:int):void {
        var _loc3_:Shape = null;
        for each(_loc3_ in param1) {
            _loc3_.y = -_loc3_.height + param2;
        }
    }

    override protected function get stateNames():Vector.<String> {
        return new <String>[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_SMALL, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_MEDIUM, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_BIG, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_SMALL_BLIND, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_MEDIUM_BLIND, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_BIG_BLIND, DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCKED_SMALL, DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCKED_MEDIUM, DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCKED_BIG, DAMAGE_INDICATOR_ATLAS_ITEMS.CRIT];
    }
}
}

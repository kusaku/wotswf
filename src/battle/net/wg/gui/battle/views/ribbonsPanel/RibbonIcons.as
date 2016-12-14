package net.wg.gui.battle.views.ribbonsPanel {
import flash.display.MovieClip;
import flash.display.Shape;
import flash.utils.Dictionary;

import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.generated.TANK_TYPES;
import net.wg.gui.battle.views.ribbonsPanel.data.BackgroundAtlasNames;
import net.wg.gui.battle.views.ribbonsPanel.data.PaddingSettings;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonSettings;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.managers.IAtlasManager;

public class RibbonIcons extends MovieClip implements IDisposable {

    private static const RIBBON_TYPE_ICON_X:int = 88;

    private static const RIBBON_TYPE_ICON_Y:int = -5;

    private static const VEH_ICON_Y:int = 11;

    private static const EMPTY_STR:String = "";

    private var _background:Shape = null;

    private var _ribbonTypeIcon:Shape = null;

    private var _atlasMgr:IAtlasManager = null;

    private var _currentTankIcon:Shape = null;

    private var _currentTankIconStr:String = null;

    private var _vehiclesIconMap:Dictionary = null;

    private var _isWithVehName:Boolean = false;

    private var _vehIconPositionWithRibbonName:int = 0;

    private var _ribbonSettings:RibbonSettings = null;

    public function RibbonIcons() {
        super();
        this._atlasMgr = App.atlasMgr;
        this._background = new Shape();
        this._ribbonTypeIcon = new Shape();
        this._ribbonTypeIcon.y = RIBBON_TYPE_ICON_Y;
        addChild(this._background);
        addChild(this._ribbonTypeIcon);
        this._vehiclesIconMap = new Dictionary();
        this._vehiclesIconMap[TANK_TYPES.LIGHT_TANK] = this.createAtlasShape(BattleAtlasItem.WHITE_ICON_LIGHTTANK_16X16);
        this._vehiclesIconMap[TANK_TYPES.MEDIUM_TANK] = this.createAtlasShape(BattleAtlasItem.WHITE_ICON_MEDIUM_TANK_16X16);
        this._vehiclesIconMap[TANK_TYPES.HEAVY_TANK] = this.createAtlasShape(BattleAtlasItem.WHITE_ICON_HEAVYTANK_16X16);
        this._vehiclesIconMap[TANK_TYPES.AT_SPG] = this.createAtlasShape(BattleAtlasItem.WHITE_ICON_AT_SPG_16X16);
        this._vehiclesIconMap[TANK_TYPES.SPG] = this.createAtlasShape(BattleAtlasItem.WHITE_ICON_SPG_16X16);
    }

    public final function dispose():void {
        App.utils.data.cleanupDynamicObject(this._vehiclesIconMap);
        this._ribbonSettings = null;
        this._vehiclesIconMap = null;
        this._background = null;
        this._ribbonTypeIcon = null;
        this._currentTankIcon = null;
        this._atlasMgr = null;
    }

    public function init(param1:RibbonSettings, param2:int):void {
        this._ribbonSettings = param1;
        this._atlasMgr.drawGraphics(AtlasConstants.BATTLE_ATLAS, this._ribbonSettings.icon, this._ribbonTypeIcon.graphics);
        this._vehIconPositionWithRibbonName = param2;
    }

    public function setSettings(param1:Boolean, param2:Boolean):void {
        var _loc5_:int = 0;
        var _loc6_:Shape = null;
        var _loc7_:* = null;
        var _loc8_:String = null;
        var _loc9_:BackgroundAtlasNames = null;
        var _loc3_:PaddingSettings = RibbonSettings.getPaddings(param1, param2);
        var _loc4_:Dictionary = RibbonSettings.ICON_X_PADDINGS;
        this._isWithVehName = param2;
        if (this._currentTankIcon != null) {
            this._currentTankIcon.visible = this._currentTankIconStr != EMPTY_STR && this._isWithVehName;
        }
        this._ribbonTypeIcon.x = RIBBON_TYPE_ICON_X + _loc3_.ribbonIconPaddingX;
        if (param1) {
            _loc5_ = this._vehIconPositionWithRibbonName;
        }
        else {
            _loc5_ = RIBBON_TYPE_ICON_X + this._ribbonTypeIcon.width;
        }
        for (_loc7_ in this._vehiclesIconMap) {
            _loc6_ = this._vehiclesIconMap[_loc7_];
            _loc6_.x = _loc5_ + _loc3_.tankIconPaddingX + _loc4_[_loc7_];
            _loc6_.y = VEH_ICON_Y;
        }
        _loc9_ = this._ribbonSettings.backgrounds;
        if (param1 && param2) {
            _loc8_ = _loc9_.large;
        }
        else if (!param1 && !param2) {
            _loc8_ = _loc9_.small;
        }
        else {
            _loc8_ = _loc9_.medium;
        }
        this._atlasMgr.drawGraphics(AtlasConstants.BATTLE_ATLAS, _loc8_, this._background.graphics);
    }

    public function setTankIcon(param1:String):void {
        if (this._currentTankIcon != null && this._currentTankIconStr != param1) {
            this._currentTankIconStr = EMPTY_STR;
            this._currentTankIcon.visible = false;
            this._currentTankIcon = null;
        }
        if (this._isWithVehName && param1 != EMPTY_STR && this._currentTankIconStr != param1) {
            this._currentTankIconStr = param1;
            this._currentTankIcon = this._vehiclesIconMap[this._currentTankIconStr];
            this._currentTankIcon.visible = true;
        }
    }

    private function createAtlasShape(param1:String):Shape {
        var _loc2_:Shape = new Shape();
        this._atlasMgr.drawGraphics(AtlasConstants.BATTLE_ATLAS, param1, _loc2_.graphics);
        addChild(_loc2_);
        _loc2_.visible = false;
        return _loc2_;
    }
}
}

package net.wg.gui.battle.falloutMultiteam.views.components.fullStats {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.infrastructure.interfaces.IColorScheme;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FMStatsTeam extends Sprite implements IDisposable {

    private static const CURRENT_SQUAD_SCHEME:String = "falloutSelfGold";

    private static const BLIND_COLOR_NAME:String = "blind";

    public var bg:BattleAtlasSprite = null;

    public var squadIcon:BattleAtlasSprite = null;

    public var playerIcon:BattleAtlasSprite = null;

    public var squadTF:TextField = null;

    private var _defaultSquadColor:uint = 0;

    private var _squadIndex:int = 0;

    private var _members:Vector.<Number> = null;

    private var _initialized:Boolean = false;

    public function FMStatsTeam() {
        super();
        this._defaultSquadColor = this.squadTF.textColor;
        this.squadIcon.visible = false;
        this.playerIcon.visible = false;
        this.squadTF.visible = false;
        this.bg.visible = false;
        this.bg.imageName = BattleAtlasItem.FM_STATS_TEAM_BG;
    }

    public function init(param1:Boolean, param2:int = 0):void {
        App.utils.asserter.assert(!this._initialized, this + " already initialized");
        var _loc3_:IColorScheme = App.colorSchemeMgr.getScheme(CURRENT_SQUAD_SCHEME);
        if (param2) {
            if (param1) {
                this.squadIcon.imageName = _loc3_.aliasColor == BLIND_COLOR_NAME ? BattleAtlasItem.FM_STATS_TEAM_CURRENT_SQUAD_ICON_BLIND : BattleAtlasItem.FM_STATS_TEAM_CURRENT_SQUAD_ICON;
                this.squadTF.textColor = _loc3_.rgb;
            }
            else {
                this.squadIcon.imageName = BattleAtlasItem.FM_STATS_TEAM_SQUAD_ICON;
                this.squadTF.textColor = this._defaultSquadColor;
            }
            this.squadTF.text = param2.toString();
            this.playerIcon.visible = false;
            this.squadIcon.visible = true;
            this.squadTF.visible = true;
        }
        else {
            if (param1) {
                this.playerIcon.imageName = _loc3_.aliasColor == BLIND_COLOR_NAME ? BattleAtlasItem.FM_STATS_TEAM_CURRENT_PLAYER_BLIND : BattleAtlasItem.FM_STATS_TEAM_CURRENT_PLAYER_ICON;
            }
            else {
                this.playerIcon.imageName = BattleAtlasItem.FM_STATS_TEAM_PLAYER_ICON;
            }
            this.squadIcon.visible = false;
            this.squadTF.visible = false;
            this.playerIcon.visible = true;
        }
        this._squadIndex = param2;
        this._initialized = true;
        this.bg.visible = true;
    }

    public function get initialized():Boolean {
        return this._initialized;
    }

    public function get isSquadTeam():Boolean {
        return this._squadIndex != 0;
    }

    public function get squadIndex():int {
        return this._squadIndex;
    }

    public function get membersCount():int {
        return !!this._members ? int(this._members.length) : 0;
    }

    public function addMember(param1:Number):void {
        if (!this._members) {
            this._members = new Vector.<Number>();
        }
        this._members.push(param1);
    }

    public function containsMember(param1:Number):Boolean {
        return !!this._members ? this._members.indexOf(param1) != -1 : false;
    }

    public function dispose():void {
        if (this._members) {
            this._members.splice(0, this._members.length);
            this._members = null;
        }
        this.bg = null;
        this.squadIcon = null;
        this.playerIcon = null;
        this.squadTF = null;
    }
}
}

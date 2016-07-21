package net.wg.gui.battle.random.views.stats.components.fullStats {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import net.wg.gui.battle.components.BattleIconHolder;

public class BattleIconView extends BattleIconHolder {

    public var battle_training:MovieClip = null;

    public var battle_ctf:MovieClip = null;

    public var battle_team:MovieClip = null;

    public var battle_fortifications:MovieClip = null;

    public var battle_sandbox:MovieClip = null;

    public var battle_ratedsandbox:MovieClip = null;

    public var battle_historical:MovieClip = null;

    public var battle_domination:MovieClip = null;

    public var battle_assault:MovieClip = null;

    public var battle_nations:MovieClip = null;

    public var battle_escort:MovieClip = null;

    public var battle_tutorial:MovieClip = null;

    public var battle_random:MovieClip = null;

    public var battle_neutral:MovieClip = null;

    public var battle_assault1:MovieClip = null;

    public var battle_assault2:MovieClip = null;

    public var battle_team7x7:MovieClip = null;

    private var _icons:Vector.<MovieClip> = null;

    public function BattleIconView() {
        var _loc1_:MovieClip = null;
        super();
        this._icons = new <MovieClip>[this.battle_training, this.battle_ctf, this.battle_team, this.battle_fortifications, this.battle_sandbox, this.battle_ratedsandbox, this.battle_historical, this.battle_domination, this.battle_assault, this.battle_nations, this.battle_escort, this.battle_tutorial, this.battle_random, this.battle_neutral, this.battle_assault1, this.battle_assault2, this.battle_team7x7];
        for each(_loc1_ in this._icons) {
            _loc1_.visible = false;
        }
    }

    public function showIcon(param1:String):void {
        var _loc2_:DisplayObject = null;
        var _loc3_:int = this._icons.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if (this._icons[_loc4_].name == param1) {
                _loc2_ = this._icons[_loc4_];
                break;
            }
            _loc4_++;
        }
        if (_loc2_) {
            showItem(_loc2_);
        }
    }

    override protected function onDispose():void {
        this.battle_training = null;
        this.battle_ctf = null;
        this.battle_team = null;
        this.battle_fortifications = null;
        this.battle_sandbox = null;
        this.battle_ratedsandbox = null;
        this.battle_historical = null;
        this.battle_domination = null;
        this.battle_assault = null;
        this.battle_nations = null;
        this.battle_escort = null;
        this.battle_tutorial = null;
        this.battle_random = null;
        this.battle_neutral = null;
        this.battle_assault1 = null;
        this.battle_assault2 = null;
        this.battle_team7x7 = null;
        this._icons.length = 0;
        this._icons = null;
        super.onDispose();
    }
}
}

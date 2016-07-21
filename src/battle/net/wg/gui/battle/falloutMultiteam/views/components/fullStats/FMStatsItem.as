package net.wg.gui.battle.falloutMultiteam.views.components.fullStats {
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.views.stats.constants.FalloutStatsValidationType;
import net.wg.gui.battle.views.stats.fullStats.FalloutStatsItem;

public class FMStatsItem extends FalloutStatsItem {

    private var _teamScoreTF:TextField = null;

    private var _teamScore:int = 0;

    private var _teamScoreVisible:Boolean = false;

    public function FMStatsItem(param1:TextField, param2:TextField, param3:TextField, param4:BattleAtlasSprite, param5:BattleAtlasSprite, param6:BattleAtlasSprite, param7:TextField, param8:TextField, param9:TextField, param10:TextField, param11:TextField) {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        this._teamScoreTF = param11;
        this._teamScoreTF.visible = false;
        param5.imageName = BattleAtlasItem.FC_STATS_DEAD_BG;
    }

    public function setTeamScore(param1:int):void {
        if (this._teamScore == param1) {
            return;
        }
        this._teamScore = param1;
        invalidate(FalloutStatsValidationType.TEAM_SCORE);
    }

    public function setTeamScoreVisible(param1:Boolean):void {
        if (this._teamScoreVisible == param1) {
            return;
        }
        this._teamScoreVisible = param1;
        invalidate(FalloutStatsValidationType.TEAM_SCORE);
    }

    override protected function draw():void {
        var _loc1_:String = null;
        super.draw();
        if (isInvalid(FalloutStatsValidationType.TEAM_SCORE)) {
            if (this._teamScoreVisible) {
                _loc1_ = this._teamScore.toString();
                if (this._teamScoreTF.text != _loc1_) {
                    this._teamScoreTF.text = _loc1_;
                }
            }
            if (this._teamScoreTF.visible != this._teamScoreVisible) {
                this._teamScoreTF.visible = this._teamScoreVisible;
            }
        }
    }

    override protected function onDispose():void {
        this._teamScoreTF = null;
        super.onDispose();
    }
}
}

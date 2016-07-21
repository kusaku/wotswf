package net.wg.gui.battle.views.stats.fullStats {
import flash.text.TextField;

import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.views.stats.constants.FalloutStatsValidationType;
import net.wg.infrastructure.interfaces.IUserProps;

public class FalloutStatsItem extends StatsTableItemBase {

    private static const DEATHS_COLOR_NORMAL:String = "textColorFalloutRegularDeaths";

    private static const DEATHS_COLOR_NO_RESPAWN:String = "textColorFalloutHighlightedDeaths";

    protected var zeroSpecialPoints:Boolean = false;

    private var _scoreTF:TextField = null;

    private var _damageTF:TextField = null;

    private var _deathsTF:TextField = null;

    private var _specialPointsTF:TextField = null;

    private var _score:int = 0;

    private var _damage:int = 0;

    private var _deaths:int = 0;

    private var _specialPoints:int = 0;

    private var _isFilled:Boolean = false;

    private var _isRespawnDisabled:Boolean = false;

    public function FalloutStatsItem(param1:TextField, param2:TextField, param3:TextField, param4:BattleAtlasSprite, param5:BattleAtlasSprite, param6:BattleAtlasSprite, param7:TextField, param8:TextField, param9:TextField, param10:TextField) {
        super(param1, param2, param3, param4, param5, param6);
        this._scoreTF = param7;
        this._damageTF = param8;
        this._deathsTF = param9;
        this._specialPointsTF = param10;
        this._scoreTF.visible = false;
        this._damageTF.visible = false;
        this._deathsTF.visible = false;
        this._specialPointsTF.visible = false;
    }

    override public function setPlayerName(param1:IUserProps):void {
        super.setPlayerName(param1);
        this._isFilled = true;
        invalidate(FalloutStatsValidationType.SCORE);
        invalidate(FalloutStatsValidationType.DAMAGE);
        invalidate(FalloutStatsValidationType.SPECIAL_POINTS);
    }

    public function setScore(param1:int):void {
        if (this._score == param1) {
            return;
        }
        this._score = param1;
        invalidate(FalloutStatsValidationType.SCORE);
    }

    public function setDamage(param1:int):void {
        if (this._damage == param1) {
            return;
        }
        this._damage = param1;
        invalidate(FalloutStatsValidationType.DAMAGE);
    }

    public function setDeaths(param1:int):void {
        if (this._deaths == param1) {
            return;
        }
        this._deaths = param1;
        invalidate(FalloutStatsValidationType.DEATHS);
    }

    public function setSpecialPoints(param1:int):void {
        if (this._specialPoints == param1) {
            return;
        }
        this._specialPoints = param1;
        invalidate(FalloutStatsValidationType.SPECIAL_POINTS);
    }

    public function setIsRespawnDisabled(param1:Boolean):void {
        if (this._isRespawnDisabled == param1) {
            return;
        }
        this._isRespawnDisabled = param1;
        invalidate(FalloutStatsValidationType.RESPAWN_STATE);
    }

    override public function reset():void {
        this._score = 0;
        this._damage = 0;
        this._deaths = 0;
        this._specialPoints = 0;
        this._isFilled = false;
        super.reset();
    }

    override protected function draw():void {
        var _loc1_:String = null;
        var _loc2_:uint = 0;
        super.draw();
        if (isInvalid(FalloutStatsValidationType.SCORE)) {
            this._scoreTF.visible = this._isFilled;
            if (this._isFilled) {
                this._scoreTF.text = this._score.toString();
            }
        }
        if (isInvalid(FalloutStatsValidationType.DAMAGE)) {
            this._damageTF.visible = this._isFilled;
            if (this._isFilled) {
                this._damageTF.text = this._damage.toString();
            }
        }
        if (isInvalid(FalloutStatsValidationType.DEATHS)) {
            this._deathsTF.visible = this._deaths != 0;
            if (this._deaths) {
                this._deathsTF.text = this._deaths.toString();
            }
        }
        if (isInvalid(FalloutStatsValidationType.SPECIAL_POINTS)) {
            this._specialPointsTF.visible = !!this.zeroSpecialPoints ? Boolean(this._isFilled) : this._specialPoints != 0;
            if (this._specialPointsTF.visible) {
                this._specialPointsTF.text = this._specialPoints.toString();
            }
        }
        if (isInvalid(FalloutStatsValidationType.RESPAWN_STATE)) {
            _loc1_ = !!this._isRespawnDisabled ? DEATHS_COLOR_NO_RESPAWN : DEATHS_COLOR_NORMAL;
            _loc2_ = App.colorSchemeMgr.getRGB(_loc1_);
            this._deathsTF.textColor = _loc2_;
        }
    }

    override protected function onDispose():void {
        this._scoreTF = null;
        this._damageTF = null;
        this._deathsTF = null;
        this._specialPointsTF = null;
        super.onDispose();
    }
}
}

package net.wg.gui.battle.components.falloutScorePanel {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextField;

import net.wg.data.VO.daapi.DAAPIFalloutTotalStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.views.vehicleMarkers.HealthBar;
import net.wg.infrastructure.base.meta.IFalloutBaseScorePanelMeta;
import net.wg.infrastructure.base.meta.impl.FalloutBaseScorePanelMeta;
import net.wg.infrastructure.events.ColorSchemeEvent;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;
import net.wg.infrastructure.managers.IAtlasManager;
import net.wg.infrastructure.managers.IColorSchemeManager;

public class FalloutBaseScorePanel extends FalloutBaseScorePanelMeta implements IFalloutBaseScorePanelMeta, IBattleComponentDataController {

    private static const ENEMY_EAR_SHADOW_COLOR_SCHEME:String = "falloutScorePanelEnemyEarShadow";

    private static const ENEMY_HEALTH_BAR_COLOR_ALIAS:String = "scorePanelHealthBar";

    private static const ALLY_HEALTH_BAR_COLOR:String = "green";

    private static const HIGHLIGHT_ANIM_START_LABEL:String = "start";

    private static const HIGHLIGHT_ANIM_STOP_LABEL:String = "stop";

    private static const HIGHLIGHT_WIN_STATE_ID:int = 0;

    private static const HIGHLIGHT_LOSE_STATE_ID:int = 1;

    private static const HIGHLIGHT_DRAW_STATE_ID:int = 2;

    private static const INVALID_COLOR_SCHEME:String = "invalidColorScheme";

    private static const INVALID_ARROWS:String = "invalidArrows";

    private static const INVALID_SCORE_HIGHLIGHT_ANIMATION:String = "invalidScoreHighlightAnimation";

    private static const INVALID_MAX_VALUE:String = "invalidMaxValue";

    private static const INVALID_ALLY_SCORE:String = "invalidAllyScore";

    private static const INVALID_ENEMY_SCORE:String = "invalidEnemyScore";

    private static const INVALID_ALLY_WARNING:String = "invalidAllyWarning";

    private static const INVALID_ENEMY_WARNING:String = "invalidEnemyWarning";

    public var allyArrowContainer:Sprite = null;

    public var falloutScorePanelDivider:Sprite = null;

    public var enemyArrowContainer:Sprite = null;

    public var allyScoreTF:TextField = null;

    public var enemyScoreTF:TextField = null;

    public var totalScoreTF:TextField = null;

    public var allyHealthBar:HealthBar = null;

    public var enemyHealthBar:HealthBar = null;

    public var allyProgressGlow:BarGlowAnimation = null;

    public var enemyProgressGlow:BarGlowAnimation = null;

    public var highlightAnimAlly:MovieClip = null;

    public var highlightAnimEnemy:MovieClip = null;

    private var _allyScore:int = 0;

    private var _enemyScore:int = 0;

    private var _maxValue:int = 0;

    private var _warningValue:int = -1;

    private var _isShowAllyWarning:Boolean = false;

    private var _isShowEnemyWarning:Boolean = false;

    private var _shadowFilter:DropShadowFilter;

    private var _atlasManager:IAtlasManager;

    private var _enemyColor:String = "";

    private var _isWinnerId:int = -1;

    private var _isPlayHighlightAnim:Boolean = false;

    private var _colorSchemeMgr:IColorSchemeManager;

    public function FalloutBaseScorePanel() {
        this._shadowFilter = new DropShadowFilter();
        this._atlasManager = App.atlasMgr;
        this._colorSchemeMgr = App.colorSchemeMgr;
        super();
        this._shadowFilter.distance = 0;
        this._shadowFilter.angle = 0;
        this._shadowFilter.alpha = 1;
        this._shadowFilter.blurX = 13;
        this._shadowFilter.blurY = 13;
        this.allyHealthBar.color = ALLY_HEALTH_BAR_COLOR;
        this.getColorSchemeProperties();
        this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemeUpdatedHandler);
    }

    override protected function configUI():void {
        super.configUI();
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, ALLY_HEALTH_BAR_COLOR + BattleAtlasItem.FALLOUT_SCORE_PANEL_ARROW, this.allyArrowContainer.graphics);
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, BattleAtlasItem.FALLOUT_SCORE_PANEL_DIVIDER, this.falloutScorePanelDivider.graphics);
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        super.draw();
        if (isInvalid(INVALID_COLOR_SCHEME)) {
            this.enemyHealthBar.color = this._enemyColor;
            this.enemyHealthBar.currHealth = this._enemyScore;
            this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, this._enemyColor + BattleAtlasItem.FALLOUT_SCORE_PANEL_ARROW, this.enemyArrowContainer.graphics);
            this.enemyScoreTF.filters = [this._shadowFilter];
        }
        if (isInvalid(INVALID_MAX_VALUE)) {
            this.allyHealthBar.maxHealth = this._maxValue;
            this.enemyHealthBar.maxHealth = this._maxValue;
            this.totalScoreTF.text = this._maxValue.toString();
        }
        if (isInvalid(INVALID_ARROWS)) {
            if (this._allyScore == this._enemyScore) {
                this.falloutScorePanelDivider.visible = true;
                this.allyArrowContainer.visible = false;
                this.enemyArrowContainer.visible = false;
            }
            else if (this._allyScore > this._enemyScore) {
                this.falloutScorePanelDivider.visible = false;
                this.allyArrowContainer.visible = true;
                this.enemyArrowContainer.visible = false;
            }
            else {
                this.falloutScorePanelDivider.visible = false;
                this.allyArrowContainer.visible = false;
                this.enemyArrowContainer.visible = true;
            }
        }
        if (isInvalid(INVALID_SCORE_HIGHLIGHT_ANIMATION)) {
            if (this._isPlayHighlightAnim) {
                if (this._isWinnerId == HIGHLIGHT_WIN_STATE_ID) {
                    this.highlightAnimAlly.gotoAndPlay(HIGHLIGHT_ANIM_START_LABEL);
                }
                else if (this._isWinnerId == HIGHLIGHT_LOSE_STATE_ID) {
                    this.highlightAnimEnemy.gotoAndPlay(HIGHLIGHT_ANIM_START_LABEL);
                }
                else {
                    this.highlightAnimAlly.gotoAndPlay(HIGHLIGHT_ANIM_START_LABEL);
                    this.highlightAnimEnemy.gotoAndPlay(HIGHLIGHT_ANIM_START_LABEL);
                }
            }
            else {
                this.highlightAnimEnemy.gotoAndStop(HIGHLIGHT_ANIM_STOP_LABEL);
                this.highlightAnimAlly.gotoAndStop(HIGHLIGHT_ANIM_STOP_LABEL);
            }
        }
        if (isInvalid(INVALID_ALLY_SCORE)) {
            this.allyScoreTF.text = this._allyScore.toString();
            this.allyHealthBar.currHealth = this._allyScore;
        }
        if (isInvalid(INVALID_ENEMY_SCORE)) {
            this.enemyScoreTF.text = this._enemyScore.toString();
            this.enemyHealthBar.currHealth = this._enemyScore;
        }
        if (isInvalid(INVALID_ALLY_WARNING)) {
            if (this._isShowAllyWarning) {
                this.allyProgressGlow.show();
            }
            this.allyProgressGlow.updatePosition(this.allyHealthBar.x, this.allyHealthBar.getVisibleWidth());
        }
        if (isInvalid(INVALID_ENEMY_WARNING)) {
            if (this._isShowEnemyWarning) {
                this.enemyProgressGlow.show();
            }
            _loc1_ = this.enemyHealthBar.getVisibleWidth();
            this.enemyProgressGlow.updatePosition(this.enemyHealthBar.x - _loc1_, _loc1_);
        }
    }

    override protected function onBeforeDispose():void {
        this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemeUpdatedHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.allyArrowContainer = null;
        this.falloutScorePanelDivider = null;
        this.enemyArrowContainer = null;
        this.allyScoreTF = null;
        this.enemyScoreTF = null;
        this.totalScoreTF = null;
        this.allyHealthBar.dispose();
        this.allyHealthBar = null;
        this.enemyHealthBar.dispose();
        this.enemyHealthBar = null;
        this.allyProgressGlow = null;
        this.enemyProgressGlow = null;
        this.highlightAnimAlly = null;
        this.highlightAnimEnemy = null;
        this._shadowFilter = null;
        this._atlasManager = null;
        this._colorSchemeMgr = null;
        super.onDispose();
    }

    public function as_init(param1:int, param2:int):void {
        this._maxValue = param1;
        this._warningValue = param2;
        invalidate(INVALID_MAX_VALUE);
    }

    private function checkShowWarning(param1:int, param2:int, param3:Boolean, param4:String):Boolean {
        var _loc5_:Boolean = param1 < this._warningValue && param2 >= this._warningValue;
        if (param3 != _loc5_) {
            invalidate(param4);
        }
        return _loc5_;
    }

    public function as_playScoreHighlightAnim():void {
        if (this._allyScore > this._enemyScore) {
            this._isWinnerId = HIGHLIGHT_WIN_STATE_ID;
        }
        else if (this._allyScore < this._enemyScore) {
            this._isWinnerId = HIGHLIGHT_LOSE_STATE_ID;
        }
        else {
            this._isWinnerId = HIGHLIGHT_DRAW_STATE_ID;
        }
        this._isPlayHighlightAnim = true;
        invalidate(INVALID_SCORE_HIGHLIGHT_ANIMATION);
    }

    public function as_stopScoreHighlightAnim():void {
        this._isPlayHighlightAnim = false;
        invalidate(INVALID_SCORE_HIGHLIGHT_ANIMATION);
    }

    private function onColorSchemeUpdatedHandler(param1:ColorSchemeEvent):void {
        this.getColorSchemeProperties();
        invalidate(INVALID_COLOR_SCHEME);
    }

    private function getColorSchemeProperties():void {
        this._shadowFilter.color = this._colorSchemeMgr.getRGB(ENEMY_EAR_SHADOW_COLOR_SCHEME);
        this._enemyColor = this._colorSchemeMgr.getAliasColor(ENEMY_HEALTH_BAR_COLOR_ALIAS);
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        this.updateTotalStats(DAAPIVehiclesInteractiveStatsVO(param1).totalStats);
    }

    public function updateVehiclesStat(param1:IDAAPIDataClass):void {
        this.updateTotalStats(DAAPIVehiclesInteractiveStatsVO(param1).totalStats);
    }

    private function updateTotalStats(param1:DAAPIFalloutTotalStatsVO):void {
        this.setPlayerScore(param1.personalWinPoints);
        this.setPlayerName(param1.leftLabel);
        this.setEnemyName(param1.rightLabel);
        var _loc2_:int = param1.leftWinPoints;
        var _loc3_:int = param1.rightWinPoints;
        if (this._allyScore != _loc2_ || this._enemyScore != _loc3_) {
            if (this._allyScore != _loc2_) {
                this._isShowAllyWarning = this.checkShowWarning(this._allyScore, _loc2_, this._isShowAllyWarning, INVALID_ALLY_WARNING);
                this._allyScore = _loc2_;
                invalidate(INVALID_ALLY_SCORE);
            }
            if (this._enemyScore != _loc3_) {
                this._isShowEnemyWarning = this.checkShowWarning(this._enemyScore, _loc3_, this._isShowEnemyWarning, INVALID_ENEMY_WARNING);
                this._enemyScore = _loc3_;
                invalidate(INVALID_ENEMY_SCORE);
            }
            invalidate(INVALID_ARROWS);
        }
    }

    public function setPlayerScore(param1:int):void {
    }

    public function setPlayerName(param1:String):void {
    }

    public function setEnemyName(param1:String):void {
    }

    public function setVehiclesData(param1:IDAAPIDataClass):void {
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
    }

    public function updateVehiclesData(param1:IDAAPIDataClass):void {
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
    }

    public function updatePersonalStatus(param1:uint, param2:uint):void {
    }

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
    }

    public function setArenaInfo(param1:IDAAPIDataClass):void {
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
    }

    public function setPersonalStatus(param1:uint):void {
    }

    public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
    }
}
}

package net.wg.gui.lobby.battleResults.components {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.text.TextField;

import net.wg.data.constants.ArenaBonusTypes;
import net.wg.data.constants.ColorSchemeNames;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.components.icons.SquadIcon;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.infrastructure.interfaces.IColorScheme;

public class TeamMemberItemRenderer extends TeamMemberRendererBase {

    private static const DAMAGE_DEATH_COLOR:int = 6381391;

    private static const DAMAGE_DEFAULT_COLOR:int = 13413751;

    private static const DIMMED_COLOR_VALUE:Number = 0.4;

    private static const PLAYER_NAME_WIDTH:int = 98;

    private static const PLAYER_NAME_POS_X:int = 2;

    private static const VEHICLE_ICON_POS_X:int = 105;

    private static const VEHICLE_NAME_POS_X:int = 157;

    private static const DAMAGE_LBL_POS_X:int = 230;

    private static const FRAGS_LBL_POS_X:int = 286;

    private static const XP_LBL_POS_X:int = 325;

    private static const XP_ICON_POS_X:int = 368;

    private static const RESOURCE_LBL_POS_X:int = 384;

    private static const RESOURCE_ICON_POS_X:int = 429;

    private static const STATE_OUT:String = "out";

    private static const STATE_OVER:String = "over";

    private static const PLAYER_NAME_OFFSET:int = 6;

    public var clickArea:MovieClip = null;

    public var selfBg:MovieClip = null;

    public var deadBg:MovieClip = null;

    public var playerName:UserNameField = null;

    public var vehicleName:TextField = null;

    public var damageLbl:TextField = null;

    public var fragsLbl:TextField = null;

    public var xpLbl:TextField = null;

    public var xpIcon:Sprite = null;

    public var resourceLbl:TextField = null;

    public var resourceIcon:Sprite = null;

    public var medalIcon:EfficiencyIconRenderer = null;

    public var fakeFocusIndicator:MovieClip = null;

    public var squadIcon:SquadIcon = null;

    public var vehicleIcon:UILoaderAlt = null;

    public function TeamMemberItemRenderer() {
        super();
    }

    private static function getDimmFilter():ColorMatrixFilter {
        var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
        var _loc2_:Array = [DIMMED_COLOR_VALUE, 0, 0, 0, 0];
        var _loc3_:Array = [0, DIMMED_COLOR_VALUE, 0, 0, 0];
        var _loc4_:Array = [0, 0, DIMMED_COLOR_VALUE, 0, 0];
        var _loc5_:Array = [0, 0, 0, 1, 0];
        var _loc6_:Array = [];
        _loc6_ = _loc6_.concat(_loc2_);
        _loc6_ = _loc6_.concat(_loc3_);
        _loc6_ = _loc6_.concat(_loc4_);
        _loc6_ = _loc6_.concat(_loc5_);
        _loc1_.matrix = _loc6_;
        return _loc1_;
    }

    override protected function configUI():void {
        super.configUI();
        mouseChildren = true;
        hitArea = this.clickArea;
        this.medalIcon.addEventListener(MouseEvent.ROLL_OVER, this.onMedalIconRollOverHandler);
        this.medalIcon.addEventListener(MouseEvent.ROLL_OUT, this.onMedalIconRollOutHandler);
        this.medalIcon.addEventListener(MouseEvent.CLICK, this.onMedalIconClickHandler);
    }

    override protected function onDispose():void {
        this.subscribeResField(false);
        this.medalIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onMedalIconRollOverHandler);
        this.medalIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onMedalIconRollOutHandler);
        this.medalIcon.removeEventListener(MouseEvent.CLICK, this.onMedalIconClickHandler);
        this.medalIcon.dispose();
        this.medalIcon = null;
        this.clickArea = null;
        this.selfBg = null;
        this.deadBg = null;
        this.playerName.dispose();
        this.playerName = null;
        this.vehicleName = null;
        this.damageLbl = null;
        this.fragsLbl = null;
        this.xpLbl = null;
        this.xpIcon = null;
        this.resourceLbl = null;
        this.resourceIcon = null;
        this.fakeFocusIndicator = null;
        this.squadIcon.dispose();
        this.squadIcon = null;
        this.vehicleIcon.dispose();
        this.vehicleIcon = null;
        super.onDispose();
    }

    override protected function showData(param1:TeamMemberItemVO):void {
        var _loc3_:int = 0;
        this.selfBg.visible = param1.isSelf;
        this.squadIcon.hide();
        this.deadBg.visible = false;
        this.medalIcon.visible = false;
        this.resourceLbl.visible = false;
        this.resourceIcon.visible = false;
        var _loc2_:IColorScheme = null;
        if (param1.isTeamKiller) {
            _loc2_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.TEAMKILLER_DEAD : ColorSchemeNames.TEAMKILLER);
        }
        else if (param1.isOwnSquad) {
            _loc2_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.SELECTED_DEAD : ColorSchemeNames.SELECTED);
        }
        else {
            _loc2_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.NORMAL_DEAD : ColorSchemeNames.NORMAL);
        }
        if (param1.playerNamePosition) {
            _loc3_ = this.playerName.x;
            this.playerName.x = this.selfBg.x + PLAYER_NAME_OFFSET;
            this.playerName.width = this.playerName.width + (_loc3_ - this.playerName.x);
        }
        if (param1.showResources) {
            this.playerName.width = PLAYER_NAME_WIDTH;
            this.playerName.x = PLAYER_NAME_POS_X;
            this.vehicleIcon.x = VEHICLE_ICON_POS_X;
            this.vehicleName.x = VEHICLE_NAME_POS_X;
            this.damageLbl.x = DAMAGE_LBL_POS_X;
            this.fragsLbl.x = FRAGS_LBL_POS_X;
            this.xpLbl.x = XP_LBL_POS_X;
            this.xpIcon.x = XP_ICON_POS_X;
            this.resourceLbl.x = RESOURCE_LBL_POS_X;
            this.resourceIcon.x = RESOURCE_ICON_POS_X;
            this.resourceLbl.visible = true;
            this.resourceIcon.visible = true;
            if (param1.resourceCount != Values.DEFAULT_INT) {
                this.resourceLbl.text = param1.resourceCount.toString();
                this.subscribeResField(false);
            }
            else {
                this.resourceLbl.text = "-";
                this.subscribeResField(true);
            }
        }
        this.playerName.userVO = param1.userVO;
        this.playerName.textColor = _loc2_.rgb;
        this.vehicleIcon.source = !!param1.tankIcon ? param1.tankIcon : this.vehicleIcon.sourceAlt;
        this.vehicleName.htmlText = param1.vehicleName;
        this.xpLbl.text = App.utils.locale.integer(param1.xp - param1.achievementXP);
        this.damageLbl.text = "0";
        this.vehicleName.textColor = _loc2_.rgb;
        this.fragsLbl.textColor = this.damageLbl.textColor = DAMAGE_DEFAULT_COLOR;
        if (param1.deathReason > -1) {
            this.damageLbl.textColor = DAMAGE_DEATH_COLOR;
            this.deadBg.visible = true;
            this.vehicleIcon.filters = [getDimmFilter()];
        }
        else {
            this.vehicleIcon.filters = [];
        }
        if (param1.damageDealt > 0) {
            this.damageLbl.text = App.utils.locale.integer(param1.damageDealt);
        }
        if (!param1.showResources && param1.squadID > 0 && bonusType != ArenaBonusTypes.CYBERSPORT) {
            this.squadIcon.show(param1.isOwnSquad, param1.squadID);
        }
        this.fragsLbl.visible = param1.kills > 0;
        if (this.fragsLbl.visible) {
            this.fragsLbl.text = param1.kills.toString();
        }
        if (param1.tkills > 0) {
            this.fragsLbl.textColor = getColorForAlias(ColorSchemeNames.TEAMKILLER, DEFAULT_TEAM_KILLER_COLOR);
        }
        if (param1.medalsCount > 0) {
            this.medalIcon.value = param1.medalsCount;
            this.medalIcon.validateNow();
            this.medalIcon.visible = true;
        }
    }

    private function subscribeResField(param1:Boolean):void {
        if (param1) {
            if (!this.resourceLbl.hasEventListener(MouseEvent.ROLL_OVER)) {
                this.resourceLbl.addEventListener(MouseEvent.ROLL_OVER, this.onResourceRollOverHandler);
                this.resourceLbl.addEventListener(MouseEvent.ROLL_OUT, this.onMedalIconRollOutHandler);
                this.resourceIcon.addEventListener(MouseEvent.ROLL_OVER, this.onResourceRollOverHandler);
                this.resourceIcon.addEventListener(MouseEvent.ROLL_OUT, this.onMedalIconRollOutHandler);
            }
        }
        else if (this.resourceLbl.hasEventListener(MouseEvent.ROLL_OVER)) {
            this.resourceLbl.removeEventListener(MouseEvent.ROLL_OVER, this.onResourceRollOverHandler);
            this.resourceLbl.removeEventListener(MouseEvent.ROLL_OUT, this.onMedalIconRollOutHandler);
            this.resourceIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onResourceRollOverHandler);
            this.resourceIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onMedalIconRollOutHandler);
        }
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = param1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.fakeFocusIndicator.gotoAndPlay(STATE_OVER);
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this.fakeFocusIndicator.gotoAndPlay(STATE_OUT);
    }

    private function onMedalIconRollOverHandler(param1:MouseEvent):void {
        var _loc2_:Vector.<String> = null;
        var _loc3_:int = 0;
        var _loc4_:uint = 0;
        if (data.achievements.length > 0) {
            _loc2_ = new Vector.<String>();
            _loc3_ = data.achievements.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_.push(App.utils.locale.makeString(ACHIEVEMENTS.all(data.achievements[_loc4_].type)));
                _loc4_++;
            }
            App.toolTipMgr.show(_loc2_.join("\n"));
        }
    }

    private function onMedalIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onMedalIconClickHandler(param1:MouseEvent):void {
        handleMouseRelease(param1);
    }

    private function onResourceRollOverHandler(param1:MouseEvent):void {
        var _loc2_:String = App.toolTipMgr.getNewFormatter().addBody(TOOLTIPS.BATTLERESULTS_FORTRESOURCE_LEGIONER_BODY, true).make();
        App.toolTipMgr.showComplex(_loc2_);
    }
}
}

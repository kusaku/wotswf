package net.wg.gui.cyberSport.views.unit {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.controls.BlackButton;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationUnitViewHeaderVO;
import net.wg.infrastructure.interfaces.ISpriteEx;

public class StaticFormationUnitViewHeader extends Sprite implements ISpriteEx {

    private static const MIDDLE_POS_X:int = 250;

    private static const DISABLE_ALPHA:Number = 0.2;

    public var teamIcon:ClanEmblem = null;

    public var teamName:TextField = null;

    public var unrankedMode:TextField = null;

    public var battlesIcon:UILoaderAlt = null;

    public var battles:TextField = null;

    public var leagueIcon:UILoaderAlt = null;

    public var winRate:TextField = null;

    public var winRateIcon:UILoaderAlt = null;

    public var fixedModeLabel:TextField = null;

    public var modeChangeBtn:BlackButton = null;

    public var modeButtonLabel:TextField = null;

    public var legionnaireIcon:UILoaderAlt = null;

    public var legionnairesCount:TextField = null;

    private var _fixedModeTooltip:String = "";

    private var _fixedModeTooltipType:String = "";

    private var _isModeTooltip:Boolean = false;

    public function StaticFormationUnitViewHeader() {
        super();
        this.unrankedMode.text = CYBERSPORT.STATICFORMATION_UNITVIEW_UNRANKEDMODE;
        this.modeChangeBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_CYBERSPORT_RANKEDICON;
        this.modeChangeBtn.mouseEnabledOnDisabled = true;
        this.modeChangeBtn.toggleEnable = true;
        this.battlesIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_DOSSIER_BATTLES40X32;
        this.winRateIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_DOSSIER_WINS40X32;
        this.fixedModeLabel.addEventListener(MouseEvent.MOUSE_OVER, this.onFixedModeLabelMouseOverHandler);
        this.fixedModeLabel.addEventListener(MouseEvent.MOUSE_OUT, onFixedModeLabelMouseOutHandler);
        this.legionnaireIcon.visible = false;
        this.legionnairesCount.visible = false;
        this.teamName.autoSize = TextFieldAutoSize.LEFT;
    }

    private static function onFixedModeLabelMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    public function dispose():void {
        this.fixedModeLabel.removeEventListener(MouseEvent.MOUSE_OVER, this.onFixedModeLabelMouseOverHandler);
        this.fixedModeLabel.removeEventListener(MouseEvent.MOUSE_OUT, onFixedModeLabelMouseOutHandler);
        this.teamIcon.dispose();
        this.teamIcon = null;
        this.teamName = null;
        this.unrankedMode = null;
        this.battlesIcon.dispose();
        this.battlesIcon = null;
        this.battles = null;
        this.leagueIcon.dispose();
        this.leagueIcon = null;
        this.winRate = null;
        this.winRateIcon.dispose();
        this.winRateIcon = null;
        this.fixedModeLabel = null;
        this.modeChangeBtn.dispose();
        this.modeChangeBtn = null;
        this.modeButtonLabel = null;
        this.legionnaireIcon.dispose();
        this.legionnaireIcon = null;
        this.legionnairesCount = null;
    }

    public function enableModeChangeBtn(param1:Boolean):void {
        this.modeChangeBtn.enabled = param1;
        this.modeChangeBtn.tooltip = !!param1 ? null : TOOLTIPS.CYBERSPORT_MODECHANGEFROZEN;
    }

    public function update(param1:Object):void {
        var _loc2_:StaticFormationUnitViewHeaderVO = StaticFormationUnitViewHeaderVO(param1);
        this.setTeamName(_loc2_.teamName);
        this.unrankedMode.visible = !_loc2_.isRankedMode;
        this.battlesIcon.visible = _loc2_.isRankedMode;
        this.battles.visible = _loc2_.isRankedMode;
        this.leagueIcon.visible = _loc2_.isRankedMode;
        this.winRate.visible = _loc2_.isRankedMode;
        this.winRateIcon.visible = _loc2_.isRankedMode;
        if (_loc2_.isRankedMode) {
            this.battles.text = _loc2_.battles;
            this.winRate.text = _loc2_.winRate;
            this.winRate.alpha = !!_loc2_.enableWinRateTF ? Number(Values.DEFAULT_ALPHA) : Number(DISABLE_ALPHA);
            this.leagueIcon.source = _loc2_.leagueIcon;
        }
        this.fixedModeLabel.visible = _loc2_.isFixedMode;
        this.modeChangeBtn.visible = !_loc2_.isFixedMode;
        this.modeButtonLabel.visible = !_loc2_.isFixedMode;
        if (_loc2_.isFixedMode) {
            this.fixedModeLabel.htmlText = _loc2_.modeLabel;
        }
        else {
            this.modeButtonLabel.htmlText = _loc2_.modeLabel;
            this.modeChangeBtn.selected = _loc2_.isRankedMode;
        }
        this._fixedModeTooltip = _loc2_.modeTooltip;
        this._fixedModeTooltipType = _loc2_.modeTooltipType;
        this._isModeTooltip = _loc2_.isModeTooltip;
    }

    private function setTeamName(param1:String):void {
        this.teamName.text = param1;
        var _loc2_:int = this.teamName.x + this.teamName.textWidth - this.teamIcon.x;
        var _loc3_:int = MIDDLE_POS_X - (_loc2_ >> 1);
        this.teamName.x = this.teamName.x + (_loc3_ - this.teamIcon.x >> 0);
        this.teamIcon.x = _loc3_;
    }

    private function onFixedModeLabelMouseOverHandler(param1:MouseEvent):void {
        if (this._isModeTooltip) {
            if (this._fixedModeTooltipType == TOOLTIPS_CONSTANTS.COMPLEX) {
                App.toolTipMgr.showComplex(this._fixedModeTooltip);
            }
            else {
                App.toolTipMgr.showSpecial(this._fixedModeTooltipType, null);
            }
        }
    }
}
}

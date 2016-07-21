package net.wg.gui.lobby.battleResults.fallout {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.lobby.battleResults.data.VictoryPanelVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipFormatter;

public class VictoryScorePanel extends UIComponentEx {

    public var descriptionLbl:TextField;

    public var scoreLbl:TextField;

    public var infoIcon:InfoIcon;

    public var specialStatusLbl:TextField;

    public var winningScoreBg:DisplayObject;

    private var _tooltip:String = "";

    public function VictoryScorePanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.infoIcon.addEventListener(MouseEvent.ROLL_OVER, this.onInfoIconRollOverHandler);
        this.infoIcon.addEventListener(MouseEvent.ROLL_OUT, this.onInfoIconRollOutHandler);
    }

    override protected function onDispose():void {
        this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onInfoIconRollOverHandler);
        this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onInfoIconRollOutHandler);
        this.infoIcon.dispose();
        this.infoIcon = null;
        this.descriptionLbl = null;
        this.scoreLbl = null;
        this.winningScoreBg = null;
        this.specialStatusLbl = null;
        super.onDispose();
    }

    public function setScore(param1:VictoryPanelVO):void {
        this.specialStatusLbl.text = param1.specialStatusStr;
        this.winningScoreBg.visible = param1.victory;
        this.scoreLbl.text = param1.score.toString();
        this.updateTopItems();
        var _loc2_:ITooltipFormatter = App.toolTipMgr.getNewFormatter();
        _loc2_.addHeader(App.utils.locale.makeString(TOOLTIPS.BATTLERESULTS_VICTORYSCOREDESCRIPTION_HEADER));
        _loc2_.addBody(param1.tooltip);
        this._tooltip = _loc2_.make();
    }

    private function updateTopItems():void {
        this.descriptionLbl.text = BATTLE_RESULTS.VICTORYSCORE;
        var _loc1_:int = 4;
        this.scoreLbl.x = this.descriptionLbl.x + this.descriptionLbl.textWidth + _loc1_;
        var _loc2_:int = 4;
        var _loc3_:int = 12;
        App.utils.commons.moveDsiplObjToEndOfText(this.infoIcon, this.scoreLbl, _loc2_, _loc3_);
        var _loc4_:int = this.infoIcon.x + this.infoIcon.width - this.descriptionLbl.x;
        var _loc5_:* = this.winningScoreBg.width - _loc4_ >> 1;
        var _loc6_:int = _loc5_ - this.descriptionLbl.x;
        this.descriptionLbl.x = this.descriptionLbl.x + _loc6_;
        this.scoreLbl.x = this.scoreLbl.x + _loc6_;
        this.infoIcon.x = this.infoIcon.x + _loc6_;
    }

    private function onInfoIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onInfoIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._tooltip);
    }
}
}

package net.wg.gui.cyberSport.staticFormation.views.impl {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.AdvancedLineDescrIconText;
import net.wg.gui.components.common.containers.IGroupEx;
import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationSummaryVO;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationSummaryView;
import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
import net.wg.infrastructure.base.meta.impl.StaticFormationSummaryViewMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class StaticFormationSummaryView extends StaticFormationSummaryViewMeta implements IStaticFormationSummaryView {

    public var placeTF:TextField = null;

    public var leagueDivisionTF:TextField = null;

    public var ladderPtsTF:TextField = null;

    public var bestTanksTF:TextField = null;

    public var notEnoughTanksTF:TextField = null;

    public var bestMapsTF:TextField = null;

    public var notEnoughMapsTF:TextField = null;

    public var ladderIcon:UILoaderAlt = null;

    public var battlesNumLDIT:AdvancedLineDescrIconText = null;

    public var winsPercentLDIT:AdvancedLineDescrIconText = null;

    public var winsByCaptureLDIT:AdvancedLineDescrIconText = null;

    public var techDefeatsLDIT:AdvancedLineDescrIconText = null;

    public var registeredTF:TextField = null;

    public var lastBattleTF:TextField = null;

    public var bestTanksGroup:IGroupEx = null;

    public var bestMapsGroup:IGroupEx = null;

    public var noAwardsTF:TextField = null;

    public var medalList:BattleResultsMedalsList = null;

    public var ribbonIcon:UILoaderAlt = null;

    private var _model:StaticFormationSummaryVO = null;

    public function StaticFormationSummaryView() {
        super();
    }

    private static function onLadderIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onNotEnoughTanksTFRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.STATICFORMATIONSUMMARYVIEW_STATS_NOTENOUGHTANKS);
    }

    private static function onNotEnoughMapsTFRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.STATICFORMATIONSUMMARYVIEW_STATS_NOTENOUGHMAPS);
    }

    private static function onCmpRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this.notEnoughTanksTF.removeEventListener(MouseEvent.ROLL_OVER, onNotEnoughTanksTFRollOverHandler);
        this.notEnoughTanksTF.removeEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
        this.notEnoughMapsTF.removeEventListener(MouseEvent.ROLL_OVER, onNotEnoughMapsTFRollOverHandler);
        this.notEnoughMapsTF.removeEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
        this.ladderIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onLadderIconRollOverHandler);
        this.ladderIcon.removeEventListener(MouseEvent.ROLL_OUT, onLadderIconRollOutHandler);
        this.placeTF = null;
        this.leagueDivisionTF = null;
        this.ladderPtsTF = null;
        this.bestTanksTF = null;
        this.notEnoughTanksTF = null;
        this.bestMapsTF = null;
        this.notEnoughMapsTF = null;
        this.ladderIcon.dispose();
        this.ladderIcon = null;
        this.battlesNumLDIT.dispose();
        this.battlesNumLDIT = null;
        this.winsPercentLDIT.dispose();
        this.winsPercentLDIT = null;
        this.winsByCaptureLDIT.dispose();
        this.winsByCaptureLDIT = null;
        this.techDefeatsLDIT.dispose();
        this.techDefeatsLDIT = null;
        this.registeredTF = null;
        this.lastBattleTF = null;
        this.bestTanksGroup.dispose();
        this.bestTanksGroup = null;
        this.bestMapsGroup.dispose();
        this.bestMapsGroup = null;
        this.noAwardsTF = null;
        this.medalList.dispose();
        this.medalList = null;
        this.ribbonIcon.dispose();
        this.ribbonIcon = null;
        this._model = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.bestTanksGroup.itemRendererLinkage = Linkages.BEST_TANKS_MAPS_ITEM_UI;
        this.bestTanksGroup.layout = new Vertical100PercWidthLayout();
        this.bestMapsGroup.itemRendererLinkage = Linkages.BEST_TANKS_MAPS_ITEM_UI;
        this.bestMapsGroup.layout = new Vertical100PercWidthLayout();
        this.notEnoughTanksTF.addEventListener(MouseEvent.ROLL_OVER, onNotEnoughTanksTFRollOverHandler);
        this.notEnoughTanksTF.addEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
        this.notEnoughMapsTF.addEventListener(MouseEvent.ROLL_OVER, onNotEnoughMapsTFRollOverHandler);
        this.notEnoughMapsTF.addEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
        this.ladderIcon.addEventListener(MouseEvent.ROLL_OVER, this.onLadderIconRollOverHandler);
        this.ladderIcon.addEventListener(MouseEvent.ROLL_OUT, onLadderIconRollOutHandler);
    }

    override protected function setData(param1:StaticFormationSummaryVO):void {
        this._model = param1;
        invalidateData();
    }

    override protected function draw():void {
        super.draw();
        if (this._model && isInvalid(InvalidationType.DATA)) {
            this.placeTF.htmlText = this._model.placeText;
            this.leagueDivisionTF.htmlText = this._model.leagueDivisionText;
            this.ladderPtsTF.htmlText = this._model.ladderPtsText;
            this.bestTanksTF.htmlText = this._model.bestTanksText;
            this.bestMapsTF.htmlText = this._model.bestMapsText;
            this.notEnoughTanksTF.htmlText = this._model.notEnoughTanksText;
            this.notEnoughMapsTF.htmlText = this._model.notEnoughMapsText;
            this.registeredTF.htmlText = this._model.registeredText;
            this.lastBattleTF.htmlText = this._model.lastBattleText;
            this.ladderIcon.source = this._model.ladderIconSource;
            this.noAwardsTF.htmlText = this._model.noAwardsText;
            this.ribbonIcon.source = this._model.ribbonSource;
            this.battlesNumLDIT.setData(this._model.battlesNumData);
            this.winsPercentLDIT.setData(this._model.winsPercentData);
            this.winsByCaptureLDIT.setData(this._model.attackDamageEfficiencyData);
            this.techDefeatsLDIT.setData(this._model.defenceDamageEfficiencyData);
            this.bestTanksGroup.width = this._model.bestTanksGroupWidth;
            this.bestMapsGroup.width = this._model.bestMapsGroupWidth;
            this.bestTanksGroup.dataProvider = new DataProvider(this._model.bestTanks);
            this.bestMapsGroup.dataProvider = new DataProvider(this._model.bestMaps);
            this.notEnoughTanksTF.visible = this._model.notEnoughTanksTFVisible;
            this.notEnoughMapsTF.visible = this._model.notEnoughMapsTFVisible;
            this.medalList.dataProvider = new DataProvider(this._model.achievements);
            this.medalList.visible = this._model.achievements.length != 0;
            this.noAwardsTF.visible = this._model.achievements.length == 0;
        }
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Object):void {
    }

    private function onLadderIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.LADDER, null, this._model.clubId);
    }
}
}

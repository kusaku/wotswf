package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl {
public class PeriodDefenceStatisticForm extends FortClanStatisticBaseForm {

    public function PeriodDefenceStatisticForm() {
        super();
    }

    override protected function applyData():void {
        battlesField.setData(model.periodBattles);
        winsField.setData(model.periodWins);
        avgDefresField.setData(model.periodAvgDefres);
        battlesStatsGroup.dataProvider = model.periodBattlesStats;
        defresStatsGroup.dataProvider = model.periodDefresStats;
        super.applyData();
    }
}
}

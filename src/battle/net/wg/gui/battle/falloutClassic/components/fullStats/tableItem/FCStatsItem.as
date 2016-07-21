package net.wg.gui.battle.falloutClassic.components.fullStats.tableItem {
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.views.stats.fullStats.FalloutStatsItem;

public class FCStatsItem extends FalloutStatsItem {

    public function FCStatsItem(param1:TextField, param2:TextField, param3:TextField, param4:BattleAtlasSprite, param5:BattleAtlasSprite, param6:BattleAtlasSprite, param7:TextField, param8:TextField, param9:TextField, param10:TextField) {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        deadBg.imageName = BattleAtlasItem.FC_STATS_DEAD_BG;
        zeroSpecialPoints = true;
    }
}
}

package net.wg.gui.battle.views.ribbonsPanel.data {
import net.wg.data.constants.BattleAtlasItem;

public class BackgroundAtlasNames {

    public static const GREY:String = "grey";

    public static const GREEN:String = "green";

    private var _small:String;

    private var _medium:String;

    private var _large:String;

    public function BackgroundAtlasNames(param1:String) {
        super();
        switch (param1) {
            case GREY:
                this._small = BattleAtlasItem.RIBBONS_BG_GREY_SMALL;
                this._medium = BattleAtlasItem.RIBBONS_BG_GREY_MEDIUM;
                this._large = BattleAtlasItem.RIBBONS_BG_GREY_LARGE;
                break;
            case GREEN:
                this._small = BattleAtlasItem.RIBBONS_BG_GREEN_SMALL;
                this._medium = BattleAtlasItem.RIBBONS_BG_GREEN_MEDIUM;
                this._large = BattleAtlasItem.RIBBONS_BG_GREEN_LARGE;
        }
    }

    public function get small():String {
        return this._small;
    }

    public function get medium():String {
        return this._medium;
    }

    public function get large():String {
        return this._large;
    }
}
}

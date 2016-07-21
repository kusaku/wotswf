package net.wg.gui.lobby.fortifications.battleRoom.clanBattle {
public class FortListViewHelper {

    public static const CREATOR_NAME:String = "creatorName";

    public static const DESCRIPTION:String = "description";

    public static const DIVISION:String = "commandSize";

    public static const PLAYERS_COUNT:String = "playersCount";

    public static const STATUS:String = "isInBattle";

    public function FortListViewHelper() {
        super();
    }

    public function getButtonWidth(param1:String):int {
        switch (param1) {
            case CREATOR_NAME:
                return 141;
            case DESCRIPTION:
                return 140;
            case DIVISION:
                return 115;
            case PLAYERS_COUNT:
                return 107;
            case STATUS:
                return 74;
            default:
                return 0;
        }
    }

    public function getSortOrder(param1:String):int {
        switch (param1) {
            case CREATOR_NAME:
                return 0;
            case DESCRIPTION:
                return 1;
            case DIVISION:
                return 2;
            case PLAYERS_COUNT:
                return 3;
            case STATUS:
                return 4;
            default:
                return -1;
        }
    }
}
}

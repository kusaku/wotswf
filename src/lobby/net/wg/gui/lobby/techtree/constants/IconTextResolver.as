package net.wg.gui.lobby.techtree.constants {
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.Values;

public class IconTextResolver {

    private static const namedLabels:Vector.<String> = Vector.<String>([NamedLabels.XP_COST, NamedLabels.EARNED_XP, NamedLabels.CREDITS_PRICE, NamedLabels.GOLD_PRICE]);

    private static const iconTexts:Vector.<String> = Vector.<String>([IconsTypes.XP_PRICE, IconsTypes.XP_PRICE, IconsTypes.CREDITS, IconsTypes.GOLD]);

    public function IconTextResolver() {
        super();
    }

    public static function getFromNamedLabel(param1:String):String {
        var _loc2_:String = Values.EMPTY_STR;
        var _loc3_:Number = namedLabels.indexOf(param1);
        if (_loc3_ > -1) {
            _loc2_ = iconTexts[_loc3_];
        }
        return _loc2_;
    }
}
}

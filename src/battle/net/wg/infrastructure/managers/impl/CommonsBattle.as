package net.wg.infrastructure.managers.impl {
import flash.geom.Rectangle;
import flash.text.TextField;

import net.wg.data.constants.UserTags;
import net.wg.data.constants.Values;
import net.wg.infrastructure.interfaces.IUserProps;
import net.wg.infrastructure.managers.utils.impl.CommonsBase;

public class CommonsBattle extends CommonsBase {

    private static const TEXT_FIELD_BOUNDS_WIDTH:Number = 4;

    public function CommonsBattle() {
        super();
    }

    override public function formatPlayerName(param1:TextField, param2:IUserProps):Boolean {
        var _loc11_:Boolean = false;
        var _loc13_:Rectangle = null;
        var _loc14_:Rectangle = null;
        var _loc15_:Number = NaN;
        var _loc16_:int = 0;
        var _loc3_:Array = param2.tags;
        var _loc4_:String = param2.userName;
        var _loc5_:String = !!param2.clanAbbrev ? CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE : Values.EMPTY_STR;
        var _loc6_:String = !!param2.region ? Values.SPACE_STR + param2.region : Values.EMPTY_STR;
        var _loc7_:String = _loc3_ && UserTags.isInRefSystem(_loc3_) ? Values.SPACE_STR + REFERRAL_IMG_TAG : Values.EMPTY_STR;
        var _loc8_:String = Values.EMPTY_STR;
        var _loc9_:uint = param1.textColor;
        if (_loc3_ && UserTags.isInIGR(_loc3_)) {
            _loc8_ = Values.SPACE_STR + (!!UserTags.isBaseIGR(_loc3_) ? IMG_TAG_OPEN_BASIC : IMG_TAG_OPEN_PREMIUM) + param2.igrVspace + IMG_TAG_CLOSE;
        }
        var _loc10_:String = _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc8_;
        var _loc12_:Number = param1.width;
        param1.htmlText = _loc10_;
        if (param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH) {
            _loc11_ = true;
            _loc10_ = _loc4_ + CUT_SYMBOLS_STR + _loc5_ + _loc6_ + _loc7_ + _loc8_;
            param1.htmlText = _loc10_;
            _loc13_ = param1.getCharBoundaries(_loc4_.length - 1);
            _loc14_ = param1.getCharBoundaries(_loc10_.length - 1);
            _loc15_ = _loc14_.x + _loc14_.width - (_loc13_.x + _loc13_.width);
            if (_loc15_ >= param1.width && param2.clanAbbrev) {
                _loc5_ = CLAN_TAG_OPEN + CUT_SYMBOLS_STR + CLAN_TAG_CLOSE;
                _loc10_ = _loc4_ + CUT_SYMBOLS_STR + _loc5_ + _loc6_ + _loc7_ + _loc8_;
                _loc14_ = param1.getCharBoundaries(_loc10_.length - 1);
                _loc15_ = _loc14_.x + _loc14_.width - (_loc13_.x + _loc13_.width);
            }
            _loc16_ = _loc4_.length;
            while (_loc16_ > 0) {
                _loc14_ = param1.getCharBoundaries(_loc16_ - 1);
                if (_loc14_.x + _loc14_.width + _loc15_ <= _loc12_) {
                    break;
                }
                _loc16_--;
            }
            param1.htmlText = _loc4_.substr(0, _loc16_) + CUT_SYMBOLS_STR + _loc5_ + _loc6_ + _loc7_ + _loc8_;
        }
        param1.textColor = _loc9_;
        return _loc11_;
    }
}
}

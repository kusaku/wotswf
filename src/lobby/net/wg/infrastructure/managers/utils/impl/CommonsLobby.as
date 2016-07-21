package net.wg.infrastructure.managers.utils.impl {
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.constants.UserTags;
import net.wg.data.constants.Values;
import net.wg.infrastructure.interfaces.IUserProps;

public class CommonsLobby extends CommonsBase {

    public function CommonsLobby() {
        super();
    }

    override public function formatPlayerName(param1:TextField, param2:IUserProps):Boolean {
        var _loc14_:int = 0;
        var _loc3_:TextFormat = param1.getTextFormat();
        var _loc4_:Object = _loc3_.size;
        var _loc5_:String = _loc3_.font;
        var _loc6_:String = _loc3_.align;
        var _loc7_:Array = param2.tags;
        var _loc8_:int = param2.igrType;
        var _loc9_:Boolean = false;
        var _loc10_:String = Values.EMPTY_STR;
        if (_loc8_ > 0) {
            _loc10_ = (_loc8_ == 2 ? IMG_TAG_OPEN_PREMIUM : IMG_TAG_OPEN_BASIC) + param2.igrVspace + IMG_TAG_CLOSE;
            _loc9_ = true;
        }
        else if (UserTags.isInIGR(_loc7_)) {
            if (UserTags.isBaseIGR(_loc7_)) {
                _loc10_ = IMG_TAG_OPEN_BASIC + param2.igrVspace + IMG_TAG_CLOSE;
                _loc9_ = true;
            }
            else if (UserTags.isPremiumIGR(_loc7_)) {
                _loc10_ = IMG_TAG_OPEN_PREMIUM + param2.igrVspace + IMG_TAG_CLOSE;
                _loc9_ = true;
            }
        }
        var _loc11_:Boolean = UserTags.isInRefSystem(_loc7_);
        var _loc12_:String = param2.prefix + param2.userName + (!!param2.clanAbbrev ? CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE : Values.EMPTY_STR) + (!!param2.region ? Values.SPACE_STR + param2.region : Values.EMPTY_STR) + (!!_loc11_ ? Values.SPACE_STR + REFERRAL_IMG_TAG : Values.EMPTY_STR) + (!!_loc9_ ? Values.SPACE_STR + _loc10_ : Values.EMPTY_STR) + param2.suffix;
        var _loc13_:Boolean = false;
        applyTextProps(param1, _loc12_, _loc3_, _loc4_, _loc5_, _loc6_);
        if (param1.width < param1.textWidth + 4) {
            _loc13_ = true;
            _loc12_ = param2.prefix + param2.userName + (!!param2.clanAbbrev ? CUT_SYMBOLS_STR : Values.EMPTY_STR) + (!!param2.region ? Values.SPACE_STR + param2.region : Values.EMPTY_STR) + (!!_loc11_ ? Values.SPACE_STR + REFERRAL_IMG_TAG : Values.EMPTY_STR) + (!!_loc9_ ? Values.SPACE_STR + _loc10_ : Values.EMPTY_STR) + param2.suffix;
            applyTextProps(param1, _loc12_, _loc3_, _loc4_, _loc5_, _loc6_);
            _loc14_ = param2.userName.length - 1;
            while (param1.width < param1.textWidth + 4 && _loc14_ > 0) {
                _loc12_ = param2.prefix + param2.userName.substr(0, _loc14_) + CUT_SYMBOLS_STR + (!!param2.region ? Values.SPACE_STR + param2.region : Values.EMPTY_STR) + (!!_loc11_ ? Values.SPACE_STR + REFERRAL_IMG_TAG : Values.EMPTY_STR) + (_loc9_ > 0 ? Values.SPACE_STR + _loc10_ : Values.EMPTY_STR) + param2.suffix;
                applyTextProps(param1, _loc12_, _loc3_, _loc4_, _loc5_, _loc6_);
                _loc14_--;
            }
        }
        if (!isNaN(param2.rgb)) {
            param1.textColor = param2.rgb;
        }
        return _loc13_;
    }

    override public function getFullPlayerName(param1:IUserProps):String {
        var _loc2_:String = (param1.igrType == 2 ? IMG_TAG_OPEN_PREMIUM : IMG_TAG_OPEN_BASIC) + param1.igrVspace + IMG_TAG_CLOSE;
        var _loc3_:Boolean = UserTags.isInRefSystem(param1.tags);
        return param1.prefix + param1.userName + (!!param1.clanAbbrev ? CLAN_TAG_OPEN + param1.clanAbbrev + CLAN_TAG_CLOSE : Values.EMPTY_STR) + (!!param1.region ? Values.SPACE_STR + param1.region : Values.EMPTY_STR) + (!!_loc3_ ? Values.SPACE_STR + REFERRAL_IMG_TAG : Values.EMPTY_STR) + (param1.igrType > 0 ? Values.SPACE_STR + _loc2_ : Values.EMPTY_STR) + param1.suffix;
    }
}
}

package net.wg.gui.lobby.battleResults.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class PersonalDataVO extends DAAPIDataClass {

    public static const XP_DATA:String = "xpData";

    public static const XP_TITLE_STR:String = "xpTitleStrings";

    public static const CREDITS_DATA:String = "creditsData";

    public static const STAT_VALUES:String = "statValues";

    public static const RESOURCE_DATA:String = "resourceData";

    public static const NO_INCOME_ALERT_MESSAGE:String = "noIncomeAlert";

    public static const GET_PREM_VO:String = "getPremVO";

    public static const ACHIEVEMENTS_LEFT:String = "achievementsLeft";

    public static const ACHIEVEMENTS_RIGHT:String = "achievementsRight";

    public var getPremVO:GetPremiumPopoverVO = null;

    public var hasGetPremBtn:Boolean = false;

    public var achievementsLeft:Array;

    public var achievementsRight:Array;

    public var creditsStr:String = "";

    public var details:Array = null;

    public var fortResourceTotal:String = "";

    public var isLegionnaire:Boolean = false;

    public var isPremium:Boolean = false;

    public var xpStr:String = "";

    public var xpTitleStrings:Vector.<String>;

    public var xpPremValues:Array = null;

    public var xpNoPremValues:Array = null;

    public var creditsPremValues:Array = null;

    public var creditsNoPremValues:Array = null;

    public var resValues:Array = null;

    public var resPremValues:Array = null;

    public var showNoIncomeAlert:Boolean = false;

    public var noIncomeAlert:AlertMessageVO = null;

    public var isMultiplierInfoVisible:Boolean = false;

    public var multiplierTooltipStr:String = "";

    public var premiumMultiplierTooltipStr:String = "";

    public var multiplierLineIdxPos:int = -1;

    public var resourceData:Vector.<DetailedStatsItemVO> = null;

    public var creditsData:Vector.<Vector.<DetailedStatsItemVO>> = null;

    public var xpData:Vector.<Vector.<DetailedStatsItemVO>> = null;

    public var statValues:Vector.<Vector.<StatItemVO>> = null;

    public function PersonalDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        switch (param1) {
            case XP_DATA:
            case CREDITS_DATA:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.fillVectorOfDetailedStatsItems(param1, _loc3_);
                return false;
            case RESOURCE_DATA:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.fillResourceData(_loc3_);
                return false;
            case STAT_VALUES:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.fillStatValues(_loc3_);
                return false;
            case GET_PREM_VO:
                this.getPremVO = new GetPremiumPopoverVO(param2);
                return false;
            case XP_TITLE_STR:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.fillXpTitleStrings(_loc3_);
                return false;
            case NO_INCOME_ALERT_MESSAGE:
                this.noIncomeAlert = new AlertMessageVO(param2);
                return false;
            case ACHIEVEMENTS_LEFT:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.fillAchievementsLeft(_loc3_);
                return false;
            case ACHIEVEMENTS_RIGHT:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.fillAchievementsRight(_loc3_);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        var _loc1_:DetailedStatsItemVO = null;
        if (this.achievementsLeft != null) {
            this.achievementsLeft.length = 0;
            this.achievementsLeft = null;
        }
        if (this.achievementsRight != null) {
            this.achievementsRight.length = 0;
            this.achievementsRight = null;
        }
        if (this.details != null) {
            this.details.splice(0, this.details.length);
            this.details = null;
        }
        if (this.xpTitleStrings) {
            this.xpTitleStrings.splice(0, this.xpTitleStrings.length);
            this.xpTitleStrings = null;
        }
        if (this.xpPremValues != null) {
            this.xpPremValues.splice(0, this.xpPremValues.length);
            this.xpPremValues = null;
        }
        if (this.xpNoPremValues != null) {
            this.xpNoPremValues.splice(0, this.xpNoPremValues.length);
            this.xpNoPremValues = null;
        }
        if (this.creditsPremValues != null) {
            this.creditsPremValues.splice(0);
            this.creditsPremValues = null;
        }
        if (this.creditsNoPremValues != null) {
            this.creditsNoPremValues.splice(0);
            this.creditsNoPremValues = null;
        }
        if (this.resValues != null) {
            this.resValues.splice(0);
            this.resValues = null;
        }
        if (this.resPremValues != null) {
            this.resPremValues.splice(0);
            this.resPremValues = null;
        }
        if (this.creditsData != null) {
            this.cleanVectorOfVectors(this.creditsData);
            this.creditsData = null;
        }
        if (this.xpData != null) {
            this.cleanVectorOfVectors(this.xpData);
            this.xpData = null;
        }
        if (this.resourceData != null) {
            for each(_loc1_ in this.resourceData) {
                _loc1_.dispose();
            }
            this.resourceData.splice(0, this.resourceData.length);
            this.resourceData = null;
        }
        if (this.statValues != null) {
            this.cleanVectorOfVectors(this.statValues);
            this.statValues = null;
        }
        if (this.getPremVO != null) {
            this.getPremVO.dispose();
            this.getPremVO = null;
        }
        if (this.noIncomeAlert != null) {
            this.noIncomeAlert.dispose();
            this.noIncomeAlert = null;
        }
        super.onDispose();
    }

    private function cleanVectorOfVectors(param1:Object):void {
        var _loc2_:Object = null;
        var _loc3_:Vector.<IDisposable> = null;
        var _loc4_:IDisposable = null;
        for each(_loc2_ in param1) {
            _loc3_ = Vector.<IDisposable>(_loc2_);
            for each(_loc4_ in _loc3_) {
                _loc4_.dispose();
            }
            _loc3_.splice(0, _loc3_.length);
        }
        param1.splice(0, param1.length);
    }

    private function fillVectorOfDetailedStatsItems(param1:String, param2:Array):void {
        var _loc3_:int = 0;
        var _loc4_:Vector.<Vector.<DetailedStatsItemVO>> = null;
        var _loc5_:Array = null;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc8_:int = 0;
        if (param2) {
            _loc3_ = param2.length;
            _loc4_ = new Vector.<Vector.<DetailedStatsItemVO>>();
            _loc8_ = 0;
            while (_loc8_ < _loc3_) {
                _loc5_ = param2[_loc8_] as Array;
                App.utils.asserter.assertNotNull(_loc5_, Errors.CANT_NULL);
                _loc6_ = _loc5_.length;
                _loc4_.push(new Vector.<DetailedStatsItemVO>(_loc6_));
                _loc7_ = 0;
                while (_loc7_ < _loc6_) {
                    _loc4_[_loc8_][_loc7_] = new DetailedStatsItemVO(_loc5_[_loc7_]);
                    _loc7_++;
                }
                _loc8_++;
            }
            this[param1] = _loc4_;
        }
    }

    private function fillResourceData(param1:Array):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (param1) {
            _loc2_ = param1.length;
            this.resourceData = new Vector.<DetailedStatsItemVO>(_loc2_);
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.resourceData[_loc3_] = new DetailedStatsItemVO(param1[_loc3_]);
                _loc3_++;
            }
        }
    }

    private function fillXpTitleStrings(param1:Array):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (param1) {
            _loc2_ = param1.length;
            this.xpTitleStrings = new Vector.<String>(_loc2_);
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.xpTitleStrings[_loc3_] = param1[_loc3_];
                _loc3_++;
            }
        }
    }

    private function fillStatValues(param1:Array):void {
        var _loc2_:int = 0;
        var _loc3_:Array = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        if (param1) {
            _loc2_ = param1.length;
            this.statValues = new Vector.<Vector.<StatItemVO>>(_loc2_);
            _loc5_ = 0;
            while (_loc5_ < _loc2_) {
                _loc3_ = param1[_loc5_];
                _loc4_ = _loc3_.length;
                this.statValues[_loc5_] = new Vector.<StatItemVO>(_loc4_);
                _loc6_ = 0;
                while (_loc6_ < _loc4_) {
                    this.statValues[_loc5_][_loc6_] = new StatItemVO(_loc3_[_loc6_]);
                    _loc6_++;
                }
                _loc5_++;
            }
        }
    }

    private function fillAchievementsRight(param1:Array):void {
        if (param1) {
            this.achievementsRight = [];
            this.fillAchievements(this.achievementsRight, param1);
        }
    }

    private function fillAchievementsLeft(param1:Array):void {
        if (param1) {
            this.achievementsLeft = [];
            this.fillAchievements(this.achievementsLeft, param1);
        }
    }

    private function fillAchievements(param1:Array, param2:Array):void {
        var _loc3_:uint = 0;
        var _loc4_:int = 0;
        if (param1) {
            _loc3_ = param2.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                param1.push(new BattleResultsMedalsListVO(param2[_loc4_]));
                _loc4_++;
            }
        }
    }
}
}

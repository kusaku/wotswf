package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.VO.AchievementProfileVO;
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationSummaryVO extends DAAPIDataClass {

    private static const ACHIEVEMENTS:String = "achievements";

    private static const BEST_TANKS:String = "bestTanks";

    private static const BEST_MAPS:String = "bestMaps";

    private static const BATTLES_NUM_DATA:String = "battlesNumData";

    private static const WINS_PERCENT_DATA:String = "winsPercentData";

    private static const ATTACK_DAMAGE_EFFICIENCY_DATA:String = "attackDamageEfficiencyData";

    private static const DEFENCE_DAMAGE_EFFICIENCY_DATA:String = "defenceDamageEfficiencyData";

    public var clubId:int = -1;

    public var placeText:String = "";

    public var leagueDivisionText:String = "";

    public var ladderPtsText:String = "";

    public var bestTanksText:String = "";

    public var bestMapsText:String = "";

    public var notEnoughTanksText:String = "";

    public var notEnoughMapsText:String = "";

    public var registeredText:String = "";

    public var lastBattleText:String = "";

    public var ladderIconSource:String = "";

    public var noAwardsText:String = "";

    public var ribbonSource:String = "";

    public var battlesNumData:StaticFormationLDITVO = null;

    public var winsPercentData:StaticFormationLDITVO = null;

    public var attackDamageEfficiencyData:StaticFormationLDITVO = null;

    public var defenceDamageEfficiencyData:StaticFormationLDITVO = null;

    public var bestTanks:Array;

    public var bestMaps:Array;

    public var achievements:Array;

    public var bestTanksGroupWidth:int = -1;

    public var bestMapsGroupWidth:int = -1;

    public var notEnoughTanksTFVisible:Boolean = false;

    public var notEnoughMapsTFVisible:Boolean = false;

    public function StaticFormationSummaryVO(param1:Object) {
        this.bestTanks = [];
        this.bestMaps = [];
        this.achievements = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        var _loc5_:Array = null;
        var _loc6_:Object = null;
        var _loc7_:Array = null;
        var _loc8_:Object = null;
        if (param1 == BATTLES_NUM_DATA) {
            this.battlesNumData = new StaticFormationLDITVO(param2);
            return false;
        }
        if (param1 == WINS_PERCENT_DATA) {
            this.winsPercentData = new StaticFormationLDITVO(param2);
            return false;
        }
        if (param1 == ATTACK_DAMAGE_EFFICIENCY_DATA) {
            this.attackDamageEfficiencyData = new StaticFormationLDITVO(param2);
            return false;
        }
        if (param1 == DEFENCE_DAMAGE_EFFICIENCY_DATA) {
            this.defenceDamageEfficiencyData = new StaticFormationLDITVO(param2);
            return false;
        }
        if (param1 == BEST_MAPS) {
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_) {
                this.bestMaps.push(new StaticFormationStatsItemVO(_loc4_));
            }
            return false;
        }
        if (param1 == BEST_TANKS) {
            _loc5_ = param2 as Array;
            for each(_loc6_ in _loc5_) {
                this.bestTanks.push(new StaticFormationStatsItemVO(_loc6_));
            }
            return false;
        }
        if (param1 == ACHIEVEMENTS) {
            _loc7_ = param2 as Array;
            for each(_loc8_ in _loc7_) {
                this.achievements.push(new AchievementProfileVO(_loc8_));
            }
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        var _loc1_:StaticFormationStatsItemVO = null;
        var _loc2_:StaticFormationStatsItemVO = null;
        var _loc3_:AchievementProfileVO = null;
        this.placeText = null;
        this.leagueDivisionText = null;
        this.ladderPtsText = null;
        this.bestTanksText = null;
        this.bestMapsText = null;
        this.notEnoughTanksText = null;
        this.notEnoughMapsText = null;
        this.registeredText = null;
        this.lastBattleText = null;
        this.ladderIconSource = null;
        this.noAwardsText = null;
        this.ribbonSource = null;
        if (this.battlesNumData) {
            this.battlesNumData.dispose();
            this.battlesNumData = null;
        }
        if (this.winsPercentData) {
            this.winsPercentData.dispose();
            this.winsPercentData = null;
        }
        if (this.attackDamageEfficiencyData) {
            this.attackDamageEfficiencyData.dispose();
            this.attackDamageEfficiencyData = null;
        }
        if (this.defenceDamageEfficiencyData) {
            this.defenceDamageEfficiencyData.dispose();
            this.defenceDamageEfficiencyData = null;
        }
        for each(_loc1_ in this.bestTanks) {
            _loc1_.dispose();
        }
        this.bestTanks.splice(0, this.bestTanks.length);
        this.bestTanks = null;
        for each(_loc2_ in this.bestMaps) {
            _loc2_.dispose();
        }
        this.bestMaps.splice(0, this.bestMaps.length);
        this.bestMaps = null;
        for each(_loc3_ in this.achievements) {
            _loc3_.dispose();
        }
        this.achievements.splice(0, this.achievements.length);
        this.achievements = null;
        super.onDispose();
    }
}
}

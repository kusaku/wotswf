package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.VO.AchievementProfileVO;
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StaticFormationStatsViewVO extends DAAPIDataClass {

    private static const ACHIEVEMENTS:String = "achievements";

    private static const SEASON_FILTERS:String = "seasonFilters";

    public var awardsText:String = "";

    public var noAwardsText:String = "";

    public var seasonFilterName:String = "";

    public var selectedSeason:int = -1;

    public var statsGroupWidth:int = -1;

    public var seasonFilterEnable:Boolean = false;

    public var noAwards:Boolean = false;

    private var _achievements:Vector.<AchievementProfileVO> = null;

    private var _seasonFilters:Vector.<String> = null;

    public function StaticFormationStatsViewVO(param1:Object) {
        this._achievements = new Vector.<AchievementProfileVO>(0);
        this._seasonFilters = new Vector.<String>(0);
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        var _loc5_:Array = null;
        var _loc6_:String = null;
        if (param1 == ACHIEVEMENTS) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, ACHIEVEMENTS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this._achievements.push(new AchievementProfileVO(_loc4_));
            }
            return false;
        }
        if (param1 == SEASON_FILTERS) {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_, SEASON_FILTERS + Errors.CANT_NULL);
            for each(_loc6_ in _loc5_) {
                this._seasonFilters.push(_loc6_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._achievements) {
            _loc1_.dispose();
        }
        this._achievements.splice(0, this._achievements.length);
        this._achievements = null;
        this._seasonFilters.splice(0, this._seasonFilters.length);
        this._seasonFilters = null;
        super.onDispose();
    }

    public function get achievements():Vector.<AchievementProfileVO> {
        return this._achievements;
    }

    public function get seasonFilters():Vector.<String> {
        return this._seasonFilters;
    }
}
}

package net.wg.gui.lobby.profile.pages.summary {
import net.wg.data.VO.AchievementProfileVO;
import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;

public class ProfileSummaryVO extends ProfileDossierInfoVO {

    private static const SIGNIFICANT_ACHIEVEMENTS:String = "significantAchievements";

    private static const NEAREST_ACHIEVEMENTS:String = "nearestAchievements";

    public var avgDamage:Number;

    public var maxDestroyed:uint;

    public var maxDestroyedByVehicle:String = "";

    public var globalRating:uint;

    public var significantAchievements:Vector.<AchievementProfileVO>;

    public var nearestAchievements:Vector.<AchievementProfileVO>;

    public function ProfileSummaryVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SIGNIFICANT_ACHIEVEMENTS) {
            this.significantAchievements = Vector.<AchievementProfileVO>(App.utils.data.convertVOArrayToVector(param1, param2, AchievementProfileVO));
            return false;
        }
        if (param1 == NEAREST_ACHIEVEMENTS) {
            this.nearestAchievements = Vector.<AchievementProfileVO>(App.utils.data.convertVOArrayToVector(param1, param2, AchievementProfileVO));
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:AchievementProfileVO = null;
        var _loc2_:AchievementProfileVO = null;
        if (this.significantAchievements != null) {
            for each(_loc1_ in this.significantAchievements) {
                _loc1_.dispose();
            }
            this.significantAchievements.fixed = false;
            this.significantAchievements.splice(0, this.significantAchievements.length);
            this.significantAchievements = null;
        }
        if (this.nearestAchievements != null) {
            for each(_loc2_ in this.nearestAchievements) {
                _loc2_.dispose();
            }
            this.nearestAchievements.fixed = false;
            this.nearestAchievements.splice(0, this.nearestAchievements.length);
            this.nearestAchievements = null;
        }
        super.onDispose();
    }

    public function getAvgDamageStr():String {
        return App.utils.locale.integer(this.avgDamage);
    }

    public function getGlobalRatingStr():String {
        return App.utils.locale.integer(this.globalRating);
    }

    public function getMaxDestroyedStr():String {
        return App.utils.locale.integer(this.maxDestroyed);
    }
}
}

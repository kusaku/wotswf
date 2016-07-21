package net.wg.gui.cyberSport.vo {
import net.wg.data.VO.AchievementProfileVO;
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.cyberSport.controls.data.CSRallyInfoVO;

public class CSStaticRallyVO extends DAAPIDataClass {

    private static const RALLY_INFO_FIELD_NAME:String = "rallyInfo";

    private static const BATTLES_COUNT_FIELD_NAME:String = "battlesCount";

    private static const WINS_PERCENT_FIELD_NAME:String = "winsPercent";

    private static const ACHIEVEMENTS_FIELD_NAME:String = "achievements";

    public var rallyInfo:CSRallyInfoVO;

    public var battlesCount:CSIndicatorData;

    public var winsPercent:CSIndicatorData;

    public var ladderIcon:String = "";

    public var ladderInfo:String = "";

    public var achievements:Array;

    public var noAwardsText:String = "";

    public var joinInfo:String = "";

    public var joinBtnDisabled:Boolean = false;

    public var joinBtnLabel:String = "";

    public var joinBtnTooltip:String = "";

    public function CSStaticRallyVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:AchievementProfileVO = null;
        var _loc5_:Object = null;
        if (param1 == RALLY_INFO_FIELD_NAME) {
            this.rallyInfo = new CSRallyInfoVO(param2);
            return false;
        }
        if (param1 == BATTLES_COUNT_FIELD_NAME) {
            this.battlesCount = new CSIndicatorData(param2);
            return false;
        }
        if (param1 == WINS_PERCENT_FIELD_NAME) {
            this.winsPercent = new CSIndicatorData(param2);
            return false;
        }
        if (param1 == ACHIEVEMENTS_FIELD_NAME) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + " Array");
            this.achievements = [];
            for each(_loc5_ in _loc3_) {
                _loc4_ = new AchievementProfileVO(_loc5_);
                this.achievements.push(_loc4_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.rallyInfo.dispose();
        this.battlesCount.dispose();
        this.winsPercent.dispose();
        this.rallyInfo = null;
        this.battlesCount = null;
        this.winsPercent = null;
        super.onDispose();
    }

    public function get achievementsNumber():uint {
        return this.achievements != null ? uint(this.achievements.length) : uint(0);
    }
}
}

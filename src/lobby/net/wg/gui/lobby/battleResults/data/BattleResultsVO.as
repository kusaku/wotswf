package net.wg.gui.lobby.battleResults.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.utils.IAssertable;
import net.wg.utils.ICommons;
import net.wg.utils.IDataUtils;

public class BattleResultsVO extends DAAPIDataClass {

    private static const COMMON:String = "common";

    private static const PERSONAL:String = "personal";

    private static const TEXT_DATA:String = "textData";

    private static const TEAM1:String = "team1";

    private static const TEAM2:String = "team2";

    private static const TAB_INFO:String = "tabInfo";

    private static const MANDATORY_FIELDS:Array = [COMMON, PERSONAL, TEXT_DATA, TEAM1, TEAM2, TAB_INFO];

    private static const ARRAY_FIELDS:Array = [TEAM1, TEAM2, TAB_INFO];

    private static const ERROR_STRING_DATA_WITH_KEY:String = "Data with key ";

    private static const ERROR_STRING_EXPECTED_TO_BE_ARRAY:String = " is expected to be array";

    public var common:CommonStatsVO = null;

    public var personal:PersonalDataVO = null;

    public var cyberSport:Object = null;

    public var quests:Array = null;

    public var unlocks:Array = null;

    public var vehicles:Array = null;

    public var textData:BattleResultsTextData;

    public var isFreeForAll:Boolean;

    public var selectedTeamMemberId:Number = -1;

    public var closingTeamMemberStatsEnabled:Boolean = true;

    public var selectedIdxInGarageDropdown:int = 0;

    public var team1:Vector.<TeamMemberItemVO> = null;

    public var team2:Vector.<TeamMemberItemVO> = null;

    public var tabInfo:Vector.<TabInfoVO> = null;

    public function BattleResultsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:IAssertable = App.utils.asserter;
        if (MANDATORY_FIELDS.indexOf(param1) != -1) {
            _loc3_.assertNotNull(param2, ERROR_STRING_DATA_WITH_KEY + param1 + Errors.CANT_NULL);
        }
        if (ARRAY_FIELDS.indexOf(param1) != -1) {
            _loc3_.assert(param2 is Array, ERROR_STRING_DATA_WITH_KEY + param1 + ERROR_STRING_EXPECTED_TO_BE_ARRAY);
        }
        var _loc4_:IDataUtils = App.utils.data;
        switch (param1) {
            case COMMON:
                this.common = new CommonStatsVO(param2);
                return false;
            case PERSONAL:
                this.personal = new PersonalDataVO(param2);
                return false;
            case TEXT_DATA:
                this.textData = new BattleResultsTextData(param2);
                return false;
            case TEAM1:
                this.team1 = Vector.<TeamMemberItemVO>(_loc4_.convertVOArrayToVector(param1, param2, TeamMemberItemVO));
                return false;
            case TEAM2:
                this.team2 = Vector.<TeamMemberItemVO>(_loc4_.convertVOArrayToVector(param1, param2, TeamMemberItemVO));
                return false;
            case TAB_INFO:
                this.tabInfo = Vector.<TabInfoVO>(_loc4_.convertVOArrayToVector(param1, param2, TabInfoVO));
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        this.cyberSport = App.utils.data.cleanupDynamicObject(this.cyberSport);
        var _loc1_:ICommons = App.utils.commons;
        var _loc2_:IDataUtils = App.utils.data;
        if (this.quests != null) {
            this.quests.splice(0);
            this.quests = null;
        }
        if (this.unlocks != null) {
            this.unlocks.splice(0);
            this.unlocks = null;
        }
        if (this.team1 != null) {
            _loc1_.releaseReferences(_loc2_.vectorToArray(this.team1));
            this.team1.splice(0, this.team1.length);
            this.team1 = null;
        }
        if (this.team2 != null) {
            _loc1_.releaseReferences(_loc2_.vectorToArray(this.team2));
            this.team2.splice(0, this.team2.length);
            this.team2 = null;
        }
        if (this.tabInfo != null) {
            _loc1_.releaseReferences(_loc2_.vectorToArray(this.tabInfo));
            this.tabInfo.splice(0, this.tabInfo.length);
            this.tabInfo = null;
        }
        if (this.vehicles != null) {
            this.vehicles.splice(0);
            this.vehicles = null;
        }
        if (this.textData != null) {
            this.textData.dispose();
            this.textData = null;
        }
        this.common.dispose();
        this.common = null;
        this.personal.dispose();
        this.personal = null;
        super.onDispose();
    }
}
}

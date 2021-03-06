package net.wg.gui.lobby.tankman {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class PersonalCaseModel implements IDisposable {

    public var inventoryID:int;

    public var iconFile:String = null;

    public var rankIconFile:String = null;

    public var nativeVehicle:NativeVehicle;

    public var firstname:String = null;

    public var lastname:String = null;

    public var rank:String = null;

    public var nationID:int;

    public var currentVehicle:PersonalCaseCurrentVehicle = null;

    public var specializationLevel:Number;

    public var inTank:Boolean = false;

    public var role:String = null;

    public var roleType:String = null;

    public var skills:Array;

    public var wg_freeXpToTankman:Boolean = false;

    public var enoughFreeXPForTeaching:Boolean;

    public var skillsCountForLearn:int = 0;

    public var lastNewSkillExp:int = 0;

    public var lastSkillLevel:int = 99;

    public var modifiers:Array = null;

    public var tabIndex:int;

    public function PersonalCaseModel(param1:Object) {
        var _loc8_:PersonalCaseCurrentVehicle = null;
        this.nativeVehicle = new NativeVehicle();
        this.skills = [];
        super();
        this.tabIndex = parseInt(param1.tabIndex);
        var _loc2_:Object = param1.nativeVehicle;
        this.nativeVehicle.innationID = _loc2_.innationID;
        this.nativeVehicle.type = _loc2_.type;
        var _loc3_:Object = param1.tankman;
        this.inventoryID = _loc3_.inventoryID;
        this.inTank = _loc3_.isInTank;
        this.nationID = _loc3_.nationID;
        this.iconFile = _loc3_.icon.big;
        this.rankIconFile = _loc3_.iconRank.big;
        this.rank = _loc3_.rankUserName;
        var _loc4_:Object = _loc3_.nativeVehicle;
        var _loc5_:Object = _loc3_.currentVehicle;
        var _loc6_:Object = param1.currentVehicle;
        var _loc7_:Boolean = param1.isOpsLocked;
        this.nativeVehicle.userName = _loc4_.userName;
        this.nativeVehicle.contourIconFile = _loc4_.iconContour;
        this.nativeVehicle.icon = _loc4_.icon;
        this.firstname = _loc3_.firstUserName;
        this.lastname = _loc3_.lastUserName;
        if (_loc6_) {
            _loc8_ = new PersonalCaseCurrentVehicle();
            this.currentVehicle = _loc8_;
            _loc8_.innationID = _loc6_.innationID;
            _loc8_.type = _loc6_.type;
            _loc8_.currentVehicleName = _loc5_.userName;
            _loc8_.inventoryID = _loc5_.inventoryID;
            _loc8_.iconContour = _loc5_.iconContour;
            _loc8_.icon = _loc5_.icon;
            _loc8_.currentVehicleBroken = _loc6_.isBroken;
            _loc8_.currentVehicleLocked = _loc6_.isLocked || _loc7_;
            _loc8_.currentVehicleLockMessage = param1.lockMessage;
        }
        this.specializationLevel = _loc3_.roleLevel;
        this.skillsCountForLearn = _loc3_.newSkillsCount[0];
        this.lastNewSkillExp = _loc3_.newSkillsCount[1];
        this.skills = this.parseCarouselTankmanSkills(_loc3_.skills, this.skillsCountForLearn, this.inventoryID);
        this.roleType = _loc3_.roleName;
        this.role = _loc3_.roleUserName;
        this.modifiers = param1.modifiers;
        this.enoughFreeXPForTeaching = param1.enoughFreeXPForTeaching;
    }

    public function dispose():void {
        this.nativeVehicle = null;
        this.currentVehicle = null;
        this.skills.splice(0);
        this.skills = null;
        this.modifiers.splice(0);
        this.modifiers = null;
    }

    private function parseCarouselTankmanSkills(param1:Array, param2:int, param3:int):Array {
        var _loc6_:CarouselTankmanSkillsModel = null;
        var _loc7_:Object = null;
        var _loc8_:CarouselTankmanSkillsModel = null;
        var _loc4_:Array = [];
        var _loc5_:int = 0;
        while (_loc5_ < param1.length) {
            _loc6_ = new CarouselTankmanSkillsModel();
            _loc7_ = param1[_loc5_];
            _loc6_.description = _loc7_.description;
            _loc6_.icon = _loc7_.icon.big;
            _loc6_.roleIcon = _loc7_.icon.role;
            _loc6_.isActive = _loc7_.isActive;
            _loc6_.isCommon = _loc7_.roleType == CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
            _loc6_.isPerk = _loc7_.isPerk;
            _loc6_.level = _loc7_.level;
            _loc6_.userName = _loc7_.userName;
            _loc6_.name = _loc7_.name;
            _loc6_.tankmanID = param3;
            _loc6_.enabled = _loc7_.isEnable;
            _loc6_.isPermanent = _loc7_.isPermanent;
            _loc4_.push(_loc6_);
            _loc5_++;
        }
        if (param2 > 0) {
            _loc8_ = new CarouselTankmanSkillsModel();
            _loc8_.isNewSkill = true;
            _loc8_.skillsCountForLearn = param2;
            _loc8_.tankmanID = param3;
            _loc4_.push(_loc8_);
        }
        return _loc4_;
    }
}
}
class NativeVehicle {

    public var userName:String = null;

    public var contourIconFile:String = null;

    public var icon:String = null;

    public var innationID:int;

    public var type:String = null;

    function NativeVehicle() {
        super();
    }
}

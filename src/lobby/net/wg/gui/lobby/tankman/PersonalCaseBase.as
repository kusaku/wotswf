package net.wg.gui.lobby.tankman {
import net.wg.data.VO.TankmanAchievementVO;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.VehicleTypes;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
import net.wg.infrastructure.base.meta.impl.PersonalCaseMeta;

import scaleform.gfx.Extensions;

public class PersonalCaseBase extends PersonalCaseMeta implements IPersonalCaseMeta {

    private static const templateS:Array = ["a", "b", "c", "d", "a", "b", "c", "d", "a1", "b2", "c3", "d4", "a5", "b6", "c7", "d8", "az", "xb", "cc", "fd", "ga", "tb", "jc", "dg"];

    private static const FIELD_FIRST_NAMES:String = "firstNames";

    private static const FIELD_LAST_NAMES:String = "lastNames";

    private static const FIELD_VALUE:String = "value";

    protected var isFirtsRun:Boolean = true;

    protected var autoSelectTab:int = 0;

    protected var data:PersonalCaseModel;

    protected var stats:Object;

    protected var retrainingData:PersonalCaseRetrainingModel;

    protected var skillsModel:Array;

    protected var documentsData:PersonalCaseDocsModel;

    protected var rentainingTabUpdated:Boolean = true;

    public function PersonalCaseBase() {
        this.skillsModel = [];
        super();
    }

    override protected function onDispose():void {
        this.data = null;
        this.stats = App.utils.data.cleanupDynamicObject(this.stats);
        this.retrainingData = null;
        this.documentsData = null;
        if (this.skillsModel) {
            this.skillsModel.splice(0, this.skillsModel.length);
            this.skillsModel = null;
        }
        super.onDispose();
    }

    public function as_setCommonData(param1:Object):void {
        this.parsePersonalCaseModel(param1);
        this.updateCommonElements();
        this.updateSkillsRelatedElements();
    }

    public function as_setDossierData(param1:Object):void {
        var _loc4_:uint = 0;
        var _loc5_:Array = null;
        var _loc6_:int = 0;
        var _loc7_:TankmanAchievementVO = null;
        var _loc9_:int = 0;
        var _loc2_:Array = [];
        var _loc3_:int = param1.achievements.length;
        var _loc8_:int = 0;
        while (_loc8_ < _loc3_) {
            _loc5_ = param1.achievements[_loc8_];
            _loc6_ = _loc5_.length;
            _loc9_ = 0;
            while (_loc9_ < _loc6_) {
                _loc7_ = new TankmanAchievementVO(_loc5_[_loc9_]);
                _loc2_.push(_loc7_);
                _loc9_++;
            }
            _loc4_ = _loc2_.length;
            if (_loc8_ < _loc3_ - 1 && _loc4_ > 0) {
                _loc2_[_loc4_ - 1].showSeparator = true;
            }
            _loc8_++;
        }
        _loc4_ = _loc2_.length;
        if (_loc4_ > 0) {
            _loc2_[_loc4_ - 1].showSeparator = false;
        }
        this.stats = {};
        this.stats.achievements = _loc2_;
        this.stats.stats = param1.stats;
        this.stats.firstMsg = param1.firstMsg;
        this.stats.secondMsg = param1.secondMsg;
        this.runtimeUpdateByModel(PersonalCaseStats, this.stats);
    }

    public function as_setRetrainingData(param1:Object):void {
        var _loc4_:Object = null;
        this.retrainingData = new PersonalCaseRetrainingModel();
        this.retrainingData.credits = param1.money[0];
        this.retrainingData.gold = param1.money[1];
        this.retrainingData.tankmanCost = param1.tankmanCost;
        this.retrainingData.vehicles = param1.vehicles;
        this.retrainingData.testData = this.data;
        this.retrainingData.testStats = this.stats;
        this.retrainingData.action = param1.action;
        var _loc2_:Array = param1.vehicles;
        var _loc3_:uint = _loc2_.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = _loc2_[_loc5_];
            switch (_loc4_.vehicleType) {
                case VehicleTypes.LIGHT_TANK:
                    this.retrainingData.lightTanks.push(_loc4_);
                    break;
                case VehicleTypes.MEDIUM_TANK:
                    this.retrainingData.mediumTanks.push(_loc4_);
                    break;
                case VehicleTypes.HEAVY_TANK:
                    this.retrainingData.heavyTanks.push(_loc4_);
                    break;
                case VehicleTypes.AT_SPG:
                    this.retrainingData.AT_SPG.push(_loc4_);
                    break;
                case VehicleTypes.SPG:
                    this.retrainingData.SPG.push(_loc4_);
                    break;
                default:
                    DebugUtils.LOG_DEBUG("ERROR unknown tank type");
            }
            _loc5_++;
        }
        this.retrainingData.nationID = this.data.nationID;
        this.retrainingData.tankmanID = this.data.inventoryID;
        this.retrainingData.currentVehicle = this.data.currentVehicle;
        this.retrainingData.nativeVehicle = this.data.nativeVehicle;
        this.retrainingData.specializationLevel = this.data.specializationLevel;
        this.runtimeUpdateByModel(CrewTankmanRetraining, this.retrainingData);
    }

    public function as_setSkillsData(param1:Array):void {
        var _loc3_:Object = null;
        var _loc4_:Array = null;
        var _loc5_:uint = 0;
        var _loc6_:PersonalCaseSkillsModel = null;
        var _loc8_:String = null;
        var _loc9_:int = 0;
        var _loc10_:Object = null;
        this.skillsModel = [];
        var _loc2_:uint = param1.length;
        var _loc7_:int = 0;
        while (_loc7_ < _loc2_) {
            _loc3_ = param1[_loc7_];
            _loc4_ = _loc3_.hasOwnProperty("skills") && _loc3_.skills is Array ? _loc3_.skills : null;
            if (!(!_loc4_ || _loc4_.length <= 0)) {
                _loc6_ = new PersonalCaseSkillsModel();
                _loc8_ = _loc3_.id;
                _loc6_.rankId = _loc8_;
                _loc6_.title = _loc3_.id;
                _loc6_.isHeader = true;
                _loc6_.selfSkill = this.data.roleType == _loc8_;
                this.skillsModel.push(_loc6_);
                _loc5_ = _loc4_.length;
                _loc9_ = 0;
                while (_loc9_ < _loc5_) {
                    _loc6_ = new PersonalCaseSkillsModel();
                    _loc10_ = _loc4_[_loc9_];
                    _loc6_.title = _loc10_.id;
                    _loc6_.isHeader = false;
                    _loc6_.desc = _loc10_.desc;
                    _loc6_.enabled = _loc10_.enabled;
                    _loc6_.name = _loc10_.name;
                    _loc6_.tankmanID = _loc10_.tankmanID;
                    _loc6_.rankId = _loc8_;
                    _loc6_.selfSkill = this.data.roleType == _loc8_;
                    _loc6_.hasNewSkills = this.data.skillsCountForLearn > 0;
                    this.skillsModel.push(_loc6_);
                    _loc9_++;
                }
            }
            _loc7_++;
        }
        this.updateSkillsRelatedElements();
        this.runtimeUpdateByModel(PersonalCaseSkills, this.skillsModel);
    }

    public function as_setDocumentsData(param1:Object):void {
        this.documentsData = new PersonalCaseDocsModel();
        if (!Extensions.isScaleform) {
            this.createTestNames(param1.firstnames);
            this.createTestNames(param1.lastnames);
        }
        this.documentsData.originalIconFile = this.data.iconFile;
        this.documentsData.firstNames = param1.firstnames;
        this.documentsData.lastNames = param1.lastnames;
        if (param1.action) {
            this.documentsData.actionPriceDataGoldVo = new ActionPriceVO(param1.action);
            this.documentsData.actionPriceDataGoldVo.ico = IconsTypes.GOLD;
            this.documentsData.actionPriceDataCreditsVo = new ActionPriceVO(param1.action);
            this.documentsData.actionPriceDataCreditsVo.ico = IconsTypes.CREDITS;
        }
        this.calculateMaxChars(this.documentsData.firstNames, this.documentsData, "firstNames");
        this.calculateMaxChars(this.documentsData.lastNames, this.documentsData, "lastNames");
        this.documentsData.icons = param1.icons;
        this.documentsData.userCredits = param1.money[0];
        this.documentsData.userGold = param1.money[1];
        if (param1.passportChangeCost is Array) {
            this.documentsData.priceOfGold = param1.passportChangeCost[0];
            this.documentsData.priceOfCredits = param1.passportChangeCost[1];
        }
        else if (param1.passportChangeCost is int) {
            this.documentsData.priceOfGold = param1.passportChangeCost;
            this.documentsData.useOnlyGold = true;
        }
        this.documentsData.currentTankmanFirstName = this.data.firstname;
        this.documentsData.currentTankmanLastName = this.data.lastname;
        this.documentsData.currentTankmanIcon = this.data.iconFile;
        if (!Extensions.isScaleform) {
            this.documentsData.currentTankmanFirstName = param1.firstnames[0].value;
            this.documentsData.currentTankmanLastName = param1.lastnames[0].value;
        }
        this.runtimeUpdateByModel(PersonalCaseDocs, this.documentsData);
        this.rentainingTabUpdated = true;
    }

    protected function parsePersonalCaseModel(param1:Object):void {
        var _loc9_:PersonalCaseCurrentVehicle = null;
        var _loc2_:PersonalCaseModel = new PersonalCaseModel();
        var _loc3_:Object = param1.nativeVehicle;
        _loc2_.nativeVehicle.innationID = _loc3_.innationID;
        _loc2_.nativeVehicle.type = _loc3_.type;
        var _loc4_:Object = param1.tankman;
        _loc2_.inventoryID = _loc4_.inventoryID;
        _loc2_.inTank = _loc4_.isInTank;
        _loc2_.nationID = _loc4_.nationID;
        _loc2_.iconFile = _loc4_.icon.big;
        _loc2_.rankIconFile = _loc4_.iconRank.big;
        _loc2_.rank = _loc4_.rankUserName;
        var _loc5_:Object = _loc4_.nativeVehicle;
        var _loc6_:Object = _loc4_.currentVehicle;
        var _loc7_:Object = param1.currentVehicle;
        var _loc8_:Boolean = param1.isOpsLocked;
        _loc2_.nativeVehicle.userName = _loc5_.userName;
        _loc2_.nativeVehicle.contourIconFile = _loc5_.iconContour;
        _loc2_.nativeVehicle.icon = _loc5_.icon;
        _loc2_.firstname = _loc4_.firstUserName;
        _loc2_.lastname = _loc4_.lastUserName;
        if (_loc7_) {
            _loc9_ = new PersonalCaseCurrentVehicle();
            _loc2_.currentVehicle = _loc9_;
            _loc9_.innationID = _loc7_.innationID;
            _loc9_.type = _loc7_.type;
            _loc9_.currentVehicleName = _loc6_.userName;
            _loc9_.inventoryID = _loc6_.inventoryID;
            _loc9_.iconContour = _loc6_.iconContour;
            _loc9_.icon = _loc6_.icon;
            _loc9_.currentVehicleBroken = _loc7_.isBroken;
            _loc9_.currentVehicleLocked = _loc7_.isLocked || _loc8_;
            _loc9_.currentVehicleLockMessage = param1.lockMessage;
        }
        _loc2_.specializationLevel = _loc4_.roleLevel;
        _loc2_.skillsCountForLearn = _loc4_.newSkillsCount[0];
        _loc2_.lastNewSkillExp = _loc4_.newSkillsCount[1];
        _loc2_.skills = this.parseCarouselTankmanSkills(_loc4_.skills, _loc2_.skillsCountForLearn, _loc2_.inventoryID);
        _loc2_.roleType = _loc4_.roleName;
        _loc2_.role = _loc4_.roleUserName;
        _loc2_.modifiers = param1.modifiers;
        _loc2_.enoughFreeXPForTeaching = param1.enoughFreeXPForTeaching;
        this.autoSelectTab = parseInt(param1.tabIndex);
        this.data = _loc2_;
    }

    protected function updateCommonElements():void {
    }

    protected function updateSkillsRelatedElements():void {
    }

    protected function runtimeUpdateByModel(param1:Class, param2:Object):void {
    }

    private function parseCarouselTankmanSkills(param1:Array, param2:int, param3:int):Array {
        var _loc6_:CarouselTankmanSkillsModel = null;
        var _loc7_:Object = null;
        var _loc4_:Array = [];
        var _loc5_:uint = param1.length;
        var _loc8_:int = 0;
        while (_loc8_ < _loc5_) {
            _loc6_ = new CarouselTankmanSkillsModel();
            _loc7_ = param1[_loc8_];
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
            _loc8_++;
        }
        if (param2 > 0) {
            _loc6_ = new CarouselTankmanSkillsModel();
            _loc6_.isNewSkill = true;
            _loc6_.skillsCountForLearn = param2;
            _loc6_.tankmanID = param3;
            _loc4_.push(_loc6_);
        }
        return _loc4_;
    }

    private function calculateMaxChars(param1:Array, param2:PersonalCaseDocsModel, param3:String):void {
        var _loc5_:Object = null;
        var _loc6_:uint = 0;
        var _loc4_:uint = param1.length;
        var _loc7_:int = 0;
        while (_loc7_ < _loc4_) {
            _loc5_ = param1[_loc7_];
            if (_loc5_.hasOwnProperty(FIELD_VALUE)) {
                _loc6_ = _loc5_[FIELD_VALUE].length;
            }
            else {
                _loc6_ = 0;
            }
            if (param3 == FIELD_FIRST_NAMES && _loc6_ > param2.fistNameMaxChars) {
                param2.fistNameMaxChars = _loc6_;
            }
            else if (param3 == FIELD_LAST_NAMES && _loc6_ > param2.lastNameMaxChars) {
                param2.lastNameMaxChars = _loc6_;
            }
            _loc7_++;
        }
    }

    private function createTestNames(param1:Array):void {
        var _loc3_:Object = null;
        var _loc4_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc2_:uint = param1.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_) {
            _loc3_ = param1[_loc5_];
            _loc3_.value = "";
            _loc6_ = Math.random() * 6 + 4;
            _loc7_ = 0;
            while (_loc7_ < _loc6_) {
                _loc4_ = Math.random() * templateS.length;
                _loc3_.value = _loc3_.value + templateS[_loc4_];
                _loc7_++;
            }
            _loc5_++;
        }
    }
}
}

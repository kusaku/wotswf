package net.wg.gui.lobby.hangar.crew {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;

public class TankmanVO extends DAAPIDataClass {

    private static const SKILLS:String = "skills";

    private static const TANKMEN_SKILL_SMALL:String = "../maps/icons/tankmen/skills/small/";

    private static const MAX_RENDER_SKILLS:int = 5;

    private static const MAX_SKILL_LEVEL:int = 100;

    private static const NEW_SKILL:String = "new_skill.png";

    public var firstName:String = "";

    public var lastName:String = "";

    public var rank:String = "";

    public var specializationLevel:int = -1;

    public var role:String = "";

    public var vehicleType:String = "";

    public var iconFile:String = "";

    public var rankIconFile:String = "";

    public var roleIconFile:String = "";

    public var contourIconFile:String = "";

    public var tankmanID:Number = NaN;

    public var nationID:int = -1;

    public var typeID:int = -1;

    public var inTank:Boolean = false;

    public var roleType:String = "";

    public var tankType:String = "";

    public var efficiencyLevel:int = -1;

    public var bonus:int = -1;

    public var lastSkillLevel:int = -1;

    public var isLessMastered:Boolean = false;

    public var compact:String = "";

    public var availableSkillsCount:int = -1;

    public var selected:Boolean = false;

    private var _recruit:Boolean = false;

    private var _personalCase:Boolean = false;

    private var _currentRole:TankmanRoleVO;

    private var _buySkillLevel:int = 0;

    private var _canBuySkill:Boolean = false;

    private var _skills:Vector.<SkillsVO>;

    private var _renderSkills:Array;

    public function TankmanVO(param1:Object) {
        this._skills = new Vector.<SkillsVO>(0);
        this._renderSkills = [];
        super(param1);
        this.prepareRenderSkills();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:SkillsVO = null;
        if (param1 == SKILLS) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc6_ = new SkillsVO(_loc3_[_loc5_]);
                if (_loc6_.buy) {
                    this._canBuySkill = true;
                    this._buySkillLevel = _loc6_.level;
                    _loc6_.dispose();
                }
                else {
                    if (_loc6_.icon) {
                        _loc6_.icon = TANKMEN_SKILL_SMALL + _loc6_.icon;
                    }
                    _loc6_.inprogress = _loc6_.level < MAX_SKILL_LEVEL;
                    this._skills.push(_loc6_);
                }
                _loc5_++;
            }
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        var _loc1_:uint = this._skills.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._skills[_loc2_].dispose();
            _loc2_++;
        }
        this._skills.splice(0, _loc1_);
        this._skills = null;
        _loc1_ = this._renderSkills.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            this._renderSkills[_loc3_].dispose();
            _loc3_++;
        }
        this._renderSkills.splice(0, _loc1_);
        this._renderSkills = null;
        this._currentRole = null;
        super.onDispose();
    }

    public function clone():TankmanVO {
        var _loc1_:TankmanVO = new TankmanVO({});
        _loc1_.firstName = this.firstName;
        _loc1_.lastName = this.lastName;
        _loc1_.rank = this.rank;
        _loc1_.specializationLevel = this.specializationLevel;
        _loc1_.role = this.role;
        _loc1_.vehicleType = this.vehicleType;
        _loc1_.iconFile = this.iconFile;
        _loc1_.rankIconFile = this.rankIconFile;
        _loc1_.roleIconFile = this.roleIconFile;
        _loc1_.contourIconFile = this.contourIconFile;
        _loc1_.tankmanID = this.tankmanID;
        _loc1_.nationID = this.nationID;
        _loc1_.typeID = this.typeID;
        _loc1_.inTank = this.inTank;
        _loc1_.roleType = this.roleType;
        _loc1_.tankType = this.tankType;
        _loc1_.efficiencyLevel = this.efficiencyLevel;
        _loc1_.bonus = this.bonus;
        _loc1_.lastSkillLevel = this.lastSkillLevel;
        _loc1_.isLessMastered = this.isLessMastered;
        _loc1_.compact = this.compact;
        _loc1_.availableSkillsCount = this.availableSkillsCount;
        _loc1_.selected = this.selected;
        _loc1_._recruit = this._recruit;
        _loc1_._personalCase = this._personalCase;
        _loc1_._currentRole = this._currentRole;
        _loc1_._buySkillLevel = this._buySkillLevel;
        _loc1_._canBuySkill = this._canBuySkill;
        var _loc2_:uint = this._skills.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_._skills.push(this._skills[_loc3_].clone());
            _loc3_++;
        }
        _loc1_.prepareRenderSkills();
        return _loc1_;
    }

    private function createBuySkillItem():SkillsVO {
        var _loc1_:SkillsVO = new SkillsVO({});
        _loc1_.icon = TANKMEN_SKILL_SMALL + NEW_SKILL;
        _loc1_.tankmanID = this.tankmanID;
        _loc1_.level = this._buySkillLevel;
        _loc1_.buy = true;
        return _loc1_;
    }

    private function prepareRenderSkills():void {
        var _loc4_:int = 0;
        var _loc1_:int = this._renderSkills.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._renderSkills[_loc2_].dispose();
            _loc2_++;
        }
        this._renderSkills.splice(0, _loc1_);
        var _loc3_:* = this.lastSkillLevel != MAX_SKILL_LEVEL;
        _loc1_ = this._skills.length;
        if (this.needGroupSkills) {
            if (_loc3_) {
                this._renderSkills.push(this._skills[_loc1_ - 2].clone());
            }
            else {
                this._renderSkills.push(this._skills[_loc1_ - 1].clone());
            }
            if (_loc3_ || this._canBuySkill) {
                this._renderSkills.push(new SkillsVO({}));
                this._renderSkills.push(new SkillsVO({}));
                if (_loc3_) {
                    this._renderSkills.push(this._skills[_loc1_ - 1].clone());
                }
                else {
                    this._renderSkills.push(this.createBuySkillItem());
                }
            }
        }
        else {
            _loc4_ = 0;
            while (_loc4_ < _loc1_) {
                this._renderSkills.push(this._skills[_loc4_].clone());
                _loc4_++;
            }
            if (this._canBuySkill) {
                this._renderSkills.push(this.createBuySkillItem());
            }
        }
    }

    public function get needGroupSkills():Boolean {
        return this._skills.length + (!!this._canBuySkill ? 1 : 0) > MAX_RENDER_SKILLS;
    }

    public function get skills():Vector.<SkillsVO> {
        return this._skills;
    }

    public function get recruit():Boolean {
        return this._recruit;
    }

    public function set recruit(param1:Boolean):void {
        this._recruit = param1;
    }

    public function get personalCase():Boolean {
        return this._personalCase;
    }

    public function set personalCase(param1:Boolean):void {
        this._personalCase = param1;
    }

    public function get currentRole():TankmanRoleVO {
        return this._currentRole;
    }

    public function set currentRole(param1:TankmanRoleVO):void {
        this._currentRole = param1;
    }

    public function get renderSkills():Array {
        return this._renderSkills;
    }

    public function get lastSkillInProgress():Boolean {
        return this._skills.length > 0 && this.lastSkillLevel != MAX_SKILL_LEVEL;
    }
}
}

package net.wg.gui.lobby.components.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;

public class BaseTankmanVO extends DAAPIDataClass {

    private static const SKILLS:String = "skills";

    private static const MAX_SKILL_LEVEL:int = 100;

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

    public var nationID:int = -1;

    public var typeID:int = -1;

    public var inTank:Boolean = false;

    public var roleType:String = "";

    public var tankType:String = "";

    public var compact:String = "";

    public var tankmanID:Number = NaN;

    public var lastSkillLevel:int = -1;

    private var _skills:Array;

    private var _buySkillLevel:int = 0;

    private var _canBuySkill:Boolean = false;

    private var _buySkillCount:int = 0;

    public function BaseTankmanVO(param1:Object) {
        this._skills = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:SkillsVO = null;
        if (param1 == SKILLS) {
            if (param2 != null) {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + Array);
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while (_loc5_ < _loc4_) {
                    _loc6_ = new SkillsVO(_loc3_[_loc5_]);
                    if (_loc6_.buy) {
                        this._canBuySkill = true;
                        this._buySkillCount = _loc6_.buyCount;
                        this._buySkillLevel = _loc6_.level;
                        _loc6_.dispose();
                    }
                    else {
                        if (_loc6_.icon) {
                            _loc6_.icon = RES_ICONS.maps_icons_tankmen_skills_small(_loc6_.icon);
                        }
                        this._skills.push(_loc6_);
                    }
                    _loc5_++;
                }
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
        super.onDispose();
    }

    public function get buySkillCount():int {
        return this._buySkillCount;
    }

    public function set buySkillCount(param1:int):void {
        this._buySkillCount = param1;
    }

    public function get skills():Array {
        return this._skills;
    }

    public function get lastSkillInProgress():Boolean {
        return this._skills.length > 0 && this.lastSkillLevel != MAX_SKILL_LEVEL;
    }

    public function get buySkillLevel():int {
        return this._buySkillLevel;
    }

    public function set buySkillLevel(param1:int):void {
        this._buySkillLevel = param1;
    }

    public function get canBuySkill():Boolean {
        return this._canBuySkill;
    }

    public function set canBuySkill(param1:Boolean):void {
        this._canBuySkill = param1;
    }
}
}

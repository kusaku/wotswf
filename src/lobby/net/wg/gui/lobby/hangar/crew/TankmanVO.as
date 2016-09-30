package net.wg.gui.lobby.hangar.crew {
import net.wg.gui.lobby.components.data.BaseTankmanVO;

public class TankmanVO extends BaseTankmanVO {

    public var efficiencyLevel:int = -1;

    public var bonus:int = -1;

    public var isLessMastered:Boolean = false;

    public var availableSkillsCount:int = -1;

    public var selected:Boolean = false;

    private var _recruit:Boolean = false;

    private var _personalCase:Boolean = false;

    private var _currentRole:TankmanRoleVO;

    public function TankmanVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this._currentRole = null;
        super.onDispose();
    }

    public function clone():TankmanVO {
        var _loc1_:TankmanVO = null;
        _loc1_ = new TankmanVO({});
        _loc1_.firstName = firstName;
        _loc1_.lastName = lastName;
        _loc1_.rank = rank;
        _loc1_.specializationLevel = specializationLevel;
        _loc1_.role = role;
        _loc1_.vehicleType = vehicleType;
        _loc1_.iconFile = iconFile;
        _loc1_.rankIconFile = rankIconFile;
        _loc1_.roleIconFile = roleIconFile;
        _loc1_.contourIconFile = contourIconFile;
        _loc1_.tankmanID = tankmanID;
        _loc1_.nationID = nationID;
        _loc1_.typeID = typeID;
        _loc1_.inTank = inTank;
        _loc1_.roleType = roleType;
        _loc1_.tankType = tankType;
        _loc1_.efficiencyLevel = this.efficiencyLevel;
        _loc1_.bonus = this.bonus;
        _loc1_.lastSkillLevel = lastSkillLevel;
        _loc1_.isLessMastered = this.isLessMastered;
        _loc1_.compact = compact;
        _loc1_.availableSkillsCount = this.availableSkillsCount;
        _loc1_.selected = this.selected;
        _loc1_._recruit = this._recruit;
        _loc1_._personalCase = this._personalCase;
        _loc1_._currentRole = this._currentRole;
        _loc1_.buySkillLevel = buySkillLevel;
        _loc1_.canBuySkill = canBuySkill;
        _loc1_.buySkillCount = buySkillCount;
        var _loc2_:uint = skills.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_.skills.push(skills[_loc3_].clone());
            _loc3_++;
        }
        return _loc1_;
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
}
}

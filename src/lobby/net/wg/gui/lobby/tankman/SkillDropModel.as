package net.wg.gui.lobby.tankman {
import net.wg.data.constants.Values;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class SkillDropModel implements IDisposable {

    public static const SAVING_MODE_GOLD:int = 2;

    public static const SAVING_MODE_CREDITS:int = 1;

    public var gold:int = 0;

    public var credits:int = 0;

    public var compactDescriptor:String = "";

    public var tankmanName:String = "";

    public var tankmanIcon:String = "";

    public var roleIcon:String = "";

    public var roleLevel:Number = NaN;

    public var nationID:Number = NaN;

    public var skillsCount:int = 0;

    public var lastSkill:String = null;

    public var lastSkillLevel:Number = NaN;

    public var preLastSkill:String = null;

    public var hasNewSkill:Boolean;

    public var newSkillsCount:int = 0;

    public var lastNewSkillLevel:Number = 0;

    public var dropSkillFree:DropSkillsCost;

    public var dropSkillCredits:DropSkillsCost;

    public var dropSkillGold:DropSkillsCost;

    public var defaultSavingMode:int;

    public var freeDropText:String = "";

    public function SkillDropModel() {
        this.dropSkillFree = new DropSkillsCost();
        this.dropSkillCredits = new DropSkillsCost();
        this.dropSkillGold = new DropSkillsCost();
        super();
    }

    public static function parseFromObject(param1:Object):SkillDropModel {
        var _loc4_:Object = null;
        var _loc2_:SkillDropModel = new SkillDropModel();
        _loc2_.credits = param1.money[0];
        _loc2_.gold = param1.money[1];
        _loc2_.compactDescriptor = param1.tankman.strCD;
        _loc2_.tankmanName = param1.tankman.firstUserName + Values.SPACE_STR + param1.tankman.lastUserName;
        _loc2_.tankmanIcon = param1.tankman.icon.big;
        _loc2_.roleIcon = param1.tankman.iconRole.small;
        _loc2_.roleLevel = param1.tankman.roleLevel;
        _loc2_.nationID = param1.tankman.nationID;
        var _loc3_:Array = param1.tankman.skills;
        _loc2_.skillsCount = _loc3_.length;
        if (_loc2_.skillsCount > 0) {
            _loc4_ = _loc3_[_loc2_.skillsCount - 1];
            _loc2_.lastSkill = _loc4_.icon.small;
            _loc2_.lastSkillLevel = _loc4_.level;
        }
        if (_loc2_.skillsCount > 1) {
            _loc4_ = _loc3_[_loc2_.skillsCount - 2];
            _loc2_.preLastSkill = _loc4_.icon.small;
        }
        _loc2_.hasNewSkill = param1.hasNewSkills;
        _loc2_.newSkillsCount = param1.newSkills[0];
        _loc2_.lastNewSkillLevel = param1.newSkills[1];
        _loc2_.dropSkillFree = DropSkillsCost.parseFromObject(param1.dropSkillsCost[0]);
        _loc2_.dropSkillFree.id = 0;
        _loc2_.dropSkillCredits = DropSkillsCost.parseFromObject(param1.dropSkillsCost[1]);
        _loc2_.dropSkillCredits.id = SAVING_MODE_CREDITS;
        _loc2_.dropSkillGold = DropSkillsCost.parseFromObject(param1.dropSkillsCost[2]);
        _loc2_.dropSkillGold.id = SAVING_MODE_GOLD;
        _loc2_.defaultSavingMode = param1.defaultSavingMode;
        if (param1.texts) {
            _loc2_.freeDropText = param1.texts.freeDrop;
        }
        return _loc2_;
    }

    public function get nation():String {
        return App.utils.nations.getNationName(this.nationID);
    }

    public final function dispose():void {
        this.dropSkillFree.dispose();
        this.dropSkillFree = null;
        this.dropSkillCredits.dispose();
        this.dropSkillCredits = null;
        this.dropSkillGold.dispose();
        this.dropSkillGold = null;
    }
}
}
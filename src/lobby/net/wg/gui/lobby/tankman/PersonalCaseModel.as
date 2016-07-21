package net.wg.gui.lobby.tankman {
public class PersonalCaseModel {

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

    public function PersonalCaseModel() {
        this.nativeVehicle = new NativeVehicle();
        this.skills = [];
        super();
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

package net.wg.gui.lobby.battleResults.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class EfficiencyRendererVO extends DAAPIDataClass {

    public var armorTotalItems:int = -1;

    public var damageDealtNames:String = "";

    public var killCount:int = -1;

    public var criticalDevices:String = "";

    public var playerFullName:String = "";

    public var isAlly:Boolean = false;

    public var typeCompDescr:int = -1;

    public var damageTotalItems:int = -1;

    public var destroyedTankmen:String = "";

    public var damageDealt:int = -1;

    public var critsCount:String = "";

    public var damageDealtVals:String = "";

    public var damageAssisted:int = -1;

    public var spotted:int = -1;

    public var destroyedDevices:String = "";

    public var playerRegion:String = "";

    public var vehicleId:int = -1;

    public var playerName:String = "";

    public var armorNames:String = "";

    public var armorVals:String = "";

    public var playerClan:String = "";

    public var isFake:Boolean = false;

    public var vehicleName:String = "";

    public var piercings:int = -1;

    public var deathReason:int = -1;

    public var tankIcon:String = "";

    public var groupLabel:String = "";

    public var baseLabel:String = "";

    public var hoveredKind:String = "";

    public var isDisabled:Boolean = false;

    public var defenceVals:int = -1;

    public var captureVals:int = -1;

    public var captureNames:String = "";

    public var captureTotalItems:int = -1;

    public var defenceNames:String = "";

    public var defenceTotalItems:int = -1;

    public var damageAssistedVals:int = -1;

    public var damageAssistedNames:String = "";

    public var assistTotalItems:int = -1;

    public function EfficiencyRendererVO(param1:Object) {
        super(param1);
    }
}
}

package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class IntelligenceRendererVO extends DAAPIDataClass {

    public var levelIcon:String = "";

    public var clanTag:String = "";

    public var defenceTime:String = "";

    public var avgBuildingLvl:Number = -1;

    public var availabilityDays:int = -1;

    public var clanID:Number = -1;

    public var isFavorite:Boolean = false;

    public var isAttackAvailable:Boolean = false;

    public var clanLvl:int = -1;

    public var defenceStartTime:int = -1;

    public function IntelligenceRendererVO(param1:Object) {
        super(param1);
    }
}
}

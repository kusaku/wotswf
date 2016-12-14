package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class IntelligenceClanFilterVO extends DAAPIDataClass {

    public var minClanLevel:int = -1;

    public var maxClanLevel:int = -1;

    public var startDefenseHour:int = -1;

    public var startDefenseMinutes:int = -1;

    public var isTwelveHoursFormat:Boolean = false;

    public var yourOwnClanStartDefenseHour:int = -1;

    public var isWrongLocalTime:Boolean = false;

    public var skipValues:Array = null;

    public function IntelligenceClanFilterVO(param1:Object = null) {
        super(param1);
    }

    override public function isEquals(param1:DAAPIDataClass):Boolean {
        var _loc2_:IntelligenceClanFilterVO = param1 as IntelligenceClanFilterVO;
        if (!_loc2_) {
            return false;
        }
        return this.minClanLevel == _loc2_.minClanLevel && this.maxClanLevel == _loc2_.maxClanLevel && this.startDefenseHour == _loc2_.startDefenseHour && this.startDefenseMinutes == _loc2_.startDefenseMinutes && this.isTwelveHoursFormat == _loc2_.isTwelveHoursFormat && this.yourOwnClanStartDefenseHour == _loc2_.yourOwnClanStartDefenseHour && this.isWrongLocalTime == _loc2_.isWrongLocalTime && isHomogenArraysEquals(this.skipValues, _loc2_.skipValues);
    }
}
}

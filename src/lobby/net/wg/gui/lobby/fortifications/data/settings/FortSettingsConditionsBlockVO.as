package net.wg.gui.lobby.fortifications.data.settings {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.fortifications.data.tankIcon.FortTankIconVO;

public class FortSettingsConditionsBlockVO extends DAAPIDataClass {

    private static const TANK_ICONS_VO:Vector.<String> = new <String>["defenceTankIcon", "attackTankIconTop", "attackTankIconBottom"];

    public var startLvlSrc:String = "";

    public var endLvlSrc:String = "";

    public var buildingIcon:String = "";

    public var lvlDashTF:String = "";

    public var defenceTankIcon:FortTankIconVO = null;

    public var attackTankIconTop:FortTankIconVO = null;

    public var attackTankIconBottom:FortTankIconVO = null;

    public function FortSettingsConditionsBlockVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (TANK_ICONS_VO.indexOf(param1) >= 0 && param2) {
            this[param1] = new FortTankIconVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        var _loc2_:FortTankIconVO = null;
        var _loc1_:Vector.<FortTankIconVO> = new <FortTankIconVO>[this.defenceTankIcon, this.attackTankIconTop, this.attackTankIconBottom];
        while (_loc1_.length > 0) {
            _loc2_ = _loc1_.pop();
            if (_loc2_ != null) {
                _loc2_.dispose();
            }
        }
        this.defenceTankIcon = null;
        this.attackTankIconTop = null;
        this.attackTankIconBottom = null;
        super.onDispose();
    }
}
}

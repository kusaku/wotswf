package net.wg.gui.lobby.battleloading.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VisualTipInfoVO extends DAAPIDataClass {

    public var settingID:String = "";

    public var tipIcon:String = "";

    public var arenaTypeID:int = -1;

    public var minimapTeam:int = -1;

    public var showMinimap:Boolean = false;

    public function VisualTipInfoVO(param1:Object) {
        super(param1);
    }
}
}

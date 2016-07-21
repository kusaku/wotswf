package net.wg.gui.battle.views.falloutRespawnView.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FalloutRespawnViewVO extends DAAPIDataClass {

    public var titleMsg:String = "";

    public var selectedVehicle:String = "";

    public var isPostmortemViewBtnEnabled:Boolean = false;

    public var postmortemBtnLbl:String = "";

    public var helpTextStr:String = "";

    public var helpPanelMode:String = "";

    public var topInfoStr:String = "";

    public var respawnInfoStr:String = "";

    public function FalloutRespawnViewVO(param1:Object) {
        super(param1);
    }
}
}

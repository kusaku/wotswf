package net.wg.gui.cyberSport.controls.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CSRallyInfoVO extends DAAPIDataClass {

    public var icon:String = "";

    public var name:String = "";

    public var profileBtnLabel:String = "";

    public var profileBtnTooltip:String = "";

    public var description:String = "";

    public var ladderIcon:String = "";

    public var id:Number;

    public var showLadder:Boolean;

    public function CSRallyInfoVO(param1:Object) {
        super(param1);
    }
}
}

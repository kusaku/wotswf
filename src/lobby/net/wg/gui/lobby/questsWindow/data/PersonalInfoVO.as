package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class PersonalInfoVO extends DAAPIDataClass {

    public var text:String = "";

    public var statusStr:String = "";

    public function PersonalInfoVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.text = null;
        this.statusStr = null;
        super.onDispose();
    }
}
}

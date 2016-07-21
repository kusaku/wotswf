package net.wg.gui.lobby.header.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestsControlBtnVO extends DAAPIDataClass {

    public var titleText:String = "";

    public var additionalText:String = "";

    public var tooltip:String = "";

    public function QuestsControlBtnVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.titleText = null;
        this.additionalText = null;
        this.tooltip = null;
        super.onDispose();
    }
}
}

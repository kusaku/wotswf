package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestDetailsSeparatorVO extends DAAPIDataClass {

    private static const PADDINGS_FIELD_NAME:String = "paddings";

    public var paddings:PaddingsVO;

    public var linkage:String = "";

    public function QuestDetailsSeparatorVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case PADDINGS_FIELD_NAME:
                this.paddings = new PaddingsVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        if (this.paddings != null) {
            this.paddings.dispose();
            this.paddings = null;
        }
        super.onDispose();
    }
}
}

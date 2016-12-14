package net.wg.gui.lobby.christmas.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ConvertDecorationsDialogVO extends DAAPIDataClass {

    private static const SLOT_FROM_FIELD_NAME:String = "slotFrom";

    private static const SLOT_TO_FIELD_NAME:String = "slotTo";

    public var slotFrom:DecorationVO;

    public var slotTo:DecorationVO;

    public function ConvertDecorationsDialogVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SLOT_FROM_FIELD_NAME) {
            this.slotFrom = new DecorationVO(param2);
            return false;
        }
        if (param1 == SLOT_TO_FIELD_NAME) {
            this.slotTo = new DecorationVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.slotFrom.dispose();
        this.slotFrom = null;
        this.slotTo.dispose();
        this.slotTo = null;
        super.onDispose();
    }
}
}

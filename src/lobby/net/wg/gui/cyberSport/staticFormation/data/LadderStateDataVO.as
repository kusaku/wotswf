package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class LadderStateDataVO extends DAAPIDataClass {

    private static const STATE_MESSAGE_FIELD_NAME:String = "stateMessage";

    public var showStateMessage:Boolean = false;

    public var stateMessage:LadderIconMessageVO;

    public function LadderStateDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == STATE_MESSAGE_FIELD_NAME) {
            this.stateMessage = new LadderIconMessageVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.stateMessage.dispose();
        this.stateMessage = null;
        super.onDispose();
    }
}
}

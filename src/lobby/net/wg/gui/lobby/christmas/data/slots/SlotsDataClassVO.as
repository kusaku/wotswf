package net.wg.gui.lobby.christmas.data.slots {
import net.wg.gui.data.DataClassItemVO;

public class SlotsDataClassVO extends DataClassItemVO {

    private var _targetData:SlotsDataVO = null;

    public function SlotsDataClassVO(param1:Object) {
        super(param1);
    }

    override public function fromHash(param1:Object):void {
        super.fromHash(param1);
        this._targetData = SlotsDataVO(voData);
    }

    override protected function onDispose():void {
        this._targetData = null;
        super.onDispose();
    }

    public function get targetData():SlotsDataVO {
        return this._targetData;
    }
}
}

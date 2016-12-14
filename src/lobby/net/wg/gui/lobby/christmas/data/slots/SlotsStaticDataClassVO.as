package net.wg.gui.lobby.christmas.data.slots {
import net.wg.gui.data.DataClassItemVO;

public class SlotsStaticDataClassVO extends DataClassItemVO {

    public var linkageClassName:String = "";

    private var _data:SlotsStaticDataVO = null;

    public function SlotsStaticDataClassVO(param1:Object) {
        super(param1);
    }

    override public function fromHash(param1:Object):void {
        super.fromHash(param1);
        this._data = SlotsStaticDataVO(voData);
    }

    override protected function onDispose():void {
        this._data = null;
        super.onDispose();
    }

    public function get data():SlotsStaticDataVO {
        return this._data;
    }
}
}

package net.wg.data.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class TrainingFormVO extends DAAPIDataClass {

    public var roomsLabel:String = "";

    public var playersLabel:String = "";

    public var listData:Array = null;

    public function TrainingFormVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.listData.splice(0);
        this.listData = null;
        super.onDispose();
    }
}
}

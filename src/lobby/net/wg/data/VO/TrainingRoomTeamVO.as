package net.wg.data.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class TrainingRoomTeamVO extends DAAPIDataClass {

    public var teamLabel:String = "";

    public var listData:Array = null;

    public function TrainingRoomTeamVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.listData.splice(0);
        this.listData = null;
        super.onDispose();
    }
}
}

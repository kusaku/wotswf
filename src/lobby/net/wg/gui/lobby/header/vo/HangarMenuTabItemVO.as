package net.wg.gui.lobby.header.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class HangarMenuTabItemVO extends DAAPIDataClass {

    public var label:String = "";

    public var value:String = "";

    public var subValues:Array;

    public var textColor:uint = 0;

    public var textColorOver:uint = 0;

    public var tooltip:String = "";

    public var enabled:Boolean = true;

    public function HangarMenuTabItemVO(param1:Object) {
        this.subValues = [];
        super(param1);
    }

    override protected function onDispose():void {
        this.subValues.splice(0, this.subValues.length);
        this.subValues = null;
        super.onDispose();
    }
}
}

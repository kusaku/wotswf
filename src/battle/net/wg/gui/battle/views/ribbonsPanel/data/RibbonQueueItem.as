package net.wg.gui.battle.views.ribbonsPanel.data {
public class RibbonQueueItem {

    public static const SHOW:String = "show";

    public static const HIDE:String = "hide";

    public var animationType:String = "";

    public var ribbonType:String = "";

    public var valueStr:String = "";

    public var vehName:String = "";

    public var vehType:String = "";

    public var countVehs:String = "";

    public function RibbonQueueItem() {
        super();
    }

    public function setData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String):void {
        this.animationType = param1;
        this.ribbonType = param2;
        this.valueStr = param3;
        this.vehName = param4;
        this.vehType = param5;
        this.countVehs = param6;
    }
}
}

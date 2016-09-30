package net.wg.gui.lobby.settings.feedback.data {
public class RibbonItemData {

    public var ribbonType:String = "";

    public var text:String = "";

    public var vehName:String = "";

    public var value:String = "";

    public function RibbonItemData(param1:String, param2:String, param3:String = "", param4:String = "") {
        super();
        this.ribbonType = param1;
        this.text = param2;
        this.vehName = param4;
        this.value = param3;
    }
}
}

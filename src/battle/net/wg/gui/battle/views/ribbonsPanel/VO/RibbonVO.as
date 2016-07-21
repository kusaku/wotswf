package net.wg.gui.battle.views.ribbonsPanel.VO {
public class RibbonVO {

    public var type:String;

    public var title:String;

    public var count:int;

    public function RibbonVO(param1:String, param2:String, param3:int) {
        super();
        this.type = param1;
        this.title = param2;
        this.count = param3;
    }

    public function incCount(param1:int):int {
        return this.count = this.count + param1;
    }
}
}

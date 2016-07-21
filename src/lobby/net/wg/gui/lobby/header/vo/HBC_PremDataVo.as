package net.wg.gui.lobby.header.vo {
public class HBC_PremDataVo extends HBC_AbstractVO {

    public var btnLabel:String = "";

    public var doLabel:String = "";

    public var isHasAction:Boolean = false;

    public function HBC_PremDataVo() {
        super();
    }

    override public function dispose():void {
        this.btnLabel = null;
        this.doLabel = null;
        super.dispose();
    }
}
}

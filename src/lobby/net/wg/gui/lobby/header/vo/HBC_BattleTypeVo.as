package net.wg.gui.lobby.header.vo {
public class HBC_BattleTypeVo extends HBC_AbstractVO {

    public var battleTypeName:String = "";

    public var battleTypeIcon:String = "";

    public var battleTypeID:String = "";

    public function HBC_BattleTypeVo() {
        super();
    }

    override public function dispose():void {
        this.battleTypeName = null;
        this.battleTypeIcon = null;
        this.battleTypeID = null;
        super.dispose();
    }
}
}

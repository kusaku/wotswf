package net.wg.gui.lobby.header.vo {
public class HBC_FinanceVo extends HBC_AbstractVO {

    public var money:String = "";

    public var btnDoText:String = "";

    public var isDiscountEnabled:Boolean = false;

    public var playDiscountAnimation:Boolean = false;

    public var isHasAction:Boolean = false;

    private var _iconId:String = "empty";

    public function HBC_FinanceVo() {
        super();
    }

    override public function dispose():void {
        this.money = null;
        this.btnDoText = null;
        this._iconId = null;
        super.dispose();
    }

    public function get iconId():String {
        return this._iconId;
    }

    public function set iconId(param1:String):void {
        this._iconId = param1;
    }
}
}

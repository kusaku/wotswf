package net.wg.gui.lobby.window {
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class ConfirmItemWindowVO extends ConfirmItemWindowBaseVO {

    private static const ACTION_PRICE_DATA:String = "actionPriceData";

    public var id:int;

    public var currency:String = "";

    public var price:Array;

    public var maxAvailableCount:Array;

    public var isActionNow:Boolean;

    public var actionPriceData:ActionPriceVO = null;

    public function ConfirmItemWindowVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ACTION_PRICE_DATA && param2 != null) {
            this.actionPriceData = new ActionPriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.actionPriceData != null) {
            this.actionPriceData.dispose();
            this.actionPriceData = null;
        }
        this.price.splice(0);
        this.price = null;
        this.maxAvailableCount.splice(0);
        this.maxAvailableCount = null;
        super.onDispose();
    }
}
}

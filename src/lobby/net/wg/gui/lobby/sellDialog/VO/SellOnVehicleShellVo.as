package net.wg.gui.lobby.sellDialog.VO {
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class SellOnVehicleShellVo extends SellVehicleItemBaseVo {

    public var userName:String = "";

    public var kind:String = "";

    public var action:Object = null;

    public var actionVo:ActionPriceVO = null;

    public function SellOnVehicleShellVo(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == "action") {
            this.action = param2;
            if (this.action) {
                this.actionVo = new ActionPriceVO(this.action);
                this.updateActionPrice();
            }
            return false;
        }
        if (param1 == "count") {
            count = Number(param2);
            this.updateActionPrice();
            return false;
        }
        return this.hasOwnProperty(param1);
    }

    private function updateActionPrice():void {
        if (this.actionVo) {
            this.actionVo.newPrices = [this.actionVo.newPriceBases[0] * count, this.actionVo.newPriceBases[1] * count];
            this.actionVo.oldPrices = [this.actionVo.oldPriceBases[0] * count, this.actionVo.oldPriceBases[1] * count];
        }
    }
}
}

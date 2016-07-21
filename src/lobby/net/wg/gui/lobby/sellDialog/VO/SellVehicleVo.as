package net.wg.gui.lobby.sellDialog.VO {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class SellVehicleVo extends DAAPIDataClass {

    private static const ACTION_LABEL:String = "action";

    public var userName:String = "";

    public var icon:String = "";

    public var level:Number = 0;

    public var isElite:Boolean = false;

    public var isPremium:Boolean = false;

    public var type:String = "";

    public var nationID:Number = 0;

    public var sellPrice:Array = null;

    public var action:Object = null;

    public var actionVo:ActionPriceVO = null;

    public var hasCrew:Boolean = false;

    public var intCD:Number = 0;

    public var isRented:Boolean = false;

    public function SellVehicleVo(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ACTION_LABEL) {
            this.action = param2;
            if (this.action) {
                this.actionVo = new ActionPriceVO(this.action);
            }
            return false;
        }
        return this.hasOwnProperty(param1);
    }

    override protected function onDispose():void {
        if (this.actionVo != null) {
            this.actionVo.dispose();
            this.actionVo = null;
        }
        this.sellPrice.splice(0, this.sellPrice.length);
        this.sellPrice = null;
        this.action = App.utils.data.cleanupDynamicObject(this.action);
        super.onDispose();
    }
}
}

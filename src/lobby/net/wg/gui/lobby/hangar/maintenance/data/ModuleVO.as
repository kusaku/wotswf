package net.wg.gui.lobby.hangar.maintenance.data {
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class ModuleVO extends DAAPIDataClass {

    private static const ACTION_PRICE_DATA:String = "actionPriceData";

    public var id:String = "";

    public var name:String = "";

    public var desc:String = "";

    public var target:int;

    public var compactDescr:int;

    public var prices:Array = null;

    public var currency:String = "";

    public var icon:String = "";

    public var index:int;

    public var slotIndex:int = 0;

    public var inventoryCount:int;

    public var vehicleCount:int;

    public var count:int;

    public var fits:Array = null;

    public var goldEqsForCredits:Boolean;

    public var userCredits:Object = null;

    public var actionPriceData:Object = null;

    public var actionPriceVo:ActionPriceVO = null;

    public var moduleLabel:String = "";

    private var _originalHash:Object;

    public function ModuleVO(param1:Object) {
        super(param1);
        this._originalHash = param1;
    }

    override protected function onDispose():void {
        if (this.actionPriceVo != null) {
            this.actionPriceVo.dispose();
            this.actionPriceVo = null;
        }
        this.userCredits = App.utils.data.cleanupDynamicObject(this.userCredits);
        this.actionPriceData = App.utils.data.cleanupDynamicObject(this.actionPriceData);
        this.prices.splice(0);
        this.fits.splice(0);
        this._originalHash = App.utils.data.cleanupDynamicObject(this._originalHash);
        super.onDispose();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ACTION_PRICE_DATA && param2) {
            this.actionPriceVo = new ActionPriceVO(param2);
        }
        return super.onDataWrite(param1, param2);
    }

    public function clone(param1:int):ModuleVO {
        var _loc2_:ModuleVO = new ModuleVO(this._originalHash);
        _loc2_.slotIndex = param1;
        return _loc2_;
    }

    public function get status():String {
        return this.target == 1 && this.slotIndex != this.index ? MENU.MODULEFITS_WRONG_SLOT : this.fits[this.slotIndex];
    }

    public function get price():int {
        return this.prices[this.currency == CURRENCIES_CONSTANTS.CREDITS ? 0 : 1];
    }
}
}

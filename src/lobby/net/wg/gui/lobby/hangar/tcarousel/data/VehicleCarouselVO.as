package net.wg.gui.lobby.hangar.tcarousel.data {
import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class VehicleCarouselVO extends DAAPIUpdatableDataClass {

    private static const SLOT_PRICE_ACTION_DATA:String = "slotPriceActionData";

    public var id:int = -1;

    public var smallInfoText:String = "";

    public var infoText:String = "";

    public var icon:String = "";

    public var iconSmall:String = "";

    public var clanLock:Number = -1;

    public var slotPrice:Number = 0;

    public var buyTank:Boolean = false;

    public var buySlot:Boolean = false;

    public var lockBackground:Boolean = false;

    public var hasSale:Boolean = false;

    public var label:String = "";

    public var level:Number = 0;

    public var elite:Boolean = false;

    public var premium:Boolean = false;

    public var favorite:Boolean = false;

    public var nation:Number = 0;

    public var xpImgSource:String = "";

    public var tankType:String = "";

    public var rentLeft:String = "";

    private var _slotPriceActionData:ActionPriceVO = null;

    public function VehicleCarouselVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SLOT_PRICE_ACTION_DATA) {
            this._slotPriceActionData = new ActionPriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this._slotPriceActionData != null) {
            this._slotPriceActionData.dispose();
            this._slotPriceActionData = null;
        }
        super.onDispose();
    }

    public function getActionPriceVO():ActionPriceVO {
        return this._slotPriceActionData;
    }
}
}

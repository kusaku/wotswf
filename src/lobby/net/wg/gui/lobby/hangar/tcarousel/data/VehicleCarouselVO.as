package net.wg.gui.lobby.hangar.tcarousel.data {
import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class VehicleCarouselVO extends DAAPIUpdatableDataClass {

    private static const SLOT_PRICE_ACTION_DATA:String = "slotPriceActionData";

    private static const TANK_ICON_DATA:String = "tankIconData";

    public var id:int = -1;

    public var infoText:String = "";

    public var additionalText:String = "";

    public var icon:String = "";

    public var clanLock:Number = -1;

    public var slotPrice:Number = 0;

    public var showInfoText:Boolean = false;

    public var buyTank:Boolean = false;

    public var buySlot:Boolean = false;

    public var lockBackground:Boolean = false;

    public var hasSale:Boolean = false;

    private var _slotPriceActionData:ActionPriceVO = null;

    private var _tankIconVO:TankIconVO = null;

    public function VehicleCarouselVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SLOT_PRICE_ACTION_DATA) {
            this._slotPriceActionData = new ActionPriceVO(param2);
            return false;
        }
        if (param1 == TANK_ICON_DATA) {
            this._tankIconVO = new TankIconVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        if (this._slotPriceActionData != null) {
            this._slotPriceActionData.dispose();
            this._slotPriceActionData = null;
        }
        if (this._tankIconVO != null) {
            this._tankIconVO.dispose();
            this._tankIconVO = null;
        }
        super.onDispose();
    }

    public function getActionPriceVO():ActionPriceVO {
        return this._slotPriceActionData;
    }

    public function getTankIconVO():TankIconVO {
        return this._tankIconVO;
    }
}
}

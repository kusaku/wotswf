package net.wg.gui.lobby.vehicleBuyWindow {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.utils.VO.PriceVO;

public class BuyingVehicleVO extends DAAPIDataClass {

    private static const STUDY_PRICE_CREDITS_ACTION:String = "studyPriceCreditsActionData";

    private static const STUDY_PRICE_GOLD_ACTION:String = "studyPriceGoldActionData";

    private static const VEHICLE_PRICES_ACTION:String = "vehiclePricesActionData";

    private static const AMMO_ACTION_PRICE:String = "ammoActionPriceData";

    private static const SLOT_ACTION_PRICE:String = "slotActionPriceData";

    private static const SELECTED_ID:String = "selectedId";

    private static const RENT_DATA_ARRAY:String = "rentData array";

    private static const VEHICLE_PRICES_ARRAY:String = "vehiclePrices array";

    public var name:String = "";

    public var longName:String = "";

    public var shortName:String = "";

    public var type:String = "";

    public var icon:String = "";

    public var description:String = "";

    public var nation:int = -1;

    public var level:int = -1;

    public var isRentable:Boolean = false;

    public var expanded:Boolean = false;

    public var isStudyDisabled:Boolean = false;

    public var isNoAmmo:Boolean = false;

    public var isElite:Boolean = false;

    public var isPremium:Boolean = false;

    public var tankmenLabel:String = "";

    public var crewCheckbox:String = "";

    public var studyPriceCredits:Number = NaN;

    public var studyPriceGold:Number = NaN;

    public var ammoPrice:Number = NaN;

    public var slotPrice:int = -1;

    public var title:String = "";

    public var priceLabel:String = "";

    public var submitBtnLabel:String = "";

    public var cancelBtnLabel:String = "";

    public var vehiclePricesActionData:ActionPriceVO = null;

    public var warningMsg:String = "";

    private var _studyPriceGoldActionDataVo:ActionPriceVO = null;

    private var _ammoActionPriceDataVo:ActionPriceVO = null;

    private var _studyPriceCreditsActionDataVo:ActionPriceVO = null;

    private var _slotActionPriceDataVo:ActionPriceVO = null;

    private var _rentDataDD:Object = null;

    private var _rentDataProviderDD:Array = null;

    private var _defSelectedRentIndex:Number = NaN;

    private var _rentDataSelectedId:int = -1;

    private var _vehiclePrices:Array = null;

    private var _vehiclePrice:PriceVO = null;

    public function BuyingVehicleVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == STUDY_PRICE_CREDITS_ACTION && param2 != null) {
            this._studyPriceCreditsActionDataVo = new ActionPriceVO(param2);
            this._studyPriceCreditsActionDataVo.forCredits = true;
            return false;
        }
        if (param1 == STUDY_PRICE_GOLD_ACTION && param2 != null) {
            this._studyPriceGoldActionDataVo = new ActionPriceVO(param2);
            this._studyPriceGoldActionDataVo.forCredits = false;
            return false;
        }
        if (param1 == VEHICLE_PRICES_ACTION && param2 != null) {
            this.vehiclePricesActionData = new ActionPriceVO(param2);
            this.updateVehicleActionPrice();
            return false;
        }
        if (param1 == AMMO_ACTION_PRICE && param2 != null) {
            this._ammoActionPriceDataVo = new ActionPriceVO(param2);
            this._ammoActionPriceDataVo.forCredits = true;
            return false;
        }
        if (param1 == SLOT_ACTION_PRICE && param2 != null) {
            this._slotActionPriceDataVo = new ActionPriceVO(param2);
            this._slotActionPriceDataVo.forCredits = false;
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:Object = null;
        var _loc2_:VehicleBuyRentItemVO = null;
        if (this._ammoActionPriceDataVo != null) {
            this._ammoActionPriceDataVo.dispose();
            this._ammoActionPriceDataVo = null;
        }
        if (this._studyPriceCreditsActionDataVo != null) {
            this._studyPriceCreditsActionDataVo.dispose();
            this._studyPriceCreditsActionDataVo = null;
        }
        if (this._slotActionPriceDataVo != null) {
            this._slotActionPriceDataVo.dispose();
            this._slotActionPriceDataVo = null;
        }
        if (this.vehiclePricesActionData != null) {
            this.vehiclePricesActionData.dispose();
            this.vehiclePricesActionData = null;
        }
        if (this._studyPriceGoldActionDataVo != null) {
            this._studyPriceGoldActionDataVo.dispose();
            this._studyPriceGoldActionDataVo = null;
        }
        if (this._vehiclePrice != null) {
            this._vehiclePrice.dispose();
            this._vehiclePrice = null;
        }
        App.utils.data.cleanupDynamicObject(this._rentDataDD);
        this._rentDataDD = null;
        if (this._rentDataProviderDD != null) {
            for each(_loc1_ in this._rentDataProviderDD) {
                _loc2_ = VehicleBuyRentItemVO(_loc1_.data);
                _loc2_.dispose();
            }
            this._rentDataProviderDD.splice(0, this._rentDataProviderDD.length);
            this._rentDataProviderDD = null;
        }
        if (this._vehiclePrices != null) {
            this._vehiclePrices.splice(0, this._vehiclePrices.length);
            this._vehiclePrices = null;
        }
        super.onDispose();
    }

    private function updateVehicleActionPrice():void {
        if (this.vehiclePricesActionData != null) {
            this.vehiclePricesActionData.forCredits = !this.vehiclePrice.isGold;
        }
    }

    private function updateRentData(param1:Array):void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:VehicleBuyRentItemVO = null;
        if (param1 != null) {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = new VehicleBuyRentItemVO(param1[_loc3_]);
                if (_loc4_.itemId == this._rentDataSelectedId) {
                    this.defSelectedRentIndex = _loc3_;
                }
                this._rentDataProviderDD.push({
                    "label": _loc4_.label,
                    "data": _loc4_,
                    "enabled": _loc4_.enabled
                });
                _loc3_++;
            }
        }
    }

    public function get vehiclePrices():Array {
        return this._vehiclePrices;
    }

    public function set vehiclePrices(param1:Array):void {
        App.utils.asserter.assertNotNull(param1, VEHICLE_PRICES_ARRAY + Errors.CANT_NULL);
        this._vehiclePrices = param1;
        this.vehiclePrice = new PriceVO(this._vehiclePrices);
        this.isPremium = this.vehiclePrice.isGold;
    }

    public function get actualActionPriceDataVo():ActionPriceVO {
        return this.vehiclePricesActionData;
    }

    public function set actualActionPriceDataVo(param1:ActionPriceVO):void {
        this.vehiclePricesActionData = param1;
    }

    public function get studyPriceCreditsActionDataVo():ActionPriceVO {
        return this._studyPriceCreditsActionDataVo;
    }

    public function set studyPriceCreditsActionData(param1:Object):void {
        if (this._studyPriceCreditsActionDataVo != null) {
            this._studyPriceCreditsActionDataVo.dispose();
        }
        if (param1 != null) {
            this._studyPriceCreditsActionDataVo = new ActionPriceVO(param1);
        }
    }

    public function get studyPriceGoldActionDataVo():ActionPriceVO {
        return this._studyPriceGoldActionDataVo;
    }

    public function set studyPriceGoldActionData(param1:Object):void {
        if (this._studyPriceGoldActionDataVo != null) {
            this._studyPriceGoldActionDataVo.dispose();
        }
        if (param1 != null) {
            this._studyPriceGoldActionDataVo = new ActionPriceVO(param1);
        }
    }

    public function get ammoActionPriceDataVo():ActionPriceVO {
        return this._ammoActionPriceDataVo;
    }

    public function set ammoActionPriceData(param1:Object):void {
        if (this._ammoActionPriceDataVo != null) {
            this._ammoActionPriceDataVo.dispose();
        }
        if (param1 != null) {
            this._ammoActionPriceDataVo = new ActionPriceVO(param1);
        }
    }

    public function get slotActionPriceDataVo():ActionPriceVO {
        return this._slotActionPriceDataVo;
    }

    public function set slotActionPriceData(param1:Object):void {
        if (this._slotActionPriceDataVo != null) {
            this._slotActionPriceDataVo.dispose();
        }
        if (param1 != null) {
            this._slotActionPriceDataVo = new ActionPriceVO(param1);
        }
    }

    public function get rentDataDD():Object {
        return this._rentDataDD;
    }

    public function set rentDataDD(param1:Object):void {
        App.utils.data.cleanupDynamicObject(this._rentDataDD);
        this._rentDataDD = param1;
        if (this._rentDataDD.hasOwnProperty(SELECTED_ID) && this._rentDataDD.selectedId != undefined && this._rentDataDD.selectedId != null) {
            this._rentDataSelectedId = this._rentDataDD.selectedId;
        }
        else {
            this._rentDataSelectedId = VehicleBuyRentItemVO.DEF_ITEM_ID;
        }
        this._rentDataProviderDD = [];
        var _loc2_:Array = this._rentDataDD.data as Array;
        App.utils.asserter.assertNotNull(_loc2_, RENT_DATA_ARRAY + Errors.CANT_NULL);
        this.updateRentData(_loc2_);
    }

    public function get vehiclePrice():PriceVO {
        return this._vehiclePrice;
    }

    public function set vehiclePrice(param1:PriceVO):void {
        this._vehiclePrice = param1;
        this.updateVehicleActionPrice();
    }

    public function get defSelectedRentIndex():Number {
        return this._defSelectedRentIndex;
    }

    public function set defSelectedRentIndex(param1:Number):void {
        this._defSelectedRentIndex = param1;
    }

    public function get rentDataProviderDD():Array {
        return this._rentDataProviderDD;
    }
}
}

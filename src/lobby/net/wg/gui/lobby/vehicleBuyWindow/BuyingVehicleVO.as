package net.wg.gui.lobby.vehicleBuyWindow {
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

    public var studyPriceCredits:Number = NaN;

    public var studyPriceGold:Number = NaN;

    public var ammoPrice:Number = NaN;

    public var slotPrice:int = -1;

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

    private var _vehiclePricesActionDataVo:ActionPriceVO = null;

    public function BuyingVehicleVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == STUDY_PRICE_CREDITS_ACTION) {
            if (param2) {
                this._studyPriceCreditsActionDataVo = new ActionPriceVO(param2);
                this._studyPriceCreditsActionDataVo.forCredits = true;
            }
            return false;
        }
        if (param1 == STUDY_PRICE_GOLD_ACTION) {
            if (param2) {
                this._studyPriceGoldActionDataVo = new ActionPriceVO(param2);
                this._studyPriceGoldActionDataVo.forCredits = false;
            }
            return false;
        }
        if (param1 == VEHICLE_PRICES_ACTION) {
            if (param2) {
                this._vehiclePricesActionDataVo = new ActionPriceVO(param2);
                this.updateVehicleActionPrice();
            }
            return false;
        }
        if (param1 == AMMO_ACTION_PRICE) {
            if (param2) {
                this._ammoActionPriceDataVo = new ActionPriceVO(param2);
                this._ammoActionPriceDataVo.forCredits = true;
            }
            return false;
        }
        if (param1 == SLOT_ACTION_PRICE) {
            if (param2) {
                this._slotActionPriceDataVo = new ActionPriceVO(param2);
                this._slotActionPriceDataVo.forCredits = false;
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:Object = null;
        var _loc2_:VehicleBuyRentItemVO = null;
        if (this._ammoActionPriceDataVo) {
            this._ammoActionPriceDataVo.dispose();
            this._ammoActionPriceDataVo = null;
        }
        if (this._studyPriceCreditsActionDataVo) {
            this._studyPriceCreditsActionDataVo.dispose();
            this._studyPriceCreditsActionDataVo = null;
        }
        if (this._slotActionPriceDataVo) {
            this._slotActionPriceDataVo.dispose();
            this._slotActionPriceDataVo = null;
        }
        if (this._vehiclePricesActionDataVo) {
            this._vehiclePricesActionDataVo.dispose();
            this._vehiclePricesActionDataVo = null;
        }
        if (this._studyPriceGoldActionDataVo) {
            this._studyPriceGoldActionDataVo.dispose();
            this._studyPriceGoldActionDataVo = null;
        }
        if (this._vehiclePrice) {
            this._vehiclePrice.dispose();
            this._vehiclePrice = null;
        }
        this._rentDataDD = App.utils.data.cleanupDynamicObject(this._rentDataDD);
        if (this._rentDataProviderDD) {
            for each(_loc1_ in this._rentDataProviderDD) {
                _loc2_ = VehicleBuyRentItemVO(_loc1_.data);
                _loc2_.dispose();
            }
            this._rentDataProviderDD.splice(0, this._rentDataProviderDD.length);
            this._rentDataProviderDD = null;
        }
        if (this._vehiclePrices) {
            this._vehiclePrices.splice(0, this._vehiclePrices.length);
            this._vehiclePrices = null;
        }
        super.onDispose();
    }

    private function updateVehicleActionPrice():void {
        if (this._vehiclePricesActionDataVo) {
            this._vehiclePricesActionDataVo.forCredits = !this.vehiclePrice.isGold;
        }
    }

    private function updateRentData(param1:Array):void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:VehicleBuyRentItemVO = null;
        if (param1) {
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
        this._vehiclePrices = param1;
        this.vehiclePrice = new PriceVO(this._vehiclePrices);
        this.isPremium = this.vehiclePrice.isGold;
    }

    public function get actualActionPriceDataVo():ActionPriceVO {
        return this._vehiclePricesActionDataVo;
    }

    public function set actualActionPriceDataVo(param1:ActionPriceVO):void {
        this._vehiclePricesActionDataVo = param1;
    }

    public function get studyPriceCreditsActionDataVo():ActionPriceVO {
        return this._studyPriceCreditsActionDataVo;
    }

    public function set studyPriceCreditsActionData(param1:Object):void {
        if (this._studyPriceCreditsActionDataVo != null) {
            this._studyPriceCreditsActionDataVo.dispose();
        }
        this._studyPriceCreditsActionDataVo = new ActionPriceVO(param1);
    }

    public function get studyPriceGoldActionDataVo():ActionPriceVO {
        return this._studyPriceGoldActionDataVo;
    }

    public function set studyPriceGoldActionData(param1:Object):void {
        if (this._studyPriceGoldActionDataVo != null) {
            this._studyPriceGoldActionDataVo.dispose();
        }
        this._studyPriceGoldActionDataVo = new ActionPriceVO(param1);
    }

    public function get ammoActionPriceDataVo():ActionPriceVO {
        return this._ammoActionPriceDataVo;
    }

    public function set ammoActionPriceData(param1:Object):void {
        if (this._ammoActionPriceDataVo != null) {
            this._ammoActionPriceDataVo.dispose();
        }
        this._ammoActionPriceDataVo = new ActionPriceVO(param1);
    }

    public function get slotActionPriceDataVo():ActionPriceVO {
        return this._slotActionPriceDataVo;
    }

    public function set slotActionPriceData(param1:Object):void {
        if (this._slotActionPriceDataVo != null) {
            this._slotActionPriceDataVo.dispose();
        }
        this._slotActionPriceDataVo = new ActionPriceVO(param1);
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
        this.updateRentData(this._rentDataDD.data as Array);
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

    public function set rentDataProviderDD(param1:Array):void {
        this._rentDataProviderDD = param1;
    }
}
}

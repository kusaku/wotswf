package net.wg.gui.lobby.vehicleCustomization.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.SimpleRendererVO;

public class FiltersPopoverVO extends DAAPIDataClass {

    private static const CUSTOMIZATION_TYPE:String = "customizationType";

    private static const BONUS_TYPES:String = "bonusType";

    private static const PURCHASE_TYPE:String = "purchaseType";

    public var lblTitle:String = "";

    public var lblBonusType:String = "";

    public var lblCustomizationType:String = "";

    public var lblPurchaseType:String = "";

    public var btnDefault:String = "";

    public var bonusTypeDisableTooltip:String = "";

    public var bonusTypeId:int = -1;

    public var customizationTypeId:int = -1;

    public var purchaseTypeId:int = -1;

    public var customizationTypeSelectedIndex:int = -1;

    public var purchaseTypeSelectedIndex:int = -1;

    public var customizationTypeVisible:Boolean = false;

    public var customizationBonusTypeVisible:Boolean = false;

    public var enableGroupFilter:Boolean = true;

    public var refreshTooltip:String = "";

    private var _bonusTypes:Vector.<SimpleRendererVO> = null;

    private var _customizationType:Vector.<String> = null;

    private var _purchaseType:Vector.<CustomizationRadioRendererVO> = null;

    public function FiltersPopoverVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        var _loc4_:String = null;
        var _loc5_:Object = null;
        if (param1 == BONUS_TYPES) {
            this._bonusTypes = new Vector.<SimpleRendererVO>();
            for each(_loc3_ in param2) {
                this._bonusTypes.push(new SimpleRendererVO(_loc3_));
            }
            return false;
        }
        if (param1 == CUSTOMIZATION_TYPE) {
            this._customizationType = new Vector.<String>();
            for each(_loc4_ in param2) {
                this._customizationType.push(_loc4_);
            }
            return false;
        }
        if (param1 == PURCHASE_TYPE) {
            this._purchaseType = new Vector.<CustomizationRadioRendererVO>();
            _loc5_ = {};
            for each(_loc5_ in param2) {
                this._purchaseType.push(new CustomizationRadioRendererVO(_loc5_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:SimpleRendererVO = null;
        var _loc2_:CustomizationRadioRendererVO = null;
        for each(_loc1_ in this._bonusTypes) {
            _loc1_.dispose();
        }
        for each(_loc2_ in this._purchaseType) {
            _loc2_.dispose();
        }
        this._bonusTypes.splice(0, this._bonusTypes.length);
        this._bonusTypes = null;
        this._purchaseType.splice(0, this._purchaseType.length);
        this._purchaseType = null;
        this._customizationType.splice(0, this._customizationType.length);
        this._customizationType = null;
        super.onDispose();
    }

    public function get bonusTypes():Vector.<SimpleRendererVO> {
        return this._bonusTypes;
    }

    public function get customizationType():Vector.<String> {
        return this._customizationType;
    }

    public function get purchaseType():Vector.<CustomizationRadioRendererVO> {
        return this._purchaseType;
    }
}
}

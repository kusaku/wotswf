package net.wg.gui.lobby.store.views {
import flash.text.TextField;

import net.wg.data.VO.ShopSubFilterData;
import net.wg.data.constants.generated.STORE_CONSTANTS;
import net.wg.data.constants.generated.STORE_TYPES;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.RadioButton;
import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
import net.wg.gui.lobby.store.views.data.FiltersVO;
import net.wg.gui.lobby.store.views.data.VehiclesFiltersVO;
import net.wg.infrastructure.interfaces.IImageUrlProperties;

public class VehicleView extends BaseStoreMenuView {

    private static const EXTRA_FITS_NAME:String = "extra";

    private static const CHECKBOX_Y_STEP:Number = 20;

    private static const FILTERS_COUNT_INVALID:String = "filtersCountInvalid";

    public var allRadioBtn:RadioButton = null;

    public var lightTankRadioBtn:RadioButton = null;

    public var mediumTankRadioBtn:RadioButton = null;

    public var heavyTankRadioBtn:RadioButton = null;

    public var atSpgRadioBtn:RadioButton = null;

    public var spgRadioBtn:RadioButton = null;

    public var lockedChkBx:CheckBox = null;

    public var inHangarChkBx:CheckBox = null;

    public var brokenChckBx:CheckBox = null;

    public var rentalsChckBx:CheckBox = null;

    public var premiumIGRChckBx:CheckBox = null;

    public var vehTypeHeader:TextField = null;

    public var vehicleFilterExtraName:TextField = null;

    private var _isPremIGREnabled:Boolean = false;

    private var _isRentalsEnabled:Boolean = false;

    public function VehicleView() {
        super();
    }

    override public function getFiltersData():FiltersVO {
        var _loc1_:VehiclesFiltersVO = this.createFiltersDataVO();
        _loc1_.vehicleType = String(this.allRadioBtn.group.selectedButton != null ? this.allRadioBtn.group.data : this.allRadioBtn.data);
        _loc1_.extra = getSelectedFilters(getFitsArray());
        return _loc1_;
    }

    override public function resetTemporaryHandlers():void {
        resetHandlers(getFitsArray(), null);
        resetHandlers(getTagsArray(), this.allRadioBtn);
    }

    override public function setFiltersData(param1:FiltersVO, param2:Boolean):void {
        super.setFiltersData(param1, param2);
        var _loc3_:VehiclesFiltersVO = VehiclesFiltersVO(param1);
        selectFilterSimple(getTagsArray(), _loc3_.vehicleType, true);
        if (param1.extra != null) {
            selectFilter(getFitsArray(), param1.extra, true, false);
        }
        else {
            this.setSelectedFilters(getFitsArray(), false);
        }
        this.setExtraVisible(param2);
    }

    override public function setSubFilterData(param1:int, param2:ShopSubFilterData):void {
    }

    override public function setUIName(param1:String, param2:Function):void {
        super.setUIName(param1, param2);
        this.isPremIGREnabled = App.globalVarsMgr.isKoreaS() && getUIName() == STORE_TYPES.INVENTORY;
        invalidate(FILTERS_COUNT_INVALID);
    }

    override public function updateSubFilter(param1:int):void {
    }

    override protected function configUI():void {
        super.configUI();
        this.inHangarChkBx.enableDynamicFrameUpdating();
        this.brokenChckBx.enableDynamicFrameUpdating();
        this._isRentalsEnabled = App.globalVarsMgr.isRentalsEnabledS();
        this.rentalsChckBx.visible = this._isRentalsEnabled;
        if (this._isRentalsEnabled) {
            this.rentalsChckBx.enableDynamicFrameUpdating();
        }
        this.isPremIGREnabled = App.globalVarsMgr.isKoreaS() && getUIName() == STORE_TYPES.INVENTORY;
        this.vehicleFilterExtraName.text = MENU.SHOP_MENU_VEHICLE_EXTRA_NAME;
        this.vehTypeHeader.text = MENU.SHOP_MENU_VEHICLE_TAGS_NAME;
    }

    override protected function onDispose():void {
        this.allRadioBtn.dispose();
        this.allRadioBtn = null;
        this.lightTankRadioBtn.dispose();
        this.lightTankRadioBtn = null;
        this.mediumTankRadioBtn.dispose();
        this.mediumTankRadioBtn = null;
        this.heavyTankRadioBtn.dispose();
        this.heavyTankRadioBtn = null;
        this.atSpgRadioBtn.dispose();
        this.atSpgRadioBtn = null;
        this.spgRadioBtn.dispose();
        this.spgRadioBtn = null;
        this.lockedChkBx.dispose();
        this.lockedChkBx = null;
        this.inHangarChkBx.dispose();
        this.inHangarChkBx = null;
        this.brokenChckBx.dispose();
        this.brokenChckBx = null;
        this.rentalsChckBx.dispose();
        this.rentalsChckBx = null;
        this.premiumIGRChckBx.dispose();
        this.premiumIGRChckBx = null;
        this.vehicleFilterExtraName = null;
        this.vehTypeHeader = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Vector.<ViewUIElementVO> = null;
        var _loc2_:Number = NaN;
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        var _loc5_:ViewUIElementVO = null;
        super.draw();
        if (isInvalid(FILTERS_COUNT_INVALID)) {
            _loc1_ = getFitsArray();
            _loc2_ = this.vehicleFilterExtraName.y;
            _loc3_ = _loc1_.length;
            _loc4_ = 1;
            while (_loc4_ <= _loc3_) {
                _loc5_ = _loc1_[_loc4_ - 1];
                _loc5_.instance.y = _loc2_ + CHECKBOX_Y_STEP * _loc4_;
                _loc4_++;
            }
        }
    }

    override protected function onTagsArrayRequest():Vector.<ViewUIElementVO> {
        return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.LIGHT_TANK_FILTER_NAME, this.lightTankRadioBtn), new ViewUIElementVO(STORE_CONSTANTS.MEDIUM_TANK_FILTER_NAME, this.mediumTankRadioBtn), new ViewUIElementVO(STORE_CONSTANTS.HEAVY_TANK_FILTER_NAME, this.heavyTankRadioBtn), new ViewUIElementVO(STORE_CONSTANTS.AT_SPG_FILTER_NAME, this.atSpgRadioBtn), new ViewUIElementVO(STORE_CONSTANTS.SPG_FILTER_NAME, this.spgRadioBtn), new ViewUIElementVO(STORE_CONSTANTS.ALL_FILTER_NAME, this.allRadioBtn)];
    }

    override protected function onFitsArrayRequest():Vector.<ViewUIElementVO> {
        var _loc1_:Vector.<ViewUIElementVO> = null;
        if (getUIName() == STORE_TYPES.SHOP) {
            _loc1_ = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.LOCKED_EXTRA_NAME, this.lockedChkBx), new ViewUIElementVO(STORE_CONSTANTS.IN_HANGAR_EXTRA_NAME, this.inHangarChkBx)];
            if (App.globalVarsMgr.isRentalsEnabledS()) {
                _loc1_.push(new ViewUIElementVO(STORE_CONSTANTS.RENTALS_EXTRA_NAME, this.rentalsChckBx));
            }
        }
        else {
            _loc1_ = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.LOCKED_EXTRA_NAME, this.lockedChkBx), new ViewUIElementVO(STORE_CONSTANTS.BROCKEN_EXTRA_NAME, this.brokenChckBx)];
            if (App.globalVarsMgr.isRentalsEnabledS()) {
                _loc1_.push(new ViewUIElementVO(STORE_CONSTANTS.RENTALS_EXTRA_NAME, this.rentalsChckBx));
            }
            if (this.isPremIGREnabled) {
                _loc1_.push(new ViewUIElementVO(STORE_CONSTANTS.PREMIUM_IGR_EXTRA_NAME, this.premiumIGRChckBx, App.utils.getHtmlIconTextS(IImageUrlProperties(App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_PREMIUM_SMALL, 34, 16, -4)))));
            }
        }
        return _loc1_;
    }

    override protected function getFitsName():String {
        return EXTRA_FITS_NAME;
    }

    protected final function setSelectedFilters(param1:Vector.<ViewUIElementVO>, param2:Boolean):void {
        var _loc3_:ViewUIElementVO = null;
        for each(_loc3_ in param1) {
            _loc3_.instance.selected = param2;
        }
    }

    protected function createFiltersDataVO():VehiclesFiltersVO {
        return new VehiclesFiltersVO(filtersDataHash);
    }

    private function setExtraVisible(param1:Boolean):void {
        this.vehicleFilterExtraName.visible = param1;
        this.lockedChkBx.visible = param1;
        this.inHangarChkBx.visible = param1;
        this.rentalsChckBx.visible = this._isRentalsEnabled && param1;
        this.premiumIGRChckBx.visible = this._isPremIGREnabled && param1;
    }

    public function get isPremIGREnabled():Boolean {
        return this._isPremIGREnabled;
    }

    public function set isPremIGREnabled(param1:Boolean):void {
        this._isPremIGREnabled = param1;
        if (this._isPremIGREnabled) {
            this.premiumIGRChckBx.enableDynamicFrameUpdating();
        }
        this.premiumIGRChckBx.visible = this._isPremIGREnabled;
    }
}
}

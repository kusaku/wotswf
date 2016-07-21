package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.DisplayObject;
import flash.text.TextField;

import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.SimpleTileList;
import net.wg.gui.components.controls.events.RendererEvent;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.hangar.tcarousel.data.FilterCarouseInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.FiltersStateVO;
import net.wg.infrastructure.base.meta.ITankCarouselFilterPopoverMeta;
import net.wg.infrastructure.base.meta.impl.TankCarouselFilterPopoverMeta;
import net.wg.utils.IClassFactory;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.events.ButtonEvent;

public class FilterPopoverView extends TankCarouselFilterPopoverMeta implements ITankCarouselFilterPopoverMeta {

    private static const RENT_PADDING:Number = 50;

    private static const PADDING:Number = 35;

    private static const INVALIDATE_STATE_DATA:String = "invStateData";

    private static const TOGGLE_TILE_WIDTH:uint = 45;

    private static const TOGGLE_TILE_HEIGHT:uint = 34;

    private static const CHECKBOX_TILE_WIDTH:uint = 110;

    private static const CHECKBOX_TILE_HEIGHT:uint = 25;

    private static const LINKAGE_TOGGLE_RENDERER_IMG_ALPHA:String = "ToggleRendererImageAlphaUI";

    private static const LINKAGE_TOGGLE_RENDERER:String = "ToggleRendererUI";

    private static const LINKAGE_CHECKBOX_RENDERER:String = "CheckBoxRendererUI";

    public var lblTitle:TextField = null;

    public var lblNationType:TextField = null;

    public var lblVehicleType:TextField = null;

    public var lblVehicleLevel:TextField = null;

    public var lblVehicleEliteType:TextField = null;

    public var listNationType:SimpleTileList = null;

    public var listVehicleType:SimpleTileList = null;

    public var listSpecialTypeLeft:SimpleTileList = null;

    public var listSpecialTypeRight:SimpleTileList = null;

    public var listVehicleLevels:SimpleTileList = null;

    public var rentCheckbox:CheckBox = null;

    public var btnDefault:ISoundButtonEx = null;

    public var separator:DisplayObject = null;

    public var dotSeparator:DisplayObject = null;

    private var _initData:FilterCarouseInitVO = null;

    private var _stateData:FiltersStateVO = null;

    public function FilterPopoverView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:IClassFactory = App.utils.classFactory;
        this.listNationType.itemRenderer = _loc1_.getClass(LINKAGE_TOGGLE_RENDERER_IMG_ALPHA);
        this.listVehicleType.itemRenderer = this.listVehicleLevels.itemRenderer = _loc1_.getClass(LINKAGE_TOGGLE_RENDERER);
        this.listSpecialTypeLeft.itemRenderer = this.listSpecialTypeRight.itemRenderer = _loc1_.getClass(LINKAGE_CHECKBOX_RENDERER);
        this.listNationType.tileWidth = this.listVehicleType.tileWidth = this.listVehicleLevels.tileWidth = TOGGLE_TILE_WIDTH;
        this.listNationType.tileHeight = this.listVehicleType.tileHeight = this.listVehicleLevels.tileHeight = TOGGLE_TILE_HEIGHT;
        this.listSpecialTypeLeft.tileWidth = this.listSpecialTypeRight.tileWidth = CHECKBOX_TILE_WIDTH;
        this.listSpecialTypeLeft.tileHeight = this.listSpecialTypeRight.tileHeight = CHECKBOX_TILE_HEIGHT;
        this.listSpecialTypeLeft.directionMode = this.listSpecialTypeRight.directionMode = this.listNationType.directionMode = this.listVehicleType.directionMode = this.listVehicleLevels.directionMode = DirectionMode.HORIZONTAL;
        this.btnDefault.addEventListener(ButtonEvent.CLICK, this.onBtnDefaultClickHandler);
        this.listNationType.addEventListener(RendererEvent.ITEM_CLICK, this.onNationTypeItemClickHandler);
        this.listVehicleType.addEventListener(RendererEvent.ITEM_CLICK, this.onVehicleTypeItemClickHandler);
        this.listSpecialTypeLeft.addEventListener(RendererEvent.ITEM_CLICK, this.onSpecialTypeLeftItemClickHandler);
        this.listSpecialTypeRight.addEventListener(RendererEvent.ITEM_CLICK, this.onSpecialTypeRightItemClickHandler);
        this.listVehicleLevels.addEventListener(RendererEvent.ITEM_CLICK, this.onLevelsTypeItemClickHandler);
        this.rentCheckbox.addEventListener(ButtonEvent.CLICK, this.onRentCheckBoxClickHandler);
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
        PopOver(wrapper).isCloseBtnVisible = true;
        super.initLayout();
    }

    override protected function onDispose():void {
        this.btnDefault.removeEventListener(ButtonEvent.CLICK, this.onBtnDefaultClickHandler);
        this.listNationType.removeEventListener(RendererEvent.ITEM_CLICK, this.onNationTypeItemClickHandler);
        this.listVehicleType.removeEventListener(RendererEvent.ITEM_CLICK, this.onVehicleTypeItemClickHandler);
        this.listSpecialTypeLeft.removeEventListener(RendererEvent.ITEM_CLICK, this.onSpecialTypeLeftItemClickHandler);
        this.listSpecialTypeRight.removeEventListener(RendererEvent.ITEM_CLICK, this.onSpecialTypeRightItemClickHandler);
        this.listVehicleLevels.removeEventListener(RendererEvent.ITEM_CLICK, this.onLevelsTypeItemClickHandler);
        this.rentCheckbox.removeEventListener(ButtonEvent.CLICK, this.onRentCheckBoxClickHandler);
        this.lblTitle = null;
        this.lblNationType = null;
        this.lblVehicleType = null;
        this.lblVehicleLevel = null;
        this.lblVehicleEliteType = null;
        this.listNationType.dispose();
        this.listNationType = null;
        this.listVehicleType.dispose();
        this.listVehicleType = null;
        this.listSpecialTypeLeft.dispose();
        this.listSpecialTypeLeft = null;
        this.listSpecialTypeRight.dispose();
        this.listSpecialTypeRight = null;
        this.listVehicleLevels.dispose();
        this.listVehicleLevels = null;
        this.btnDefault.dispose();
        this.btnDefault = null;
        this._initData = null;
        this._stateData = null;
        this.rentCheckbox.dispose();
        this.rentCheckbox = null;
        this.separator = null;
        this.dotSeparator = null;
        super.onDispose();
    }

    override protected function setInitData(param1:FilterCarouseInitVO):void {
        App.utils.asserter.assertNull(this._initData, "Reinitialization TanksFilterPopover");
        this._initData = param1;
        this.lblTitle.htmlText = this._initData.titleLabel;
        this.lblNationType.htmlText = this._initData.nationLabel;
        this.lblVehicleType.htmlText = this._initData.vehicleTypeLabel;
        this.lblVehicleLevel.htmlText = this._initData.vehicleLevelLabel;
        this.lblVehicleEliteType.htmlText = this._initData.vehicleEliteTypeLabel;
        this.listNationType.dataProvider = this._initData.nationTypes;
        this.listVehicleType.dataProvider = this._initData.vehicleTypes;
        this.listSpecialTypeLeft.dataProvider = this._initData.specialTypesLeft;
        this.listSpecialTypeRight.dataProvider = this._initData.specialTypesRight;
        this.listVehicleLevels.dataProvider = this._initData.levelsTypes;
        this.btnDefault.label = this._initData.btnDefaultLabel;
        this.btnDefault.tooltip = this._initData.btnDefaultTooltip;
        if (param1.rentCheckBoxVO != null) {
            this.rentCheckbox.label = param1.rentCheckBoxVO.label;
            this.rentCheckbox.toolTip = param1.rentCheckBoxVO.tooltip;
            this.rentCheckbox.enabled = param1.rentCheckBoxVO.enabled;
            this.rentCheckbox.selected = param1.rentCheckBoxVO.selected;
        }
        this.rentCheckbox.visible = param1.hasRentedVehicles;
        this.dotSeparator.visible = param1.hasRentedVehicles;
        this.updateSize();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_STATE_DATA) && this._stateData != null) {
            this.listSetState(this.listNationType, this._stateData.nationTypeSelected);
            this.listSetState(this.listVehicleType, this._stateData.vehicleTypeSelected);
            this.listSetState(this.listSpecialTypeLeft, this._stateData.specialTypeLeftSelected);
            this.listSetState(this.listSpecialTypeRight, this._stateData.specialTypeRightSelected);
            this.listSetState(this.listVehicleLevels, this._stateData.levelsTypeSelected);
            this.rentCheckbox.selected = this._stateData.rentSelected;
            this.rentCheckbox.enabled = this._stateData.rentEnabled;
        }
    }

    override protected function setState(param1:FiltersStateVO):void {
        this._stateData = param1;
        invalidate(INVALIDATE_STATE_DATA);
    }

    public function as_enableDefBtn(param1:Boolean):void {
        this.btnDefault.enabled = param1;
    }

    private function listSetState(param1:SimpleTileList, param2:Vector.<Boolean>):void {
        var _loc3_:int = param2.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            param1.getRendererAt(_loc4_).selectable = param2[_loc4_];
            _loc4_++;
        }
    }

    private function updateSize():void {
        var _loc1_:int = 0;
        var _loc2_:Number = this._initData.specialTypesLeft.length * CHECKBOX_TILE_HEIGHT;
        var _loc3_:Number = this._initData.specialTypesRight.length * CHECKBOX_TILE_HEIGHT;
        _loc1_ = _loc1_ - (Math.max(_loc2_, _loc3_) - this.listSpecialTypeLeft.height);
        this.dotSeparator.y = this.dotSeparator.y - _loc1_;
        this.rentCheckbox.y = this.rentCheckbox.y - _loc1_;
        if (!this._initData.hasRentedVehicles) {
            _loc1_ = _loc1_ + RENT_PADDING;
        }
        this.separator.y = this.separator.y - _loc1_;
        this.btnDefault.y = this.btnDefault.y - _loc1_;
        setViewSize(this.width, height - _loc1_ + PADDING);
    }

    private function onNationTypeItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.nationTypeId, param1.index);
        param1.stopPropagation();
    }

    private function onRentCheckBoxClickHandler(param1:ButtonEvent):void {
        changeFilterS(this._initData.rentVehicleId, -1);
    }

    private function onLevelsTypeItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.levelTypesId, param1.index);
        param1.stopPropagation();
    }

    private function onSpecialTypeLeftItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.specialTypesLeftId, param1.index);
        param1.stopPropagation();
    }

    private function onSpecialTypeRightItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.specialTypesRightId, param1.index);
        param1.stopPropagation();
    }

    private function onVehicleTypeItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.vehicleTypeId, param1.index);
        param1.stopPropagation();
    }

    private function onBtnDefaultClickHandler(param1:ButtonEvent):void {
        setDefaultFilterS();
    }
}
}

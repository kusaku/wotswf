package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.text.TextField;

import net.wg.gui.components.controls.SimpleTileList;
import net.wg.gui.components.controls.events.RendererEvent;
import net.wg.gui.components.popovers.PopOver;
import net.wg.gui.components.popovers.PopOverConst;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.hangar.tcarousel.data.FilterCarouseInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.FiltersStateVO;
import net.wg.infrastructure.base.meta.ITankCarouselFilterPopoverMeta;
import net.wg.infrastructure.base.meta.impl.TankCarouselFilterPopoverMeta;
import net.wg.utils.IClassFactory;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.events.ButtonEvent;

public class FilterPopoverView extends TankCarouselFilterPopoverMeta implements ITankCarouselFilterPopoverMeta {

    private static const PADDING:Number = 23;

    private static const INVALIDATE_STATE_DATA:String = "invStateData";

    private static const TOGGLE_TILE_WIDTH:uint = 45;

    private static const TOGGLE_TILE_HEIGHT:uint = 34;

    private static const CHECKBOX_TILE_WIDTH:uint = 110;

    private static const CHECKBOX_TILE_HEIGHT:uint = 25;

    private static const LIST_OFFSET:uint = 12;

    private static const LABEL_OFFSET:uint = 5;

    private static const SEPARATOR_OFFSET:int = -24;

    private static const DEFAULT_BTN_OFFSET:uint = 20;

    private static const LINKAGE_TOGGLE_RENDERER_IMG_ALPHA:String = "ToggleRendererImageAlphaUI";

    private static const LINKAGE_TOGGLE_RENDERER:String = "ToggleRendererUI";

    private static const LINKAGE_CHECKBOX_RENDERER:String = "CheckBoxRendererUI";

    public var lblTitle:TextField = null;

    public var lblNationType:TextField = null;

    public var lblVehicleType:TextField = null;

    public var lblVehicleLevel:TextField = null;

    public var lblHidden:TextField = null;

    public var lblSpecials:TextField = null;

    public var listNationType:SimpleTileList = null;

    public var listVehicleType:SimpleTileList = null;

    public var listVehicleLevels:SimpleTileList = null;

    public var listSpecials:SimpleTileList = null;

    public var listHidden:SimpleTileList = null;

    public var btnDefault:ISoundButtonEx = null;

    public var separator:DisplayObject = null;

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
        this.listSpecials.itemRenderer = this.listHidden.itemRenderer = _loc1_.getClass(LINKAGE_CHECKBOX_RENDERER);
        this.listNationType.tileWidth = this.listVehicleType.tileWidth = this.listVehicleLevels.tileWidth = TOGGLE_TILE_WIDTH;
        this.listNationType.tileHeight = this.listVehicleType.tileHeight = this.listVehicleLevels.tileHeight = TOGGLE_TILE_HEIGHT;
        this.listSpecials.tileWidth = this.listHidden.tileWidth = CHECKBOX_TILE_WIDTH;
        this.listSpecials.tileHeight = this.listHidden.tileHeight = CHECKBOX_TILE_HEIGHT;
        this.listSpecials.directionMode = this.listHidden.directionMode = this.listNationType.directionMode = this.listVehicleType.directionMode = this.listVehicleLevels.directionMode = DirectionMode.HORIZONTAL;
        this.btnDefault.addEventListener(ButtonEvent.CLICK, this.onBtnDefaultClickHandler);
        this.listNationType.addEventListener(RendererEvent.ITEM_CLICK, this.onNationTypeItemClickHandler);
        this.listVehicleType.addEventListener(RendererEvent.ITEM_CLICK, this.onVehicleTypeItemClickHandler);
        this.listSpecials.addEventListener(RendererEvent.ITEM_CLICK, this.onSpecialItemClickHandler);
        this.listHidden.addEventListener(RendererEvent.ITEM_CLICK, this.onHiddenItemClickHandler);
        this.listSpecials.addEventListener(Event.RESIZE, this.onListsResizeHandler);
        this.listHidden.addEventListener(Event.RESIZE, this.onListsResizeHandler);
        this.listVehicleLevels.addEventListener(RendererEvent.ITEM_CLICK, this.onLevelsTypeItemClickHandler);
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
        this.listSpecials.removeEventListener(RendererEvent.ITEM_CLICK, this.onSpecialItemClickHandler);
        this.listHidden.removeEventListener(RendererEvent.ITEM_CLICK, this.onHiddenItemClickHandler);
        this.listSpecials.removeEventListener(Event.RESIZE, this.onListsResizeHandler);
        this.listHidden.removeEventListener(Event.RESIZE, this.onListsResizeHandler);
        this.listVehicleLevels.removeEventListener(RendererEvent.ITEM_CLICK, this.onLevelsTypeItemClickHandler);
        this.lblTitle = null;
        this.lblNationType = null;
        this.lblVehicleType = null;
        this.lblVehicleLevel = null;
        this.lblSpecials = null;
        this.lblHidden = null;
        this.listNationType.dispose();
        this.listNationType = null;
        this.listVehicleType.dispose();
        this.listVehicleType = null;
        this.listSpecials.dispose();
        this.listSpecials = null;
        this.listHidden.dispose();
        this.listHidden = null;
        this.listVehicleLevels.dispose();
        this.listVehicleLevels = null;
        this.btnDefault.dispose();
        this.btnDefault = null;
        this._initData = null;
        this._stateData = null;
        this.separator = null;
        super.onDispose();
    }

    override protected function setInitData(param1:FilterCarouseInitVO):void {
        App.utils.asserter.assertNull(this._initData, "Reinitialization TanksFilterPopover");
        this._initData = param1;
        this.lblTitle.htmlText = this._initData.titleLabel;
        this.lblNationType.htmlText = this._initData.nationsLabel;
        this.lblVehicleType.htmlText = this._initData.vehicleTypesLabel;
        this.lblVehicleLevel.htmlText = this._initData.levelsLabel;
        this.lblSpecials.htmlText = this._initData.specialsLabel;
        this.lblHidden.htmlText = this._initData.hiddenLabel;
        this.listNationType.dataProvider = this._initData.nations;
        this.listVehicleType.dataProvider = this._initData.vehicleTypes;
        this.listSpecials.dataProvider = this._initData.specials;
        this.listVehicleLevels.dataProvider = this._initData.levels;
        this.listHidden.dataProvider = this._initData.hidden;
        this.btnDefault.label = this._initData.defaultButtonLabel;
        this.btnDefault.tooltip = this._initData.defaultButtonTooltip;
        this.lblHidden.visible = this._initData.hiddenSectionVisible;
        this.listHidden.visible = this._initData.hiddenSectionVisible;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_STATE_DATA) && this._stateData != null) {
            this.listSetState(this.listNationType, this._stateData.nationsSelected);
            this.listSetState(this.listVehicleType, this._stateData.vehicleTypesSelected);
            this.listSetState(this.listSpecials, this._stateData.specialsSelected);
            this.listSetState(this.listHidden, this._stateData.hiddenSelected);
            this.listSetState(this.listVehicleLevels, this._stateData.levelsSelected);
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
        var _loc1_:int = this.listSpecials.y + this.listSpecials.height + LIST_OFFSET;
        if (this._initData.hiddenSectionVisible) {
            this.lblHidden.y = _loc1_;
            this.listHidden.y = this.lblHidden.y + this.lblHidden.height + LABEL_OFFSET ^ 0;
            _loc1_ = this.listHidden.y + this.listHidden.height + LIST_OFFSET;
        }
        this.separator.y = _loc1_ + SEPARATOR_OFFSET;
        this.btnDefault.y = this.separator.y + this.separator.height + DEFAULT_BTN_OFFSET;
        var _loc2_:int = this.btnDefault.y + this.btnDefault.height + PADDING;
        setViewSize(width, _loc2_);
    }

    private function onListsResizeHandler(param1:Event):void {
        this.updateSize();
        param1.stopPropagation();
    }

    private function onNationTypeItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.nationsSectionId, param1.index);
        param1.stopPropagation();
    }

    private function onLevelsTypeItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.levelsSectionId, param1.index);
        param1.stopPropagation();
    }

    private function onSpecialItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.specialSectionId, param1.index);
        param1.stopPropagation();
    }

    private function onHiddenItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.hiddenSectionId, param1.index);
        param1.stopPropagation();
    }

    private function onVehicleTypeItemClickHandler(param1:RendererEvent):void {
        changeFilterS(this._initData.vehicleTypesSectionId, param1.index);
        param1.stopPropagation();
    }

    private function onBtnDefaultClickHandler(param1:ButtonEvent):void {
        setDefaultFilterS();
    }
}
}

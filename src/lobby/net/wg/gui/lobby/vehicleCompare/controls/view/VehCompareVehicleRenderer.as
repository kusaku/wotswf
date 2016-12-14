package net.wg.gui.lobby.vehicleCompare.controls.view {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareCrewLevelVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehicleRendererEvent;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.ICommons;

import scaleform.clik.controls.ListItemRenderer;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class VehCompareVehicleRenderer extends ListItemRenderer implements IScrollerItemRenderer, IPopOverCaller {

    private static const INVALIATE_RENDERER_DATA:String = "invaliate_renderer_data";

    private static const TANK_NAME_Y_OFFSET:int = -6;

    private static const LEVEL_MC_X:int = 21;

    private static const ADD_BTN_ALPHA:Number = 0.25;

    public var closeBtn:ISoundButtonEx = null;

    public var crewDropdown:DropdownMenu = null;

    public var moduleBtn:ISoundButtonEx = null;

    public var addVehicleBtn:Sprite = null;

    public var btnHover:Sprite = null;

    public var vehicleIcon:TankIcon = null;

    public var separator:Sprite = null;

    public var noVehicleTf:TextField = null;

    public var addVehicleTF:TextField = null;

    public var premiumTF:TextField = null;

    public var attentionIcon:Sprite;

    private var _commons:ICommons = null;

    private var _rendererData:VehCompareVehicleVO;

    private var _crewDP:DataProvider;

    private var _tooltipMgr:ITooltipMgr;

    public function VehCompareVehicleRenderer() {
        super();
        this._crewDP = new DataProvider();
        this._tooltipMgr = App.toolTipMgr;
        this._commons = App.utils.commons;
        cacheAsBitmap = true;
    }

    override protected function configUI():void {
        super.configUI();
        mouseChildren = true;
        mouseEnabled = true;
        buttonMode = false;
        this.noVehicleTf.mouseWheelEnabled = false;
        this.noVehicleTf.mouseEnabled = false;
        this.noVehicleTf.text = VEH_COMPARE.VEHICLECOMPAREVIEW_TOPPANEL_NOVEHICLE;
        this.premiumTF.text = VEH_COMPARE.VEHICLECOMPAREVIEW_TOPPANEL_PREMIUM;
        this.closeBtn.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_REMOVEFROMCOMPARE;
        this.addVehicleTF.text = VEH_COMPARE.VEHICLECOMPAREVIEW_BTNADDVEHICLES;
        this.addVehicleTF.visible = false;
        this.crewDropdown.dataProvider = this._crewDP;
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.moduleBtn.addEventListener(ButtonEvent.CLICK, this.onModuleBtnClickHandler);
        this.vehicleIcon.addEventListener(MouseEvent.CLICK, this.onVehicleIconClickHandler);
        this.vehicleIcon.addEventListener(MouseEvent.MOUSE_OVER, this.onVehicleIconMouseOverHandler);
        this.vehicleIcon.addEventListener(MouseEvent.MOUSE_OUT, this.onVehicleIconMouseOutHandler);
        this.addVehicleBtn.addEventListener(MouseEvent.CLICK, this.onAddVehicleBtnClickHandler);
        this.addVehicleBtn.addEventListener(MouseEvent.MOUSE_OVER, this.onAddVehicleBtnMouseOverHandler);
        this.addVehicleBtn.addEventListener(MouseEvent.MOUSE_OUT, this.onAddVehicleBtnMouseOutHandler);
        this.addVehicleBtn.buttonMode = true;
        this.addVehicleBtn.alpha = ADD_BTN_ALPHA;
        this.moduleBtn.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_BTNMODULES;
        this.crewDropdown.addEventListener(MouseEvent.MOUSE_OVER, this.onCrewDropdownMouseOverHandler);
        this.crewDropdown.addEventListener(MouseEvent.MOUSE_OUT, this.onCrewDropdownMouseOutHandler);
        this.vehicleIcon.tankNameField.y = this.vehicleIcon.tankNameField.y + TANK_NAME_Y_OFFSET;
        this.vehicleIcon.mouseChildren = false;
        this.vehicleIcon.buttonMode = true;
        this.vehicleIcon.hitArea = this.btnHover;
        this.btnHover.mouseEnabled = this.btnHover.mouseChildren = false;
        this.addVehicleBtn.visible = false;
        this.attentionIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAttentionIconRollOverHandler);
        this.attentionIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAttentionIconRollOutHandler);
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(INVALIATE_RENDERER_DATA)) {
            _loc1_ = this._rendererData != null;
            if (_loc1_) {
                _loc1_ = !this._rendererData.isFirstEmptySlot;
            }
            this.btnHover.visible = false;
            this.vehicleIcon.visible = _loc1_;
            this.moduleBtn.visible = _loc1_;
            this.crewDropdown.visible = _loc1_;
            this.closeBtn.visible = _loc1_;
            this.premiumTF.visible = _loc1_;
            this.noVehicleTf.visible = !_loc1_ && !(this._rendererData && this._rendererData.isFirstEmptySlot);
            this.addVehicleBtn.visible = this._rendererData && this._rendererData.isFirstEmptySlot;
            this.attentionIcon.visible = false;
            mouseEnabled = mouseChildren = !this.noVehicleTf.visible;
            this.vehicleIcon.hitArea = !!_loc1_ ? this.btnHover : null;
            if (_loc1_) {
                this.vehicleIcon.nation = this._rendererData.nation;
                this.vehicleIcon.image = this._rendererData.image;
                this.vehicleIcon.showName = true;
                this.vehicleIcon.tankName = this._rendererData.label;
                this.vehicleIcon.level = this._rendererData.level;
                this.vehicleIcon.isElite = this._rendererData.elite;
                this.vehicleIcon.isPremium = this._rendererData.premium;
                this.vehicleIcon.tankType = this._rendererData.tankType;
                this.vehicleIcon.validateNow();
                this.vehicleIcon.levelMc.x = LEVEL_MC_X;
                this.moduleBtn.label = this._rendererData.moduleType;
                this.premiumTF.visible = this._rendererData.premium;
                this.moduleBtn.visible = !this._rendererData.premium;
                if (this._rendererData.crewLevels != null) {
                    this._crewDP.cleanUp();
                    this._crewDP.setSource(App.utils.data.vectorToArray(this._rendererData.crewLevels));
                    this.crewDropdown.menuRowCount = this._crewDP.length;
                }
                if (this.crewDropdown.selectedIndex != this._rendererData.crewLevelIndx) {
                    this.crewDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onCrewDropdownIndexChangeHandler);
                    this.crewDropdown.selectedIndex = this._rendererData.crewLevelIndx;
                    this.crewDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onCrewDropdownIndexChangeHandler);
                }
                this.attentionIcon.visible = this._rendererData.isAttention;
            }
        }
    }

    override protected function onDispose():void {
        this.vehicleIcon.removeEventListener(MouseEvent.CLICK, this.onVehicleIconClickHandler);
        this.vehicleIcon.removeEventListener(MouseEvent.MOUSE_OVER, this.onVehicleIconMouseOverHandler);
        this.vehicleIcon.removeEventListener(MouseEvent.MOUSE_OUT, this.onVehicleIconMouseOutHandler);
        this.vehicleIcon.dispose();
        this.vehicleIcon = null;
        this.moduleBtn.removeEventListener(ButtonEvent.CLICK, this.onModuleBtnClickHandler);
        this.moduleBtn.dispose();
        this.moduleBtn = null;
        this.crewDropdown.removeEventListener(MouseEvent.MOUSE_OVER, this.onCrewDropdownMouseOverHandler);
        this.crewDropdown.removeEventListener(MouseEvent.MOUSE_OUT, this.onCrewDropdownMouseOutHandler);
        this.crewDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onCrewDropdownIndexChangeHandler);
        this.crewDropdown.dispose();
        this.crewDropdown = null;
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.addVehicleBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.onAddVehicleBtnMouseOverHandler);
        this.addVehicleBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.onAddVehicleBtnMouseOutHandler);
        this.addVehicleBtn.removeEventListener(MouseEvent.CLICK, this.onAddVehicleBtnClickHandler);
        this.addVehicleBtn = null;
        if (this._rendererData) {
            this._rendererData.removeEventListener(Event.CHANGE, this.onDataChangeHandler);
            this._rendererData = null;
        }
        this.attentionIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAttentionIconRollOverHandler);
        this.attentionIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAttentionIconRollOutHandler);
        this.attentionIcon = null;
        this._crewDP.cleanUp();
        this._crewDP = null;
        this.separator = null;
        this.noVehicleTf = null;
        this.addVehicleTF = null;
        this.premiumTF = null;
        this._tooltipMgr = null;
        this.btnHover = null;
        this._commons = null;
        super.onDispose();
    }

    public function getHitArea():DisplayObject {
        return this;
    }

    public function getTargetButton():DisplayObject {
        return this;
    }

    public function measureSize(param1:Point = null):Point {
        return null;
    }

    override public function set data(param1:Object):void {
        if (super.data == param1) {
            return;
        }
        if (this._rendererData) {
            this._rendererData.removeEventListener(Event.CHANGE, this.onDataChangeHandler);
        }
        super.data = param1;
        this._rendererData = VehCompareVehicleVO(param1);
        if (this._rendererData) {
            this._rendererData.addEventListener(Event.CHANGE, this.onDataChangeHandler);
        }
        invalidate(INVALIATE_RENDERER_DATA);
    }

    public function set tooltipDecorator(param1:ITooltipMgr):void {
    }

    private function onDataChangeHandler(param1:Event):void {
        invalidate(INVALIATE_RENDERER_DATA);
    }

    private function onCrewDropdownMouseOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }

    private function onVehicleIconMouseOverHandler(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (this._rendererData && !this._rendererData.isFirstEmptySlot) {
            _loc2_ = !!this._rendererData.isInHangar ? VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_TOHANGAR : VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_TOPREVIEW;
            this._tooltipMgr.showComplex(_loc2_);
            this.btnHover.visible = true;
        }
    }

    private function onAddVehicleBtnMouseOutHandler(param1:MouseEvent):void {
        this.addVehicleBtn.alpha = ADD_BTN_ALPHA;
        this.addVehicleTF.visible = false;
    }

    private function onAddVehicleBtnMouseOverHandler(param1:MouseEvent):void {
        this.addVehicleBtn.alpha = 1;
        this.addVehicleTF.visible = true;
    }

    private function onAddVehicleBtnClickHandler(param1:MouseEvent):void {
        App.popoverMgr.show(this, VEHICLE_COMPARE_CONSTANTS.VEHICLE_CMP_ADD_VEHICLE_POPOVER);
    }

    private function onVehicleIconClickHandler(param1:MouseEvent):void {
        var _loc2_:VehCompareVehicleRendererEvent = null;
        var _loc3_:String = null;
        if (this._rendererData && !this._rendererData.isFirstEmptySlot) {
            if (this._commons.isRightButton(param1)) {
                _loc2_ = new VehCompareVehicleRendererEvent(this._rendererData.id, VehCompareVehicleRendererEvent.RIGHT_CLICK, true);
                _loc2_.index = this._rendererData.index;
                dispatchEvent(_loc2_);
            }
            else if (this._commons.isLeftButton(param1)) {
                _loc3_ = !!this._rendererData.isInHangar ? VehCompareVehicleRendererEvent.GO_TO_HANGAR_CLICK : VehCompareVehicleRendererEvent.GO_TO_PREVIEW_CLICK;
                dispatchEvent(new VehCompareVehicleRendererEvent(this._rendererData.id, _loc3_, true));
            }
        }
    }

    private function onVehicleIconMouseOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
        this.btnHover.visible = false;
    }

    private function onCrewDropdownMouseOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_CREWDROPDOWN);
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id, VehCompareVehicleRendererEvent.REMOVE_CLICK, true);
        _loc2_.index = this._rendererData.index;
        dispatchEvent(_loc2_);
    }

    private function onCrewDropdownIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id, VehCompareVehicleRendererEvent.CREW_LEVEL_CHANGED, true);
        _loc2_.crewLevelId = VehCompareCrewLevelVO(param1.itemData).id;
        _loc2_.index = this._rendererData.index;
        dispatchEvent(_loc2_);
    }

    private function onModuleBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id, VehCompareVehicleRendererEvent.MODULES_CLICK, true);
        _loc2_.index = this._rendererData.index;
        dispatchEvent(_loc2_);
    }

    private function onAttentionIconRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_ATTENTIONEQUIPMENT);
    }

    private function onAttentionIconRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }
}
}

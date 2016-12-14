package net.wg.gui.lobby.vehicleCompare.controls.view {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.interfaces.IButtonIconTextTransparent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
import net.wg.gui.lobby.vehicleCompare.interfaces.ITopPanel;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.interfaces.IDataProvider;

public class VehCompareTopPanel extends UIComponentEx implements ITopPanel, IPopOverCaller {

    private static const INV_ATTENTION_ICON_VISIBLE:String = "invAttentionIconVisible";

    public var carousel:VehCompareTankCarousel = null;

    public var separator:MovieClip;

    public var topBg:Sprite;

    public var buttonAddVehicle:SoundButtonEx;

    public var labelVehCount:LabelControl;

    public var btnRemove:IButtonIconTextTransparent;

    public var attentionIcon:Sprite;

    private var _backHitArea:Sprite;

    private var _attentionIconVisible:Boolean = false;

    private var _toolTipMgr:ITooltipMgr;

    public function VehCompareTopPanel() {
        super();
        this._toolTipMgr = App.toolTipMgr;
    }

    override protected function onDispose():void {
        this.carousel.dispose();
        this.carousel = null;
        removeChild(this._backHitArea);
        this._backHitArea = null;
        this.separator.hitArea = null;
        this.separator = null;
        this.topBg = null;
        this.buttonAddVehicle.removeEventListener(ButtonEvent.CLICK, this.onButtonAddVehicleClickHandler);
        this.buttonAddVehicle.dispose();
        this.buttonAddVehicle = null;
        this.labelVehCount.dispose();
        this.labelVehCount = null;
        this.btnRemove.removeEventListener(ButtonEvent.CLICK, this.onBtnRemoveClickHandler);
        this.btnRemove.dispose();
        this.btnRemove = null;
        this.attentionIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAttentionIconRollOverHandler);
        this.attentionIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAttentionIconRollOutHandler);
        this.attentionIcon = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this._backHitArea = new Sprite();
        addChild(this._backHitArea);
        this.separator.hitArea = this._backHitArea;
        this.separator.mouseEnabled = this.separator.mouseChildren = false;
        this.buttonAddVehicle.addEventListener(ButtonEvent.CLICK, this.onButtonAddVehicleClickHandler);
        this.buttonAddVehicle.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_ADDVEHICLES;
        this.buttonAddVehicle.label = VEH_COMPARE.VEHICLECOMPAREVIEW_BTNADDVEHICLES;
        this.btnRemove.addEventListener(ButtonEvent.CLICK, this.onBtnRemoveClickHandler);
        this.btnRemove.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_REMOVEALLVEHICLES;
        this.attentionIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAttentionIconRollOverHandler);
        this.attentionIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAttentionIconRollOutHandler);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.carousel.width = width - this.carousel.x;
            this.separator.x = width;
            this.separator.width = width;
            this.topBg.width = width - this.topBg.x;
        }
        if (isInvalid(INV_ATTENTION_ICON_VISIBLE)) {
            this.attentionIcon.visible = this._attentionIconVisible;
        }
    }

    public function setAttentionVisible(param1:Boolean):void {
        this._attentionIconVisible = param1;
        invalidate(INV_ATTENTION_ICON_VISIBLE);
    }

    public function getHitArea():DisplayObject {
        return this.buttonAddVehicle.hitArea;
    }

    public function getTargetButton():DisplayObject {
        return this.buttonAddVehicle;
    }

    public function setVehiclesCountText(param1:String):void {
        this.labelVehCount.htmlText = param1;
    }

    public function setVehiclesData(param1:IDataProvider):void {
        this.carousel.dataProvider = param1;
    }

    public function updateTableScrollPosition(param1:int):void {
        this.carousel.updateTableScrollPosition(param1);
    }

    private function onBtnRemoveClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new VehCompareEvent(VehCompareEvent.REMOVE_ALL_CLICK));
    }

    private function onButtonAddVehicleClickHandler(param1:ButtonEvent):void {
        App.popoverMgr.show(this, VEHICLE_COMPARE_CONSTANTS.VEHICLE_CMP_ADD_VEHICLE_POPOVER);
    }

    private function onAttentionIconRollOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showComplex(VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_DIFFERENTMODULESORCREW);
    }

    private function onAttentionIconRollOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }
}
}

package net.wg.gui.lobby.vehicleCustomization {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.InteractiveObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.net.URLRequest;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSlotEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class CustomizationSlotRenderer extends UIComponentEx implements ISlotsPanelRenderer, IFocusChainContainer {

    private static const DEFAULT_ICON_SIZE:int = 128;

    private static const DEFAULT_ICON_SIZE_AFTER_SCALE:int = 43;

    private static const STATE_BASE_BUBBLE:String = "base";

    private static const STATE_SHOW_BUBBLE:String = "showBubble";

    private static const STATE_HIDE_BUBBLE:String = "hideBubble";

    public var removeBtn:SoundButtonEx = null;

    public var revertBtn:SoundButtonEx = null;

    public var mainIcon:BitmapFill = null;

    public var currencyIcon:Image = null;

    public var bonusBubble:TextField = null;

    public var bubbleTop:CustomizationSlotBubble = null;

    public var glow:MovieClip = null;

    public var btnSlot:SoundButtonEx = null;

    public var currencyBackground:Sprite = null;

    private var _slotData:CustomizationSlotVO = null;

    private var _loader:Loader = null;

    private var _id:int = -1;

    private var _ownerId:int = -1;

    private var _selectId:int = -1;

    private var _selected:Boolean = false;

    private var _state:String = "rendererStateBaseMode";

    private var _occupied:Boolean = false;

    private var _slotTooltip:String = "";

    private var _toolTipMgr:ITooltipMgr = null;

    public function CustomizationSlotRenderer() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
        this._toolTipMgr = App.toolTipMgr;
    }

    override protected function configUI():void {
        super.configUI();
        this._loader = new Loader();
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onCompleteLoadMainIconHandler);
        this.bubbleTop.enabled = false;
        this.bubbleTop.mouseChildren = false;
        this.mainIcon.mouseEnabled = false;
        this.mainIcon.mouseChildren = false;
        this.currencyIcon.mouseEnabled = false;
        this.currencyIcon.mouseChildren = false;
        this.bonusBubble.mouseEnabled = false;
        this.glow.mouseEnabled = false;
        this.glow.visible = false;
        this.currencyBackground.mouseEnabled = false;
        this.btnSlot.addEventListener(ButtonEvent.CLICK, this.onRendererClickHandler);
        this.btnSlot.addEventListener(MouseEvent.MOUSE_OVER, this.onRendererOverHandler);
        this.btnSlot.addEventListener(MouseEvent.MOUSE_OUT, this.onRendererOutHandler);
        this.removeBtn.addEventListener(ButtonEvent.CLICK, this.onRemoveBtnClickHandler);
        this.revertBtn.addEventListener(ButtonEvent.CLICK, this.onRevertBtnClickHandler);
    }

    override protected function draw():void {
        super.draw();
        if (this._slotData != null && isInvalid(InvalidationType.DATA)) {
            this._occupied = this._slotData.itemID >= 0;
            this.removeBtn.visible = this._occupied;
            this.revertBtn.visible = this._slotData.revertBtnVisible;
            this._loader.load(new URLRequest(this._slotData.img));
            this.currencyIcon.source = this._slotData.purchaseTypeIcon;
            this.bubbleTop.text = this._slotData.bonus;
            this.bonusBubble.htmlText = this._slotData.bonus;
            this.removeBtn.tooltip = this._slotData.removeBtnTooltip;
            this.revertBtn.tooltip = this._slotData.revertBtnTooltip;
            this._slotTooltip = this._slotData.slotTooltip;
            this.currencyIcon.visible = !this._slotData.isInDossier && this._occupied;
            this.currencyBackground.visible = this.currencyIcon.visible;
            this.setBubble();
        }
        if (isInvalid(InvalidationType.STATE)) {
            if (this._state == CustomizationHelper.RENDER_STATE_BASE_MODE) {
                this.bonusBubble.visible = this._occupied;
                gotoAndStop(STATE_BASE_BUBBLE);
                this.bubbleTop.visible = false;
                this.removeBtn.visible = false;
                this.bubbleTop.isWasOccupied = false;
                this.revertBtn.visible = false;
            }
            else if (this._state == CustomizationHelper.RENDER_STATE_BUY_MODE) {
                this.bonusBubble.visible = false;
                this.removeBtn.visible = this._occupied;
                this.revertBtn.visible = this._slotData.revertBtnVisible;
            }
            this.setBubble();
        }
    }

    override protected function onDispose():void {
        this._toolTipMgr = null;
        this.removeBtn.removeEventListener(ButtonEvent.CLICK, this.onRemoveBtnClickHandler);
        this.removeBtn.dispose();
        this.removeBtn = null;
        this.revertBtn.removeEventListener(ButtonEvent.CLICK, this.onRevertBtnClickHandler);
        this.revertBtn.dispose();
        this.revertBtn = null;
        this._slotData.dispose();
        this._slotData = null;
        this.bonusBubble = null;
        this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onCompleteLoadMainIconHandler);
        this._loader = null;
        this.mainIcon.dispose();
        this.mainIcon = null;
        this.currencyIcon.dispose();
        this.currencyIcon = null;
        this.btnSlot.removeEventListener(ButtonEvent.CLICK, this.onRendererClickHandler);
        this.btnSlot.removeEventListener(MouseEvent.MOUSE_OVER, this.onRendererOverHandler);
        this.btnSlot.removeEventListener(MouseEvent.MOUSE_OUT, this.onRendererOutHandler);
        this.btnSlot.dispose();
        this.btnSlot = null;
        this.bubbleTop.dispose();
        this.bubbleTop = null;
        this.glow = null;
        this.currencyBackground = null;
        super.onDispose();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_.push(this.btnSlot);
        if (this.revertBtn.visible) {
            _loc1_.push(this.revertBtn);
        }
        if (this.removeBtn.visible) {
            _loc1_.push(this.removeBtn);
        }
        return _loc1_;
    }

    public function hide():void {
        visible = false;
    }

    public function setData(param1:DAAPIDataClass):void {
        if (this._slotData != null) {
            this._slotData.dispose();
            this._slotData = null;
        }
        this._toolTipMgr.hide();
        this._slotData = CustomizationSlotVO(param1);
        invalidateData();
    }

    public function setState(param1:String):void {
        this._state = param1;
        invalidateState();
    }

    public function show():void {
        visible = true;
    }

    public function showPartly():void {
    }

    public function update(param1:Object):void {
        var _loc2_:CustomizationSlotUpdateVO = CustomizationSlotUpdateVO(param1);
        this.setData(_loc2_.data);
        invalidateState();
    }

    private function setBubble():void {
        if (this._state == CustomizationHelper.RENDER_STATE_BUY_MODE) {
            if (this._occupied) {
                this.bubbleTop.visible = true;
                this.bubbleTop.isWasOccupied = true;
                gotoAndPlay(STATE_SHOW_BUBBLE);
            }
            else if (this.bubbleTop.isWasOccupied) {
                gotoAndPlay(STATE_HIDE_BUBBLE);
            }
            else {
                this.bubbleTop.visible = false;
            }
        }
    }

    public function get ownerId():int {
        return this._ownerId;
    }

    public function set ownerId(param1:int):void {
        this._ownerId = param1;
    }

    public function get selectId():int {
        return this._selectId;
    }

    public function set selectId(param1:int):void {
        this._selectId = param1;
    }

    public function get id():int {
        return this._id;
    }

    public function set id(param1:int):void {
        this._id = param1;
    }

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        if (this._selected != param1) {
            this._selected = param1;
            this.btnSlot.selected = param1;
            this.glow.visible = param1;
        }
    }

    private function onCompleteLoadMainIconHandler(param1:Event):void {
        var _loc2_:BitmapData = Bitmap(this._loader.content).bitmapData;
        this._loader.unloadAndStop(false);
        var _loc3_:Number = _loc2_.width > DEFAULT_ICON_SIZE ? Number(DEFAULT_ICON_SIZE) : Number(_loc2_.width);
        var _loc4_:Number = _loc2_.height > DEFAULT_ICON_SIZE ? Number(DEFAULT_ICON_SIZE) : Number(_loc2_.height);
        this.mainIcon.matrix = new Matrix(DEFAULT_ICON_SIZE_AFTER_SCALE / _loc3_, 0, 0, DEFAULT_ICON_SIZE_AFTER_SCALE / _loc4_);
        this.mainIcon.setBitmap(_loc2_);
    }

    private function onRendererClickHandler(param1:ButtonEvent):void {
        if (this._selected) {
            return;
        }
        this._toolTipMgr.hide();
        var _loc2_:CustomizationSlotEvent = new CustomizationSlotEvent(CustomizationSlotEvent.SELECT_SLOT, this._id, this._ownerId, this._selectId);
        dispatchEvent(_loc2_);
    }

    private function onRendererOverHandler(param1:MouseEvent):void {
        if (!this._occupied && this._state == CustomizationHelper.RENDER_STATE_BASE_MODE) {
            this._toolTipMgr.showComplex(this._slotTooltip);
        }
        else if (this._occupied) {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM, null, this._id, this._ownerId);
        }
    }

    private function onRendererOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onRemoveBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:CustomizationSlotEvent = new CustomizationSlotEvent(CustomizationSlotEvent.REMOVE_SLOT, this._id, this._ownerId, this._selectId);
        dispatchEvent(_loc2_);
    }

    private function onRevertBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:CustomizationSlotEvent = new CustomizationSlotEvent(CustomizationSlotEvent.REVERT_SLOT, this._id, this._ownerId, this._selectId);
        dispatchEvent(_loc2_);
    }
}
}

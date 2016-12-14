package net.wg.gui.lobby.vehicleCompare {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.assets.data.SeparatorConstants;
import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
import net.wg.gui.components.controls.Image;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehicleCompare.data.VehicleModulesWindowInitDataVO;
import net.wg.gui.lobby.vehicleCompare.events.VehicleModuleItemEvent;
import net.wg.infrastructure.base.meta.IVehicleModulesWindowMeta;
import net.wg.infrastructure.base.meta.impl.VehicleModulesWindowMeta;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.events.ButtonEvent;

public class VehicleModulesWindow extends VehicleModulesWindowMeta implements IVehicleModulesWindowMeta {

    private static const INV_INIT_DATA:String = "InvInitData";

    private static const INV_STATE:String = "InvState";

    private static const WINDOW_WIDTH:int = 790;

    private static const WINDOW_HEIGHT:int = 647;

    private static const MODULE_CELL_HEIGHT:int = 92;

    private static const MODULE_CELL_WIDTH:int = 40;

    private static const ATTENTION_ICON_HORIZONTAL_GAP:int = 7;

    public var compareBtn:ISoundButtonEx = null;

    public var resetBtn:ISoundButtonEx = null;

    public var closeBtn:ISoundButtonEx = null;

    public var stateTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var tree:VehicleModulesTree = null;

    public var separator:ISeparatorAsset = null;

    public var attentionIcon:Image = null;

    private var _initData:VehicleModulesWindowInitDataVO;

    private var _stateLabel:String;

    private var _stateEnabled:Boolean;

    private var _attentionIconVisible:Boolean = false;

    private var _toolTipMgr:ITooltipMgr;

    public function VehicleModulesWindow() {
        super();
        isModal = true;
        canClose = true;
        isCentered = true;
        canDrag = false;
        this._toolTipMgr = App.toolTipMgr;
    }

    override protected function configUI():void {
        super.configUI();
        this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
        this.stateTF.autoSize = TextFieldAutoSize.RIGHT;
        this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
        this.separator.mouseEnabled = false;
        this.resetBtn.addEventListener(ButtonEvent.CLICK, this.onResetBtnBtnClickHandler);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.compareBtn.addEventListener(ButtonEvent.CLICK, this.onCompareBtnClickHandler);
        this.tree.addEventListener(VehicleModuleItemEvent.MODULE_ITEM_HOVERED, this.onTreeModuleItemHoveredHandler);
        this.tree.addEventListener(VehicleModuleItemEvent.MODULE_ITEM_CLICKED, this.onTreeModuleItemClickedHandler);
        this.tree.availableWidth = WINDOW_WIDTH;
        this.attentionIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ATTENTIONICONFILLED;
        this.attentionIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAttentionIconRollOverHandler);
        this.attentionIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAttentionIconRollOutHandler);
        this.attentionIcon.addEventListener(Event.CHANGE, this.onAttentionIconChangeHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function onDispose():void {
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.resetBtn.removeEventListener(ButtonEvent.CLICK, this.onResetBtnBtnClickHandler);
        this.resetBtn.dispose();
        this.resetBtn = null;
        this.compareBtn.removeEventListener(ButtonEvent.CLICK, this.onCompareBtnClickHandler);
        this.compareBtn.dispose();
        this.compareBtn = null;
        this.separator.dispose();
        this.separator = null;
        this.tree.removeEventListener(VehicleModuleItemEvent.MODULE_ITEM_CLICKED, this.onTreeModuleItemClickedHandler);
        this.tree.removeEventListener(VehicleModuleItemEvent.MODULE_ITEM_HOVERED, this.onTreeModuleItemHoveredHandler);
        this.tree.dispose();
        this.tree = null;
        this.attentionIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAttentionIconRollOverHandler);
        this.attentionIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAttentionIconRollOutHandler);
        this.attentionIcon.removeEventListener(Event.CHANGE, this.onAttentionIconChangeHandler);
        this.attentionIcon.dispose();
        this.attentionIcon = null;
        this.descriptionTF = null;
        this.stateTF = null;
        this._initData = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    override protected function setInitData(param1:VehicleModulesWindowInitDataVO):void {
        this._initData = param1;
        invalidate(INV_INIT_DATA);
    }

    override protected function draw():void {
        super.draw();
        if (this._initData && isInvalid(INV_INIT_DATA)) {
            window.title = this._initData.windowTitle;
            this.descriptionTF.htmlText = this._initData.description;
            this.resetBtn.label = this._initData.resetBtnLabel;
            this.resetBtn.tooltip = this._initData.resetBtnTooltip;
            this.closeBtn.label = this._initData.closeBtnLabel;
            this.closeBtn.tooltip = this._initData.closeBtnTooltip;
            this.compareBtn.label = this._initData.compareBtnLabel;
            this.compareBtn.tooltip = this._initData.compareBtnTooltip;
        }
        if (isInvalid(INV_STATE)) {
            this.stateTF.htmlText = this._stateLabel;
            this.resetBtn.enabled = this._stateEnabled;
            this.attentionIcon.visible = this._attentionIconVisible;
            if (this._attentionIconVisible) {
                this.attentionIcon.x = this.stateTF.x - this.attentionIcon.width - ATTENTION_ICON_HORIZONTAL_GAP | 0;
            }
        }
    }

    override protected function initialize():void {
        super.initialize();
        this.tree.yRatio = MODULE_CELL_HEIGHT;
        this.tree.xRatio = MODULE_CELL_WIDTH;
    }

    public function as_setAttentionVisible(param1:Boolean):void {
        this._attentionIconVisible = param1;
    }

    public function as_setItem(param1:String, param2:Object):void {
        this.tree.invalidateNodesData(param1, param2);
    }

    override protected function setNodesStates(param1:Array):void {
        this.tree.setNodesStates(param1);
    }

    public function as_setState(param1:String, param2:Boolean):void {
        this._stateLabel = param1;
        this._stateEnabled = param2;
        invalidate(INV_STATE);
    }

    override public function get width():Number {
        return WINDOW_WIDTH;
    }

    override public function get height():Number {
        return WINDOW_HEIGHT;
    }

    private function onAttentionIconChangeHandler(param1:Event):void {
        invalidate(INV_STATE);
    }

    private function onTreeModuleItemClickedHandler(param1:VehicleModuleItemEvent):void {
        onModuleClickS(param1.id);
    }

    private function onTreeModuleItemHoveredHandler(param1:VehicleModuleItemEvent):void {
        onModuleHoverS(param1.id);
    }

    private function onResetBtnBtnClickHandler(param1:ButtonEvent):void {
        onResetBtnBtnClickS();
    }

    private function onCompareBtnClickHandler(param1:ButtonEvent):void {
        onCompareBtnClickS();
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onAttentionIconRollOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showComplex(VEH_COMPARE.MODULESVIEW_TOOLTIPS_ATTENTIONEQUIPMENT);
    }

    private function onAttentionIconRollOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }
}
}

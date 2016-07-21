package net.wg.gui.lobby.fortifications.cmp.main.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.ORDER_TYPES;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.events.SlotsPanelEvent;
import net.wg.gui.components.controls.slotsPanel.ISlotsPanel;
import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
import net.wg.gui.lobby.fortifications.cmp.orders.ICheckBoxIcon;
import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public class FortMainFooter extends UIComponentEx implements IMainFooter {

    private static const LEAVE_TRANSPORT_BTN_OFFSET_Y:uint = 16;

    public var checkBoxOrderType:ICheckBoxIcon = null;

    private var _footerBitmapFill:BitmapFill = null;

    private var _intelligenceButton:SoundButtonEx = null;

    private var _sortieBtn:SoundButtonEx = null;

    private var _ordersPanel:ISlotsPanel = null;

    private var _leaveModeBtn:SoundButtonEx = null;

    private var _tutorialArrowIntelligence:IUIComponentEx = null;

    private var showCheckBox:Boolean = false;

    private var _tutorialArrowOffsetX:int = 0;

    private var _tutorialArrowOffsetY:int = 0;

    public function FortMainFooter() {
        super();
        this.checkBoxOrderType.addEventListener(Event.SELECT, this.selectHandler);
        this.checkBoxOrderType.addEventListener(MouseEvent.ROLL_OVER, onCheckBoxOrderTypeRollOverHandler);
        this.checkBoxOrderType.addEventListener(MouseEvent.ROLL_OUT, onCheckBoxOrderTypeRollOutHandler);
        this.ordersPanel.addEventListener(SlotsPanelEvent.NEED_REPOSITION, this.repositionHandler);
        this._tutorialArrowOffsetX = this._tutorialArrowIntelligence.x - this.intelligenceButton.x;
        this._tutorialArrowOffsetY = this._tutorialArrowIntelligence.y - this.intelligenceButton.y;
    }

    private static function onCheckBoxOrderTypeRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_ORDERSPANEL_CHECKBOXORDERTYPE);
    }

    private static function onCheckBoxOrderTypeRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this._sortieBtn.label = FORTIFICATIONS.FORTMAINVIEW_SORTIEBUTTON_TITLE;
        this._sortieBtn.tooltip = TOOLTIPS.FORTIFICATION_FOOTER_SORTIEBUTTON;
        this._intelligenceButton.label = FORTIFICATIONS.FORTMAINVIEW_INTELLIGENCEBUTTON_TITLE;
        this._intelligenceButton.tooltip = TOOLTIPS.FORTIFICATION_FOOTER_INTELLIGENCEBUTTON;
        this._leaveModeBtn.label = FORTIFICATIONS.FORTMAINVIEW_LEAVE_BUTTON_LABEL;
        this._sortieBtn.focusIndicator.mouseEnabled = false;
    }

    override protected function onDispose():void {
        this.checkBoxOrderType.removeEventListener(Event.SELECT, this.selectHandler);
        this.checkBoxOrderType.removeEventListener(MouseEvent.ROLL_OVER, onCheckBoxOrderTypeRollOverHandler);
        this.checkBoxOrderType.removeEventListener(MouseEvent.ROLL_OUT, onCheckBoxOrderTypeRollOutHandler);
        this.checkBoxOrderType.dispose();
        this.checkBoxOrderType = null;
        this.ordersPanel.removeEventListener(SlotsPanelEvent.NEED_REPOSITION, this.repositionHandler);
        this.ordersPanel = null;
        this._leaveModeBtn.dispose();
        this._leaveModeBtn = null;
        this._footerBitmapFill.dispose();
        this._footerBitmapFill = null;
        this._intelligenceButton.dispose();
        this._intelligenceButton = null;
        this._sortieBtn.dispose();
        this._sortieBtn = null;
        App.utils.tweenAnimator.removeAnims(DisplayObject(this._tutorialArrowIntelligence));
        this._tutorialArrowIntelligence.dispose();
        this._tutorialArrowIntelligence = null;
        super.onDispose();
    }

    public function getComponentForFocus():InteractiveObject {
        return this._leaveModeBtn;
    }

    public function updateControls():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        FortsControlsAligner.instance.rightControl(DisplayObject(this._intelligenceButton), 0);
        this._tutorialArrowIntelligence.x = this._intelligenceButton.x + this._tutorialArrowOffsetX;
        this._tutorialArrowIntelligence.y = this._intelligenceButton.y + this._tutorialArrowOffsetY;
        this._leaveModeBtn.y = actualHeight - this._leaveModeBtn.actualHeight >> 1 - LEAVE_TRANSPORT_BTN_OFFSET_Y;
        FortsControlsAligner.instance.centerControl(this._leaveModeBtn, false);
        this.ordersPanel.y = this._footerBitmapFill.y;
        if (this.isInitedChildren() && this.ordersPanel.visible) {
            _loc1_ = this.sortieBtn.x + this.sortieBtn.width;
            _loc2_ = this._intelligenceButton.x;
            _loc3_ = _loc2_ - _loc1_;
            this.showCheckBox = this.ordersPanel.isShowCheckBox(_loc3_);
            if (this.showCheckBox) {
                this.checkBoxOrderType.visible = true;
                this.checkBoxUpdater();
            }
            else {
                this.checkBoxOrderType.visible = false;
                this.ordersPanel.redrawSlots(ORDER_TYPES.FORT_ORDER_ALL_GROUP);
            }
        }
        this.checkBoxOrderType.x = this.sortieBtn.x + this.sortieBtn.width ^ 0;
    }

    private function checkBoxUpdater():void {
        if (!this.checkBoxOrderType.visible || !this.isInitedChildren()) {
            return;
        }
        if (this.checkBoxOrderType.isSelected()) {
            this.ordersPanel.redrawSlots(ORDER_TYPES.FORT_ORDER_CONSUMABLES_GROUP);
        }
        else {
            this.ordersPanel.redrawSlots(ORDER_TYPES.FORT_ORDER_GENERAL_GROUP);
        }
    }

    private function isInitedChildren():Boolean {
        return this.ordersPanel.isInited() && this.checkBoxOrderType.isInited();
    }

    public function get orderSelector():ICheckBoxIcon {
        return this.checkBoxOrderType;
    }

    public function set widthFill(param1:Number):void {
        this._footerBitmapFill.widthFill = param1;
    }

    public function get heightFill():Number {
        return this._footerBitmapFill.heightFill;
    }

    public function get leaveModeBtn():SoundButtonEx {
        return this._leaveModeBtn;
    }

    public function set leaveModeBtn(param1:SoundButtonEx):void {
        this._leaveModeBtn = param1;
    }

    public function get ordersPanel():ISlotsPanel {
        return this._ordersPanel;
    }

    public function set ordersPanel(param1:ISlotsPanel):void {
        this._ordersPanel = param1;
    }

    public function get intelligenceButton():SoundButtonEx {
        return this._intelligenceButton;
    }

    public function set intelligenceButton(param1:SoundButtonEx):void {
        this._intelligenceButton = param1;
    }

    public function get sortieBtn():SoundButtonEx {
        return this._sortieBtn;
    }

    public function set sortieBtn(param1:SoundButtonEx):void {
        this._sortieBtn = param1;
    }

    public function get footerBitmapFill():BitmapFill {
        return this._footerBitmapFill;
    }

    public function set footerBitmapFill(param1:BitmapFill):void {
        this._footerBitmapFill = param1;
    }

    public function get tutorialArrowIntelligence():IUIComponentEx {
        return this._tutorialArrowIntelligence;
    }

    public function set tutorialArrowIntelligence(param1:IUIComponentEx):void {
        this._tutorialArrowIntelligence = param1;
    }

    private function selectHandler(param1:Event):void {
        this.checkBoxUpdater();
    }

    private function repositionHandler(param1:Event):void {
        if (this.showCheckBox) {
            this.ordersPanel.x = App.appWidth - this.ordersPanel.actualWidth + this.checkBoxOrderType.width >> 1;
        }
        else {
            this.ordersPanel.x = App.appWidth - this.ordersPanel.actualWidth >> 1;
        }
    }
}
}

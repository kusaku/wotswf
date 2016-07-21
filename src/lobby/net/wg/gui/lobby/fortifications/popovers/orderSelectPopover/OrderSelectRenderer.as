package net.wg.gui.lobby.fortifications.popovers.orderSelectPopover {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.data.OrderSelectRendererVO;
import net.wg.gui.lobby.fortifications.events.OrderSelectEvent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class OrderSelectRenderer extends TableRenderer {

    private static const ARSENAL_ICON_OFFSET:int = 60;

    private static const RETURN_BTN_MIN_WIDTH:int = 117;

    public var headerTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var orderCountTF:TextField = null;

    public var returnButton:SoundButtonEx = null;

    public var orderIcon:UILoaderAlt = null;

    public var arsenalIcon:UILoaderAlt = null;

    public var tooltipHitArea:MovieClip = null;

    private var _orderID:int = -1;

    private var _orderLevel:int = -1;

    public function OrderSelectRenderer() {
        super();
        mouseEnabledOnDisabled = true;
    }

    private static function onTooltipHitAreaRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_FORTORDERSELECTPOPOVER_ARSENALICON);
    }

    private static function onTooltipHitAreaRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override public function setData(param1:Object):void {
        if (param1) {
            _data = param1;
            invalidateData();
        }
    }

    override protected function getBgShadowOffset():int {
        return 0;
    }

    override protected function configUI():void {
        super.configUI();
        this.returnButton.autoSize = TextFieldAutoSize.LEFT;
        this.returnButton.minWidth = RETURN_BTN_MIN_WIDTH;
        disableMc.mouseEnabled = disableMc.mouseChildren = false;
        this.headerTF.mouseEnabled = false;
        this.descriptionTF.mouseEnabled = false;
        this.orderIcon.mouseEnabled = this.orderIcon.mouseChildren = false;
        rendererBg.mouseEnabled = rendererBg.mouseChildren = false;
        this.orderCountTF.mouseEnabled = false;
        this.arsenalIcon.mouseEnabled = this.arsenalIcon.mouseChildren = false;
        this.arsenalIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_INVENTORYICON;
        this.tooltipHitArea.alpha = 0;
    }

    override protected function onDispose():void {
        removeEventListener(ButtonEvent.CLICK, this.onClickHandler);
        this.removeArsenalListeners();
        this.headerTF = null;
        this.descriptionTF = null;
        this.orderCountTF = null;
        this.returnButton.dispose();
        this.returnButton = null;
        this.orderIcon.dispose();
        this.orderIcon = null;
        this.arsenalIcon.dispose();
        this.arsenalIcon = null;
        this.tooltipHitArea = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:OrderSelectRendererVO = null;
        var _loc2_:Boolean = false;
        super.draw();
        if (_data && isInvalid(InvalidationType.DATA)) {
            _loc1_ = OrderSelectRendererVO(_data);
            this._orderID = _loc1_.orderID;
            this._orderLevel = _loc1_.orderLevel;
            this.orderIcon.source = _loc1_.orderIconSrc;
            this.headerTF.htmlText = _loc1_.headerText;
            this.descriptionTF.htmlText = _loc1_.descriptionText;
            this.orderCountTF.htmlText = _loc1_.orderCountText;
            this.returnButton.label = _loc1_.returnBtnLabel;
            this.orderCountTF.autoSize = TextFieldAutoSize.RIGHT;
            this.enabled = _loc1_.isEnabled;
            updateDisable(!enabled);
            _loc2_ = _loc1_.isSelected;
            this.returnButton.visible = _loc2_;
            this.arsenalIcon.visible = _loc1_.showArsenalIcon;
            this.tooltipHitArea.mouseEnabled = this.tooltipHitArea.mouseChildren = this.tooltipHitArea.buttonMode = this.tooltipHitArea.useHandCursor = !_loc2_;
            if (!_loc2_ && enabled) {
                this.arsenalIcon.x = this.width - ARSENAL_ICON_OFFSET - this.orderCountTF.textWidth >> 0;
                this.tooltipHitArea.x = this.arsenalIcon.x;
                this.tooltipHitArea.y = this.arsenalIcon.y;
                this.tooltipHitArea.width = this.orderCountTF.textWidth + this.arsenalIcon.width;
                this.addArsenalListeners();
            }
            else {
                this.removeArsenalListeners();
            }
            if (enabled) {
                addEventListener(ButtonEvent.CLICK, this.onClickHandler);
            }
            else {
                removeEventListener(ButtonEvent.CLICK, this.onClickHandler);
            }
        }
    }

    private function addArsenalListeners():void {
        this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OVER, onTooltipHitAreaRollOverHandler);
        this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OUT, onTooltipHitAreaRollOutHandler);
    }

    private function removeArsenalListeners():void {
        this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OVER, onTooltipHitAreaRollOverHandler);
        this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OUT, onTooltipHitAreaRollOutHandler);
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = buttonMode = useHandCursor = param1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (this._orderID != -1 && this._orderLevel != -1) {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_CONSUMABLE_ORDER, null, this._orderID, this._orderLevel);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
    }

    private function onClickHandler(param1:ButtonEvent):void {
        var _loc2_:String = null;
        if (param1.target == this.returnButton) {
            _loc2_ = OrderSelectEvent.REMOVE_ORDER;
        }
        else if (this.returnButton.visible) {
            _loc2_ = OrderSelectEvent.CLOSE_POPOVER;
        }
        else {
            _loc2_ = OrderSelectEvent.ADD_ORDER;
        }
        dispatchEvent(new OrderSelectEvent(_loc2_, this._orderID));
    }
}
}

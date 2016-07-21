package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.utilData.TwoDimensionalPadding;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.OrderPopoverVO;
import net.wg.gui.lobby.fortifications.popovers.orderPopover.OrderInfoBlock;
import net.wg.infrastructure.base.meta.IFortOrderPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortOrderPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.StatusIndicator;
import scaleform.clik.events.ButtonEvent;

public class FortOrderPopover extends FortOrderPopoverMeta implements IFortOrderPopoverMeta {

    private static const AFTER_DESCR_PADDING:int = 15;

    private static const TEXT_PADDING:int = 5;

    private static const BUTTON_PADDING:int = 10;

    private static const PIXEL_PADDING:int = 1;

    private static const DISABLED_ALPHA:Number = 0.5;

    private static const INV_DISABLE_BTN:String = "invDisableBtn";

    private static const INV_FOCUS:String = "invFocus";

    private static const SEC_TO_MSEC_SCALE:int = 1000;

    private static const QUEST_LINK_TEXT_PADDING_SHIFT:int = 2;

    private static const KEY_POINT_PADDING_X_SHIFT:int = -5;

    public var bigIcon:UILoaderAlt;

    public var titleTF:TextField;

    public var levelTF:TextField;

    public var timeLeftTF:TextField;

    public var descriptionTF:TextField;

    public var timerHover:MovieClip;

    public var alertIcon:MovieClip;

    public var durationProgress:StatusIndicator;

    public var infoBlock:OrderInfoBlock;

    public var useOrderBtn:ISoundButtonEx;

    public var detailsBtn:ISoundButtonEx;

    public var bottomSeparator:MovieClip = null;

    public var questLink:ISoundButtonEx;

    private var _data:OrderPopoverVO = null;

    private var _isOrderDisabled:Boolean = false;

    private var _cooldownPeriod:Number = 0;

    public function FortOrderPopover() {
        super();
    }

    private static function onCmpRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        if (this.useOrderBtn.visible && this.useOrderBtn.enabled) {
            setFocus(InteractiveObject(this.useOrderBtn));
        }
        else if (this.infoBlock.showCreateOrderBtn) {
            setFocus(this.infoBlock.createOrderBtn);
        }
        else if (this.detailsBtn.visible) {
            setFocus(InteractiveObject(this.detailsBtn));
        }
        else {
            setFocus(this);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.useOrderBtn.visible = false;
        this.useOrderBtn.label = FORTIFICATIONS.ORDERS_ORDERPOPOVER_USEORDER;
        this.detailsBtn.label = FORTIFICATIONS.ORDERS_ORDERPOPOVER_DETAILSBTN;
        this.infoBlock.createOrderBtn.addEventListener(ButtonEvent.CLICK, this.onInfoBlockCreateOrderBtnClickHandler);
        this.detailsBtn.addEventListener(ButtonEvent.CLICK, this.onDetailsBtnClickHandler);
        this.useOrderBtn.addEventListener(ButtonEvent.CLICK, this.onUseOrderBtnClickHandler);
        this.timerHover.addEventListener(MouseEvent.ROLL_OVER, this.onTimerHoverRollOverHandler);
        this.timerHover.addEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
        this.questLink.addEventListener(ButtonEvent.CLICK, this.onQuestLinkClickHandler);
    }

    override protected function getKeyPointPadding():TwoDimensionalPadding {
        var _loc1_:TwoDimensionalPadding = super.getKeyPointPadding();
        _loc1_.top = new Point(KEY_POINT_PADDING_X_SHIFT, _loc1_.top.y);
        return _loc1_;
    }

    override protected function setInitData(param1:OrderPopoverVO):void {
        this._data = param1;
        invalidateData();
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
        super.initLayout();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        if (this._data && isInvalid(InvalidationType.DATA)) {
            this.titleTF.htmlText = this._data.title;
            this.levelTF.htmlText = this._data.levelStr;
            this.alertIcon.visible = this._data.showAlertIcon;
            this.descriptionTF.htmlText = this._data.description;
            this.timeLeftTF.htmlText = this._data.leftTimeStr;
            if (this._data.inCooldown && !this._data.isPermanent) {
                this.durationProgress.visible = true;
                this.durationProgress.maximum = this._data.effectTime;
                this.durationProgress.value = this._data.leftTime;
                this.startCooldownAnimation();
            }
            else {
                this.clearCooldown();
            }
            this.detailsBtn.visible = this._data.showDetailsBtn;
            this.useOrderBtn.visible = this._data.canUseOrder;
            this.questLink.visible = this._data.showLinkBtn;
            this.infoBlock.duration = this._data.effectTimeStr;
            this.infoBlock.productionTime = this._data.productionTime;
            this.infoBlock.building = this._data.buildingStr;
            this.infoBlock.price = this._data.productionCost;
            this.infoBlock.producedAmount = this._data.producedAmount;
            this.infoBlock.showCreateOrderBtn = this._data.canCreateOrder;
            this.bigIcon.source = this._data.icon;
            this.bigIcon.alpha = !!this._data.hasBuilding ? Number(1) : Number(DISABLED_ALPHA);
            this.infoBlock.validateNow();
            this.useOrderBtn.tooltip = this._data.useBtnTooltip;
            invalidateSize();
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.titleTF.height = Math.round(this.titleTF.textHeight + TEXT_PADDING);
            App.utils.commons.moveDsiplObjToEndOfText(this.alertIcon, this.titleTF, 0, PIXEL_PADDING);
            this.levelTF.y = Math.round(this.titleTF.y + this.titleTF.height);
            this.descriptionTF.height = Math.round(this.descriptionTF.textHeight + TEXT_PADDING);
            this.infoBlock.y = Math.round(this.descriptionTF.y + this.descriptionTF.textHeight + AFTER_DESCR_PADDING);
            _loc1_ = Math.round(this.infoBlock.y + this.infoBlock.height + AFTER_DESCR_PADDING + TEXT_PADDING);
            this.bottomSeparator.y = this.infoBlock.y + this.infoBlock.height + TEXT_PADDING + this.bottomSeparator.height;
            this.useOrderBtn.y = this.bottomSeparator.y - this.bottomSeparator.height + BUTTON_PADDING;
            _loc2_ = Math.round(this.useOrderBtn.y + this.useOrderBtn.height + BUTTON_PADDING);
            App.utils.commons.moveDsiplObjToEndOfText(DisplayObject(this.questLink), this.descriptionTF, TEXT_PADDING + QUEST_LINK_TEXT_PADDING_SHIFT, PIXEL_PADDING);
            if (this._data.canUseOrder) {
                setSize(this.width, _loc2_);
                this.bottomSeparator.visible = true;
            }
            else {
                setSize(this.width, _loc1_);
                this.bottomSeparator.visible = false;
            }
        }
        if (isInvalid(INV_DISABLE_BTN)) {
            this.useOrderBtn.enabled = !this._isOrderDisabled;
            this.useOrderBtn.mouseChildren = true;
            this.useOrderBtn.mouseEnabled = true;
            invalidate(INV_FOCUS);
        }
        super.draw();
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.updateCooldonwAnimation);
        if (this.questLink) {
            this.questLink.removeEventListener(ButtonEvent.CLICK, this.onQuestLinkClickHandler);
            this.questLink.dispose();
            this.questLink = null;
        }
        this.bigIcon.dispose();
        this.bigIcon = null;
        this.titleTF = null;
        this.levelTF = null;
        this.timeLeftTF = null;
        this.descriptionTF = null;
        if (this.alertIcon) {
            this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
            this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
            this.alertIcon = null;
        }
        if (this.timerHover) {
            this.timerHover.removeEventListener(MouseEvent.ROLL_OVER, this.onTimerHoverRollOverHandler);
            this.timerHover.removeEventListener(MouseEvent.ROLL_OUT, onCmpRollOutHandler);
            this.timerHover = null;
        }
        if (this.durationProgress) {
            this.durationProgress.dispose();
            this.durationProgress = null;
        }
        if (this.infoBlock) {
            this.infoBlock.createOrderBtn.removeEventListener(ButtonEvent.CLICK, this.onInfoBlockCreateOrderBtnClickHandler);
            this.infoBlock.dispose();
            this.infoBlock = null;
        }
        if (this.useOrderBtn) {
            this.useOrderBtn.removeEventListener(ButtonEvent.CLICK, this.onUseOrderBtnClickHandler);
            this.useOrderBtn.dispose();
            this.useOrderBtn = null;
        }
        this.detailsBtn.removeEventListener(ButtonEvent.CLICK, this.onDetailsBtnClickHandler);
        this.detailsBtn.dispose();
        this.detailsBtn = null;
        this._data = null;
        this.bottomSeparator = null;
        super.onDispose();
    }

    public function as_disableOrder(param1:Boolean):void {
        this._isOrderDisabled = param1;
        invalidate(INV_DISABLE_BTN);
    }

    private function startCooldownAnimation():void {
        App.utils.scheduler.cancelTask(this.updateCooldonwAnimation);
        var _loc1_:Number = this._data.leftTime / this._data.effectTime;
        var _loc2_:int = Math.round(_loc1_ * this.durationProgress.totalFrames);
        this._cooldownPeriod = this._data.leftTime / _loc2_ * SEC_TO_MSEC_SCALE;
        App.utils.scheduler.scheduleTask(this.updateCooldonwAnimation, this._cooldownPeriod);
    }

    private function updateCooldonwAnimation():void {
        var _loc1_:Number = getLeftTimeS();
        this.timeLeftTF.htmlText = getLeftTimeStrS();
        if (_loc1_ > 0) {
            this.durationProgress.value = getLeftTimeS();
            App.utils.scheduler.scheduleTask(this.updateCooldonwAnimation, this._cooldownPeriod);
        }
        else {
            this.clearCooldown();
        }
    }

    private function clearCooldown():void {
        App.utils.scheduler.cancelTask(this.updateCooldonwAnimation);
        this.durationProgress.visible = false;
        this._cooldownPeriod = 0;
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    private function onDetailsBtnClickHandler(param1:ButtonEvent):void {
        openOrderDetailsWindowS();
        App.popoverMgr.hide();
    }

    private function onInfoBlockCreateOrderBtnClickHandler(param1:ButtonEvent):void {
        requestForCreateOrderS();
    }

    private function onUseOrderBtnClickHandler(param1:ButtonEvent):void {
        requestForUseOrderS();
    }

    private function onTimerHoverRollOverHandler(param1:MouseEvent):void {
        var _loc2_:String = getLeftTimeTooltipS();
        if (_loc2_) {
            App.toolTipMgr.show(_loc2_);
        }
    }

    private function onAlertIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this._data.alertIconTooltip);
    }

    private function onQuestLinkClickHandler(param1:ButtonEvent):void {
        if (this._data) {
            openQuestS(this._data.questID);
        }
    }
}
}

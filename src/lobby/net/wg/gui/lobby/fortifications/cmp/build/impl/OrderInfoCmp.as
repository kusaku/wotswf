package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.OrderInfoVO;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class OrderInfoCmp extends UIComponentEx {

    private static const TEXT_OFFSET_NO_ICON:int = 10;

    private static const TEXT_OFFSET_ICON:int = 6;

    private static const LINK_BTN_PADDING_X:int = 5;

    private static const LINK_BTN_PADDING_Y:int = 1;

    public var infoIcon:UILoaderAlt;

    public var title:TextField;

    public var resourceIcon:OrderInfoIconCmp;

    public var description:TextField;

    public var descriptionLinkBtn:ISoundButtonEx;

    public var alertIcon:MovieClip;

    private var _model:OrderInfoVO;

    private var _descrRightMargin:Number;

    private var _descriptionLinkCallback:Function;

    public function OrderInfoCmp() {
        super();
        this._descrRightMargin = this.description.x + this.description.width;
        this.infoIcon.visible = false;
        this.alertIcon.visible = false;
        this.alertIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.descriptionLinkBtn.addEventListener(ButtonEvent.CLICK, this.onDescriptionLinkBtnClickHandler);
    }

    private static function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this.resourceIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onResourceIconRollOverHandler);
        this.resourceIcon.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.resourceIcon.dispose();
        this.resourceIcon = null;
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.alertIcon = null;
        this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onInfoIconRollOverHandler);
        this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.infoIcon.dispose();
        this.infoIcon = null;
        this.descriptionLinkBtn.removeEventListener(ButtonEvent.CLICK, this.onDescriptionLinkBtnClickHandler);
        this.descriptionLinkBtn.dispose();
        this.descriptionLinkBtn = null;
        this._descriptionLinkCallback = null;
        this.description = null;
        this.title = null;
        this._model = null;
    }

    public function setData(param1:OrderInfoVO):void {
        this._model = param1;
        if (this._model.iconSource != "") {
            this.title.htmlText = this._model.title;
            this.resourceIcon.setSource(this._model.iconSource);
            this.resourceIcon.setLevels(this._model.iconLevel);
            this.resourceIcon.setResourceCount(this._model.ordersCount);
            this.resourceIcon.visible = true;
            this.description.x = this.resourceIcon.x + this.resourceIcon.width + TEXT_OFFSET_ICON;
        }
        else {
            this.resourceIcon.visible = false;
            this.description.x = this.resourceIcon.x + TEXT_OFFSET_NO_ICON;
        }
        this.description.width = this._descrRightMargin - this.description.x;
        this.description.htmlText = this._model.description;
        this.alertIcon.visible = this._model.showAlertIcon;
        if (StringUtils.isNotEmpty(this._model.infoIconSource)) {
            this.infoIcon.source = this._model.infoIconSource;
            this.infoIcon.visible = true;
            this.infoIcon.addEventListener(MouseEvent.ROLL_OVER, this.onInfoIconRollOverHandler);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        }
        else {
            this.infoIcon.visible = false;
        }
        this.descriptionLinkBtn.visible = param1.descriptionLink;
        if (param1.descriptionLink) {
            this.descriptionLinkBtn.tooltip = TOOLTIPS.FORTIFICATION_MODERNIZATION_DESCRIPTIONLINK;
            App.utils.commons.moveDsiplObjToEndOfText(DisplayObject(this.descriptionLinkBtn), this.description, LINK_BTN_PADDING_X, LINK_BTN_PADDING_Y);
        }
        App.utils.commons.moveDsiplObjToEndOfText(this.alertIcon, this.title);
        if (this._model.orderID != -1) {
            this.resourceIcon.addEventListener(MouseEvent.ROLL_OVER, this.onResourceIconRollOverHandler);
            this.resourceIcon.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        }
    }

    public function setDescriptionLinkCallback(param1:Function):void {
        this._descriptionLinkCallback = param1;
    }

    private function onDescriptionLinkBtnClickHandler(param1:ButtonEvent):void {
        if (this._descriptionLinkCallback != null) {
            this._descriptionLinkCallback();
        }
    }

    private function onInfoIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._model.infoIconToolTip);
    }

    private function onAlertIconRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._model.alertIconTooltip)) {
            App.toolTipMgr.show(this._model.alertIconTooltip);
        }
        else {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_ORDERPOPOVER_USEORDERBTN_DEFENCEHOURDISABLED);
        }
    }

    private function onResourceIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_CONSUMABLE_ORDER, null, this._model.orderID, this._model.iconLevel);
    }
}
}

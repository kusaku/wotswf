package net.wg.gui.lobby.modulesPanel.components {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.data.Colors;
import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.lobby.modulesPanel.data.DeviceVO;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class FittingListItemRenderer extends TableRenderer {

    public var moduleType:ModuleTypesUIWithFill;

    public var titleField:TextField;

    public var errorField:TextField;

    public var priceMC:IconText;

    public var actionPrice:ActionPrice;

    public var targetMC:MovieClip;

    private var _deviceData:DeviceVO;

    private var _commons:ICommons;

    private var _tooltipMgr:ITooltipMgr;

    private var _rightOffsets:Dictionary;

    public function FittingListItemRenderer() {
        var _loc2_:DisplayObject = null;
        super();
        this._commons = App.utils.commons;
        this._tooltipMgr = App.toolTipMgr;
        _deferredDispose = true;
        this._rightOffsets = new Dictionary();
        var _loc1_:Vector.<DisplayObject> = new <DisplayObject>[this.errorField, this.priceMC, this.actionPrice, this.targetMC];
        for each(_loc2_ in _loc1_) {
            this._rightOffsets[_loc2_] = width - _loc2_.x;
        }
        _loc1_.splice(0, _loc1_.length);
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._deviceData = DeviceVO(param1);
        invalidateData();
        this.hideTooltip();
    }

    override protected function onBeforeDispose():void {
        removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.priceMC.dispose();
        this.priceMC = null;
        this.moduleType.dispose();
        this.moduleType = null;
        this.titleField = null;
        this.errorField = null;
        this.targetMC = null;
        this._deviceData = null;
        this._commons = null;
        this._tooltipMgr = null;
        App.utils.data.cleanupDynamicObject(this._rightOffsets);
        this._rightOffsets = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        preventAutoSizingBg = true;
        this.actionPrice.visible = false;
        this.moduleType.mouseEnabled = this.moduleType.mouseChildren = false;
        this.priceMC.mouseEnabled = this.priceMC.mouseChildren = false;
        this.targetMC.mouseEnabled = this.targetMC.mouseChildren = false;
        rendererBg.mouseEnabled = rendererBg.mouseChildren = false;
        this.titleField.mouseEnabled = false;
        this.errorField.mouseEnabled = false;
        addEventListener(MouseEvent.CLICK, this.onClickHandler);
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
    }

    override protected function draw():void {
        var _loc1_:* = null;
        if (isInvalid(InvalidationType.DATA)) {
            this.setup();
        }
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            for (_loc1_ in this._rightOffsets) {
                DisplayObject(_loc1_).x = width - this._rightOffsets[_loc1_];
            }
        }
    }

    protected function setup():void {
        var _loc1_:Boolean = false;
        if (this._deviceData == null) {
            return;
        }
        this.titleField.htmlText = this._deviceData.name;
        this._commons.updateTextFieldSize(this.titleField, false, true);
        App.utils.asserter.assertFrameExists(this._deviceData.moduleLabel, this.moduleType);
        this.moduleType.gotoAndStop(this._deviceData.moduleLabel);
        _loc1_ = this._deviceData.showPrice;
        this.priceMC.visible = _loc1_;
        this.actionPrice.visible = _loc1_;
        if (_loc1_) {
            this.setupPrice();
        }
        this.setupTarget();
        this.errorField.visible = !this._deviceData.isSelected && StringUtils.isNotEmpty(this._deviceData.status);
        if (this.errorField.visible) {
            this.errorField.htmlText = this._deviceData.status;
            this._commons.updateTextFieldSize(this.errorField, false, true);
        }
        this.enabled = !this._deviceData.disabled;
    }

    protected function layoutErrorField(param1:TextField):void {
        if (param1.numLines < this.errorField.numLines) {
            this.errorField.y = param1.y | 0;
        }
        else {
            this.errorField.y = param1.y + param1.height - this.errorField.height | 0;
        }
    }

    protected function showItemTooltip():void {
        this._tooltipMgr.showSpecial(this._deviceData.tooltipType, null, this._deviceData.id, this._deviceData.slotIndex);
    }

    protected function hideTooltip():void {
        this._tooltipMgr.hide();
    }

    private function setupTarget():void {
        this.targetMC.visible = this._deviceData.targetVisible;
        if (this._deviceData.targetVisible) {
            this.targetMC.gotoAndPlay(this._deviceData.target);
        }
    }

    private function setupPrice():void {
        this.actionPrice.setData(this._deviceData.actionPriceData);
        if (this.actionPrice.visible) {
            this.actionPrice.setup(this);
            if (!this._deviceData.isEnoughCurrency) {
                this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
            else {
                this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
            }
        }
        this.priceMC.visible = !this.actionPrice.visible;
        if (this.priceMC.visible) {
            this.priceMC.icon = this._deviceData.currency;
            this.priceMC.text = this._deviceData.price;
            if (!this._deviceData.isEnoughCurrency) {
                this.priceMC.textColor = Colors.ERROR_COLOR;
            }
            this.priceMC.validateNow();
        }
    }

    override public function set enabled(param1:Boolean):void {
        var _loc2_:String = ActionPrice.TEXT_COLOR_TYPE_ICON;
        if (this._deviceData != null && !this._deviceData.isEnoughCurrency) {
            _loc2_ = ActionPrice.TEXT_COLOR_TYPE_ERROR;
        }
        this.actionPrice.textColorType = _loc2_;
        super.enabled = param1;
        mouseEnabled = true;
        mouseChildren = true;
        buttonMode = enabled;
    }

    private function onClickHandler(param1:MouseEvent):void {
        this.hideTooltip();
        if (this._commons.isRightButton(param1)) {
            dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO, this._deviceData.id.toString()));
        }
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        this.showItemTooltip();
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }
}
}

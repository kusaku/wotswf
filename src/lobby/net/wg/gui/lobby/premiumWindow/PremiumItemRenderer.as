package net.wg.gui.lobby.premiumWindow {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.ComponentState;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.premiumWindow.data.PremiumItemRendererVo;

import scaleform.clik.constants.InvalidationType;

public class PremiumItemRenderer extends SoundListItemRenderer {

    public var image:UILoaderAlt = null;

    public var durationTf:TextField = null;

    public var actionPrice:ActionPrice = null;

    public var hitMC:Sprite = null;

    public var dataVO:PremiumItemRendererVo = null;

    public var bg:Sprite = null;

    public var border:MovieClip;

    public function PremiumItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        if (param1) {
            if (this.dataVO) {
                this.dataVO.dispose();
                this.dataVO = null;
            }
            this.dataVO = PremiumItemRendererVo(param1);
            this.visible = false;
            invalidateData();
        }
        super.setData(param1);
    }

    override protected function preInitialize():void {
        constraintsDisabled = true;
        preventAutosizing = true;
        super.preInitialize();
    }

    override protected function onDispose():void {
        this.image.dispose();
        this.image = null;
        this.durationTf = null;
        this.actionPrice.removeEventListener(Event.COMPLETE, this.onActionPriceRedrawCompleteHandler);
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.hitMC = null;
        this.dataVO.dispose();
        this.dataVO = null;
        this.bg = null;
        this.border = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        if (this.hitMC) {
            this.hitArea = this.hitMC;
        }
        this.durationTf.autoSize = TextFieldAutoSize.LEFT;
        this.durationTf.mouseEnabled = false;
        this.actionPrice.addEventListener(Event.COMPLETE, this.onActionPriceRedrawCompleteHandler);
        mouseEnabledOnDisabled = true;
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.DATA) && this.dataVO) {
            this.durationTf.htmlText = this.dataVO.duration;
            this.image.source = this.dataVO.image;
            this.updateActionPrice(this.dataVO.actionPrice, this.dataVO.haveMoney);
            this.enabled = selectable = this.dataVO.enabled;
            buttonMode = this.dataVO.enabled;
        }
        super.draw();
    }

    private function updateActionPrice(param1:ActionPriceVO, param2:Boolean):void {
        this.actionPrice.textColorType = !!param2 ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
        this.actionPrice.setData(param1);
        this.durationTf.x = this.bg.width - this.durationTf.width >> 1;
        this.actionPrice.setup(this);
    }

    override public function set alpha(param1:Number):void {
        if (alpha == param1) {
            return;
        }
        super.alpha = param1;
        this.border.alpha = Math.max(1, 1 / param1);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (this.actionPrice != null && this.actionPrice.visible) {
            this.actionPrice.showTooltip();
        }
        if (!param1.buttonDown && enabled) {
            setState(ComponentState.OVER);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        if (this.actionPrice != null && this.actionPrice.visible) {
            this.actionPrice.hideTooltip();
        }
        if (!param1.buttonDown && enabled) {
            setState(ComponentState.OUT);
        }
    }

    private function onActionPriceRedrawCompleteHandler(param1:Event):void {
        if (!this.actionPrice.visible) {
            return;
        }
        this.durationTf.x = this.bg.width - this.durationTf.width - this.actionPrice.hitMc.width >> 1;
        this.actionPrice.x = this.durationTf.x + this.durationTf.width + this.actionPrice.hitMc.width;
    }
}
}

package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.lobby.hangar.tcarousel.controls.CounterTFContainer;
import net.wg.gui.lobby.hangar.tcarousel.event.TankFiltersEvents;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class TankFilterCounter extends UIComponentEx {

    private static const COUNT_TEXT_INVALID:String = "count_text_invalid";

    private static const SHOW_HIDE_INVALID:String = "show_hide_invalid";

    private static const ATTENTION_INVALID:String = "attention_invalid";

    private static const SHOW_STATE:String = "show";

    private static const HIDE_STATE:String = "hide";

    private static const GLOW_BLINK_STATE:String = "blink";

    private static const GLOW_IDLE_STATE:String = "idle";

    private static const ATTENTION_STATE:String = "attention";

    public var arrow:MovieClip = null;

    public var hitMc:Sprite = null;

    public var blinkMc:MovieClip = null;

    public var countTFContainer:CounterTFContainer = null;

    public var closeButton:ButtonIconTextTransparent = null;

    private var _countText:String = "";

    private var _isShow:Boolean = false;

    private var _isAttention:Boolean = false;

    private var _lastShow:Boolean = false;

    public function TankFilterCounter() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.closeButton.addEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.hitMc.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        this.hitMc.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.blinkMc.mouseEnabled = false;
        this.blinkMc.mouseChildren = false;
        this.arrow.mouseEnabled = false;
        this.arrow.mouseChildren = false;
        mouseEnabled = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(SHOW_HIDE_INVALID) && this._isShow != this._lastShow) {
            this.hitMc.mouseEnabled = this._isShow;
            this.closeButton.mouseEnabled = this._isShow;
            gotoAndPlay(!!this._isShow ? SHOW_STATE : HIDE_STATE);
            this._lastShow = this._isShow;
        }
        if (isInvalid(InvalidationType.STATE)) {
            this.hitMc.mouseEnabled = this._isShow;
            this.closeButton.mouseEnabled = this._isShow;
        }
        if (isInvalid(ATTENTION_INVALID)) {
            if (this._isAttention) {
                this.countTFContainer.gotoAndPlay(ATTENTION_STATE);
            }
            else {
                this.countTFContainer.gotoAndStop(ATTENTION_STATE);
            }
        }
        if (isInvalid(COUNT_TEXT_INVALID) && StringUtils.isNotEmpty(this._countText)) {
            this.countTFContainer.setText(this._countText);
        }
    }

    override protected function onDispose():void {
        this.hitMc.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        this.hitMc.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.arrow = null;
        this.blinkMc = null;
        this.hitMc = null;
        this.countTFContainer.dispose();
        this.countTFContainer = null;
        this.closeButton.removeEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.closeButton.dispose();
        this.closeButton = null;
        super.onDispose();
    }

    public function blink():void {
        if (this._isShow) {
            this.blinkMc.gotoAndPlay(GLOW_BLINK_STATE);
        }
    }

    public function hide():void {
        this._isShow = false;
        this.blinkMc.gotoAndStop(GLOW_IDLE_STATE);
        invalidate(SHOW_HIDE_INVALID);
    }

    public function setCloseButtonTooltip(param1:String):void {
        this.closeButton.tooltip = param1;
    }

    public function setCount(param1:String, param2:Boolean):void {
        if (this._countText != param1) {
            this._countText = param1;
            invalidate(COUNT_TEXT_INVALID);
        }
        if (this._isAttention != param2) {
            this._isAttention = param2;
            invalidate(ATTENTION_INVALID);
        }
        this._isShow = true;
        if (this._isShow != this._lastShow) {
            invalidate(SHOW_HIDE_INVALID);
        }
    }

    private function onCloseButtonClickHandler(param1:ButtonEvent):void {
        this.hide();
        dispatchEvent(new TankFiltersEvents(TankFiltersEvents.FILTER_RESET, true));
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        if (this._isShow) {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_FILTER, null);
        }
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}

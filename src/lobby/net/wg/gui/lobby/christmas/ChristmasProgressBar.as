package net.wg.gui.lobby.christmas {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ButtonIconTransparent;
import net.wg.gui.lobby.christmas.data.ProgressBarVO;
import net.wg.gui.lobby.christmas.event.ChristmasProgressBarEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasProgressBar;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.StatusIndicator;
import scaleform.clik.events.ButtonEvent;

public class ChristmasProgressBar extends UIComponentEx implements IChristmasProgressBar {

    private static const BUTTON_PADDING:int = 8;

    private static const BUTTON_ICON_OFFSET_TOP:int = 1;

    public var giftButton:ButtonIconTransparent = null;

    public var levelText:TextField = null;

    public var progressIndicator:StatusIndicator = null;

    public var progressFlash:MovieClip = null;

    private var _levelText:String = "";

    private var _progress:Number = 0;

    private var _showFlash:Boolean = false;

    public function ChristmasProgressBar() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.giftButton.iconSource = RES_ICONS.MAPS_ICONS_CHRISTMAS_PROGRESSBAR_INFORMATION;
        this.giftButton.tooltip = TOOLTIPS.XMAS_PROGRESSBAR_RULESBUTTON;
        this.giftButton.iconOffsetTop = BUTTON_ICON_OFFSET_TOP;
        this.progressIndicator.minimum = 0;
        this.progressIndicator.maximum = 1;
        this.progressIndicator.value = 0;
        this.progressIndicator.validateNow();
        this.progressIndicator.x = -this.progressIndicator.width >> 1;
        this.progressFlash.mouseChildren = this.progressFlash.mouseEnabled = false;
        this.levelText.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.levelText.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.progressIndicator.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.progressIndicator.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.giftButton.addEventListener(ButtonEvent.CLICK, this.onGiftButtonClickHandler);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.levelText.htmlText = this._levelText;
            this.progressIndicator.value = this._progress;
            if (this._showFlash) {
                this.progressFlash.gotoAndPlay(1);
            }
            App.utils.commons.updateTextFieldSize(this.levelText);
            this.levelText.x = -this.levelText.width >> 1;
            this.giftButton.x = Math.max(this.levelText.x + this.levelText.width, this.progressIndicator.x + this.progressIndicator.width) + BUTTON_PADDING | 0;
        }
    }

    override protected function onDispose():void {
        this.giftButton.removeEventListener(ButtonEvent.CLICK, this.onGiftButtonClickHandler);
        this.levelText.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.levelText.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.progressIndicator.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.progressIndicator.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.giftButton.dispose();
        this.giftButton = null;
        this.progressIndicator.dispose();
        this.progressIndicator = null;
        this.levelText = null;
        this.progressFlash = null;
        super.onDispose();
    }

    public function getComponentForFocus():InteractiveObject {
        return this.giftButton;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        return new <InteractiveObject>[this.giftButton];
    }

    public function setData(param1:ProgressBarVO):void {
        this._levelText = param1.levelText;
        this._progress = param1.progress;
        this._showFlash = param1.showFlash;
        invalidateData();
    }

    private function onControlRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.XMAS_TREE, null, true);
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onGiftButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ChristmasProgressBarEvent(ChristmasProgressBarEvent.SHOW_RULES));
    }
}
}

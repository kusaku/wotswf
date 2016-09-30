package net.wg.gui.lobby.techtree.controls {
import flash.display.MovieClip;
import flash.events.MouseEvent;

import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.controls.SoundButton;

import scaleform.clik.constants.InvalidationType;

public class NationButton extends SoundButton {

    public var ico:MovieClip;

    public var icoAdd:MovieClip;

    public function NationButton() {
        super();
    }

    private static function hideTooltip(param1:MouseEvent):void {
        if (App.toolTipMgr != null) {
            App.toolTipMgr.hide();
        }
    }

    override protected function onBeforeDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.showTooltip, false);
        removeEventListener(MouseEvent.ROLL_OUT, hideTooltip, false);
        removeEventListener(MouseEvent.CLICK, hideTooltip, false);
        super.onBeforeDispose();
    }

    override protected function preInitialize():void {
        super.preInitialize();
        this.defineSoundProps();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.showTooltip);
        addEventListener(MouseEvent.ROLL_OUT, hideTooltip);
        addEventListener(MouseEvent.CLICK, hideTooltip);
    }

    override protected function draw():void {
        if (_baseDisposed) {
            return;
        }
        super.draw();
        if (_label != null && isInvalid(InvalidationType.DATA)) {
            if (this.ico != null) {
                this.ico.gotoAndStop(_label);
            }
            if (this.icoAdd != null) {
                this.icoAdd.gotoAndStop(_label);
            }
        }
    }

    protected function defineSoundProps():void {
        soundType = SoundTypes.TAB;
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        if (!_selected) {
            super.handleMouseRelease(param1);
        }
    }

    private function showTooltip(param1:MouseEvent):void {
        if (_label != null && !_selected) {
            if (App.toolTipMgr != null) {
                App.toolTipMgr.showComplex(App.toolTipMgr.getNewFormatter().addHeader(TOOLTIPS.techtreepage_nations(_label), true).make());
            }
        }
    }
}
}

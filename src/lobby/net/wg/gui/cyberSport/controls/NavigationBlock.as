package net.wg.gui.cyberSport.controls {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;

import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.vo.NavigationBlockVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.events.ButtonEvent;

public class NavigationBlock extends UIComponentEx {

    public var previousButton:ButtonIconTextTransparent;

    public var nextButton:ButtonIconTextTransparent;

    public var iconLoader:UILoaderAlt;

    public function NavigationBlock() {
        super();
    }

    public function setup(param1:NavigationBlockVO):void {
        this.previousButton.visible = param1.previousVisible;
        this.nextButton.visible = param1.nextVisible;
        this.previousButton.enabled = param1.previousEnabled;
        this.nextButton.enabled = param1.nextEnabled;
        this.iconLoader.source = param1.icon;
    }

    public function setInCoolDown(param1:Boolean):void {
        if (this.previousButton) {
            this.previousButton.enabled = !param1;
        }
        if (this.nextButton) {
            this.nextButton.enabled = !param1;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.previousButton.addEventListener(ButtonEvent.CLICK, this.onPreviousClick);
        this.nextButton.addEventListener(ButtonEvent.CLICK, this.onNextClick);
        this.addListeners(this.nextButton);
        this.addListeners(this.previousButton);
    }

    private function addListeners(param1:InteractiveObject):void {
        param1.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        param1.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
    }

    private function removeListeners(param1:InteractiveObject):void {
        param1.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
    }

    private function onNextClick(param1:ButtonEvent):void {
        param1.stopImmediatePropagation();
        dispatchEvent(new CSComponentEvent(CSComponentEvent.LOAD_NEXT_REQUEST));
    }

    private function onPreviousClick(param1:ButtonEvent):void {
        param1.stopImmediatePropagation();
        dispatchEvent(new CSComponentEvent(CSComponentEvent.LOAD_PREVIOUS_REQUEST));
    }

    override protected function onDispose():void {
        this.previousButton.removeEventListener(ButtonEvent.CLICK, this.onPreviousClick);
        this.nextButton.removeEventListener(ButtonEvent.CLICK, this.onNextClick);
        this.removeListeners(this.nextButton);
        this.removeListeners(this.previousButton);
        this.previousButton.dispose();
        this.nextButton.dispose();
        this.iconLoader.dispose();
        this.nextButton = null;
        this.previousButton = null;
        this.iconLoader = null;
        super.onDispose();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}

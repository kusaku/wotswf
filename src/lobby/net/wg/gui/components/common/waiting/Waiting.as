package net.wg.gui.components.common.waiting {
import net.wg.data.constants.Linkages;
import net.wg.infrastructure.base.interfaces.IWaiting;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class Waiting extends UIComponent implements IWaiting {

    private var _waitingComponent:WaitingComponent = null;

    private var _text:String = null;

    private var _backgroundAlpha:Number = 1;

    public function Waiting() {
        super();
    }

    override protected function onDispose():void {
        if (this._waitingComponent) {
            this._waitingComponent.dispose();
            this._waitingComponent = null;
        }
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateSize();
        }
    }

    public function hide():void {
        visible = false;
    }

    public function setMessage(param1:String):void {
        if (this._text != param1) {
            this._text = param1;
            this.updateMessage();
        }
    }

    public function show():void {
        visible = true;
        if (!this._waitingComponent) {
            this._waitingComponent = App.utils.classFactory.getComponent(Linkages.WAITING_COMPONENT, WaitingComponent);
            addChild(this._waitingComponent);
            this.updateBackgroundAlpha();
            this.updateSize();
            this.updateMessage();
            this._waitingComponent.validateNow();
        }
    }

    private function updateMessage():void {
        if (this._waitingComponent) {
            this._waitingComponent.setMessage(this._text);
        }
    }

    private function updateBackgroundAlpha():void {
        if (this._waitingComponent) {
            this._waitingComponent.backgroundMc.alpha = this._backgroundAlpha;
        }
    }

    private function updateSize():void {
        if (this._waitingComponent) {
            this._waitingComponent.setSize(_width, _height);
        }
    }

    public function set backgroundAlpha(param1:Number):void {
        if (this._backgroundAlpha != param1) {
            this._backgroundAlpha = param1;
            this.updateBackgroundAlpha();
        }
    }
}
}

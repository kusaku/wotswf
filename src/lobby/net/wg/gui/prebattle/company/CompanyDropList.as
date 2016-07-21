package net.wg.gui.prebattle.company {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.ComponentState;
import net.wg.gui.components.controls.ScrollingListEx;

public class CompanyDropList extends ScrollingListEx {

    private static const SHADOW_TOP_PADDING:uint = 17;

    private static const AUTHENTIC_WIDTH:uint = 245;

    private static const AUTHENTIC_HEIGHT:uint = 411;

    public var topLabel:TextField;

    public var bottomLabel:TextField;

    public var arrowMc:MovieClip;

    public function CompanyDropList() {
        super();
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        this.topLabel = null;
        this.bottomLabel = null;
        this.arrowMc = null;
        super.onDispose();
    }

    override protected function initialize():void {
        super.initialize();
        setActualSize(AUTHENTIC_WIDTH, AUTHENTIC_HEIGHT);
    }

    override protected function configUI():void {
        super.configUI();
        buttonMode = true;
        mouseEnabled = true;
        this.arrowMc.mouseEnabled = false;
        this.bottomLabel.mouseEnabled = false;
        this.topLabel.mouseEnabled = false;
        this.topLabel.text = PREBATTLE.LABELS_COMPANY_PLAYERS_TOP;
        this.bottomLabel.text = PREBATTLE.LABELS_COMPANY_PLAYERS_BOTTOM;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        addEventListener(MouseEvent.CLICK, this.onClickHandler);
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        if (!enabled) {
            return;
        }
        if (!_focused) {
            setState(ComponentState.OVER);
        }
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        if (!enabled) {
            return;
        }
        if (!_focused) {
            setState(ComponentState.OUT);
        }
    }

    private function onClickHandler(param1:MouseEvent):void {
        if (enabled) {
            return;
        }
        setState(ComponentState.DOWN);
    }

    public function replaceArrow(param1:Number):void {
        this.arrowMc.y = param1 + SHADOW_TOP_PADDING;
    }
}
}

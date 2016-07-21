package net.wg.gui.cyberSport.controls {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.gfx.TextFieldEx;

public class CandidateHeaderItemRender extends UIComponent {

    private static const LINE_PADDING:uint = 5;

    private static const LEFT_LINE_PADDING:uint = 1;

    public var headerName:TextField;

    public var leftLine:MovieClip;

    public var rightLine:MovieClip;

    private var headerToolTip:String = "";

    public function CandidateHeaderItemRender() {
        super();
        buttonMode = false;
        useHandCursor = false;
        scaleX = scaleY = 1;
        TextFieldEx.setVerticalAlign(this.headerName, TextFieldEx.VALIGN_CENTER);
    }

    public function setData(param1:String, param2:String):void {
        this.headerName.autoSize = TextFieldAutoSize.CENTER;
        this.headerName.htmlText = param1;
        if (param2 != Values.EMPTY_STR) {
            this.headerToolTip = param2;
            this.headerName.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutTextHandler);
            this.headerName.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverTextHandler);
        }
        else {
            this.headerName.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutTextHandler);
            this.headerName.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverTextHandler);
        }
    }

    public function invalidationElements():void {
        this.headerName.x = Math.round((this._width - this.headerName.width) / 2);
        this.leftLine.x = LEFT_LINE_PADDING;
        this.leftLine.width = Math.round(this.headerName.x - LINE_PADDING);
        this.rightLine.x = Math.round(this.headerName.x + this.headerName.width + LINE_PADDING);
        this.rightLine.width = Math.round(this._width - this.rightLine.x + LINE_PADDING);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.invalidationElements();
        }
    }

    override protected function onDispose():void {
        this.headerName.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutTextHandler);
        this.headerName.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverTextHandler);
        this.headerName = null;
        this.headerToolTip = null;
        this.leftLine = null;
        this.rightLine = null;
        super.onDispose();
    }

    private function onRollOutTextHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onRollOverTextHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this.headerToolTip);
    }
}
}

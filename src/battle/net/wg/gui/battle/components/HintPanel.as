package net.wg.gui.battle.components {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class HintPanel extends Sprite implements IDisposable {

    private static const TEXTFIELD_PADDING:int = 5;

    private static const GAP:int = 20;

    private static const ICON_LEFT_SIDE:int = 56;

    private static const ICON_RIGHT_SIDE:int = 56;

    public var messageLeftTF:TextField = null;

    public var messageRightTF:TextField = null;

    public var keyTF:TextField = null;

    public var buttonBgMc:MovieClip = null;

    public var bgMc:MovieClip = null;

    private var _keyValue:String = "";

    private var _messageLeft:String = "";

    private var _messageRight:String = "";

    private var _width:int = -1;

    private var _keySelected:Boolean = true;

    public function HintPanel() {
        super();
        this.keyTF.autoSize = TextFieldAutoSize.LEFT;
    }

    public final function dispose():void {
        this.keyTF = null;
        this.bgMc = null;
        this.buttonBgMc = null;
        this.messageLeftTF = null;
        this.messageRightTF = null;
    }

    public function show(param1:String, param2:String, param3:String):void {
        this._keySelected = Boolean(param1);
        if (param1 != this._keyValue) {
            this._keyValue = param1;
            if (this._keySelected) {
                this.keyTF.htmlText = param1;
                this.keyTF.width = this.keyTF.textWidth + TEXTFIELD_PADDING | 0;
                this.buttonBgMc.width = this.keyTF.width + ICON_LEFT_SIDE + ICON_RIGHT_SIDE;
            }
        }
        if (this._keySelected) {
            if (param2 != this._messageLeft) {
                this._messageLeft = param2;
                this.messageLeftTF.htmlText = param2;
                this.messageLeftTF.width = this.messageLeftTF.textWidth + TEXTFIELD_PADDING | 0;
            }
        }
        if (param3 != this._messageRight) {
            this._messageRight = param3;
            this.messageRightTF.htmlText = param3;
            this.messageRightTF.width = this.messageRightTF.textWidth + TEXTFIELD_PADDING | 0;
        }
        this.update();
        visible = true;
    }

    private function update():void {
        this.messageLeftTF.visible = this._keySelected;
        this.buttonBgMc.visible = this._keySelected;
        this.keyTF.visible = this._keySelected;
        if (this._keySelected) {
            this.messageLeftTF.x = 0;
            this.keyTF.x = this.messageLeftTF.width + GAP;
            this.messageRightTF.x = this.keyTF.x + this.keyTF.width + GAP;
            this.buttonBgMc.x = this.keyTF.x + (this.keyTF.width - this.buttonBgMc.width >> 1);
        }
        else {
            this.messageRightTF.x = 0;
        }
        this._width = this.messageRightTF.x + this.messageRightTF.width;
        this.bgMc.x = this._width - this.bgMc.width >> 1;
    }

    override public function get width():Number {
        return this._width;
    }
}
}

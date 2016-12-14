package net.wg.gui.lobby.quests.components {
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class QuestTaskDescription extends UIComponentEx {

    public var textField:TextField = null;

    private var _text:String;

    public function QuestTaskDescription() {
        super();
        this.textField.wordWrap = true;
        this.textField.autoSize = TextFieldAutoSize.LEFT;
    }

    public function get text():String {
        return this._text;
    }

    public function set text(param1:String):void {
        if (param1 == this._text) {
            return;
        }
        this._text = param1;
        invalidate(InvalidationType.DATA);
    }

    override protected function onDispose():void {
        this.textField = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc3_:Number = NaN;
        super.draw();
        var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
        var _loc2_:Boolean = isInvalid(InvalidationType.SIZE);
        if (_loc1_) {
            this.textField.htmlText = this._text;
        }
        if (_loc1_ || _loc2_) {
            _loc3_ = this.textField.y + this.textField.height;
            if (_loc3_ != _height) {
                _height = _loc3_;
                if (hasEventListener(Event.RESIZE)) {
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
    }
}
}

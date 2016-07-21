package net.wg.gui.battle.views.stats {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class BattleTipsController implements IDisposable {

    private var _titleTipTF:TextField = null;

    private var _bodyTipLeftTF:TextField = null;

    private var _bodyTipRightTF:TextField = null;

    private var _bodyTipCenterTF:TextField = null;

    public function BattleTipsController(param1:TextField, param2:TextField, param3:TextField, param4:TextField) {
        super();
        this._titleTipTF = param1;
        this._bodyTipLeftTF = param2;
        this._bodyTipRightTF = param3;
        this._bodyTipCenterTF = param4;
        TextFieldEx.setNoTranslate(param1, true);
        TextFieldEx.setNoTranslate(param2, true);
        TextFieldEx.setNoTranslate(param3, true);
        TextFieldEx.setNoTranslate(param4, true);
    }

    public function setText(param1:String, param2:String = null, param3:String = null):void {
        if (param2 && param3) {
            this._bodyTipLeftTF.autoSize = TextFieldAutoSize.LEFT;
            this._bodyTipRightTF.autoSize = TextFieldAutoSize.LEFT;
            this._titleTipTF.htmlText = param1;
            this._bodyTipLeftTF.htmlText = param2;
            this._bodyTipRightTF.htmlText = param3;
            this._titleTipTF.visible = true;
            this._bodyTipLeftTF.visible = true;
            this._bodyTipRightTF.visible = true;
            this._bodyTipCenterTF.visible = false;
        }
        else {
            this._bodyTipCenterTF.htmlText = param1;
            this._titleTipTF.visible = false;
            this._bodyTipLeftTF.visible = false;
            this._bodyTipRightTF.visible = false;
            this._bodyTipCenterTF.visible = true;
        }
    }

    public function hide():void {
        this._titleTipTF.visible = false;
        this._bodyTipLeftTF.visible = false;
        this._bodyTipRightTF.visible = false;
        this._bodyTipCenterTF.visible = false;
    }

    public function dispose():void {
        this._titleTipTF = null;
        this._bodyTipLeftTF = null;
        this._bodyTipRightTF = null;
        this._bodyTipCenterTF = null;
    }
}
}

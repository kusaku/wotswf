package net.wg.gui.lobby.header.headerButtonBar {
import flash.text.TextField;

import net.wg.gui.lobby.header.vo.HBC_PremDataVo;

import org.idmedia.as3commons.util.StringUtils;

public class HBC_Prem extends HBC_ActionItem {

    private static const TEXTS_GAP:int = -6;

    private static const MAX_FONT_SIZE:int = 14;

    private static const MIN_SCREEN_PADDING:int = 15;

    private static const ADDITIONAL_SCREEN_PADDING:int = 3;

    public var textField:TextField = null;

    private var _premVo:HBC_PremDataVo = null;

    public function HBC_Prem() {
        super();
        minScreenPadding.left = MIN_SCREEN_PADDING;
        minScreenPadding.right = MIN_SCREEN_PADDING;
        additionalScreenPadding.left = ADDITIONAL_SCREEN_PADDING;
        additionalScreenPadding.right = ADDITIONAL_SCREEN_PADDING;
        maxFontSize = MAX_FONT_SIZE;
    }

    override protected function updateSize():void {
        bounds.width = Math.max(this.textField.width, doItTextField.width) ^ 0;
        super.updateSize();
    }

    override protected function updateData():void {
        var _loc1_:int = 0;
        if (data) {
            this.textField.htmlText = this._premVo.btnLabel;
            doItTextField.visible = StringUtils.isNotEmpty(this._premVo.doLabel);
            if (doItTextField.visible) {
                doItTextField.text = this._premVo.doLabel;
            }
            if (this.isNeedUpdateFont()) {
                updateFontSize(this.textField, useFontSize);
            }
            App.utils.commons.updateTextFieldSize(this.textField, true, true);
        }
        super.updateData();
        if (this.isNeedUpdateFont()) {
            updateFontSize(doItTextField, useFontSize);
            App.utils.commons.updateTextFieldSize(doItTextField, true, false);
            needUpdateFontSize = false;
        }
        if (doItTextField.visible) {
            _loc1_ = this.textField.height + doItTextField.height + TEXTS_GAP;
            this.textField.y = height - _loc1_ >> 1;
            doItTextField.y = this.textField.y + this.textField.height + TEXTS_GAP | 0;
        }
        else {
            this.textField.y = height - this.textField.height >> 1;
        }
    }

    override protected function isDiscountEnabled():Boolean {
        return this._premVo.isHasAction;
    }

    override protected function onDispose():void {
        this._premVo = null;
        this.textField = null;
        super.onDispose();
    }

    override protected function isNeedUpdateFont():Boolean {
        return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size || useFontSize != doItTextField.getTextFormat().size;
    }

    override public function set data(param1:Object):void {
        this._premVo = HBC_PremDataVo(param1);
        super.data = param1;
    }
}
}

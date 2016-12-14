package net.wg.gui.lobby.techtree.controls {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class PremiumDescription extends UIComponentEx {

    public static const ELITE_SUFFIX:String = "_elite";

    public static const TITLE_PADDING:Number = 5;

    private var _data:ExtraInformation;

    private var textFormat:TextFormat;

    public var titleField:TextField;

    public var benefitField:TextField;

    public var contentField:TextField;

    public var typeIcon:MovieClip;

    public var premIGRBg:Sprite;

    public function PremiumDescription() {
        super();
        this.textFormat = new TextFormat();
        this.textFormat.align = TextFormatAlign.LEFT;
        this.textFormat.leading = -3;
    }

    public function setData(param1:ExtraInformation):void {
        if (param1 == null) {
            return;
        }
        this._data = param1;
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function draw():void {
        if (this._data != null && isInvalid(InvalidationType.DATA)) {
            if (this.titleField != null) {
                this.titleField.autoSize = TextFieldAutoSize.LEFT;
                this.titleField.htmlText = this._data.title != null ? this._data.title : "";
                this.titleField.setTextFormat(this.textFormat);
                this.titleField.width = this.titleField.textWidth + TITLE_PADDING;
            }
            if (this.benefitField != null) {
                this.benefitField.text = this._data.benefitsHead != null ? this._data.benefitsHead : "";
            }
            if (this.contentField != null) {
                this.contentField.multiline = true;
                this.contentField.wordWrap = true;
                this.contentField.autoSize = TextFieldAutoSize.LEFT;
                this.contentField.htmlText = this._data.benefitsList != null ? this._data.benefitsList : "";
            }
            if (this.typeIcon != null) {
                this.typeIcon.gotoAndStop(this._data.type + ELITE_SUFFIX);
            }
            if (this.premIGRBg != null) {
                this.premIGRBg.visible = this._data.isPremiumIgr;
            }
        }
        super.draw();
    }
}
}

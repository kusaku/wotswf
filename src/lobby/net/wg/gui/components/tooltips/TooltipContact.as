package net.wg.gui.components.tooltips {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.tooltips.VO.ContactTooltipVO;
import net.wg.gui.components.tooltips.helpers.Utils;
import net.wg.gui.messenger.controls.ContactStatusIndicator;

public class TooltipContact extends ToolTipSpecial {

    public static const STATUS_TITLE_GAP:int = 10;

    private static const MIN_BACKGROUND_WDTH:int = 322;

    private static const MIN_BACKGROUND_HEIGHT:int = 80;

    public function TooltipContact() {
        super();
    }

    override protected function redraw():void {
        var _loc5_:uint = 0;
        var _loc6_:int = 0;
        var _loc7_:TextField = null;
        var _loc8_:TextField = null;
        var _loc9_:TextFormat = null;
        var _loc1_:ContactTooltipVO = new ContactTooltipVO(_data);
        var _loc2_:ContactStatusIndicator = content.statusIndicator;
        var _loc3_:TextField = content.title;
        var _loc4_:Number = contentMargin.left + bgShadowMargin.left;
        _loc2_.x = _loc4_;
        _loc2_.setLinkage(Linkages.TOOLTIP_USER_STATUS_PREFIX);
        _loc2_.showOfflineIndicator = true;
        _loc2_.update(_loc1_);
        _loc3_.autoSize = TextFieldAutoSize.LEFT;
        _loc3_.htmlText = Utils.instance.htmlWrapper(App.utils.commons.getFullPlayerName(_loc1_.userPropsVO), Utils.instance.COLOR_HEADER, 18, "$TitleFont") + "<br/>" + Utils.instance.htmlWrapper(_loc1_.statusDescription, Utils.instance.COLOR_NORMAL, 14, "$FieldFont");
        _loc3_.x = _loc2_.x + _loc2_.width + STATUS_TITLE_GAP;
        separators = new Vector.<Separator>(0);
        topPosition = content.y + content.height;
        topPosition = topPosition + Utils.instance.MARGIN_AFTER_BLOCK;
        if (_loc1_.units) {
            this.addSeparatorWithMargin();
            _loc5_ = _loc1_.units.length;
            _loc6_ = 0;
            while (_loc6_ < _loc5_) {
                _loc7_ = this.createTextField(_loc4_);
                _loc7_.htmlText = _loc1_.units[_loc6_];
                content.addChild(_loc7_);
                topPosition = topPosition + _loc7_.height;
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_BLOCK;
                if (_loc6_ < _loc5_ - 1) {
                    this.addSeparatorWithMargin();
                }
                _loc6_++;
            }
        }
        if (_loc1_.note) {
            this.addSeparatorWithMargin();
            _loc8_ = this.createTextField(_loc4_);
            _loc9_ = new TextFormat();
            _loc8_.htmlText = Utils.instance.htmlWrapper(_loc1_.note, Utils.instance.COLOR_NORMAL_DARK, 14, "$FieldFont");
            _loc9_.align = TextFormatAlign.CENTER;
            _loc8_.setTextFormat(_loc9_);
            content.addChild(_loc8_);
        }
        super.redraw();
    }

    override protected function updateSize():void {
        super.updateSize();
        background.width = Math.max(MIN_BACKGROUND_WDTH, background.width);
        background.height = Math.max(MIN_BACKGROUND_HEIGHT, background.height);
    }

    private function createTextField(param1:int):TextField {
        var _loc2_:TextField = App.textMgr.createTextField();
        _loc2_.y = topPosition;
        _loc2_.x = param1;
        _loc2_.multiline = true;
        _loc2_.wordWrap = true;
        _loc2_.autoSize = TextFieldAutoSize.LEFT;
        _loc2_.width = content.width - param1;
        return _loc2_;
    }

    private function addSeparatorWithMargin():Separator {
        var _loc1_:Separator = null;
        _loc1_ = Utils.instance.createSeparate(content);
        _loc1_.y = topPosition ^ 0;
        _loc1_.x = width - _loc1_.width >> 1;
        separators.push(_loc1_);
        topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
        return _loc1_;
    }
}
}

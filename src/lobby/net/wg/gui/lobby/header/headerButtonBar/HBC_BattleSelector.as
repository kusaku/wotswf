package net.wg.gui.lobby.header.headerButtonBar {
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.header.LobbyHeader;
import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;

import scaleform.clik.constants.InvalidationType;

public class HBC_BattleSelector extends HeaderButtonContentItem {

    private static const MAX_TEXT_WIDTH_NARROW_SCREEN:int = 104;

    private static const MAX_TEXT_WIDTH_WIDE_SCREEN:int = 40;

    private static const MAX_TEXT_WIDTH_MAX_SCREEN:int = 500;

    public var textField:TextField = null;

    public var icon:UILoaderAlt = null;

    public var arrow:HBC_ArrowDown = null;

    private var _battleTypeVo:HBC_BattleTypeVo = null;

    private var _iconWidth:Number = 0;

    public function HBC_BattleSelector() {
        super();
        minScreenPadding.left = 10;
        minScreenPadding.right = 10;
        additionalScreenPadding.left = 0;
        additionalScreenPadding.right = 4;
        maxFontSize = 14;
        hideDisplayObjList.push(this.icon);
        this.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        this.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
    }

    override public function onPopoverClose():void {
        this.arrow.state = HBC_ArrowDown.STATE_NORMAL;
    }

    override public function onPopoverOpen():void {
        this.arrow.state = HBC_ArrowDown.STATE_UP;
    }

    override protected function updateSize():void {
        bounds.width = this.arrow.x + this.arrow.width;
        super.updateSize();
    }

    override protected function updateData():void {
        var _loc1_:Number = NaN;
        if (data) {
            this.icon.source = this._battleTypeVo.battleTypeIcon;
            this.textField.x = this._battleTypeVo.battleTypeIcon && this.icon.visible ? !!this._iconWidth ? Number(this.icon.x + this._iconWidth) : Number(this.icon.x + this.icon.width + ICON_MARGIN) : Number(0);
            _loc1_ = -this.textField.x;
            switch (screen) {
                case LobbyHeader.NARROW_SCREEN:
                    _loc1_ = _loc1_ + MAX_TEXT_WIDTH_NARROW_SCREEN;
                    break;
                case LobbyHeader.WIDE_SCREEN:
                    _loc1_ = _loc1_ + (MAX_TEXT_WIDTH_NARROW_SCREEN + wideScreenPrc * MAX_TEXT_WIDTH_WIDE_SCREEN);
                    break;
                case LobbyHeader.MAX_SCREEN:
                    _loc1_ = _loc1_ + (MAX_TEXT_WIDTH_NARROW_SCREEN + wideScreenPrc * MAX_TEXT_WIDTH_WIDE_SCREEN + maxScreenPrc * MAX_TEXT_WIDTH_MAX_SCREEN);
            }
            if (availableWidth > 0) {
                _loc1_ = availableWidth - (TEXT_FIELD_MARGIN + ARROW_MARGIN + this.textField.x + this.arrow.width);
            }
            this.textField.width = _loc1_;
            if (this.isNeedUpdateFont()) {
                updateFontSize(this.textField, useFontSize);
                needUpdateFontSize = false;
            }
            App.utils.commons.formatPlayerName(this.textField, App.utils.commons.getUserProps(this._battleTypeVo.battleTypeName));
            this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
            this.arrow.x = this.textField.x + this.textField.width + ARROW_MARGIN ^ 0;
        }
        super.updateData();
    }

    override protected function isNeedUpdateFont():Boolean {
        return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size;
    }

    override protected function onDispose():void {
        this.icon.removeEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        this.icon.removeEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
        this._battleTypeVo = null;
        this.textField.filters = null;
        this.textField = null;
        this.icon.dispose();
        this.icon = null;
        this.arrow.dispose();
        this.arrow = null;
        super.onDispose();
    }

    override public function set data(param1:Object):void {
        this._battleTypeVo = HBC_BattleTypeVo(param1);
        if (!this._battleTypeVo.battleTypeIcon) {
            this._iconWidth = 0;
        }
        super.data = param1;
    }

    private function onIconLoadIOErrorHandler(param1:UILoaderEvent):void {
        this._iconWidth = 0;
        invalidate(InvalidationType.DATA, InvalidationType.SIZE);
    }

    private function onIconLoadCompleteHandler(param1:UILoaderEvent):void {
        this._iconWidth = param1.target.width;
        invalidate(InvalidationType.DATA, InvalidationType.SIZE);
    }
}
}

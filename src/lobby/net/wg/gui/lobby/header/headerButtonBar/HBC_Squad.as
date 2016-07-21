package net.wg.gui.lobby.header.headerButtonBar {
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;

import scaleform.clik.constants.InvalidationType;

public class HBC_Squad extends HeaderButtonContentItem {

    private static const ICON_ARROW_GAP:int = 3;

    private static const TEXT_ARROW_GAP:int = 14;

    private static const ARROW_RIGHT_PADDING:int = 4;

    public var arrow:HBC_ArrowDown = null;

    public var textField:TextField = null;

    public var icon:UILoaderAlt = null;

    private var _squadDataVo:HBC_SquadDataVo = null;

    public function HBC_Squad() {
        super();
        minScreenPadding.left = 13;
        minScreenPadding.right = 11;
        additionalScreenPadding.left = 4;
        additionalScreenPadding.right = -2;
        maxFontSize = 14;
        hideDisplayObjList.push(this.icon);
    }

    override public function onPopoverClose():void {
        this.arrow.state = HBC_ArrowDown.STATE_NORMAL;
    }

    override public function onPopoverOpen():void {
        this.arrow.state = HBC_ArrowDown.STATE_UP;
    }

    override protected function configUI():void {
        super.configUI();
        this.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        this.icon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
    }

    override protected function updateSize():void {
        if (this._squadDataVo.isEvent) {
            bounds.width = this.arrow.x + this.arrow.width + ARROW_RIGHT_PADDING;
        }
        else {
            bounds.width = !!this.icon.visible ? Number(this.icon.x + this.icon.width) : Number(this.textField.x + this.textField.width);
        }
        super.updateSize();
    }

    override protected function updateData():void {
        if (data) {
            this.textField.text = this._squadDataVo.buttonName;
        }
        else {
            this.textField.text = MENU.HEADERBUTTONS_BTNLABEL_CREATESQUAD;
        }
        if (this.isNeedUpdateFont()) {
            updateFontSize(this.textField, useFontSize);
            needUpdateFontSize = false;
        }
        this.icon.source = this._squadDataVo.icon;
        this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
        if (this.icon.visible) {
            this.icon.x = this.textField.width + ICON_MARGIN ^ 0;
            this.arrow.x = this.icon.x + this.icon.width + ICON_ARROW_GAP ^ 0;
        }
        else {
            this.arrow.x = this.textField.x + this.textField.textWidth + TEXT_ARROW_GAP ^ 0;
        }
        this.arrow.visible = this._squadDataVo.isEvent;
        super.updateData();
    }

    override protected function onDispose():void {
        this.icon.removeEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        this.textField = null;
        this.icon.dispose();
        this.icon = null;
        this._squadDataVo = null;
        this.arrow.dispose();
        this.arrow = null;
        super.onDispose();
    }

    override protected function isNeedUpdateFont():Boolean {
        return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size;
    }

    override public function set data(param1:Object):void {
        this._squadDataVo = HBC_SquadDataVo(param1);
        super.data = param1;
    }

    private function onIconLoadCompleteHandler(param1:UILoaderEvent):void {
        invalidate(InvalidationType.DATA, InvalidationType.SIZE);
    }
}
}

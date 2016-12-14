package net.wg.gui.lobby.header.itemSelectorPopover {
import flash.display.MovieClip;
import flash.events.MouseEvent;

import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.Values;
import net.wg.gui.components.assets.interfaces.INewIndicator;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.events.ItemSelectorRendererEvent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Constraints;

public class ItemSelectorRenderer extends SoundListItemRenderer {

    private static const ICON_DISABLED_ALPHA:Number = 0.5;

    public var newIndicator:INewIndicator = null;

    public var hitAreaA:MovieClip = null;

    public var icon:UILoaderAlt = null;

    public var specialBg:UILoaderAlt = null;

    private var dataVo:ItemSelectorRendererVO;

    private var _active:Boolean = false;

    public function ItemSelectorRenderer() {
        super();
        soundType = SoundTypes.RNDR_NORMAL;
        scaleX = scaleY = 1;
        this.newIndicator.visible = false;
        this.newIndicator.mouseChildren = false;
        this.hitArea = this.hitAreaA;
    }

    private static function onMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onMousePressHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.textField.multiline = true;
        this.textField.wordWrap = false;
        mouseEnabledOnDisabled = true;
        if (!constraintsDisabled) {
            constraints.addElement(this.icon.name, this.icon, Constraints.LEFT | Constraints.TOP);
        }
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_DOWN, onMousePressHandler, false, 0, true);
        addEventListener(ButtonEvent.CLICK, this.onButtonClickHandler, false, 0, true);
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.DATA) && data) {
            this.enabled = !this.dataVo.disabled;
        }
        super.draw();
        if (isInvalid(InvalidationType.DATA) && data) {
            this.applyData(this.dataVo);
        }
    }

    override protected function updateAfterStateChange():void {
        super.updateAfterStateChange();
        if (!constraintsDisabled && this.icon) {
            constraints.updateElement(this.icon.name, this.icon);
        }
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
        removeEventListener(MouseEvent.MOUSE_DOWN, onMousePressHandler);
        removeEventListener(ButtonEvent.CLICK, this.onButtonClickHandler);
        this.newIndicator.dispose();
        this.newIndicator = null;
        this.hitAreaA = null;
        this.specialBg.dispose();
        this.specialBg = null;
        this.icon.dispose();
        this.icon = null;
        this.dataVo = null;
        super.onDispose();
    }

    override protected function updateText():void {
        if (_label != null && textField != null) {
            textField.htmlText = _label;
            App.utils.commons.updateTextFieldSize(this.textField, false);
            this.textField.y = height - this.textField.height >> 1;
            textField.alpha = !!enabled ? Number(1) : Number(ICON_DISABLED_ALPHA);
        }
    }

    private function applyData(param1:ItemSelectorRendererVO):void {
        var _loc2_:Boolean = false;
        this.active = param1.active;
        _label = param1.label;
        this.updateText();
        if (this.newIndicator) {
            _loc2_ = param1.isNew && !param1.disabled;
            if (this.newIndicator.visible != _loc2_) {
                this.newIndicator.visible = _loc2_;
                this.updateNewAnimation(_loc2_);
            }
        }
        this.icon.visible = param1.icon && param1.icon != Values.EMPTY_STR;
        this.icon.source = param1.icon;
        if (param1.specialBgIcon != Values.EMPTY_STR) {
            this.specialBg.source = param1.specialBgIcon;
        }
    }

    private function updateNewAnimation(param1:Boolean):void {
        preventAutosizing = true;
        if (param1) {
            this.newIndicator.shine();
        }
        else {
            this.newIndicator.pause();
        }
    }

    override public function set data(param1:Object):void {
        super.data = param1;
        this.dataVo = ItemSelectorRendererVO(data);
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        this.icon.alpha = !!param1 ? Number(1) : Number(ICON_DISABLED_ALPHA);
    }

    public function get active():Boolean {
        return this._active;
    }

    public function set active(param1:Boolean):void {
        this._active = param1;
        selected = param1;
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        dispatchEvent(new ItemSelectorRendererEvent(ItemSelectorRendererEvent.RENDERER_OVER, true, false, this.dataVo.data));
    }

    private function onButtonClickHandler(param1:ButtonEvent):void {
        if (!enabled) {
            return;
        }
        dispatchEvent(new ItemSelectorRendererEvent(ItemSelectorRendererEvent.RENDERER_CLICK, true));
    }
}
}

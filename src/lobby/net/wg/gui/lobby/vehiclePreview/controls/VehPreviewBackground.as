package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.Sprite;

import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class VehPreviewBackground extends UIComponentEx {

    public var separator:Sprite = null;

    public var bitmaps:Sprite = null;

    private var _backHitArea:Sprite = null;

    public function VehPreviewBackground() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        if (this.separator != null) {
            this._backHitArea = new Sprite();
            addChild(this._backHitArea);
            this.separator.hitArea = this._backHitArea;
            this.separator.mouseChildren = this.separator.mouseEnabled = false;
        }
    }

    override protected function onDispose():void {
        if (this._backHitArea != null) {
            removeChild(this._backHitArea);
            this._backHitArea = null;
        }
        if (this.separator != null) {
            this.separator.hitArea = null;
            this.separator = null;
        }
        this.bitmaps = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.bitmaps.width = width;
            if (this.separator != null) {
                this.separator.width = width;
            }
        }
    }
}
}

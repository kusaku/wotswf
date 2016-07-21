package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.Sprite;

import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class VehPreviewBackground extends UIComponentEx {

    public var separator:Sprite;

    public var bitmaps:Sprite;

    private var _backHitArea:Sprite;

    public function VehPreviewBackground() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._backHitArea = new Sprite();
        addChild(this._backHitArea);
        this.separator.hitArea = this._backHitArea;
        this.separator.mouseChildren = this.separator.mouseEnabled = false;
    }

    override protected function onDispose():void {
        removeChild(this._backHitArea);
        this._backHitArea = null;
        this.separator.hitArea = null;
        this.separator = null;
        this.bitmaps = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.bitmaps.width = width;
            this.separator.width = width;
        }
    }
}
}

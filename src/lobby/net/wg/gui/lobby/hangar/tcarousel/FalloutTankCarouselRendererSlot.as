package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.Sprite;

public class FalloutTankCarouselRendererSlot extends TankCarouselRendererSlot {

    public var falloutSelect:Sprite = null;

    public var falloutArrowHover:Sprite = null;

    public var falloutArrow:Sprite = null;

    public function FalloutTankCarouselRendererSlot() {
        super();
        this.falloutSelect.visible = false;
        this.falloutArrow.visible = false;
        this.falloutArrowHover.visible = false;
    }

    override public function hideAllContent():void {
        super.hideAllContent();
        this.falloutSelect.visible = false;
        this.falloutArrowHover.visible = false;
        this.falloutArrow.visible = false;
    }

    override protected function onDispose():void {
        this.falloutSelect = null;
        this.falloutArrowHover = null;
        this.falloutArrow = null;
        super.onDispose();
    }

    public function updateFalloutData(param1:Boolean, param2:Boolean):void {
        this.falloutSelect.visible = param1;
        if (!param1) {
            this.falloutArrow.visible = param2;
            this.falloutArrowHover.visible = param2;
        }
        else {
            this.falloutArrow.visible = false;
            this.falloutArrowHover.visible = false;
        }
    }
}
}

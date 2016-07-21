package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.Sprite;

import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;

public class TankCarouselRendererSlot extends SoundButtonEx {

    private static const LOCK_BG_ALIAS:String = "bgDisPattern";

    private static const LOCK_BG_REPEAT:String = "all";

    public var tankIcon:TankIcon = null;

    public var icon:Image = null;

    public var lockBg:BitmapFill = null;

    public var background:Sprite = null;

    public function TankCarouselRendererSlot() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
        this.lockBg.widthFill = this.background.width;
        this.lockBg.heightFill = this.background.height;
        this.lockBg.repeat = LOCK_BG_REPEAT;
        this.lockBg.source = LOCK_BG_ALIAS;
        this.lockBg.visible = false;
    }

    override protected function setState(param1:String):void {
        super.setState(param1);
        validateNow();
    }

    override protected function onDispose():void {
        this.icon.dispose();
        this.icon = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.lockBg.dispose();
        this.lockBg = null;
        this.background = null;
        super.onDispose();
    }

    public function hideAllContent():void {
        this.icon.visible = false;
        this.tankIcon.visible = false;
        this.lockBg.visible = false;
    }

    public function setIcon(param1:String):void {
        this.icon.visible = true;
        this.tankIcon.visible = false;
        this.icon.source = param1;
    }

    public function updateData(param1:VehicleCarouselVO):void {
        this.icon.visible = false;
        this.tankIcon.visible = true;
        this.tankIcon.setVehicleCarouselVO(param1.getTankIconVO());
        this.tankIcon.validateNow();
        this.lockBg.visible = param1.lockBackground;
    }
}
}

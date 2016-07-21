package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.MovieClip;
import flash.geom.Rectangle;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
import net.wg.infrastructure.base.UIComponentEx;

public class PopoverBuildingTexture extends UIComponentEx implements IBuildingTexture {

    public var iconLoader:UILoaderAlt = null;

    public function PopoverBuildingTexture() {
        super();
    }

    override protected function onDispose():void {
        this.iconLoader.dispose();
        this.iconLoader = null;
        super.onDispose();
    }

    public function getBuildingShape():MovieClip {
        return null;
    }

    public function setBuildingShapeBounds(param1:Rectangle):void {
    }

    public function setIconOffsets(param1:Number, param2:Number):void {
        this.iconLoader.x = param1;
        this.iconLoader.y = param2;
    }

    public function setState(param1:String):void {
        this.iconLoader.source = param1;
    }
}
}

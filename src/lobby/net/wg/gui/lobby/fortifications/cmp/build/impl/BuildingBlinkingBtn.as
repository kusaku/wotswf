package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;

import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class BuildingBlinkingBtn extends MovieClip implements IDisposable {

    public var buildingTexture:IBuildingTexture;

    public function BuildingBlinkingBtn() {
        super();
    }

    public function dispose():void {
        this.buildingTexture = null;
    }

    public function setIconOffsets(param1:Number, param2:Number):void {
        this.buildingTexture.setIconOffsets(param1, param2);
    }

    public function setState(param1:String):void {
        this.buildingTexture.setState(param1);
    }
}
}

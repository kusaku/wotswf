package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Rectangle;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
import net.wg.infrastructure.base.UIComponentEx;

public class BuildingTexture extends UIComponentEx implements IBuildingTexture {

    public var buildingShape:MovieClip = null;

    public var buildingLoader:UILoaderAlt = null;

    public function BuildingTexture() {
        super();
        this.buildingShape.mouseChildren = this.buildingShape.mouseEnabled = false;
        this.buildingShape.visible = false;
    }

    override protected function onDispose():void {
        this.buildingShape = null;
        if (this.buildingLoader.hasEventListener(UILoaderEvent.COMPLETE)) {
            this.buildingLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onBuildingLoaderCompleteHandler);
        }
        this.buildingLoader.dispose();
        this.buildingLoader = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.buildingLoader.addEventListener(UILoaderEvent.COMPLETE, this.onBuildingLoaderCompleteHandler);
    }

    public function getBuildingShape():MovieClip {
        return this.buildingShape;
    }

    public function setBuildingShapeBounds(param1:Rectangle):void {
        this.buildingShape.x = param1.x;
        this.buildingShape.y = param1.y;
        this.buildingShape.width = param1.width;
        this.buildingShape.height = param1.height;
    }

    public function setIconOffsets(param1:Number, param2:Number):void {
        this.buildingLoader.x = param1;
        this.buildingLoader.y = param2;
    }

    public function setState(param1:String):void {
        this.buildingLoader.source = param1;
    }

    private function onBuildingLoaderCompleteHandler(param1:UILoaderEvent):void {
        this.buildingLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onBuildingLoaderCompleteHandler);
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}

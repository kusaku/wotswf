package net.wg.gui.components.crosshairPanel.components.gunMarker {
import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
import net.wg.infrastructure.base.SimpleContainer;

public class GunMarkerMixing extends SimpleContainer implements IGunMarkerMixing {

    public function GunMarkerMixing() {
        super();
    }

    public function setReloadingState(param1:String):void {
    }

    public function setReloadingAsPercent(param1:Number):void {
        var _loc2_:int = GunMarkerConsts.MIXING_PROGRESS_TOTAL_FRAMES_COUNT * param1;
        gotoAndStop(_loc2_);
    }

    override protected function onDispose():void {
        super.onDispose();
    }
}
}

package net.wg.gui.components.crosshairPanel.components.gunMarker {
import flash.filters.ColorMatrixFilter;

public class GunMarkerDebug extends GunMarker implements IGunMarker {

    protected var devModeFilterMatrix:Array;

    protected var devModeColorFilter:ColorMatrixFilter;

    public function GunMarkerDebug() {
        this.devModeFilterMatrix = [2, 0.2, 0.2, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.3, 2, 0.8, 0, 0, 0, 1, 1, 0];
        this.devModeColorFilter = new ColorMatrixFilter(this.devModeFilterMatrix);
        super();
        radiusMC.filters = [this.devModeColorFilter];
    }

    override protected function onDispose():void {
        this.devModeFilterMatrix.splice(0);
        this.devModeFilterMatrix = null;
        super.onDispose();
    }
}
}

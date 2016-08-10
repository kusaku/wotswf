package net.wg.gui.lobby.vehiclePreview.controls {
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.interfaces.IContentSize;

public class VehPreviewInfoViewStack extends ViewStack implements IContentSize {

    public function VehPreviewInfoViewStack() {
        super();
    }

    public function get contentWidth():Number {
        return currentView != null ? Number(currentView.width) : Number(0);
    }

    public function get contentHeight():Number {
        return currentView != null ? Number(currentView.height) : Number(0);
    }
}
}

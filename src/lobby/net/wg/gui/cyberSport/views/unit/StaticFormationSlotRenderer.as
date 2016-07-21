package net.wg.gui.cyberSport.views.unit {
import net.wg.gui.components.controls.UILoaderAlt;

public class StaticFormationSlotRenderer extends SlotRenderer {

    public var legionnaireIcon:UILoaderAlt;

    public function StaticFormationSlotRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        addTooltipSubscriber(this.legionnaireIcon);
    }

    override protected function onDispose():void {
        removeTooltipSubscriber(this.legionnaireIcon);
        this.legionnaireIcon.dispose();
        this.legionnaireIcon = null;
        super.onDispose();
    }
}
}

package net.wg.gui.settings {
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;

public class SettingsSniperForm extends SettingsArcadeForm {

    public var zoomIndicatorLabel:LabelControl = null;

    public var zoomIndicatorValue:LabelControl = null;

    public var zoomIndicatorSlider:Slider = null;

    public function SettingsSniperForm() {
        super();
    }

    override protected function onDispose():void {
        this.zoomIndicatorLabel.dispose();
        this.zoomIndicatorLabel = null;
        this.zoomIndicatorValue.dispose();
        this.zoomIndicatorValue = null;
        this.zoomIndicatorSlider.dispose();
        this.zoomIndicatorSlider = null;
        super.onDispose();
    }

    override protected function disableAllControls():void {
        super.disableAllControls();
        this.zoomIndicatorLabel.enabled = false;
        this.zoomIndicatorValue.enabled = false;
        this.zoomIndicatorSlider.enabled = false;
    }
}
}

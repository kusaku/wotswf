package net.wg.gui.settings {
import net.wg.gui.components.controls.BorderShadowScrollPane;

import scaleform.clik.core.UIComponent;

public class AdvancedGraphicSettingsForm extends UIComponent {

    private static const PANE_WIDTH:Number = 800;

    private static const PANE_HEIGHT:Number = 398;

    public var scrollPane:BorderShadowScrollPane;

    public var content:AdvancedGraphicContentForm;

    protected var _data:Object = null;

    public function AdvancedGraphicSettingsForm() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.scrollPane.setSize(PANE_WIDTH, PANE_HEIGHT);
        this.content = this.scrollPane.target as AdvancedGraphicContentForm;
    }

    override protected function onDispose():void {
        this.content = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        super.onDispose();
    }
}
}

package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class ResearchPanelMeta extends BaseDAAPIComponent {

    public var goToResearch:Function;

    public function ResearchPanelMeta() {
        super();
    }

    public function goToResearchS():void {
        App.utils.asserter.assertNotNull(this.goToResearch, "goToResearch" + Errors.CANT_NULL);
        this.goToResearch();
    }
}
}

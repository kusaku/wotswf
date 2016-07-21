package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class QuestRecruitWindowMeta extends AbstractWindowView {

    public var onApply:Function;

    public function QuestRecruitWindowMeta() {
        super();
    }

    public function onApplyS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.onApply, "onApply" + Errors.CANT_NULL);
        this.onApply(param1);
    }
}
}

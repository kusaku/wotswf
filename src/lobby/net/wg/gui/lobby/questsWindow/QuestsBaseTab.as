package net.wg.gui.lobby.questsWindow {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.meta.IQuestsTabMeta;
import net.wg.infrastructure.base.meta.impl.QuestsTabMeta;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsBaseTab extends QuestsTabMeta implements IQuestsTabMeta {

    public function QuestsBaseTab() {
        super();
    }

    public function as_setSelectedQuest(param1:String):void {
        throw new AbstractException("as_setSelectedQuest" + Errors.ABSTRACT_INVOKE);
    }
}
}

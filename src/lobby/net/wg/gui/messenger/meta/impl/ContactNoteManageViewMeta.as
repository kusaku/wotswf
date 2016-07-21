package net.wg.gui.messenger.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.messenger.views.BaseManageContactView;

public class ContactNoteManageViewMeta extends BaseManageContactView {

    public var sendData:Function;

    public function ContactNoteManageViewMeta() {
        super();
    }

    public function sendDataS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.sendData, "sendData" + Errors.CANT_NULL);
        this.sendData(param1);
    }
}
}

package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class SendInvitesWindowMeta extends AbstractWindowView {

    public var showError:Function;

    public var setOnlineFlag:Function;

    public var sendInvites:Function;

    public var getAllAvailableContacts:Function;

    public function SendInvitesWindowMeta() {
        super();
    }

    public function showErrorS(param1:String):void {
        App.utils.asserter.assertNotNull(this.showError, "showError" + Errors.CANT_NULL);
        this.showError(param1);
    }

    public function setOnlineFlagS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.setOnlineFlag, "setOnlineFlag" + Errors.CANT_NULL);
        this.setOnlineFlag(param1);
    }

    public function sendInvitesS(param1:Array, param2:String):void {
        App.utils.asserter.assertNotNull(this.sendInvites, "sendInvites" + Errors.CANT_NULL);
        this.sendInvites(param1, param2);
    }

    public function getAllAvailableContactsS():Array {
        App.utils.asserter.assertNotNull(this.getAllAvailableContacts, "getAllAvailableContacts" + Errors.CANT_NULL);
        return this.getAllAvailableContacts();
    }
}
}

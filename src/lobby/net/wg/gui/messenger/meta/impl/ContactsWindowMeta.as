package net.wg.gui.messenger.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class ContactsWindowMeta extends AbstractWindowView {

    public var searchContact:Function;

    public var addToFriends:Function;

    public var addToIgnored:Function;

    public var isEnabledInRoaming:Function;

    public function ContactsWindowMeta() {
        super();
    }

    public function searchContactS(param1:String):void {
        App.utils.asserter.assertNotNull(this.searchContact, "searchContact" + Errors.CANT_NULL);
        this.searchContact(param1);
    }

    public function addToFriendsS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.addToFriends, "addToFriends" + Errors.CANT_NULL);
        this.addToFriends(param1, param2);
    }

    public function addToIgnoredS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.addToIgnored, "addToIgnored" + Errors.CANT_NULL);
        this.addToIgnored(param1, param2);
    }

    public function isEnabledInRoamingS(param1:Number):Boolean {
        App.utils.asserter.assertNotNull(this.isEnabledInRoaming, "isEnabledInRoaming" + Errors.CANT_NULL);
        return this.isEnabledInRoaming(param1);
    }
}
}

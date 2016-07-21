package net.wg.gui.messenger.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.SmartPopOverView;

public class ContactsListPopoverMeta extends SmartPopOverView {

    public var addToFriends:Function;

    public var addToIgnored:Function;

    public var isEnabledInRoaming:Function;

    public var changeGroup:Function;

    public var copyIntoGroup:Function;

    public function ContactsListPopoverMeta() {
        super();
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

    public function changeGroupS(param1:Number, param2:String, param3:Object):void {
        App.utils.asserter.assertNotNull(this.changeGroup, "changeGroup" + Errors.CANT_NULL);
        this.changeGroup(param1, param2, param3);
    }

    public function copyIntoGroupS(param1:Number, param2:Object):void {
        App.utils.asserter.assertNotNull(this.copyIntoGroup, "copyIntoGroup" + Errors.CANT_NULL);
        this.copyIntoGroup(param1, param2);
    }
}
}

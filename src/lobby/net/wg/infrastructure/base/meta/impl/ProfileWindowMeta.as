package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class ProfileWindowMeta extends AbstractWindowView {

    public var userAddFriend:Function;

    public var userAddToClan:Function;

    public var userSetIgnored:Function;

    public var userCreatePrivateChannel:Function;

    public function ProfileWindowMeta() {
        super();
    }

    public function userAddFriendS():void {
        App.utils.asserter.assertNotNull(this.userAddFriend, "userAddFriend" + Errors.CANT_NULL);
        this.userAddFriend();
    }

    public function userAddToClanS():void {
        App.utils.asserter.assertNotNull(this.userAddToClan, "userAddToClan" + Errors.CANT_NULL);
        this.userAddToClan();
    }

    public function userSetIgnoredS():void {
        App.utils.asserter.assertNotNull(this.userSetIgnored, "userSetIgnored" + Errors.CANT_NULL);
        this.userSetIgnored();
    }

    public function userCreatePrivateChannelS():void {
        App.utils.asserter.assertNotNull(this.userCreatePrivateChannel, "userCreatePrivateChannel" + Errors.CANT_NULL);
        this.userCreatePrivateChannel();
    }
}
}

package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class MessengerBarMeta extends BaseDAAPIComponent {

    public var channelButtonClick:Function;

    public var contactsButtonClick:Function;

    public function MessengerBarMeta() {
        super();
    }

    public function channelButtonClickS():void {
        App.utils.asserter.assertNotNull(this.channelButtonClick, "channelButtonClick" + Errors.CANT_NULL);
        this.channelButtonClick();
    }

    public function contactsButtonClickS():void {
        App.utils.asserter.assertNotNull(this.contactsButtonClick, "contactsButtonClick" + Errors.CANT_NULL);
        this.contactsButtonClick();
    }
}
}

package net.wg.gui.lobby.messengerBar {
import flash.display.DisplayObject;

import net.wg.gui.components.controls.IconTextBigButton;
import net.wg.infrastructure.base.meta.IContactsListButtonMeta;
import net.wg.infrastructure.base.meta.impl.ContactsListButtonMeta;
import net.wg.infrastructure.interfaces.IPopOverCaller;

import scaleform.clik.constants.InvalidationType;

public class ContactsListButton extends ContactsListButtonMeta implements IContactsListButtonMeta, IPopOverCaller {

    public var contactsButton:IconTextBigButton = null;

    private var _contactsCount:int = 0;

    public function ContactsListButton() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.contactsButton.tooltip = TOOLTIPS.LOBY_MESSENGER_CONTACTS_BUTTON;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.contactsButton.label = this._contactsCount > 0 ? this._contactsCount.toString() : "";
        }
    }

    public function as_setContactsCount(param1:Number):void {
        this._contactsCount = param1;
        invalidateData();
    }

    public function getTargetButton():DisplayObject {
        return this.contactsButton;
    }

    public function getHitArea():DisplayObject {
        return this.contactsButton;
    }
}
}

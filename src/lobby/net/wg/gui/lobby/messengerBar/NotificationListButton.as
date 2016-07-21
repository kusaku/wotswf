package net.wg.gui.lobby.messengerBar {
import flash.display.DisplayObject;

import net.wg.data.Aliases;
import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.advanced.BlinkingButton;
import net.wg.gui.lobby.messengerBar.interfaces.INotificationListButton;
import net.wg.infrastructure.base.meta.impl.NotificationListButtonMeta;

import scaleform.clik.events.ButtonEvent;

public class NotificationListButton extends NotificationListButtonMeta implements INotificationListButton {

    public var button:BlinkingButton;

    public function NotificationListButton() {
        super();
    }

    public function getTargetButton():DisplayObject {
        return this.button;
    }

    public function getHitArea():DisplayObject {
        return this.button;
    }

    public function as_setState(param1:Boolean):void {
        if (this.button.blinking != param1) {
            this.button.blinking = param1;
        }
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(ButtonEvent.CLICK, this.btnClickHandler, false, 0, true);
        this.button.tooltip = TOOLTIPS.LOBY_MESSENGER_SERVICE_BUTTON;
        this.button.soundType = SoundTypes.MESSANGER_BTN;
    }

    override protected function draw():void {
        super.draw();
    }

    override protected function onDispose():void {
        removeEventListener(ButtonEvent.CLICK, this.btnClickHandler);
        this.button.dispose();
        this.button = null;
        super.onDispose();
    }

    private function btnClickHandler(param1:ButtonEvent):void {
        handleClickS();
        App.popoverMgr.show(this, Aliases.NOTIFICATIONS_LIST);
    }
}
}

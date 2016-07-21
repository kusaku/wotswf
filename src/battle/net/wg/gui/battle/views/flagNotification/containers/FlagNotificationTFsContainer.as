package net.wg.gui.battle.views.flagNotification.containers {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FlagNotificationTFsContainer extends Sprite implements IDisposable {

    public var messageTF:TextField;

    public var flagCapturedTF:TextField;

    public var flagDeliveredTF:TextField;

    public var flagAbsorbedTF:TextField;

    public function FlagNotificationTFsContainer() {
        super();
    }

    public function dispose():void {
        this.messageTF = null;
        this.flagCapturedTF = null;
        this.flagDeliveredTF = null;
        this.flagAbsorbedTF = null;
    }
}
}

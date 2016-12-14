package net.wg.gui.lobby.sellDialog {
import flash.text.TextField;

import net.wg.gui.components.controls.IconText;
import net.wg.infrastructure.base.UIComponentEx;

public class MovingResult extends UIComponentEx {

    public var creditsIT:IconText;

    public var text:TextField;

    public function MovingResult() {
        super();
    }

    override protected function configUI():void {
        this.text.text = DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL;
        this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
    }
}
}

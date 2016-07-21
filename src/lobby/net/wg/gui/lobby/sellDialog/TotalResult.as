package net.wg.gui.lobby.sellDialog {
import flash.text.TextField;

import net.wg.gui.components.controls.IconText;
import net.wg.infrastructure.base.UIComponentEx;

public class TotalResult extends UIComponentEx {

    private static const PADDING_NEXT_BLOCK:int = 25;

    public var headerTF:TextField;

    public var creditsIT:IconText;

    public var goldIT:IconText;

    public function TotalResult() {
        super();
    }

    override protected function configUI():void {
        this.headerTF.text = DIALOGS.VEHICLESELLDIALOG_COMMONRESULT;
        this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        this.goldIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
    }

    override protected function onDispose():void {
        this.creditsIT.dispose();
        this.goldIT.dispose();
        this.creditsIT = null;
        this.headerTF = null;
        this.goldIT = null;
        super.onDispose();
    }

    public function getSize():int {
        return this.headerTF.y + this.headerTF.height + PADDING_NEXT_BLOCK;
    }
}
}

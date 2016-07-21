package net.wg.gui.lobby.sellDialog {
import flash.display.MovieClip;

import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.IconText;
import net.wg.infrastructure.base.UIComponentEx;

public class SettingsButton extends UIComponentEx {

    public var setingsDropBtn:CheckBox = null;

    public var creditsIT:IconText = null;

    public var ddLine:MovieClip = null;

    public function SettingsButton() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:String = App.utils.locale.makeString(DIALOGS.BUYVEHICLEDIALOG_EXPANDBTNLABEL);
        _loc1_ = App.utils.toUpperOrLowerCase(_loc1_, true);
        this.setingsDropBtn.label = _loc1_;
        this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
    }

    override protected function onDispose():void {
        this.setingsDropBtn.dispose();
        this.setingsDropBtn = null;
        this.creditsIT.dispose();
        this.creditsIT = null;
        this.ddLine = null;
        super.onDispose();
    }
}
}

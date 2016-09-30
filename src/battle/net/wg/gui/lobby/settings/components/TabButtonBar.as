package net.wg.gui.lobby.settings.components {
import net.wg.gui.components.advanced.ButtonBarEx;

import scaleform.clik.controls.Button;

public class TabButtonBar extends ButtonBarEx {

    public function TabButtonBar() {
        super();
    }

    override protected function populateRendererData(param1:Button, param2:uint):void {
        var _loc3_:Object = _dataProvider.requestItemAt(param2);
        if (_loc3_ && _loc3_.hasOwnProperty("image")) {
            (param1 as SettingsTabButton).iconSource(_loc3_["image"]);
        }
        super.populateRendererData(param1, param2);
    }
}
}

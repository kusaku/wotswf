package net.wg.gui.lobby.settings.components {
import net.wg.gui.components.advanced.ButtonBarEx;

import scaleform.clik.controls.Button;

public class RadioButtonBar extends ButtonBarEx {

    private static const SUPPORTED:String = "supported";

    public function RadioButtonBar() {
        super();
    }

    override protected function populateRendererData(param1:Button, param2:uint):void {
        var _loc3_:Object = _dataProvider.requestItemAt(param2);
        if (_loc3_ && _loc3_.hasOwnProperty(SUPPORTED)) {
            param1.enabled = _loc3_[SUPPORTED];
        }
        super.populateRendererData(param1, param2);
    }
}
}

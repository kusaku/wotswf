package net.wg.gui.lobby.fallout.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class SelectorWindowBtnStatesVO extends DAAPIDataClass {

    public var dominationBtnEnabled:Boolean = false;

    public var multiteamBtnEnabled:Boolean = false;

    public var closeBtnEnabled:Boolean = false;

    public var autoSquadCheckboxEnabled:Boolean = false;

    public function SelectorWindowBtnStatesVO(param1:Object) {
        super(param1);
    }
}
}

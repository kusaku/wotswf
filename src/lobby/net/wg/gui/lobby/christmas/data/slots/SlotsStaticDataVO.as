package net.wg.gui.lobby.christmas.data.slots {
import net.wg.data.daapi.base.DAAPIDataClass;

public class SlotsStaticDataVO extends DAAPIDataClass {

    public var isHeaderEnabled:Boolean = false;

    public var isRulesVisible:Boolean = false;

    public var isTabsVisible:Boolean = false;

    public var isConversionBtnVisible:Boolean = false;

    public function SlotsStaticDataVO(param1:Object) {
        super(param1);
    }
}
}

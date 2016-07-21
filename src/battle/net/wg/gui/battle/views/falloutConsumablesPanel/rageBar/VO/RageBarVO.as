package net.wg.gui.battle.views.falloutConsumablesPanel.rageBar.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class RageBarVO extends DAAPIDataClass {

    public var maxValue:Number = 0;

    public var curValue:Number = 0;

    public var rageBar_x_offset:int = 0;

    public var rageBar_y_offset:int = 0;

    public function RageBarVO(param1:Object) {
        super(param1);
    }
}
}

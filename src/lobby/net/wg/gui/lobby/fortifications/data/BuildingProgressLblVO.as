package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class BuildingProgressLblVO extends DAAPIDataClass {

    public var totalValue:String = "";

    public var currentValueFormatter:String = "";

    public var currentValue:String = "";

    public var separator:String = "";

    public function BuildingProgressLblVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.totalValue = null;
        this.currentValueFormatter = null;
        this.currentValue = null;
        this.separator = null;
        super.onDispose();
    }
}
}

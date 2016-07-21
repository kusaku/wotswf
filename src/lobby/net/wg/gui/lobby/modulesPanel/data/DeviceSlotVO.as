package net.wg.gui.lobby.modulesPanel.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DeviceSlotVO extends DAAPIDataClass {

    public var slotType:String = "";

    public var slotIndex:int = -1;

    public var tooltip:String = "";

    public var tooltipType:String = "";

    public var id:Number = NaN;

    public var level:int = -1;

    public var removable:Boolean = false;

    public var moduleLabel:String = "";

    public var extraModuleInfo:String = "";

    public function DeviceSlotVO(param1:Object) {
        super(param1);
    }
}
}

package net.wg.gui.lobby.modulesPanel.data {
public class ModuleVO extends DeviceVO {

    public var level:int = -1;

    public var paramValues:String = "";

    public var paramNames:String = "";

    public var extraModuleInfo:String = "";

    public function ModuleVO(param1:Object) {
        super(param1);
    }
}
}

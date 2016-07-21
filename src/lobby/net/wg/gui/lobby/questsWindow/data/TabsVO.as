package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class TabsVO extends DAAPIDataClass {

    private static const TABS_FIELD_NAME:String = "tabs";

    public var tabs:Vector.<TabDataVO> = null;

    public function TabsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case TABS_FIELD_NAME:
                this.tabs = Vector.<TabDataVO>(App.utils.data.convertVOArrayToVector(param1, param2, TabDataVO));
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        var _loc1_:TabDataVO = null;
        if (this.tabs != null) {
            for each(_loc1_ in this.tabs) {
                _loc1_.dispose();
            }
            this.tabs.fixed = false;
            this.tabs.splice(0, this.tabs.length);
            this.tabs = null;
        }
        super.onDispose();
    }
}
}

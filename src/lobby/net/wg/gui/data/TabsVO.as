package net.wg.gui.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;

public class TabsVO extends DAAPIDataClass {

    private static const TABS_FIELD_NAME:String = "tabs";

    public var tabs:Array = null;

    public function TabsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        switch (param1) {
            case TABS_FIELD_NAME:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, TABS_FIELD_NAME + Errors.CANT_NULL);
                this.tabs = [];
                for each(_loc4_ in _loc3_) {
                    this.tabs.push(new TabDataVO(_loc4_));
                }
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
            this.tabs.splice(0, this.tabs.length);
            this.tabs = null;
        }
        super.onDispose();
    }
}
}

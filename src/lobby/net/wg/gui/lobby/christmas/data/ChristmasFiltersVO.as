package net.wg.gui.lobby.christmas.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.SimpleRendererVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ChristmasFiltersVO extends DAAPIDataClass {

    private static const ITEMS_FIELD_NAME:String = "items";

    public var label:String = "";

    public var items:Array = null;

    public function ChristmasFiltersVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == ITEMS_FIELD_NAME && param2 != null) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, param1 + Errors.CANT_NULL);
            this.items = [];
            for each(_loc4_ in _loc3_) {
                this.items.push(new SimpleRendererVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        if (this.items != null) {
            for each(_loc1_ in this.items) {
                _loc1_.dispose();
            }
            this.items.splice(0, this.items.length);
            this.items = null;
        }
        super.onDispose();
    }
}
}

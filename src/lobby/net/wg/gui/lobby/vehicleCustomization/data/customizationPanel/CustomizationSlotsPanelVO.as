package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationSlotsPanelVO extends DAAPIDataClass {

    private static const RENDERERS_GROUPS_DATA:String = "data";

    private var _groups:Vector.<CustomizationSlotsGroupVO> = null;

    public function CustomizationSlotsPanelVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:Object = null;
        if (param1 == RENDERERS_GROUPS_DATA) {
            this._groups = new Vector.<CustomizationSlotsGroupVO>();
            _loc3_ = 0;
            _loc4_ = param2.length;
            _loc5_ = null;
            _loc3_ = 0;
            while (_loc3_ < _loc4_) {
                _loc5_ = param2[_loc3_];
                this._groups.push(new CustomizationSlotsGroupVO(_loc5_));
                _loc3_++;
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:int = 0;
        var _loc2_:int = this._groups.length;
        _loc1_ = 0;
        while (_loc1_ < _loc2_) {
            this._groups[_loc1_].dispose();
            _loc1_++;
        }
        this._groups.splice(0, _loc2_);
        this._groups = null;
        super.onDispose();
    }

    public function get groups():Vector.<CustomizationSlotsGroupVO> {
        return this._groups;
    }

    public function set groups(param1:Vector.<CustomizationSlotsGroupVO>):void {
        this._groups = param1;
    }
}
}

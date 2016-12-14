package net.wg.gui.lobby.christmas.data.slots {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class SlotsDataVO extends DAAPIDataClass {

    private static const SLOTS_FIELD_NAME:String = "slots";

    public var slots:Vector.<SlotVO> = null;

    public function SlotsDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        if (param1 == SLOTS_FIELD_NAME) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, param1 + Errors.CANT_NULL);
            _loc4_ = _loc3_.length;
            this.slots = new Vector.<SlotVO>(_loc4_, true);
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                this.slots[_loc5_] = new SlotVO(_loc3_[_loc5_]);
                _loc5_++;
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        if (this.slots != null) {
            for each(_loc1_ in this.slots) {
                _loc1_.dispose();
            }
            this.slots.fixed = false;
            this.slots.splice(0, this.slots.length);
            this.slots = null;
        }
        super.onDispose();
    }

    public function updateSlotData(param1:SlotVO):Boolean {
        var _loc2_:SlotVO = null;
        var _loc3_:int = this.slots.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = this.slots[_loc4_];
            if (_loc2_.slotId == param1.slotId) {
                _loc2_.dispose();
                this.slots[_loc4_] = param1;
                return true;
            }
            _loc4_++;
        }
        return false;
    }
}
}

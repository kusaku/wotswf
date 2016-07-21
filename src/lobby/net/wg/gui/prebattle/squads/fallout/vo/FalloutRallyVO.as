package net.wg.gui.prebattle.squads.fallout.vo {
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.gui.rally.vo.RallyVO;

public class FalloutRallyVO extends RallyVO {

    public function FalloutRallyVO(param1:Object) {
        super(param1);
    }

    override protected function initSlotsVO(param1:Object):void {
        var _loc3_:Object = null;
        var _loc4_:FalloutRallySlotVO = null;
        slots = new Vector.<IRallySlotVO>();
        var _loc2_:Array = param1 as Array;
        for each(_loc3_ in _loc2_) {
            _loc4_ = new FalloutRallySlotVO(_loc3_);
            slots.push(_loc4_);
        }
    }
}
}

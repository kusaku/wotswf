package net.wg.gui.cyberSport.views.unit {
import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.interfaces.IRallySlotVO;

public class StaticRallyUnitSlotHelper extends UnitSlotHelper {

    public function StaticRallyUnitSlotHelper() {
        super();
    }

    override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO):void {
        super.updateComponents(param1, param2);
        var _loc3_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
        _loc3_.slotLabel.visible = true;
    }
}
}

package net.wg.gui.cyberSport.views.unit {
import flash.events.Event;

import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSlotsVO;
import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
import net.wg.gui.rally.interfaces.IRallySlotVO;

public class StaticFormationTeamSection extends CyberSportTeamSectionBase {

    public function StaticFormationTeamSection() {
        super();
    }

    override protected function getSlotVO(param1:Object):IRallySlotVO {
        return new LegionariesSlotsVO(param1);
    }

    override protected function getSlotHelper():ISlotRendererHelper {
        return new StaticFormationUnitSlotHelper();
    }

    private function onModeChangeBtnSelect(param1:Event):void {
    }
}
}

package net.wg.gui.cyberSport.views.unit {
import flash.display.InteractiveObject;

import net.wg.gui.cyberSport.views.respawn.UnitSlotButtonProperties;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.interfaces.IRallySlotVO;

public class StaticFormationUnitSlotHelper extends UnitSlotHelper {

    private var _removeBtnProps:UnitSlotButtonProperties;

    public function StaticFormationUnitSlotHelper() {
        super();
        this._removeBtnProps = new UnitSlotButtonProperties({
            "x": 255,
            "width": 23
        });
    }

    override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null):void {
        super.onControlRollOver(param1, param2, param3, param4);
        if (param3 != null) {
            if (param1 == StaticFormationSlotRenderer(param2).legionnaireIcon) {
                App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_STATICFORMATION_LEGIONNAIRE);
            }
        }
    }

    override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO):void {
        super.updateComponents(param1, param2);
        var _loc3_:LegionariesCandidateVO = LegionariesCandidateVO(param2.player);
        var _loc4_:Boolean = false;
        if (param2 != null && param2.player != null) {
            _loc4_ = _loc3_.isLegionaries;
        }
        StaticFormationSlotRenderer(param1).legionnaireIcon.visible = _loc4_;
    }

    override protected function get removeBtnProps():UnitSlotButtonProperties {
        return this._removeBtnProps;
    }
}
}

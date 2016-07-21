package net.wg.gui.lobby.fortifications.cmp.battleRoom {
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.rally.controls.RallyLockableSlotRenderer;

public class SortieSlot extends RallyLockableSlotRenderer {

    public var showTakePlaceBtn:Boolean = true;

    public function SortieSlot() {
        super();
    }

    override public function setStatus(param1:int):String {
        var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
        if (param1 < STATUSES.length && param1) {
            _loc2_ = STATUSES[param1];
        }
        statusIndicator.status = _loc2_;
        return _loc2_;
    }

    override protected function configUI():void {
        super.configUI();
        takePlaceFirstTimeBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
        if (takePlaceBtn) {
            takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
        }
    }

    public function get takePlaceFirstTimeBtnTyped():ButtonIconTextTransparent {
        return ButtonIconTextTransparent(takePlaceFirstTimeBtn);
    }

    public function set takePlaceFirstTimeBtnTyped(param1:ButtonIconTextTransparent):void {
        takePlaceFirstTimeBtn = param1;
    }
}
}

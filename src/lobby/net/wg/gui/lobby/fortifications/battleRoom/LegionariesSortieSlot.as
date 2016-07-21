package net.wg.gui.lobby.fortifications.battleRoom {
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;

public class LegionariesSortieSlot extends SortieSlot {

    private static const ICON_PADDING:uint = 10;

    public var legionariesIcon:UILoaderAlt = null;

    public function LegionariesSortieSlot() {
        super();
        if (this.legionariesIcon != null) {
            this.legionariesIcon.visible = false;
        }
    }

    override protected function configUI():void {
        super.configUI();
        addTooltipSubscriber(this.legionariesIcon);
    }

    override protected function onDispose():void {
        removeTooltipSubscriber(this.legionariesIcon);
        this.legionariesIcon.dispose();
        this.legionariesIcon = null;
        super.onDispose();
    }

    override public function updateComponents():void {
        super.updateComponents();
        if (this.legionariesIcon == null) {
            return;
        }
        if (slotData && slotData.player && LegionariesCandidateVO(slotData.player).isLegionaries) {
            this.legionariesIcon.visible = true;
            this.legionariesIcon.mouseEnabled = true;
            this.legionariesIcon.x = slotLabel.x + slotLabel.textWidth + ICON_PADDING;
        }
        else {
            this.legionariesIcon.mouseEnabled = false;
            this.legionariesIcon.visible = false;
        }
    }
}
}

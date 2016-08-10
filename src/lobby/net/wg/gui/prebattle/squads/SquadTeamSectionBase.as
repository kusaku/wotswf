package net.wg.gui.prebattle.squads {
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.views.room.BaseTeamSection;

public class SquadTeamSectionBase extends BaseTeamSection {

    public var slot0:IRallySimpleSlotRenderer;

    public var slot1:IRallySimpleSlotRenderer;

    public var slot2:IRallySimpleSlotRenderer;

    public function SquadTeamSectionBase() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        btnFight.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_BTNFIGHT;
        btnNotReady.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_BTNNOTREADY;
    }

    override protected function onDispose():void {
        this.slot0 = null;
        this.slot1 = null;
        this.slot2 = null;
        super.onDispose();
    }

    override protected function getMembersStr():String {
        return MESSENGER.DIALOGS_SQUADCHANNEL_MEMBERS;
    }
}
}

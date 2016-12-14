package net.wg.gui.lobby.christmas.controls.slots {
import net.wg.gui.lobby.christmas.interfaces.IChristmasDroppableSlot;

public class ChristmasTankSlots extends ChristmasCustomizationSlots {

    public var slot1:IChristmasDroppableSlot = null;

    public var slot2:IChristmasDroppableSlot = null;

    public var slot3:IChristmasDroppableSlot = null;

    public var slot4:IChristmasDroppableSlot = null;

    public function ChristmasTankSlots() {
        super();
        addSlots(this.slot1, this.slot2, this.slot3, this.slot4);
        addDropActors(this.slot1, this.slot2, this.slot3, this.slot4);
    }
}
}

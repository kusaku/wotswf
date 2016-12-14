package net.wg.gui.lobby.christmas.controls.slots {
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.christmas.data.slots.CustomizationStaticDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;

public class ChristmasCustomizationSlots extends ChristmasSlots {

    public var backIcon:UILoaderAlt = null;

    public function ChristmasCustomizationSlots() {
        super();
    }

    override public function setStaticData(param1:SlotsStaticDataVO):void {
        super.setStaticData(param1);
        this.backIcon.source = CustomizationStaticDataVO(param1).backIcon;
    }

    override protected function onDispose():void {
        this.backIcon.dispose();
        this.backIcon = null;
        super.onDispose();
    }
}
}

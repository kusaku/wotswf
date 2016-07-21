package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class DamagePanelMeta extends BattleDisplayable {

    public var clickToTankmanIcon:Function;

    public var clickToDeviceIcon:Function;

    public var clickToFireIcon:Function;

    public var getTooltipData:Function;

    public function DamagePanelMeta() {
        super();
    }

    public function clickToTankmanIconS(param1:String):void {
        App.utils.asserter.assertNotNull(this.clickToTankmanIcon, "clickToTankmanIcon" + Errors.CANT_NULL);
        this.clickToTankmanIcon(param1);
    }

    public function clickToDeviceIconS(param1:String):void {
        App.utils.asserter.assertNotNull(this.clickToDeviceIcon, "clickToDeviceIcon" + Errors.CANT_NULL);
        this.clickToDeviceIcon(param1);
    }

    public function clickToFireIconS():void {
        App.utils.asserter.assertNotNull(this.clickToFireIcon, "clickToFireIcon" + Errors.CANT_NULL);
        this.clickToFireIcon();
    }

    public function getTooltipDataS(param1:String, param2:String):String {
        App.utils.asserter.assertNotNull(this.getTooltipData, "getTooltipData" + Errors.CANT_NULL);
        return this.getTooltipData(param1, param2);
    }
}
}

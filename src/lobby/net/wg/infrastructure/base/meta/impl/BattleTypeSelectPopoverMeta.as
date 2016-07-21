package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.SmartPopOverView;

public class BattleTypeSelectPopoverMeta extends SmartPopOverView {

    public var selectFight:Function;

    public var demoClick:Function;

    public var getTooltipData:Function;

    public function BattleTypeSelectPopoverMeta() {
        super();
    }

    public function selectFightS(param1:String):void {
        App.utils.asserter.assertNotNull(this.selectFight, "selectFight" + Errors.CANT_NULL);
        this.selectFight(param1);
    }

    public function demoClickS():void {
        App.utils.asserter.assertNotNull(this.demoClick, "demoClick" + Errors.CANT_NULL);
        this.demoClick();
    }

    public function getTooltipDataS(param1:String):String {
        App.utils.asserter.assertNotNull(this.getTooltipData, "getTooltipData" + Errors.CANT_NULL);
        return this.getTooltipData(param1);
    }
}
}

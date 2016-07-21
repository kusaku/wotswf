package net.wg.gui.lobby.fallout.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class SelectorWindowStaticDataVO extends DAAPIDataClass {

    private static const TOOLTIP_DATA:String = "tooltipData";

    public var windowTitle:String = "";

    public var headerTitleStr:String = "";

    public var headerDescStr:String = "";

    public var dominationBattleTitleStr:String = "";

    public var dominationBattleDescStr:String = "";

    public var dominationBattleBtnStr:String = "";

    public var multiteamTitleStr:String = "";

    public var multiteamDescStr:String = "";

    public var multiteamBattleBtnStr:String = "";

    public var multiteamAutoSquadEnabled:Boolean = false;

    public var multiteamAutoSquadLabel:String = "";

    public var tooltipData:FalloutBattleSelectorTooltipVO = null;

    public var bgImg:String = "";

    public function SelectorWindowStaticDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == TOOLTIP_DATA) {
            this.tooltipData = new FalloutBattleSelectorTooltipVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.tooltipData.dispose();
        this.tooltipData = null;
        super.onDispose();
    }
}
}

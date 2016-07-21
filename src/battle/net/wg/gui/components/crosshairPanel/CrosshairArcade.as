package net.wg.gui.components.crosshairPanel {
public class CrosshairArcade extends CrosshairBase {

    private static const CASSETE_POSITION_ARCADE:Number = -1;

    private static const CASSETE_POSITION_SNIPER:Number = 13;

    private static const CASSETE_POSITION_PANZER:Number = -11;

    private static const CASSETE_POSITION_DASHED:Number = 0;

    private var cassetteDict:Object;

    public function CrosshairArcade() {
        this.cassetteDict = {
            "type0": CASSETE_POSITION_ARCADE,
            "type1": CASSETE_POSITION_SNIPER,
            "type2": CASSETE_POSITION_PANZER,
            "type3": CASSETE_POSITION_DASHED
        };
        super();
    }

    override protected function updateNetType():void {
        super.updateNetType();
        cassetteMC.y = this.cassetteDict[_netType];
    }

    override protected function onDispose():void {
        this.cassetteDict = null;
        super.onDispose();
    }
}
}

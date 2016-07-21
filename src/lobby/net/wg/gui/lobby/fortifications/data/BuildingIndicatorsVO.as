package net.wg.gui.lobby.fortifications.data {
public class BuildingIndicatorsVO extends BuildingPopoverBaseVO {

    private static const HP_PROGRESS_LABELS:String = "hpProgressLabels";

    private static const DEFRES_PROGRESS_LABELS:String = "defResProgressLabels";

    public var hpLabel:String = "";

    public var defResLabel:String = "";

    public var hpCurrentValue:int = -1;

    public var hpTotalValue:int = -1;

    public var defResCurrentValue:int = -1;

    public var defResTotalValue:int = -1;

    public var defResCompensationValue:int = -1;

    public var hpProgressLabels:BuildingProgressLblVO;

    public var defResProgressLabels:BuildingProgressLblVO;

    public function BuildingIndicatorsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == HP_PROGRESS_LABELS) {
            this.hpProgressLabels = new BuildingProgressLblVO(param2);
            return false;
        }
        if (param1 == DEFRES_PROGRESS_LABELS) {
            this.defResProgressLabels = new BuildingProgressLblVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.hpProgressLabels) {
            this.hpProgressLabels.dispose();
            this.hpProgressLabels = null;
        }
        if (this.defResProgressLabels) {
            this.defResProgressLabels.dispose();
            this.defResProgressLabels = null;
        }
        this.hpLabel = null;
        this.defResLabel = null;
        super.onDispose();
    }
}
}

package net.wg.gui.lobby.fortifications.data {
public class BuildingPopoverActionVO extends BuildingPopoverBaseVO {

    public var toolTipData:String = "";

    public var currentState:int = -1;

    public var orderTimer:String = "";

    public var timeOver:String = "";

    public var generalLabel:String = "";

    public var actionButtonLbl:String = "";

    public var enableActionButton:Boolean = true;

    public var productionInPause:Boolean = false;

    public var pauseReasonTooltip:Array;

    public function BuildingPopoverActionVO(param1:Object) {
        this.pauseReasonTooltip = [];
        super(param1);
    }
}
}

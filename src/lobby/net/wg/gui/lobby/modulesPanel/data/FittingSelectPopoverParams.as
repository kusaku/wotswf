package net.wg.gui.lobby.modulesPanel.data {
public class FittingSelectPopoverParams {

    private var _slotType:String;

    private var _slotIndex:int;

    public function FittingSelectPopoverParams(param1:String, param2:int = -1) {
        super();
        this._slotType = param1;
        this._slotIndex = param2;
    }

    public function get slotType():String {
        return this._slotType;
    }

    public function get slotIndex():int {
        return this._slotIndex;
    }
}
}

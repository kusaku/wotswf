package net.wg.gui.lobby.fortifications.data {
import net.wg.gui.lobby.window.ConfirmItemWindowBaseVO;

public class ConfirmOrderVO extends ConfirmItemWindowBaseVO {

    public var level:int = -1;

    public var productionTime:int = -1;

    public var productionCost:int = -1;

    public var maxAvailableCount:Number;

    public function ConfirmOrderVO(param1:Object) {
        super(param1);
    }
}
}

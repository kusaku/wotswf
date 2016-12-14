package net.wg.gui.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class AwardWindowTakeNextBtnVO extends DAAPIDataClass {

    public var isTakeNextBtnEnabled:Boolean = false;

    public var takeNextBtnLabel:String = "";

    public var christmasTakeNextBtnLabel:String = "";

    public function AwardWindowTakeNextBtnVO(param1:Object) {
        super(param1);
    }
}
}

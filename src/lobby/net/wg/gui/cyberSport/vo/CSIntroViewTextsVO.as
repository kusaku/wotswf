package net.wg.gui.cyberSport.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CSIntroViewTextsVO extends DAAPIDataClass {

    public var titleLblText:String = "";

    public var descrLblText:String = "";

    public var listRoomTitleLblText:String = "";

    public var listRoomDescrLblText:String = "";

    public var listRoomBtnLabel:String = "";

    public var autoTitleLblText:String = "";

    public var autoDescrLblText:String = "";

    public var vehicleBtnTitleTfText:String = "";

    public var regulationsInfoText:String = "";

    public var regulationsInfoTooltip:String = "";

    public function CSIntroViewTextsVO(param1:Object) {
        super(param1);
    }

    override public function isEquals(param1:DAAPIDataClass):Boolean {
        var _loc2_:CSIntroViewTextsVO = param1 as CSIntroViewTextsVO;
        if (!_loc2_) {
            return false;
        }
        return this.titleLblText == _loc2_.titleLblText && this.descrLblText == _loc2_.descrLblText && this.listRoomTitleLblText == _loc2_.listRoomTitleLblText && this.listRoomDescrLblText == _loc2_.listRoomDescrLblText && this.listRoomBtnLabel == _loc2_.listRoomBtnLabel && this.autoTitleLblText == _loc2_.autoTitleLblText && this.autoDescrLblText == _loc2_.autoDescrLblText && this.vehicleBtnTitleTfText == _loc2_.vehicleBtnTitleTfText && this.regulationsInfoText == _loc2_.regulationsInfoText && this.regulationsInfoTooltip == _loc2_.regulationsInfoTooltip;
    }
}
}

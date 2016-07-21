package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationRadioRendererVO;

public class CarouselInitVO extends DAAPIDataClass {

    private static const DURATION_TYPE:String = "durationType";

    public var icoPurchased:String = "";

    public var icoFilter:String = "";

    public var durationSelectIndex:int = -1;

    public var onlyPurchased:Boolean = false;

    public var message:String = "";

    public var fitterTooltip:String = "";

    public var chbPurchasedTooltip:String = "";

    private var _durationType:Vector.<CustomizationRadioRendererVO> = null;

    public function CarouselInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        if (param1 == DURATION_TYPE) {
            this._durationType = new Vector.<CustomizationRadioRendererVO>();
            _loc3_ = {};
            for each(_loc3_ in param2) {
                this._durationType.push(new CustomizationRadioRendererVO(_loc3_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:int = 0;
        var _loc2_:int = this._durationType.length;
        _loc1_ = 0;
        while (_loc1_ < _loc2_) {
            this._durationType[_loc1_].dispose();
            _loc1_++;
        }
        this._durationType.splice(0, this._durationType.length);
        this._durationType = null;
        super.onDispose();
    }

    public function get durationType():Vector.<CustomizationRadioRendererVO> {
        return this._durationType;
    }
}
}

package net.wg.gui.lobby.vehicleCustomization.data.panels {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationBonusRendererVO extends DAAPIDataClass {

    private static const ANIMATION:String = "animationPanel";

    public var bonusName:String = "";

    public var bonusIcon:String = "";

    public var bonusType:String = "";

    private var _animation:AnimationBonusVO = null;

    public function CustomizationBonusRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ANIMATION) {
            this._animation = new AnimationBonusVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    public function get animation():AnimationBonusVO {
        return this._animation;
    }
}
}

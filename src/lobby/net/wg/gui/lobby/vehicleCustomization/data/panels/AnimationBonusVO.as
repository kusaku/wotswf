package net.wg.gui.lobby.vehicleCustomization.data.panels {
import net.wg.data.daapi.base.DAAPIDataClass;

public class AnimationBonusVO extends DAAPIDataClass {

    public var value1:String = "";

    public var value2:String = "";

    public var animationType:String = "";

    public var install:Boolean = false;

    public var color:String = "";

    public function AnimationBonusVO(param1:Object) {
        super(param1);
    }
}
}

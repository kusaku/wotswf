package net.wg.gui.cyberSport.controls.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CSAnimationVO extends DAAPIDataClass {

    public var animationType:String = "";

    public var leavesOldSource:String = "";

    public var leavesNewSource:String = "";

    public var ribbonOldSource:String = "";

    public var ribbonNewSource:String = "";

    public var divisionOldSource:String = "";

    public var divisionNewSource:String = "";

    public var divisionAdditionalSource:String = "";

    public var logoOldSource:String = "";

    public var logoNewSource:String = "";

    public var headerText:String = "";

    public var descriptionText:String = "";

    public var applyBtnLabel:String = "";

    public function CSAnimationVO(param1:Object) {
        super(param1);
    }
}
}

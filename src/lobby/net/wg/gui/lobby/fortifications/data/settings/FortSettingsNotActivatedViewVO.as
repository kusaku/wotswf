package net.wg.gui.lobby.fortifications.data.settings {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortSettingsNotActivatedViewVO extends DAAPIDataClass {

    private static const SETTINGS_BLOCKS_VO:Vector.<String> = new <String>["settingsBlockTop", "settingsBlockBottom"];

    public var titleText:String = "";

    public var description:String = "";

    public var conditionTitle:String = "";

    public var firstCondition:String = "";

    public var secondCondition:String = "";

    public var conditionsText:String = "";

    public var fortConditionsText:String = "";

    public var defenceConditionsText:String = "";

    public var attackConditionsText:String = "";

    public var isBtnEnabled:Boolean = false;

    public var firstStatus:String = "";

    public var secondStatus:String = "";

    public var btnToolTipData:String = "";

    public var settingsBlockTop:FortSettingsConditionsBlockVO = null;

    public var settingsBlockBottom:FortSettingsConditionsBlockVO = null;

    public function FortSettingsNotActivatedViewVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (SETTINGS_BLOCKS_VO.indexOf(param1) >= 0 && param2) {
            this[param1] = new FortSettingsConditionsBlockVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        var _loc2_:FortSettingsConditionsBlockVO = null;
        this.description = null;
        this.conditionTitle = null;
        this.firstCondition = null;
        this.secondCondition = null;
        this.firstStatus = null;
        this.secondStatus = null;
        this.btnToolTipData = null;
        var _loc1_:Vector.<FortSettingsConditionsBlockVO> = new <FortSettingsConditionsBlockVO>[this.settingsBlockTop, this.settingsBlockBottom];
        while (_loc1_.length > 0) {
            _loc2_ = _loc1_.pop();
            if (_loc2_ != null) {
                _loc2_.dispose();
            }
        }
        this.settingsBlockTop = null;
        this.settingsBlockBottom = null;
        super.onDispose();
    }
}
}

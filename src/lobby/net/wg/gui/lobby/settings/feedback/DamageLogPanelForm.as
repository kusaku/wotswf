package net.wg.gui.lobby.settings.feedback {
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.lobby.settings.components.RadioButtonBar;

public class DamageLogPanelForm extends BaseForm {

    private static const TEXT_PADDING:int = 4;

    private static const INFO_DELTA:int = 5;

    private static const DAMAGE_LOG_TOTAL_DAMAGE_ID:String = "damageLogTotalDamage";

    private static const DAMAGE_LOG_BLOCKED_DAMAGE_ID:String = "damageLogBlockedDamage";

    private static const DAMAGE_LOG_ASSIST_DAMAGE_ID:String = "damageLogAssistDamage";

    private static const DAMAGE_LOG_SHOW_DETAILS_ID:String = "damageLogShowDetails";

    private static const DETAILS_LOG_DOESNT_SHOW:int = 2;

    public var settingsDamageLogContainer:SettingsDamageLogContainer = null;

    public var damageLogDamageLabel:TextField = null;

    public var damageLogTotalDamageCheckbox:CheckBox = null;

    public var damageLogBlockedDamageCheckbox:CheckBox = null;

    public var damageLogAssistDamageCheckbox:CheckBox = null;

    public var damageLogDetailsLabel:TextField = null;

    public var damageLogDetailsInfoIcon:InfoIcon = null;

    public var damageLogShowDetailsButtonBar:RadioButtonBar;

    public function DamageLogPanelForm() {
        super();
    }

    override public function updateContent(param1:Object):void {
        super.updateContent(param1);
        var _loc2_:Boolean = param1[DAMAGE_LOG_TOTAL_DAMAGE_ID];
        var _loc3_:Boolean = param1[DAMAGE_LOG_ASSIST_DAMAGE_ID];
        var _loc4_:Boolean = param1[DAMAGE_LOG_BLOCKED_DAMAGE_ID];
        var _loc5_:int = param1[DAMAGE_LOG_SHOW_DETAILS_ID];
        var _loc6_:* = _loc5_ != DETAILS_LOG_DOESNT_SHOW;
        this.settingsDamageLogContainer.update(_loc2_, _loc4_, _loc3_, _loc6_);
    }

    override protected function onDispose():void {
        this.damageLogBlockedDamageCheckbox.dispose();
        this.damageLogBlockedDamageCheckbox = null;
        this.damageLogAssistDamageCheckbox.dispose();
        this.damageLogAssistDamageCheckbox = null;
        this.damageLogTotalDamageCheckbox.dispose();
        this.damageLogTotalDamageCheckbox = null;
        this.damageLogDetailsLabel = null;
        this.damageLogShowDetailsButtonBar.dispose();
        this.damageLogShowDetailsButtonBar = null;
        this.damageLogDamageLabel = null;
        this.damageLogDetailsInfoIcon.dispose();
        this.damageLogDetailsInfoIcon = null;
        this.settingsDamageLogContainer.dispose();
        this.settingsDamageLogContainer = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.damageLogDamageLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMLABEL;
        this.damageLogTotalDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_DAMAGEDONE;
        this.damageLogBlockedDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_BLOCKEDDAMAGE;
        this.damageLogAssistDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_DAMAGEASSIST;
        this.damageLogDetailsLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_DETAILSLABEL;
        this.damageLogDetailsLabel.width = this.damageLogDetailsLabel.textWidth + TEXT_PADDING;
        this.damageLogDetailsInfoIcon.icoType = InfoIcon.TYPE_INFO;
        this.damageLogDetailsInfoIcon.tooltip = TOOLTIPS.SETTINGS_DAMAGELOG_DETAILS;
        this.damageLogDetailsInfoIcon.x = this.damageLogDetailsLabel.x + this.damageLogDetailsLabel.width + INFO_DELTA ^ 0;
    }

    override public function get formId():String {
        return Linkages.FEEDBACK_DAMAGE_LOG;
    }
}
}

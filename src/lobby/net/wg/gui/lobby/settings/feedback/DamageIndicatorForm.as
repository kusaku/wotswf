package net.wg.gui.lobby.settings.feedback {
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.lobby.settings.components.RadioButtonBar;

public class DamageIndicatorForm extends BaseForm {

    private static const EXTENDED_SETTINGS_ID:int = 1;

    private static const WITH_CRITS_ID:int = 0;

    private static const DAMAGE_INDICATOR_TYPE_CONTROL_ID:String = "damageIndicatorType";

    private static const DAMAGE_INDICATOR_PRESETS_CONTROL_ID:String = "damageIndicatorPresets";

    private static const WITH_TANK_INFO_CONTROL_ID:String = "damageIndicatorVehicleInfo";

    private static const WITH_VALUE_CONTROL_ID:String = "damageIndicatorDamageValue";

    public var damageIndicatorTypeLabel:TextField = null;

    public var damageIndicatorPresetsLabel:TextField = null;

    public var damageIndicatorItemsLabel:TextField = null;

    public var damageIndicatorTypeButtonBar:RadioButtonBar = null;

    public var damageIndicatorPresetsButtonBar:RadioButtonBar = null;

    public var damageIndicatorDamageValueCheckbox:CheckBox = null;

    public var damageIndicatorVehicleInfoCheckbox:CheckBox = null;

    public var damageIndicatorAnimationCheckbox:CheckBox = null;

    public var damageIndicatorContainer:DamageIndicatorsContainer = null;

    public function DamageIndicatorForm() {
        super();
    }

    override public function updateContent(param1:Object):void {
        super.updateContent(param1);
        var _loc2_:* = param1[DAMAGE_INDICATOR_TYPE_CONTROL_ID] == EXTENDED_SETTINGS_ID;
        var _loc3_:* = param1[DAMAGE_INDICATOR_PRESETS_CONTROL_ID] == WITH_CRITS_ID;
        var _loc4_:Boolean = param1[WITH_TANK_INFO_CONTROL_ID];
        var _loc5_:Boolean = param1[WITH_VALUE_CONTROL_ID];
        this.damageIndicatorPresetsButtonBar.validateNow();
        this.setEnableExtendedParams(_loc2_);
        this.damageIndicatorContainer.updateSettings(!_loc2_, _loc5_, _loc4_, _loc3_);
    }

    override protected function configUI():void {
        super.configUI();
        this.damageIndicatorTypeLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_TYPELABEL;
        this.damageIndicatorPresetsLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_PRESETS;
        this.damageIndicatorItemsLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS;
        this.damageIndicatorDamageValueCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_DAMAGE;
        this.damageIndicatorVehicleInfoCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_TANKNAME;
        this.damageIndicatorAnimationCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_ANIMATION;
    }

    override protected function onDispose():void {
        this.damageIndicatorContainer.dispose();
        this.damageIndicatorContainer = null;
        this.damageIndicatorTypeLabel = null;
        this.damageIndicatorPresetsLabel = null;
        this.damageIndicatorItemsLabel = null;
        this.damageIndicatorTypeButtonBar.dispose();
        this.damageIndicatorTypeButtonBar = null;
        this.damageIndicatorPresetsButtonBar.dispose();
        this.damageIndicatorPresetsButtonBar = null;
        this.damageIndicatorDamageValueCheckbox.dispose();
        this.damageIndicatorDamageValueCheckbox = null;
        this.damageIndicatorVehicleInfoCheckbox.dispose();
        this.damageIndicatorVehicleInfoCheckbox = null;
        this.damageIndicatorAnimationCheckbox.dispose();
        this.damageIndicatorAnimationCheckbox = null;
        super.onDispose();
    }

    override protected function onButtonBarIndexChange(param1:RadioButtonBar):void {
        super.onButtonBarIndexChange(param1);
        var _loc2_:* = param1.dataProvider[param1.selectedIndex].data == EXTENDED_SETTINGS_ID;
        switch (param1) {
            case this.damageIndicatorTypeButtonBar:
                this.setEnableExtendedParams(_loc2_);
                break;
            case this.damageIndicatorPresetsButtonBar:
        }
    }

    private function setEnableExtendedParams(param1:Boolean):void {
        this.damageIndicatorPresetsButtonBar.enabled = param1;
        this.damageIndicatorDamageValueCheckbox.enabled = param1;
        this.damageIndicatorVehicleInfoCheckbox.enabled = param1;
        this.damageIndicatorAnimationCheckbox.enabled = param1;
    }

    override public function get formId():String {
        return Linkages.FEEDBACK_DAMAGE_INDICATOR;
    }
}
}

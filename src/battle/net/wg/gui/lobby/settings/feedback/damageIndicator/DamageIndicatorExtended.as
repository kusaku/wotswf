package net.wg.gui.lobby.settings.feedback.damageIndicator {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DamageIndicatorExtended extends Sprite implements IDisposable {

    public var critTF:TextField = null;

    public var blockedTF:TextField = null;

    public var damageTF:TextField = null;

    public var damageModuleTF:TextField = null;

    public var blockDamageCountTF:TextField = null;

    public var damageCountTF:TextField = null;

    public var critBgMc:MovieClip = null;

    public var critArrowMc:DamageIndicatorArrow = null;

    public var critVehicleMc:DamageIndicatorVehicleInfo = null;

    public var blockedBgMc:MovieClip = null;

    public var blockedArrowMc:DamageIndicatorArrow = null;

    public var blockedVehicleMc:DamageIndicatorVehicleInfo = null;

    public var damageBgMc:MovieClip = null;

    public var damageArrowMc:DamageIndicatorArrow = null;

    public var damageVehicleMc:DamageIndicatorVehicleInfo = null;

    public function DamageIndicatorExtended() {
        super();
        this.critTF.autoSize = TextFieldAutoSize.CENTER;
        this.blockedTF.autoSize = TextFieldAutoSize.CENTER;
        this.damageTF.autoSize = TextFieldAutoSize.CENTER;
        this.critTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_CRITLABEL;
        this.blockedTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_BLOCKEDLABEL;
        this.damageTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_DAMAGELABEL;
        this.damageModuleTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_DAMAGEMODULE;
        this.blockDamageCountTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_BLOCKDAMAGECOUNTTF;
        this.damageCountTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_BLOCKDAMAGECOUNTTF;
        this.critArrowMc.circleMc.rotation = this.critArrowMc.rotation * -1;
        this.blockedArrowMc.circleMc.rotation = this.blockedArrowMc.rotation * -1;
        this.damageArrowMc.circleMc.rotation = this.damageArrowMc.rotation * -1;
    }

    public final function dispose():void {
        this.critTF = null;
        this.blockedTF = null;
        this.damageTF = null;
        this.critArrowMc.dispose();
        this.critArrowMc = null;
        this.critVehicleMc.dispose();
        this.critVehicleMc = null;
        this.critBgMc = null;
        this.blockedArrowMc.dispose();
        this.blockedArrowMc = null;
        this.blockedVehicleMc.dispose();
        this.blockedVehicleMc = null;
        this.blockedBgMc = null;
        this.damageArrowMc.dispose();
        this.damageArrowMc = null;
        this.damageVehicleMc.dispose();
        this.damageVehicleMc = null;
        this.damageBgMc = null;
    }
}
}

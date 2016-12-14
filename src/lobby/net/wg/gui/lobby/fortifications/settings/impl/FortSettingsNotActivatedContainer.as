package net.wg.gui.lobby.fortifications.settings.impl {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.components.assets.ArrowSeparator;
import net.wg.gui.components.assets.data.SeparatorConstants;
import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.ISpriteEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.events.ButtonEvent;

public class FortSettingsNotActivatedContainer extends UIComponentEx implements ISpriteEx, IViewStackContent {

    public var titleTF:TextField = null;

    public var description:TextField = null;

    public var conditionTitle:TextField = null;

    public var firstCondition:TextField = null;

    public var secondCondition:TextField = null;

    public var conditionsTF:TextField = null;

    public var fortConditionsTF:TextField = null;

    public var defenceConditionsTF:TextField = null;

    public var attackConditionsTF:TextField = null;

    public var settingsBlockTop:ISpriteEx = null;

    public var settingsBlockBottom:ISpriteEx = null;

    public var firstStatus:TextField = null;

    public var secondStatus:TextField = null;

    public var activateDefenceTime:SoundButtonEx = null;

    public var separator:ArrowSeparator = null;

    public var topSeparator:ISeparatorAsset = null;

    public var centerSeparator:ISeparatorAsset = null;

    public var bottomSeparator:ISeparatorAsset = null;

    private var applyBtnTooltip:String = "";

    public function FortSettingsNotActivatedContainer() {
        super();
        this.scaleX = this.scaleY = 1;
        this.topSeparator.setCenterAsset(Linkages.TABLE_SHADDOW_UI);
        this.centerSeparator.setType(SeparatorConstants.DOTTED_TYPE);
        this.bottomSeparator.setCenterAsset(Linkages.SEPARATOR_UI);
    }

    private static function activateDefenceTime_rollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    public function update(param1:Object):void {
        var _loc2_:FortSettingsNotActivatedViewVO = FortSettingsNotActivatedViewVO(param1);
        this.titleTF.htmlText = _loc2_.titleText;
        if (this.description.htmlText != _loc2_.description) {
            this.description.htmlText = _loc2_.description;
        }
        if (this.conditionTitle.htmlText != _loc2_.conditionTitle) {
            this.conditionTitle.htmlText = _loc2_.conditionTitle;
        }
        if (this.firstCondition.htmlText != _loc2_.firstCondition) {
            this.firstCondition.htmlText = _loc2_.firstCondition;
        }
        if (this.secondCondition.htmlText != _loc2_.secondCondition) {
            this.secondCondition.htmlText = _loc2_.secondCondition;
        }
        this.conditionsTF.htmlText = _loc2_.conditionsText;
        this.fortConditionsTF.htmlText = _loc2_.fortConditionsText;
        this.defenceConditionsTF.htmlText = _loc2_.defenceConditionsText;
        this.attackConditionsTF.htmlText = _loc2_.attackConditionsText;
        this.firstStatus.htmlText = _loc2_.firstStatus;
        this.secondStatus.htmlText = _loc2_.secondStatus;
        this.applyBtnTooltip = _loc2_.btnToolTipData;
        this.activateDefenceTime.enabled = _loc2_.isBtnEnabled;
        if (this.activateDefenceTime.enabled) {
            this.activateDefenceTime.addEventListener(ButtonEvent.CLICK, this.activateDefenceTime_buttonClickHandler);
        }
        this.settingsBlockTop.update(_loc2_.settingsBlockTop);
        this.settingsBlockBottom.update(_loc2_.settingsBlockBottom);
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    private function activateDefenceTime_buttonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new FortSettingsEvent(FortSettingsEvent.ACTIVATE_DEFENCE_PERIOD));
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return !!this.activateDefenceTime.enabled ? this.activateDefenceTime : null;
    }

    override protected function onDispose():void {
        this.description = null;
        this.conditionTitle = null;
        this.firstCondition = null;
        this.secondCondition = null;
        this.firstStatus = null;
        this.secondStatus = null;
        this.activateDefenceTime.removeEventListener(ButtonEvent.CLICK, this.activateDefenceTime_buttonClickHandler);
        this.activateDefenceTime.removeEventListener(MouseEvent.ROLL_OUT, activateDefenceTime_rollOutHandler);
        this.activateDefenceTime.removeEventListener(MouseEvent.ROLL_OVER, this.activateDefenceTime_rollOverHandler);
        this.activateDefenceTime.dispose();
        this.activateDefenceTime = null;
        this.separator.dispose();
        this.topSeparator.dispose();
        this.centerSeparator.dispose();
        this.bottomSeparator.dispose();
        this.separator = null;
        this.topSeparator = null;
        this.centerSeparator = null;
        this.bottomSeparator = null;
        this.settingsBlockTop.dispose();
        this.settingsBlockTop = null;
        this.settingsBlockBottom.dispose();
        this.settingsBlockBottom = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.activateDefenceTime.label = FORTIFICATIONS.SETTINGSWINDOW_MAINBUTTONLABEL;
        this.activateDefenceTime.mouseEnabledOnDisabled = true;
        this.activateDefenceTime.addEventListener(MouseEvent.ROLL_OUT, activateDefenceTime_rollOutHandler);
        this.activateDefenceTime.addEventListener(MouseEvent.ROLL_OVER, this.activateDefenceTime_rollOverHandler);
    }

    private function activateDefenceTime_rollOverHandler(param1:MouseEvent):void {
        if (this.applyBtnTooltip == Values.EMPTY_STR) {
            return;
        }
        App.toolTipMgr.show(this.applyBtnTooltip);
    }
}
}

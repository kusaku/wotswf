package net.wg.gui.lobby.settings.feedback {
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.gui.components.controls.CheckBox;

public class BattleEventsInfoForm extends BaseForm {

    public var battleEventsCommonLabel:TextField = null;

    public var battleEventsShowInBattleCheckbox:CheckBox = null;

    public var battleEventsVisibleEventsLabel:TextField = null;

    public var battleEventsEnemyHpDamageCheckbox:CheckBox = null;

    public var battleEventsEnemyBurningCheckbox:CheckBox = null;

    public var battleEventsEnemyRamAttackCheckbox:CheckBox = null;

    public var battleEventsBlockedDamageCheckbox:CheckBox = null;

    public var battleEventsEnemyDetectionDamageCheckbox:CheckBox = null;

    public var battleEventsEnemyTrackDamageCheckbox:CheckBox = null;

    public var battleEventsEnemyDetectionCheckbox:CheckBox = null;

    public var battleEventsEnemyKillCheckbox:CheckBox = null;

    public var battleEventsBaseCaptureDropCheckbox:CheckBox = null;

    public var battleEventsBaseCaptureCheckbox:CheckBox = null;

    public var battleEventsEnemyCriticalHitCheckbox:CheckBox = null;

    public var battleEventsInformationLabel:TextField = null;

    public var battleEventsEventNameCheckbox:CheckBox = null;

    public var battleEventsVehicleInfoCheckbox:CheckBox = null;

    public var ribbonsContainer:SettingsRibbonContainer = null;

    private var _itemsMap:Dictionary = null;

    private var _countSelectedItems:int = 0;

    public function BattleEventsInfoForm() {
        super();
        this._itemsMap = new Dictionary();
        this._itemsMap[this.battleEventsBlockedDamageCheckbox.name] = BATTLE_EFFICIENCY_TYPES.ARMOR;
        this._itemsMap[this.battleEventsEnemyBurningCheckbox.name] = BATTLE_EFFICIENCY_TYPES.BURN;
        this._itemsMap[this.battleEventsEnemyRamAttackCheckbox.name] = BATTLE_EFFICIENCY_TYPES.RAM;
        this._itemsMap[this.battleEventsEnemyHpDamageCheckbox.name] = BATTLE_EFFICIENCY_TYPES.DAMAGE;
        this._itemsMap[this.battleEventsEnemyDetectionDamageCheckbox.name] = BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT;
        this._itemsMap[this.battleEventsEnemyTrackDamageCheckbox.name] = BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK;
        this._itemsMap[this.battleEventsEnemyDetectionCheckbox.name] = BATTLE_EFFICIENCY_TYPES.DETECTION;
        this._itemsMap[this.battleEventsEnemyKillCheckbox.name] = BATTLE_EFFICIENCY_TYPES.DESTRUCTION;
        this._itemsMap[this.battleEventsBaseCaptureDropCheckbox.name] = BATTLE_EFFICIENCY_TYPES.DEFENCE;
        this._itemsMap[this.battleEventsBaseCaptureCheckbox.name] = BATTLE_EFFICIENCY_TYPES.CAPTURE;
        this._itemsMap[this.battleEventsEnemyCriticalHitCheckbox.name] = BATTLE_EFFICIENCY_TYPES.CRITS;
    }

    override public function updateContent(param1:Object):void {
        var _loc2_:Boolean = false;
        var _loc3_:CheckBox = null;
        var _loc4_:* = null;
        super.updateContent(param1);
        this._countSelectedItems = 0;
        for (_loc4_ in this._itemsMap) {
            _loc3_ = this[_loc4_];
            _loc2_ = _loc3_.selected;
            this.ribbonsContainer.updateItemVisible(this._itemsMap[_loc4_], _loc2_);
            if (_loc2_) {
                this._countSelectedItems++;
            }
        }
        this.ribbonsContainer.updateSettings(this.battleEventsEventNameCheckbox.selected, this.battleEventsVehicleInfoCheckbox.selected);
        this.setEventsCheckboxesEnabled();
    }

    override protected function onCheckBoxSelected(param1:CheckBox):void {
        var _loc2_:* = null;
        super.onCheckBoxSelected(param1);
        if (this._itemsMap.hasOwnProperty(param1.name)) {
            if (this._countSelectedItems == 0) {
                this.battleEventsShowInBattleCheckbox.selected = false;
            }
        }
        else if (this._countSelectedItems == 0 && param1 == this.battleEventsShowInBattleCheckbox && param1.selected) {
            for (_loc2_ in this._itemsMap) {
                this[_loc2_].selected = true;
            }
            this.battleEventsEventNameCheckbox.selected = true;
            this.battleEventsVehicleInfoCheckbox.selected = true;
        }
    }

    override protected function onDispose():void {
        App.utils.data.cleanupDynamicObject(this._itemsMap);
        this._itemsMap = null;
        this.battleEventsBaseCaptureCheckbox.dispose();
        this.battleEventsBaseCaptureCheckbox = null;
        this.battleEventsBaseCaptureDropCheckbox.dispose();
        this.battleEventsBaseCaptureDropCheckbox = null;
        this.battleEventsBlockedDamageCheckbox.dispose();
        this.battleEventsBlockedDamageCheckbox = null;
        this.battleEventsCommonLabel = null;
        this.battleEventsEnemyBurningCheckbox.dispose();
        this.battleEventsEnemyBurningCheckbox = null;
        this.battleEventsEnemyCriticalHitCheckbox.dispose();
        this.battleEventsEnemyCriticalHitCheckbox = null;
        this.battleEventsEnemyDetectionCheckbox.dispose();
        this.battleEventsEnemyDetectionCheckbox = null;
        this.battleEventsEnemyDetectionDamageCheckbox.dispose();
        this.battleEventsEnemyDetectionDamageCheckbox = null;
        this.battleEventsEnemyHpDamageCheckbox.dispose();
        this.battleEventsEnemyHpDamageCheckbox = null;
        this.battleEventsEnemyKillCheckbox.dispose();
        this.battleEventsEnemyKillCheckbox = null;
        this.battleEventsEnemyRamAttackCheckbox.dispose();
        this.battleEventsEnemyRamAttackCheckbox = null;
        this.battleEventsEnemyTrackDamageCheckbox.dispose();
        this.battleEventsEnemyTrackDamageCheckbox = null;
        this.battleEventsShowInBattleCheckbox.dispose();
        this.battleEventsShowInBattleCheckbox = null;
        this.battleEventsVisibleEventsLabel = null;
        this.battleEventsInformationLabel = null;
        this.battleEventsEventNameCheckbox.dispose();
        this.battleEventsEventNameCheckbox = null;
        this.battleEventsVehicleInfoCheckbox.dispose();
        this.battleEventsVehicleInfoCheckbox = null;
        this.ribbonsContainer.dispose();
        this.ribbonsContainer = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.battleEventsCommonLabel.text = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_LABEL_COMMONLABEL;
        this.battleEventsShowInBattleCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_SHOWINBATTLE;
        this.battleEventsVisibleEventsLabel.text = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_LABEL_VISIBLEEVENTS;
        this.battleEventsBaseCaptureCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_BASECAPTURE;
        this.battleEventsBaseCaptureDropCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_BASECAPTUREDROP;
        this.battleEventsBlockedDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_BLOCKEDDAMAGE;
        this.battleEventsEnemyBurningCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYBURNING;
        this.battleEventsEnemyCriticalHitCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYCRITICALHIT;
        this.battleEventsEnemyDetectionCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYDETECTION;
        this.battleEventsEnemyDetectionDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYDETECTIONDAMAGE;
        this.battleEventsEnemyHpDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYHPDAMAGE;
        this.battleEventsEnemyKillCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYKILL;
        this.battleEventsEnemyRamAttackCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYRAMATTACK;
        this.battleEventsEnemyTrackDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYTRACKDAMAGE;
        this.battleEventsInformationLabel.text = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_LABEL_INFORMATION;
        this.battleEventsEventNameCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_EVENTNAME;
        this.battleEventsVehicleInfoCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_VEHICLEINFO;
    }

    private function setEventsCheckboxesEnabled():void {
        var _loc1_:Boolean = this.battleEventsShowInBattleCheckbox.selected;
        this.battleEventsEnemyHpDamageCheckbox.enabled = _loc1_;
        this.battleEventsEnemyBurningCheckbox.enabled = _loc1_;
        this.battleEventsEnemyRamAttackCheckbox.enabled = _loc1_;
        this.battleEventsBlockedDamageCheckbox.enabled = _loc1_;
        this.battleEventsEnemyDetectionDamageCheckbox.enabled = _loc1_;
        this.battleEventsEnemyTrackDamageCheckbox.enabled = _loc1_;
        this.battleEventsEnemyDetectionCheckbox.enabled = _loc1_;
        this.battleEventsEnemyKillCheckbox.enabled = _loc1_;
        this.battleEventsBaseCaptureDropCheckbox.enabled = _loc1_;
        this.battleEventsBaseCaptureCheckbox.enabled = _loc1_;
        this.battleEventsEnemyCriticalHitCheckbox.enabled = _loc1_;
        this.battleEventsEventNameCheckbox.enabled = _loc1_;
        this.battleEventsVehicleInfoCheckbox.enabled = _loc1_;
        this.ribbonsContainer.visible = _loc1_;
    }

    override public function get formId():String {
        return Linkages.FEEDBACK_BATTLE_EVENTS;
    }
}
}

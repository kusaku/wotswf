package net.wg.gui.lobby.tankman {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.SKILLS_CONSTANTS;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TankmanTrainingSmallButton;
import net.wg.infrastructure.base.meta.ISkillDropMeta;
import net.wg.infrastructure.base.meta.impl.SkillDropMeta;

import scaleform.clik.controls.ButtonGroup;
import scaleform.clik.events.ButtonEvent;

public class SkillDropWindow extends SkillDropMeta implements ISkillDropMeta {

    private static const INVALID_DATA:String = "invalidData";

    private static const INVALID_MONEY:String = "invalidMoney";

    private static const SAVE_MODE_GROUP:String = "savingModeGroup";

    private static const SCORE_TYPE_DROP_SKILLS:String = "dropSkills";

    private static const MAX_SKILL:int = 100;

    public var beforeBlock:TankmanSkillsInfoBlock;

    public var afterBlock:TankmanSkillsInfoBlock;

    public var buttonCancel:SoundButtonEx;

    public var buttonDrop:SoundButtonEx;

    public var goldButton:TankmanTrainingSmallButton;

    public var creditsButton:TankmanTrainingSmallButton;

    public var freeButton:TankmanTrainingSmallButton;

    public var freeDropTf:TextField;

    public var model:SkillDropModel;

    private var _savingModeGroup:ButtonGroup;

    private var _gold:Number = NaN;

    private var _credits:Number = NaN;

    private var _isFirstInited:Boolean = false;

    public function SkillDropWindow() {
        super();
        isCentered = true;
        isModal = true;
        canDrag = false;
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:String = SAVE_MODE_GROUP;
        this._savingModeGroup = new ButtonGroup(_loc1_, this);
        this.goldButton.groupName = _loc1_;
        this.creditsButton.groupName = _loc1_;
        this.freeButton.groupName = _loc1_;
        this._savingModeGroup.addButton(this.goldButton);
        this._savingModeGroup.addButton(this.creditsButton);
        this._savingModeGroup.addButton(this.freeButton);
        this._savingModeGroup.addEventListener(Event.CHANGE, this.onSavingModeGroupChangeHandler);
        this.goldButton.allowDeselect = this.creditsButton.allowDeselect = this.freeButton.allowDeselect = false;
        this.goldButton.doubleClickEnabled = this.creditsButton.doubleClickEnabled = this.freeButton.doubleClickEnabled = true;
        this.goldButton.retraining = this.creditsButton.retraining = this.freeButton.retraining = false;
        this.goldButton.scopeType = this.creditsButton.scopeType = this.freeButton.scopeType = SCORE_TYPE_DROP_SKILLS;
        this.goldButton.addEventListener(MouseEvent.DOUBLE_CLICK, this.onDropButtonDoubleClickHandler);
        this.creditsButton.addEventListener(MouseEvent.DOUBLE_CLICK, this.onDropButtonDoubleClickHandler);
        this.freeButton.addEventListener(MouseEvent.DOUBLE_CLICK, this.onDropButtonDoubleClickHandler);
        this.buttonDrop.addEventListener(ButtonEvent.CLICK, this.onButtonDropClickHandler);
        this.buttonCancel.addEventListener(ButtonEvent.CLICK, this.onButtonCancelClickHandler);
    }

    override protected function onDispose():void {
        this.goldButton.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onDropButtonDoubleClickHandler);
        this.creditsButton.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onDropButtonDoubleClickHandler);
        this.freeButton.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onDropButtonDoubleClickHandler);
        this.buttonDrop.removeEventListener(ButtonEvent.CLICK, this.onButtonDropClickHandler);
        this.buttonCancel.removeEventListener(ButtonEvent.CLICK, this.onButtonCancelClickHandler);
        this.beforeBlock.dispose();
        this.beforeBlock = null;
        this.afterBlock.dispose();
        this.afterBlock = null;
        this.buttonCancel.dispose();
        this.buttonCancel = null;
        this.buttonDrop.dispose();
        this.buttonDrop = null;
        this.goldButton.dispose();
        this.goldButton = null;
        this.creditsButton.dispose();
        this.creditsButton = null;
        this.freeButton.dispose();
        this.freeButton = null;
        this.freeDropTf = null;
        if (this._savingModeGroup) {
            this._savingModeGroup.removeEventListener(Event.CHANGE, this.onSavingModeGroupChangeHandler);
            this._savingModeGroup.dispose();
            this._savingModeGroup = null;
        }
        if (this.model) {
            this.model.dispose();
            this.model = null;
        }
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        window.title = MENU.SKILLDROPWINDOW_TITLE;
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        super.draw();
        if (isInvalid(INVALID_DATA) && this.model) {
            _loc1_ = this.model.skillsCount <= 1 && this.model.lastSkillLevel < 1;
            this.goldButton.visible = !_loc1_;
            this.creditsButton.visible = !_loc1_;
            this.freeButton.visible = !_loc1_;
            this.freeDropTf.visible = _loc1_;
            if (!_loc1_) {
                this.goldButton.level = Math.round(this.model.dropSkillGold.xpReuseFraction * MAX_SKILL);
                this.creditsButton.level = Math.round(this.model.dropSkillCredits.xpReuseFraction * MAX_SKILL);
                this.freeButton.level = Math.round(this.model.dropSkillFree.xpReuseFraction * MAX_SKILL);
                this.goldButton.nation = this.creditsButton.nation = this.freeButton.nation = this.model.nationID;
                this.updateSavingModes();
            }
            else {
                this.freeDropTf.htmlText = this.model.freeDropText;
            }
            this.beforeBlock.nation = this.afterBlock.nation = this.model.nation;
            this.beforeBlock.tankmanName = this.afterBlock.tankmanName = this.model.tankmanName;
            this.beforeBlock.portraitSource = this.afterBlock.portraitSource = this.model.tankmanIcon;
            this.beforeBlock.roleSource = this.afterBlock.roleSource = this.model.roleIcon;
            this.beforeBlock.setRoleLevel(this.model.roleLevel);
            if (!this._isFirstInited) {
                this.autoSelectSavingMode();
                this._isFirstInited = true;
            }
            this.recalculateData();
        }
        if (isInvalid(INVALID_MONEY)) {
            this.updateSavingModes();
        }
    }

    public function as_setCredits(param1:Number):void {
        this._credits = param1;
        invalidate(INVALID_MONEY);
    }

    public function as_setData(param1:Object):void {
        this.model = SkillDropModel.parseFromObject(param1);
        this._gold = this.model.gold;
        this._credits = this.model.credits;
        invalidate(INVALID_DATA);
    }

    public function as_setGold(param1:Number):void {
        this._gold = param1;
        invalidate(INVALID_MONEY);
    }

    private function updateSavingModes():void {
        this.goldButton.setDataForDropSkills(this.model.dropSkillGold.gold, this._gold >= this.model.dropSkillGold.gold, this.model.dropSkillGold.actionPriceDataVo);
        this.creditsButton.setDataForDropSkills(this.model.dropSkillCredits.credits, this._credits > this.model.dropSkillCredits.credits, this.model.dropSkillCredits.actionPriceDataVo);
        this.freeButton.setDataForDropSkills(NaN, true, null);
    }

    private function autoSelectSavingMode():void {
        var _loc1_:TankmanTrainingSmallButton = null;
        switch (this.model.defaultSavingMode) {
            case SkillDropModel.SAVING_MODE_GOLD:
                _loc1_ = this.goldButton;
                break;
            case SkillDropModel.SAVING_MODE_CREDITS:
                _loc1_ = this.creditsButton;
                break;
            default:
                _loc1_ = this.freeButton;
        }
        this._savingModeGroup.selectedButton = _loc1_;
        if (_loc1_.enabled) {
            _loc1_.selected = true;
        }
    }

    private function getSelectedDropCostInfo():DropSkillsCost {
        var _loc1_:DropSkillsCost = null;
        switch (this._savingModeGroup.selectedButton) {
            case this.goldButton:
                _loc1_ = this.model.dropSkillGold;
                break;
            case this.creditsButton:
                _loc1_ = this.model.dropSkillCredits;
                break;
            case this.freeButton:
                _loc1_ = this.model.dropSkillFree;
        }
        return _loc1_;
    }

    private function recalculateData():void {
        var _loc1_:Object = this.getSelectedDropCostInfo();
        var _loc2_:Array = calcDropSkillsParamsS(this.model.compactDescriptor, _loc1_.xpReuseFraction);
        var _loc3_:Number = _loc2_[0];
        var _loc4_:int = _loc3_ >= MAX_SKILL ? int(_loc2_[1]) : -1;
        var _loc5_:Number = _loc2_[2];
        this.beforeBlock.setSkills(this.model.skillsCount, this.model.preLastSkill, this.model.lastSkill, this.model.lastSkillLevel, this.model.hasNewSkill, this.model.newSkillsCount, this.model.lastNewSkillLevel);
        var _loc6_:String = _loc4_ > 1 ? SKILLS_CONSTANTS.TYPE_NEW_SKILL : null;
        var _loc7_:String = SKILLS_CONSTANTS.TYPE_NEW_SKILL;
        var _loc8_:* = this.model.skillsCount > _loc4_;
        this.afterBlock.setSkills(_loc4_, _loc6_, _loc7_, _loc5_, _loc8_);
        this.afterBlock.setRoleLevel(this.model.roleLevel, _loc3_);
    }

    private function onSavingModeGroupChangeHandler(param1:Event):void {
        this.recalculateData();
    }

    private function onDropButtonDoubleClickHandler(param1:MouseEvent):void {
        this.onButtonDropClickHandler(null);
    }

    private function onButtonCancelClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onButtonDropClickHandler(param1:ButtonEvent):void {
        dropSkillsS(this.getSelectedDropCostInfo().id);
    }
}
}

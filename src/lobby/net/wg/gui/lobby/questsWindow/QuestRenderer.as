package net.wg.gui.lobby.questsWindow {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.data.constants.QuestsStates;
import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.advanced.interfaces.INewIndicator;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.components.ProgressIndicator;
import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
import net.wg.gui.lobby.questsWindow.events.IQuestRenderer;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class QuestRenderer extends TableRenderer implements IQuestRenderer {

    private static const DEF_COUNTER_Y:int = 27;

    private static const COMPLEX_COUNTER_Y:int = 18;

    private static const TEXT_FIELD_PADDING:int = 5;

    public var newIndicator:INewIndicator;

    public var indicatorIGR:UILoaderAlt;

    public var counter:QuestsCounter;

    public var statusMC:QuestStatusComponent;

    public var actionMC:MovieClip;

    public var progressIndicator:ProgressIndicator;

    public var taskTF:TextField;

    public var descrTF:TextFieldShort;

    public var timerTF:TextField;

    public var blockTitleTF:TextField;

    public var bckgrImageLoader:UILoaderAlt;

    public var hitMc:MovieClip;

    public var hitTooltipMc:MovieClip;

    private var _status:String = "";

    private var _type:int = -1;

    private var _wasAnimated:Boolean = false;

    private var _questData:QuestRendererVO;

    private var _questComponents:Vector.<DisplayObject>;

    private var _blockTitleComponents:Vector.<DisplayObject>;

    public function QuestRenderer() {
        super();
        this.newIndicator.visible = false;
        this.indicatorIGR.visible = false;
        this.counter.visible = false;
        this.statusMC.visible = false;
        this.progressIndicator.visible = false;
        this.actionMC.visible = false;
        this._questComponents = new <DisplayObject>[this.indicatorIGR, this.counter, this.actionMC, this.progressIndicator, this.taskTF, this.descrTF, this.timerTF, rendererBg];
        this._blockTitleComponents = new <DisplayObject>[this.blockTitleTF];
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._questData = QuestRendererVO(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.mouseChildren = true;
        this.mouseEnabled = true;
        this.addListeners();
        this.hitArea = this.hitMc;
        this.newIndicator.hitArea = this.newIndicator.hitMC;
        this.hitTooltipMc.buttonMode = true;
        this.buttonMode = true;
        this.newIndicator.mouseChildren = false;
        this.descrTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
        this.descrTF.validateNow();
    }

    override protected function onDispose():void {
        this.hitArea = null;
        this.removeListeners();
        this.hitTooltipMc = null;
        this.hitMc = null;
        this.timerTF = null;
        this.descrTF.dispose();
        this.descrTF = null;
        this.taskTF = null;
        this.actionMC = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        this.indicatorIGR.dispose();
        this.indicatorIGR = null;
        this.counter.dispose();
        this.counter = null;
        this.statusMC.dispose();
        this.statusMC = null;
        this.progressIndicator.dispose();
        this.progressIndicator = null;
        this._questData = null;
        this.blockTitleTF = null;
        this._questComponents.splice(0, this._questComponents.length);
        this._blockTitleComponents.splice(0, this._blockTitleComponents.length);
        this._questComponents = null;
        this._blockTitleComponents = null;
        this.bckgrImageLoader.dispose();
        this.bckgrImageLoader = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE)) {
            if (this._questData != null) {
                this.checkData(this._questData);
            }
        }
        if (isInvalid(InvalidationType.DATA)) {
            if (this._questData != null) {
                this.checkData(this._questData);
                this.checkNew(this._questData);
                this.visible = true;
            }
            else {
                this.visible = false;
            }
            this._wasAnimated = true;
        }
        this.newIndicator.mouseChildren = false;
    }

    public function hideNew():void {
        this.newIndicator.hide();
    }

    private function addListeners():void {
        this.hitTooltipMc.addEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        this.hitTooltipMc.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.hitTooltipMc.addEventListener(MouseEvent.ROLL_OVER, this.onHitTooltipMcRollOverHandler);
        this.indicatorIGR.addEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        this.indicatorIGR.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.indicatorIGR.addEventListener(MouseEvent.ROLL_OVER, this.onIndicatorIgrRollOverHandler);
        this.newIndicator.addEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        this.newIndicator.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.newIndicator.addEventListener(MouseEvent.ROLL_OVER, this.onNewIndicatorRollOverHandler);
    }

    private function removeListeners():void {
        this.hitTooltipMc.removeEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        this.hitTooltipMc.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.hitTooltipMc.removeEventListener(MouseEvent.ROLL_OVER, this.onHitTooltipMcRollOverHandler);
        this.indicatorIGR.removeEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OVER, this.onIndicatorIgrRollOverHandler);
        this.newIndicator.removeEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        this.newIndicator.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.newIndicator.removeEventListener(MouseEvent.ROLL_OVER, this.onNewIndicatorRollOverHandler);
    }

    private function checkData(param1:QuestRendererVO):void {
        var _loc2_:int = param1.rendererType;
        if (_loc2_ == QUESTS_ALIASES.RENDERER_TYPE_QUEST) {
            if (_loc2_ != this._type) {
                QuestWindowUtils.instance.setItemsVisible(this._blockTitleComponents, false);
                QuestWindowUtils.instance.setItemsVisible(this._questComponents, true);
                this._type = _loc2_;
            }
            this.setQuestTexts(param1);
            this.checkCounter(param1);
            this.checkProgress(param1);
            this.checkIGR(param1);
            this.checkAction(param1);
            this.mouseChildren = true;
            this.mouseEnabled = true;
        }
        else if (_loc2_ == QUESTS_ALIASES.RENDERER_TYPE_BLOCK_TITLE) {
            if (_loc2_ != this._type) {
                QuestWindowUtils.instance.setItemsVisible(this._blockTitleComponents, true);
                QuestWindowUtils.instance.setItemsVisible(this._questComponents, false);
                this._type = _loc2_;
            }
            this.blockTitleTF.htmlText = this._questData.description;
            this.mouseChildren = false;
            this.mouseEnabled = false;
        }
        else {
            App.utils.asserter.assert(false, "Quest renderer type \'" + param1.rendererType + "\'" + Errors.WASNT_FOUND);
        }
        this.checkStatus(param1);
        var _loc3_:Boolean = param1.isSelectable;
        this.enabled = _loc3_;
        buttonMode = _loc3_;
        this.hitTooltipMc.buttonMode = _loc3_;
        var _loc4_:Boolean = param1.showBckgrImage;
        this.bckgrImageLoader.visible = _loc4_;
        if (_loc4_) {
            this.bckgrImageLoader.source = param1.bckgrImage;
        }
    }

    private function checkAction(param1:QuestRendererVO):void {
        this.actionMC.visible = param1.eventType == QuestsStates.ACTION;
    }

    private function setQuestTexts(param1:QuestRendererVO):void {
        this.taskTF.htmlText = param1.taskType;
        this.descrTF.label = param1.description;
        this.timerTF.htmlText = param1.timerDescription;
    }

    private function checkProgress(param1:QuestRendererVO):void {
        if (param1.progrBarType && !param1.status) {
            this.progressIndicator.visible = true;
            this.progressIndicator.setValues(param1.progrBarType, param1.currentProgrVal, param1.maxProgrVal);
            this.progressIndicator.setTooltip(param1.progrTooltip);
        }
        else {
            this.progressIndicator.visible = false;
        }
        if (this.counter.visible && this.progressIndicator.visible) {
            this.counter.y = COMPLEX_COUNTER_Y;
        }
    }

    private function checkCounter(param1:QuestRendererVO):void {
        if (param1.tasksCount >= 0 && !param1.status) {
            this.counter.visible = true;
            this.counter.textField.text = param1.tasksCount.toString();
            this.counter.y = DEF_COUNTER_Y;
        }
        else {
            this.counter.visible = false;
        }
    }

    private function checkIGR(param1:QuestRendererVO):void {
        this.indicatorIGR.visible = param1.IGR;
        if (this.indicatorIGR.visible) {
            this.indicatorIGR.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREMIUM_SMALL;
        }
        this.indicatorIGR.x = int(this.taskTF.x + this.taskTF.textWidth + TEXT_FIELD_PADDING);
    }

    private function checkNew(param1:QuestRendererVO):void {
        this.newIndicator.visible = param1.isNew;
        if (param1.isNew && !this._wasAnimated) {
            this.newIndicator.shine();
        }
        else {
            this.newIndicator.pause();
        }
    }

    private function checkStatus(param1:QuestRendererVO):void {
        if (this._status != param1.status) {
            this._status = param1.status;
            this.statusMC.setStatus(this._status);
            this.descrTF.textColor = !!this._status ? Number(QuestsStates.CLR_TASK_TF_WITH_STATUS) : Number(QuestsStates.CLR_TASK_TF_NORMAL);
            this.descrTF.validateNow();
        }
    }

    private function showTooltip(param1:String):void {
        App.toolTipMgr.show(param1);
    }

    private function hideTooltip():void {
        App.toolTipMgr.hide();
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
    }

    private function onNewIndicatorRollOverHandler(param1:MouseEvent):void {
        if (this._questData != null) {
            this.showTooltip(this._questData.eventType == QuestsStates.ACTION ? TOOLTIPS.QUESTS_NEWLABEL_ACTION : TOOLTIPS.QUESTS_NEWLABEL_TASK);
        }
    }

    private function onIndicatorIgrRollOverHandler(param1:MouseEvent):void {
        this.showTooltip(TOOLTIPS.QUESTS_IGR);
    }

    private function onControlClickHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onHitTooltipMcRollOverHandler(param1:MouseEvent):void {
        if (this._questData != null && StringUtils.isNotEmpty(this._questData.tooltip)) {
            this.showTooltip(this._questData.tooltip);
        }
    }
}
}

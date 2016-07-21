package net.wg.gui.lobby.battleResults.components {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.BattleResultsQuestVO;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.QuestsStates;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.events.QuestEvent;
import net.wg.gui.lobby.interfaces.ISubtaskComponent;
import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
import net.wg.gui.lobby.questsWindow.SubtasksList;
import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class BattleResultsEventRenderer extends UIComponentEx implements ISubtaskComponent {

    private static const BOTTOM_PADDING:int = 14;

    private static const LINKBTN_PADDING:int = 12;

    private static const AWARDS_PADDING:int = 5;

    private static const LINK_BTN_Y_OFFSET:int = 4;

    private static const LABELS_OFFSET:int = 2;

    public var taskTF:TextField;

    public var linkBtn:SoundButtonEx;

    public var statusMC:QuestStatusComponent;

    public var counter:QuestsCounter;

    public var awards:QuestAwardsBlock;

    public var progressList:SubtasksList;

    public var alert:MovieClip;

    public var lineMC:MovieClip;

    private var _data:BattleResultsQuestVO = null;

    private var _status:String = "";

    private var _tasksCount:int = -1;

    private var _tooltipMgr:ITooltipMgr;

    private var _linkBtnHasListeners:Boolean = false;

    public function BattleResultsEventRenderer() {
        this._tooltipMgr = App.toolTipMgr;
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.linkBtn.visible = true;
        this.statusMC.visible = false;
        this.counter.visible = false;
        this.linkBtn.focusable = false;
        this.taskTF.mouseEnabled = false;
        this.progressList.linkage = Linkages.PROGRESS_ELEMENT;
        this.taskTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
        this.awards.contentAlign = TextFieldAutoSize.RIGHT;
        this.awards.hasFixedHeight = false;
    }

    override protected function onDispose():void {
        if (this._linkBtnHasListeners) {
            this.linkBtn.removeEventListener(ButtonEvent.CLICK, this.onLinkBtnClickHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onLinkBtnRollOutHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onLinkBtnRollOverHandler);
        }
        this.linkBtn.dispose();
        this.taskTF = null;
        if (this._data) {
            this._data.dispose();
            this._data = null;
        }
        this.counter.dispose();
        this.counter = null;
        this.linkBtn = null;
        this.statusMC.dispose();
        this.statusMC = null;
        this.lineMC = null;
        this.awards.dispose();
        this.awards = null;
        this.alert = null;
        this.progressList.dispose();
        this.progressList = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this._data != null) {
                visible = true;
                this.checkStatus();
                this.checkCounter();
                _loc1_ = this.checkLabels() + BOTTOM_PADDING;
                _loc2_ = this.checkAlertMsg(_loc1_);
                _loc1_ = _loc1_ + (!!_loc2_ ? _loc2_ + BOTTOM_PADDING : 0);
                _loc3_ = this.checkProgressList(_loc1_);
                _loc1_ = _loc1_ + (!!_loc3_ ? _loc3_ + BOTTOM_PADDING : 0);
                _loc1_ = _loc1_ + this.checkAwards(_loc1_);
                this.lineMC.y = _loc1_;
                setSize(width, this.lineMC.y);
                this.linkBtn.visible = this._data.isLinkBtnVisible;
                if (this.linkBtn.visible && !this._linkBtnHasListeners) {
                    this._linkBtnHasListeners = true;
                    this.linkBtn.addEventListener(ButtonEvent.CLICK, this.onLinkBtnClickHandler);
                    this.linkBtn.addEventListener(MouseEvent.ROLL_OUT, this.onLinkBtnRollOutHandler);
                    this.linkBtn.addEventListener(MouseEvent.ROLL_OVER, this.onLinkBtnRollOverHandler);
                }
                dispatchEvent(new Event(Event.RESIZE));
            }
            else {
                visible = false;
            }
        }
    }

    public function disableLinkBtns(param1:Vector.<String>):void {
        this.linkBtn.enabled = param1.indexOf(this._data.questInfo.questID) != -1;
        this.linkBtn.mouseEnabled = true;
    }

    public function setData(param1:Object):void {
        this._data = param1 != null ? new BattleResultsQuestVO(param1) : null;
        invalidateData();
    }

    private function hideTooltip():void {
        this._tooltipMgr.hide();
    }

    private function checkAwards(param1:int):int {
        this.awards.setActualWidth(this.progressList.width);
        this.awards.setData(this._data.awards);
        this.awards.visible = this._data.awards && this._data.awards.length;
        this.awards.validateNow();
        this.awards.y = param1 + AWARDS_PADDING;
        return this.awards.height > 0 ? int(this.awards.height + AWARDS_PADDING) : 0;
    }

    private function checkProgressList(param1:int):int {
        this.progressList.y = param1;
        this.progressList.setData(this._data.progressList);
        this.progressList.validateNow();
        return this.progressList.height;
    }

    private function checkAlertMsg(param1:int):int {
        this.alert.visible = Boolean(this._data.alertMsg);
        this.alert.msgTF.text = this._data.alertMsg;
        this.alert.y = param1;
        return !!StringUtils.isNotEmpty(this._data.alertMsg) ? int(TextField(this.alert.msgTF).textHeight) : 0;
    }

    private function checkLabels():int {
        var _loc1_:Boolean = false;
        if (this.taskTF.text != this._data.questInfo.description) {
            this.taskTF.text = this._data.questInfo.description;
            _loc1_ = StringUtils.isNotEmpty(this.taskTF.text);
            this.linkBtn.x = (!!_loc1_ ? this.taskTF.x + this.taskTF.getLineMetrics(this.taskTF.numLines - 1).width + LINKBTN_PADDING : this.taskTF.x) | 0;
            this.linkBtn.y = (!!_loc1_ ? this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height : this.taskTF.y) + LINK_BTN_Y_OFFSET | 0;
            this.taskTF.mouseEnabled = false;
        }
        return this.linkBtn.y + this.linkBtn.height + LABELS_OFFSET;
    }

    private function checkCounter():void {
        if (this._tasksCount != this._data.questInfo.tasksCount) {
            this._tasksCount = this._data.questInfo.tasksCount;
            if (this._tasksCount >= 0 && StringUtils.isEmpty(this._status)) {
                this.counter.visible = true;
                this.counter.textField.text = this._tasksCount.toString();
            }
            else {
                this.counter.visible = false;
            }
        }
    }

    private function checkStatus():void {
        if (this._status != this._data.questInfo.status) {
            this._status = this._data.questInfo.status;
            this.statusMC.setStatus(this._status);
            this.taskTF.textColor = !!StringUtils.isNotEmpty(this._status) ? uint(QuestsStates.CLR_TASK_TF_WITH_STATUS) : uint(QuestsStates.CLR_TASK_TF_NORMAL);
        }
    }

    private function onLinkBtnRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onLinkBtnRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.show(!!this.linkBtn.enabled ? TOOLTIPS.QUESTS_LINKBTN_TASK : TOOLTIPS.QUESTS_DISABLELINKBTN_TASK);
    }

    private function onLinkBtnClickHandler(param1:ButtonEvent):void {
        this.hideTooltip();
        var _loc2_:QuestEvent = new QuestEvent(QuestEvent.SELECT_QUEST, this._data.questInfo.questID);
        _loc2_.eventType = this._data.questInfo.eventType;
        dispatchEvent(_loc2_);
    }
}
}

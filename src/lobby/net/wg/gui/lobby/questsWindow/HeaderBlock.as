package net.wg.gui.lobby.questsWindow {
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.QuestsStates;
import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.lobby.components.ProgressIndicator;
import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
import net.wg.gui.lobby.questsWindow.data.HeaderDataVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.data.DataProvider;

public class HeaderBlock extends UIComponent {

    public static const CONTENT_TABS_PADDING:int = 30;

    public static const LOWER_TABS_PADDING:int = 15;

    private static const VERTICAL_PADDING:int = 20;

    private static const MIDDLE_PADDING:int = 12;

    private static const TEXT_MARGIN:int = 10;

    private static const COUNTER_NO_DATA:int = -1;

    private static const COUNTER_X:int = 347;

    private static const STATUS_MARGIN:int = 18;

    private static const TIME_TF_PADDING:int = 6;

    private static const COUNTER_PADDING:int = 5;

    public var labelTF:TextField;

    public var timeTF:TextField;

    public var counter:QuestsCounter;

    public var bg:MovieClip;

    public var maskMC:MovieClip;

    public var progressIndicator:ProgressIndicator;

    public var contentTabs:ContentTabBar;

    public var statusMC:MovieClip;

    private var _headerData:HeaderDataVO = null;

    private var _noProgress:Boolean = true;

    public function HeaderBlock() {
        super();
        this.counter.visible = false;
        this.progressIndicator.visible = false;
    }

    override protected function onDispose():void {
        this.progressIndicator.dispose();
        this.counter.dispose();
        this._headerData = null;
        this.contentTabs.dispose();
        this.contentTabs = null;
        this.hitArea = null;
        this.counter = null;
        this.labelTF = null;
        this.timeTF = null;
        this.statusMC = null;
        this.bg = null;
        this.maskMC = null;
        this.progressIndicator = null;
        super.onDispose();
    }

    public function setData(param1:HeaderDataVO):void {
        this._headerData = param1;
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.maskMC.height = 0;
        this.bg.mouseEnabled = false;
        this.bg.mouseChildren = false;
        this.hitArea = this.maskMC;
        this.contentTabs.dataProvider = new DataProvider([{
            "label": QUESTS.QUESTS_CONDITIONS,
            "data": QuestsStates.CONDITIONS,
            "tooltip": ""
        }, {
            "label": QUESTS.QUESTS_REQUIREMENTS,
            "data": QuestsStates.REQUIREMENTS,
            "tooltip": ""
        }]);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this._headerData) {
                this.setTexts();
                this.checkStatus();
                this.checkCounter();
                this.checkProgress();
                this.layoutComponents();
            }
            else {
                setSize(this.width, 0);
            }
            dispatchEvent(new Event(Event.RESIZE));
        }
    }

    private function setTexts():void {
        this.labelTF.htmlText = this._headerData.title;
        this.timeTF.htmlText = this._headerData.date;
    }

    private function layoutComponents():void {
        this.labelTF.height = this.labelTF.textHeight + TEXT_MARGIN;
        this.timeTF.height = this.timeTF.textHeight + TEXT_MARGIN;
        var _loc1_:Number = this.labelTF.textHeight + this.labelTF.y;
        this.timeTF.y = Math.round(_loc1_ + MIDDLE_PADDING);
        var _loc2_:Number = this.timeTF.textHeight + this.timeTF.y;
        this.statusMC.y = Math.round(!!this.timeTF.text ? Number(_loc2_ + TIME_TF_PADDING) : Number(this.timeTF.y));
        var _loc3_:Number = Math.round(TextField(this.statusMC.textField).textHeight + this.statusMC.y);
        var _loc4_:Boolean = true;
        if (this._headerData.eventType == QuestsStates.ACTION || !this._headerData.hasRequirements) {
            _loc4_ = false;
            this.contentTabs.selectedIndex = 0;
        }
        else if (!this._headerData.hasConditions) {
            _loc4_ = false;
            this.contentTabs.selectedIndex = 1;
        }
        this.contentTabs.visible = _loc4_;
        this.contentTabs.y = Math.round(_loc3_ + CONTENT_TABS_PADDING);
        this.bg.y = !!_loc4_ ? Number(this.contentTabs.y + LOWER_TABS_PADDING) : Number(_loc3_ + VERTICAL_PADDING);
        this.maskMC.height = this._headerData.status == QuestsStates.DONE ? Number(this.bg.y) : Number(0);
        setSize(this.width, this.bg.y | 0);
    }

    private function checkProgress():void {
        this.progressIndicator.visible = Boolean(this._headerData.progrBarType) && !this._noProgress;
        if (this._headerData.progrBarType) {
            this.progressIndicator.setValues(this._headerData.progrBarType, this._headerData.currentProgrVal, this._headerData.maxProgrVal);
            this.progressIndicator.setTooltip(this._headerData.progrTooltip);
            this.progressIndicator.validateNow();
        }
    }

    private function checkCounter():void {
        this.counter.textField.text = this._headerData.tasksCount.toString();
        if (this._headerData.tasksCount > COUNTER_NO_DATA && !this._noProgress) {
            this.counter.visible = true;
            this.progressIndicator.y = Math.round(this.counter.y + this.counter.height - COUNTER_PADDING);
        }
        else {
            this.counter.visible = false;
            this.progressIndicator.y = Math.round(this.counter.y + this.counter.height / 2);
        }
    }

    private function checkStatus():void {
        this._noProgress = false;
        if (this._headerData.status == QuestsStates.NOT_AVAILABLE) {
            this.statusMC.gotoAndStop(QuestsStates.NOT_AVAILABLE);
            this._noProgress = this._headerData.tasksCount <= 0 && this._headerData.currentProgrVal <= 0;
            this.counter.x = COUNTER_X + STATUS_MARGIN;
            this.labelTF.textColor = QuestsStates.CLR_TASK_TF_WITH_STATUS;
        }
        else if (this._headerData.status == QuestsStates.DONE) {
            this.statusMC.gotoAndStop(QuestsStates.DONE);
            this.counter.x = COUNTER_X + STATUS_MARGIN;
            this.labelTF.textColor = QuestsStates.CLR_TASK_TF_WITH_STATUS;
        }
        else {
            this.statusMC.gotoAndStop(QuestsStates.ANOTHER);
            this.labelTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
            this.counter.x = COUNTER_X + STATUS_MARGIN;
        }
        TextField(this.statusMC.textField).text = this._headerData.statusDescription;
        TextField(this.statusMC.textField).height = TextField(this.statusMC.textField).textHeight + TEXT_MARGIN;
        this.statusMC.visible = Boolean(this._headerData.statusDescription);
    }
}
}

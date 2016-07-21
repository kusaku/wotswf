package net.wg.gui.lobby.quests.views {
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.ResizableScrollPane;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.events.ScrollPaneEvent;
import net.wg.gui.lobby.quests.components.QuestTaskDescription;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
import net.wg.gui.lobby.quests.events.QuestTaskDetailsViewEvent;
import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class QuestTaskDetailsView extends UIComponentEx implements IViewStackContent, IFocusChainContainer {

    private static const SCROLLBAR_AWARD_GAP:int = 10;

    private static const TASK_DESCRIPTION_OFFSET:int = 50;

    public static const INVALIDATION_TYPE_LAYOUT:String = "layoutInvalid";

    public var headerTF:TextField = null;

    public var scrollPane:ResizableScrollPane = null;

    public var descriptionBlock:QuestTaskDescription = null;

    public var awardsBlock:QuestAwardsBlock = null;

    public var scrollBar:ScrollBar = null;

    public var applyBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var taskDescriptionTF:TextField = null;

    private var _model:QuestTaskDetailsVO = null;

    public function QuestTaskDetailsView() {
        super();
    }

    override protected function onDispose():void {
        this.scrollPane.removeEventListener(ScrollPaneEvent.POSITION_CHANGED, this.onScrollPositionChangedHandler);
        this.scrollPane.dispose();
        this.scrollPane = null;
        this.awardsBlock.removeEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.awardsBlock.dispose();
        this.awardsBlock = null;
        this.scrollBar.removeEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.scrollBar.dispose();
        this.scrollBar = null;
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyBtnClickHandler);
        this.applyBtn.removeEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.applyBtn.dispose();
        this.applyBtn = null;
        this.cancelBtn.removeEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.descriptionBlock.removeEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.descriptionBlock = null;
        this._model = null;
        this.taskDescriptionTF = null;
        this.headerTF = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.scrollBar.addEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.scrollPane.scrollBar = this.scrollBar;
        this.scrollPane.addEventListener(ScrollPaneEvent.POSITION_CHANGED, this.onScrollPositionChangedHandler);
        this.applyBtn.dynamicSizeByText = true;
        this.applyBtn.mouseEnabledOnDisabled = true;
        this.applyBtn.addEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyBtnClickHandler);
        this.cancelBtn.dynamicSizeByText = true;
        this.cancelBtn.mouseEnabledOnDisabled = true;
        this.cancelBtn.addEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.descriptionBlock = QuestTaskDescription(this.scrollPane.target);
        this.descriptionBlock.addEventListener(Event.RESIZE, this.onChildResizeHandler);
        this.taskDescriptionTF.wordWrap = true;
        this.taskDescriptionTF.multiline = true;
        this.taskDescriptionTF.mouseEnabled = false;
        this.awardsBlock.showFlagBottom = false;
        this.awardsBlock.addEventListener(Event.RESIZE, this.onChildResizeHandler);
    }

    override protected function draw():void {
        super.draw();
        var _loc1_:Boolean = isInvalid(InvalidationType.SIZE, INVALIDATION_TYPE_LAYOUT);
        if (_loc1_) {
            this.layoutChildren();
        }
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        if (this.cancelBtn.visible) {
            _loc1_[_loc1_.length] = this.cancelBtn;
        }
        else if (this.applyBtn.visible) {
            _loc1_[_loc1_.length] = this.applyBtn;
        }
        return _loc1_;
    }

    public function update(param1:Object):void {
        this._model = QuestTaskDetailsVO(param1);
        this.commitData();
        this.layoutChildren();
    }

    protected function commitData():void {
        if (this._model == null) {
            this.visible = false;
            return;
        }
        this.visible = true;
        this.headerTF.htmlText = this._model.headerText;
        this.descriptionBlock.text = this._model.conditionsText;
        this.applyBtn.visible = this._model.isApplyBtnVisible;
        if (this.applyBtn.visible) {
            this.applyBtn.enabled = this._model.isApplyBtnEnabled;
            this.applyBtn.label = this._model.btnLabel;
            this.applyBtn.tooltip = !!this._model.btnToolTip ? this._model.btnToolTip : Values.EMPTY_STR;
            this.applyBtn.validateNow();
        }
        this.cancelBtn.visible = this._model.isCancelBtnVisible;
        if (this.cancelBtn.visible) {
            this.cancelBtn.label = this._model.btnLabel;
            this.cancelBtn.tooltip = !!this._model.btnToolTip ? this._model.btnToolTip : Values.EMPTY_STR;
            this.cancelBtn.validateNow();
        }
        this.taskDescriptionTF.htmlText = this._model.taskDescriptionText;
        this.awardsBlock.autoHeight = !this.applyBtn.visible && !this.cancelBtn.visible;
        this.awardsBlock.setData(this._model.mainAwards, this._model.addAwards);
        this.awardsBlock.validateNow();
        this.scrollPane.scrollPosition = 0;
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    protected function layoutChildren():void {
        this.awardsBlock.y = this.height - this.awardsBlock.height ^ 0;
        this.scrollPane.height = this.awardsBlock.y - this.scrollPane.y - SCROLLBAR_AWARD_GAP;
        this.scrollPane.validateNow();
        this.scrollBar.height = this.scrollPane.height;
        if (this.applyBtn.visible) {
            this.applyBtn.x = this.awardsBlock.width - this.applyBtn.width >> 1;
        }
        if (this.cancelBtn.visible) {
            this.cancelBtn.x = this.awardsBlock.width - this.cancelBtn.width >> 1;
        }
        this.taskDescriptionTF.y = (this.headerTF.y >> 0) + TASK_DESCRIPTION_OFFSET - (this.taskDescriptionTF.height >> 1);
    }

    private function onChildResizeHandler(param1:Event):void {
        invalidate(INVALIDATION_TYPE_LAYOUT);
    }

    private function onScrollPositionChangedHandler(param1:ScrollPaneEvent):void {
        invalidate(INVALIDATION_TYPE_LAYOUT);
    }

    private function onApplyBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new QuestTaskDetailsViewEvent(QuestTaskDetailsViewEvent.SELECT_TASK, this._model.taskID));
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new QuestTaskDetailsViewEvent(QuestTaskDetailsViewEvent.CANCEL_TASK, this._model.taskID));
    }
}
}

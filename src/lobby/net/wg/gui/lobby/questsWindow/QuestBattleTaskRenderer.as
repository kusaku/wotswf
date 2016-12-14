package net.wg.gui.lobby.questsWindow {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.QuestsStates;
import net.wg.gui.components.assets.interfaces.INewIndicator;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.components.ProgressIndicator;
import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
import net.wg.gui.lobby.questsWindow.events.IQuestRenderer;

import org.idmedia.as3commons.util.StringUtils;

public class QuestBattleTaskRenderer extends SoundListItemRenderer implements IQuestRenderer {

    private static const COMPLEX_COUNTER_Y:int = 13;

    private static const PROGRESS_INDICATOR_Y:int = 45;

    private static const DEF_PROGRESS_INDICATOR_Y:int = 34;

    private static const DEF_COUNTER_Y:int = 27;

    private static const DESCRIPTION_Y:int = 15;

    private static const DEF_DESCRIPTION_Y:int = 25;

    private static const TIMER_Y:int = 36;

    private static const DEF_TIMER_Y:int = 46;

    private static const IGR_PADDING:int = 5;

    private static const RENDERER_DATA:String = "rendererData";

    private static const EMPTY_GROUP_STATUS:String = "";

    private static const TITLE_Y:int = 21;

    private static const DEF_TITLE_Y:int = 11;

    private static const ALPHA_DESCRIPTION:Number = 0.6;

    private static const ALPHA_DESCRIPTION_DISABLED:Number = 0.3;

    public var timer:TextField = null;

    public var action:MovieClip = null;

    public var counter:QuestsCounter = null;

    public var backgroundGroup:MovieClip = null;

    public var description:TextFieldShort = null;

    public var indicatorIGR:UILoaderAlt = null;

    public var newIndicator:INewIndicator = null;

    public var questStatus:QuestStatusComponent = null;

    public var backgroundImageLoader:UILoaderAlt = null;

    public var selectedQuestBackground:MovieClip = null;

    public var progressIndicator:ProgressIndicator = null;

    public var title:TextField = null;

    public var status:TextField = null;

    public var arrowOpen:MovieClip = null;

    public var arrowHower:MovieClip = null;

    public var arrowNormal:MovieClip = null;

    public var hirAreaMc:MovieClip = null;

    private var _questData:QuestRendererVO = null;

    public function QuestBattleTaskRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._questData = QuestRendererVO(param1);
        invalidate(RENDERER_DATA);
    }

    override protected function configUI():void {
        super.configUI();
        this.mouseChildren = true;
        this.mouseEnabled = true;
        this.addListeners();
        this.hitArea = this.hirAreaMc;
        this.buttonMode = true;
        this.mouseEnabledOnDisabled = true;
        this.newIndicator.hitArea = this.newIndicator.hitMC;
        this.newIndicator.mouseChildren = false;
        this.title.visible = false;
        this.action.visible = false;
        this.status.visible = false;
        this.counter.visible = false;
        this.arrowOpen.visible = false;
        this.arrowHower.visible = false;
        this.description.visible = false;
        this.arrowNormal.visible = false;
        this.questStatus.visible = false;
        this.newIndicator.visible = false;
        this.indicatorIGR.visible = false;
        this.progressIndicator.visible = false;
        this.backgroundGroup.visible = false;
        this.selectedQuestBackground.visible = false;
        this.description.useDropShadow = false;
    }

    override protected function onDispose():void {
        this.removeListeners();
        this.counter.dispose();
        this.counter = null;
        this.indicatorIGR.dispose();
        this.indicatorIGR = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        this.questStatus.dispose();
        this.questStatus = null;
        this.backgroundImageLoader.dispose();
        this.backgroundImageLoader = null;
        this.progressIndicator.dispose();
        this.progressIndicator = null;
        this.description.dispose();
        this.description = null;
        this.action = null;
        this.timer = null;
        this.backgroundGroup = null;
        this.selectedQuestBackground = null;
        this.title = null;
        this.status = null;
        this.arrowOpen = null;
        this.arrowHower = null;
        this.arrowNormal = null;
        this.hirAreaMc = null;
        this._questData = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        var _loc2_:Boolean = false;
        super.draw();
        if (isInvalid(RENDERER_DATA)) {
            if (this._questData != null) {
                _loc1_ = this._questData.isSelectable;
                buttonMode = _loc1_;
                enabled = _loc1_;
                this.mouseChildren = true;
                _loc2_ = this._questData.showBckgrImage;
                this.backgroundImageLoader.visible = _loc2_;
                if (_loc2_) {
                    this.backgroundImageLoader.source = this._questData.bckgrImage;
                }
                if (this._questData.isTitle) {
                    this.titleMode();
                }
                else {
                    this.questRendererMode();
                }
                this.visible = true;
            }
            else {
                this.visible = false;
            }
        }
    }

    public function hideNew():void {
        this.newIndicator.hide();
    }

    private function questRendererMode():void {
        this.title.visible = false;
        this.status.visible = false;
        this.arrowOpen.visible = false;
        this.arrowHower.visible = false;
        this.arrowNormal.visible = false;
        this.selectedQuestBackground.visible = true;
        this.action.visible = this._questData.eventType == QuestsStates.ACTION;
        this.timer.htmlText = this._questData.timerDescription;
        this.description.label = this._questData.description;
        if (this._questData.isAvailable) {
            this.description.alpha = ALPHA_DESCRIPTION;
        }
        else {
            this.description.alpha = ALPHA_DESCRIPTION_DISABLED;
        }
        if (StringUtils.isNotEmpty(this._questData.timerDescription)) {
            this.timer.y = TIMER_Y;
            this.description.y = DESCRIPTION_Y;
        }
        else {
            this.timer.y = DEF_TIMER_Y;
            this.description.y = DEF_DESCRIPTION_Y;
        }
        this.updateNewIndicator();
        this.updateIGRIndicator();
        this.checkCounter();
        this.checkProgress();
        this.checkStatus();
        this.timer.visible = true;
        this.description.visible = true;
        this.backgroundGroup.visible = false;
    }

    private function titleMode():void {
        this.timer.visible = false;
        this.action.visible = false;
        this.counter.visible = false;
        this.backgroundGroup.visible = true;
        this.description.visible = false;
        this.questStatus.setStatus(null);
        this.newIndicator.visible = false;
        this.indicatorIGR.visible = false;
        this.progressIndicator.visible = false;
        this.selectedQuestBackground.visible = false;
        this.title.htmlText = this._questData.description;
        this.title.visible = true;
        if (this._questData.groupStatus != EMPTY_GROUP_STATUS) {
            this.status.htmlText = this._questData.groupStatus;
            this.status.visible = true;
            this.title.y = DEF_TITLE_Y;
        }
        else {
            this.status.visible = false;
            this.title.y = TITLE_Y;
        }
        this.arrowOpen.visible = this._questData.isOpen;
        this.arrowHower.visible = !this._questData.isOpen;
        this.arrowNormal.visible = !this._questData.isOpen;
    }

    private function updateNewIndicator():void {
        this.newIndicator.visible = this._questData.isNew;
        this.newIndicator.pause();
    }

    private function updateIGRIndicator():void {
        this.indicatorIGR.visible = this._questData.IGR;
        if (this.indicatorIGR.visible) {
            this.indicatorIGR.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREMIUM_SMALL;
            this.indicatorIGR.y = this.description.y + IGR_PADDING;
        }
    }

    private function checkProgress():void {
        if (this._questData.progrBarType && !this._questData.status) {
            this.progressIndicator.visible = true;
            this.progressIndicator.setValues(this._questData.progrBarType, this._questData.currentProgrVal, this._questData.maxProgrVal);
            this.progressIndicator.setTooltip(this._questData.progrTooltip);
            this.progressIndicator.y = DEF_PROGRESS_INDICATOR_Y;
        }
        else {
            this.progressIndicator.visible = false;
        }
        if (this.counter.visible && this.progressIndicator.visible) {
            this.counter.y = COMPLEX_COUNTER_Y;
            this.progressIndicator.y = PROGRESS_INDICATOR_Y;
        }
    }

    private function checkCounter():void {
        if (this._questData.tasksCount >= 0 && !this._questData.status) {
            this.counter.visible = true;
            this.counter.textField.text = this._questData.tasksCount.toString();
            this.counter.y = DEF_COUNTER_Y;
        }
        else {
            this.counter.visible = false;
        }
    }

    private function checkStatus():void {
        this.questStatus.setStatus(this._questData.status);
    }

    private function addListeners():void {
        addEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        addEventListener(MouseEvent.ROLL_OVER, this.onHitAreaRollOverHandler);
        this.indicatorIGR.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.indicatorIGR.addEventListener(MouseEvent.ROLL_OVER, this.onIndicatorIgrRollOverHandler);
        this.newIndicator.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.newIndicator.addEventListener(MouseEvent.ROLL_OVER, this.onNewIndicatorRollOverHandler);
    }

    private function removeListeners():void {
        removeEventListener(MouseEvent.CLICK, this.onControlClickHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        removeEventListener(MouseEvent.ROLL_OVER, this.onHitAreaRollOverHandler);
        this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OVER, this.onIndicatorIgrRollOverHandler);
        this.newIndicator.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.newIndicator.removeEventListener(MouseEvent.ROLL_OVER, this.onNewIndicatorRollOverHandler);
    }

    private function showTooltip(param1:String):void {
        App.toolTipMgr.show(param1);
    }

    private function hideTooltip():void {
        App.toolTipMgr.hide();
    }

    override public function set mouseChildren(param1:Boolean):void {
        super.mouseChildren = param1;
    }

    private function onHitAreaRollOverHandler(param1:MouseEvent):void {
        if (!this._questData.isTitle) {
            this.showTooltip(this._questData.tooltip);
        }
    }

    private function onNewIndicatorRollOverHandler(param1:MouseEvent):void {
        if (this._questData != null) {
            this.showTooltip(this._questData.eventType == QuestsStates.ACTION ? TOOLTIPS.QUESTS_NEWLABEL_ACTION : TOOLTIPS.QUESTS_NEWLABEL_TASK);
        }
    }

    private function onIndicatorIgrRollOverHandler(param1:MouseEvent):void {
        this.showTooltip(TOOLTIPS.QUESTS_IGR);
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onControlClickHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }
}
}

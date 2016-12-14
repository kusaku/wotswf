package net.wg.gui.lobby.window {
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.data.MissionAwardWindowVO;
import net.wg.gui.lobby.quests.components.AwardCarousel;
import net.wg.gui.lobby.quests.components.RadioButtonScrollBar;
import net.wg.gui.lobby.questsWindow.ConditionBlock;
import net.wg.infrastructure.base.meta.IMissionAwardWindowMeta;
import net.wg.infrastructure.base.meta.impl.MissionAwardWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class MissionAwardWindow extends MissionAwardWindowMeta implements IMissionAwardWindowMeta {

    private static const DESCRIPTION_COMMON_OFFSET:int = 10;

    private static const AVAILABLE_QUEST_OFFSET:int = 15;

    private static const STATUS_ICON_OFFSET:int = 3;

    private static const PERSONAL_QUEST_ARROW_Y:int = 32;

    private static const COMMON_QUEST_ARROW_Y:int = -17;

    private static const NEXT_DESCRIPTION_OFFSET:int = 2;

    private static const NEXT_HEADER_OFFSET:int = 10;

    private static const ADDITIANAL_STATUS_OFFSET:int = 8;

    private static const ADDITIANAL_QUEST_BTN_OFFSET_Y:int = 3;

    private static const ADDITIANAL_QUEST_BTN_OFFSET_X:int = 5;

    private static const NOT_AVAILABLE_MISSION_OFFSET:int = 16;

    private static const NOT_AVAILABLE_COMMON_OFFSET:int = 26;

    private static const WINDOW_HEIGHT_OFFSET:int = 23;

    private static const NEXT_BUTTON_AVAILABLE_OFFSET:int = 12;

    private static const NEXT_BUTTON_NOT_AVAILABLE_OFFSET:int = 32;

    private static const NEXT_BUTTON_NOT_PERSONAL:int = 8;

    private static const CONDITION_BLOCK_OFFSET:int = 12;

    private static const MAIN_STATUS_OFFSET:int = 6;

    private static const WINDOW_WIDTH:int = 446;

    private static const DOTS:String = "...";

    private static const MAX_LINE_NUMBER:uint = 2;

    private static const UPDATE_POSITION_INV:String = "updatePositionInv";

    public var descriptionTF:TextField = null;

    public var headerTF:TextField = null;

    public var currentQuestConditionsTF:TextField = null;

    public var mainStatusTF:TextField = null;

    public var currentQuestHeaderTF:TextField = null;

    public var arrow:MovieClip = null;

    public var separator:MovieClip = null;

    public var nextQuestButton:SoundButtonEx = null;

    public var availableQuestTF:TextField = null;

    public var nextQuestHeaderTF:TextField = null;

    public var nextQuestConditionsTF:TextField = null;

    public var additionalStatusTF:TextField = null;

    public var ribbonImage:UILoaderAlt = null;

    public var backImage:UILoaderAlt = null;

    public var additionalStatusIcon:Image = null;

    public var mainStatusIcon:Image = null;

    public var additionalLinkBtn:SoundButtonEx = null;

    public var awardCarousel:AwardCarousel = null;

    public var radioButtonScrollBar:RadioButtonScrollBar = null;

    public var conditionsBlock:ConditionBlock = null;

    public var isImageIsLoaded:Boolean = false;

    private var _dataVO:MissionAwardWindowVO = null;

    public function MissionAwardWindow() {
        super();
    }

    override protected function setData(param1:MissionAwardWindowVO):void {
        this._dataVO = param1;
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.currentQuestConditionsTF.autoSize = TextFieldAutoSize.LEFT;
        this.currentQuestConditionsTF.multiline = true;
        this.nextQuestConditionsTF.autoSize = TextFieldAutoSize.LEFT;
        this.nextQuestConditionsTF.multiline = true;
        this.additionalStatusTF.autoSize = TextFieldAutoSize.LEFT;
        this.nextQuestButton.addEventListener(ButtonEvent.CLICK, this.onNextQuestButtonClickHandler);
        this.additionalLinkBtn.addEventListener(ButtonEvent.CLICK, this.onAdditionalLinkBtnClickHandler);
        this.additionalStatusIcon.addEventListener(Event.CHANGE, this.onImageIconChangeHandler);
        this.mainStatusIcon.addEventListener(Event.CHANGE, this.onImageIconChangeHandler);
        this.radioButtonScrollBar.setScroller(this.awardCarousel.scrollList);
        this.conditionsBlock.addEventListener(Event.RESIZE, this.onConditionsBlockResizeHandler);
        this.currentQuestHeaderTF.autoSize = TextFieldAutoSize.LEFT;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._dataVO != null) {
            window.title = this._dataVO.windowTitle;
            this.backImage.source = this._dataVO.backImage;
            this.ribbonImage.source = this._dataVO.ribbonImage;
            this.additionalStatusIcon.source = this._dataVO.additionalStatusIcon;
            this.mainStatusIcon.source = this._dataVO.mainStatusIcon;
            this.headerTF.htmlText = this._dataVO.header;
            this.descriptionTF.htmlText = this._dataVO.description;
            this.currentQuestHeaderTF.htmlText = this._dataVO.currentQuestHeader;
            this.setTruncatedHtmlText(this.currentQuestConditionsTF, this._dataVO.currentQuestConditions, MAX_LINE_NUMBER);
            this.nextQuestHeaderTF.htmlText = this._dataVO.nextQuestHeader;
            this.setTruncatedHtmlText(this.nextQuestConditionsTF, this._dataVO.nextQuestConditions, MAX_LINE_NUMBER);
            this.availableQuestTF.htmlText = this._dataVO.availableText;
            this.additionalStatusTF.htmlText = this._dataVO.additionalStatusText;
            this.mainStatusTF.htmlText = this._dataVO.mainStatusText;
            this.nextQuestButton.label = this._dataVO.nextButtonText;
            this.nextQuestButton.tooltip = this._dataVO.nextButtonTooltip;
            this.awardCarousel.dataProvider = this._dataVO.awards;
            this.conditionsBlock.setData(this._dataVO.conditions);
            this.updateVisibleComponents();
        }
        if (isInvalid(UPDATE_POSITION_INV) && this.isImageIsLoaded && this._dataVO != null) {
            this.updatePosition();
        }
    }

    override protected function onDispose():void {
        this.descriptionTF = null;
        this.headerTF = null;
        this.currentQuestConditionsTF = null;
        this.mainStatusTF = null;
        this.currentQuestHeaderTF = null;
        this.arrow = null;
        this.availableQuestTF = null;
        this.nextQuestHeaderTF = null;
        this.nextQuestConditionsTF = null;
        this.additionalStatusTF = null;
        this.separator = null;
        this.backImage.dispose();
        this.backImage = null;
        this.ribbonImage.dispose();
        this.ribbonImage = null;
        this.nextQuestButton.removeEventListener(ButtonEvent.CLICK, this.onNextQuestButtonClickHandler);
        this.nextQuestButton.dispose();
        this.nextQuestButton = null;
        this.additionalLinkBtn.removeEventListener(ButtonEvent.CLICK, this.onAdditionalLinkBtnClickHandler);
        this.additionalLinkBtn.dispose();
        this.additionalLinkBtn = null;
        this.additionalStatusIcon.removeEventListener(Event.CHANGE, this.onImageIconChangeHandler);
        this.additionalStatusIcon.dispose();
        this.additionalStatusIcon = null;
        this.mainStatusIcon.removeEventListener(Event.CHANGE, this.onImageIconChangeHandler);
        this.mainStatusIcon.dispose();
        this.mainStatusIcon = null;
        this.awardCarousel.dispose();
        this.awardCarousel = null;
        this.radioButtonScrollBar.dispose();
        this.radioButtonScrollBar = null;
        this.conditionsBlock.removeEventListener(Event.RESIZE, this.onConditionsBlockResizeHandler);
        this.conditionsBlock.dispose();
        this.conditionsBlock = null;
        this._dataVO = null;
        App.utils.scheduler.cancelTask(this.setContentHeight);
        super.onDispose();
    }

    private function updateVisibleComponents():void {
        this.conditionsBlock.visible = !this._dataVO.isPersonalQuest && this._dataVO.conditions.length;
        this.currentQuestConditionsTF.visible = this._dataVO.isPersonalQuest;
        this.additionalLinkBtn.visible = this._dataVO.isPersonalQuest;
        this.additionalStatusTF.visible = this._dataVO.isPersonalQuest;
        this.additionalStatusIcon.visible = this._dataVO.isPersonalQuest;
        this.nextQuestHeaderTF.visible = this._dataVO.isPersonalQuest && this._dataVO.availableNextQuest;
        this.nextQuestConditionsTF.visible = this.nextQuestHeaderTF.visible;
        this.availableQuestTF.visible = this._dataVO.availableNextQuest && !this._dataVO.isLastQuest;
        this.arrow.visible = this._dataVO.availableNextQuest;
        if (this._dataVO.isPersonalQuest) {
            this.separator.visible = !this.arrow.visible && this._dataVO.isLastQuest;
        }
        else {
            this.separator.visible = !this.arrow.visible && !this._dataVO.isLastQuest;
        }
        this.nextQuestButton.visible = this.arrow.visible || this.separator.visible;
    }

    private function updatePosition():void {
        this.mainStatusTF.y = this.currentQuestHeaderTF.y + this.currentQuestHeaderTF.height + MAIN_STATUS_OFFSET ^ 0;
        if (this._dataVO.isPersonalQuest) {
            this.currentQuestConditionsTF.y = this.mainStatusTF.y + this.mainStatusTF.height ^ 0;
            this.arrow.y = this.currentQuestConditionsTF.y + this.currentQuestConditionsTF.height + PERSONAL_QUEST_ARROW_Y ^ 0;
            this.additionalStatusTF.y = this.currentQuestConditionsTF.y + this.currentQuestConditionsTF.height + ADDITIANAL_STATUS_OFFSET ^ 0;
            this.additionalLinkBtn.y = this.additionalStatusTF.y + (this.additionalStatusTF.height - this.additionalLinkBtn.height >> 1) + ADDITIANAL_QUEST_BTN_OFFSET_Y ^ 0;
            this.additionalLinkBtn.x = this.additionalStatusTF.x + this.additionalStatusTF.width + ADDITIANAL_QUEST_BTN_OFFSET_X ^ 0;
            this.availableQuestTF.y = this.arrow.y + this.arrow.height - AVAILABLE_QUEST_OFFSET ^ 0;
            this.nextQuestHeaderTF.y = this.availableQuestTF.y + this.availableQuestTF.height + NEXT_HEADER_OFFSET ^ 0;
            this.nextQuestConditionsTF.y = this.nextQuestHeaderTF.y + this.nextQuestHeaderTF.height + NEXT_DESCRIPTION_OFFSET ^ 0;
            if (this._dataVO.availableNextQuest) {
                this.nextQuestButton.y = this.nextQuestConditionsTF.y + this.nextQuestConditionsTF.height + NEXT_BUTTON_AVAILABLE_OFFSET ^ 0;
            }
            else {
                this.nextQuestButton.y = this.separator.y + this.separator.height - NEXT_BUTTON_NOT_AVAILABLE_OFFSET;
            }
        }
        else {
            this.descriptionTF.y = this.headerTF.y - DESCRIPTION_COMMON_OFFSET ^ 0;
            this.conditionsBlock.y = this.mainStatusTF.y + CONDITION_BLOCK_OFFSET ^ 0;
            this.arrow.y = this.conditionsBlock.y + this.conditionsBlock.height + COMMON_QUEST_ARROW_Y ^ 0;
            this.availableQuestTF.y = this.arrow.y + this.arrow.height ^ 0;
            this.nextQuestButton.y = this.availableQuestTF.y + this.availableQuestTF.height + NEXT_BUTTON_NOT_PERSONAL ^ 0;
        }
        this.mainStatusIcon.y = this.mainStatusTF.y + STATUS_ICON_OFFSET ^ 0;
        this.additionalStatusIcon.y = this.additionalStatusTF.y + STATUS_ICON_OFFSET;
        App.utils.scheduler.scheduleOnNextFrame(this.setContentHeight);
    }

    private function setContentHeight():void {
        var _loc1_:Number = NaN;
        if (this._dataVO.isPersonalQuest) {
            if (this.nextQuestButton.visible) {
                _loc1_ = this.nextQuestButton.y + this.nextQuestButton.height + NOT_AVAILABLE_MISSION_OFFSET;
            }
            else {
                _loc1_ = this.additionalStatusTF.y + this.additionalStatusTF.height + WINDOW_HEIGHT_OFFSET;
            }
        }
        else if (this.nextQuestButton.visible) {
            _loc1_ = this.nextQuestButton.y + this.nextQuestButton.height + NOT_AVAILABLE_COMMON_OFFSET;
        }
        else {
            _loc1_ = this.conditionsBlock.y + this.conditionsBlock.height + WINDOW_HEIGHT_OFFSET;
        }
        window.updateSize(WINDOW_WIDTH, _loc1_, true);
        this.updateWindowPosition();
    }

    private function updateWindowPosition():void {
        window.x = App.appWidth - window.width >> 1;
        window.y = App.appHeight - window.height >> 1;
    }

    private function setTruncatedHtmlText(param1:TextField, param2:String, param3:uint):void {
        var _loc4_:String = param2;
        param1.htmlText = _loc4_;
        while (param1.numLines > param3) {
            _loc4_ = _loc4_.substr(0, _loc4_.length - 1);
            param1.htmlText = _loc4_ + DOTS;
        }
    }

    private function onImageIconChangeHandler(param1:Event):void {
        this.isImageIsLoaded = true;
        invalidate(UPDATE_POSITION_INV);
    }

    private function onConditionsBlockResizeHandler(param1:Event):void {
        invalidate(UPDATE_POSITION_INV);
    }

    private function onAdditionalLinkBtnClickHandler(param1:ButtonEvent):void {
        onNextQuestClickS();
    }

    private function onNextQuestButtonClickHandler(param1:ButtonEvent):void {
        onCurrentQuestClickS();
    }
}
}

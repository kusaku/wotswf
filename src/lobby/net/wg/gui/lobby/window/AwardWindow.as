package net.wg.gui.lobby.window {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.advanced.DashLine;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.HyperLink;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.data.AwardWindowTakeNextBtnVO;
import net.wg.gui.data.AwardWindowVO;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.battleResults.components.MedalsList;
import net.wg.gui.lobby.components.AwardWindowAnimationController;
import net.wg.gui.lobby.components.StoppableAnimationLoader;
import net.wg.gui.lobby.components.events.StoppableAnimationLoaderEvent;
import net.wg.gui.lobby.components.interfaces.IAwardWindow;
import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationController;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoader;
import net.wg.gui.lobby.quests.components.TaskAwardsBlock;
import net.wg.infrastructure.base.meta.impl.AwardWindowMeta;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;

public class AwardWindow extends AwardWindowMeta implements IAwardWindow {

    private static const DASH_LINE_HORIZONTAL_OFFSET:Number = 20;

    private static const DASH_LINE_VERTICAL_TOP_PADDING:Number = 6;

    private static const DASH_LINE_VERTICAL_BOTTOM_PADDING:Number = 17;

    private static const DEFAULT_VERTICAL_OFFSET:Number = 10;

    private static const TEXTAREA_VERTICAL_OFFSET:Number = 8;

    private static const AWARD_IMAGE_BOTTOM_OFFSET:Number = 40;

    private static const MIN_BUTTON_WIDTH:Number = 136;

    private static const TAKE_NEXT_BUTTON_PADDING:uint = 18;

    private static const TEXT_ANTI_ALIASING_OFFSET:uint = 5;

    private static const TEXT_AREA_DEFAULT_WIDTH:int = 417;

    private static const TEXT_AREA_DEFAULT_X:int = 18;

    private static const TEXT_AREA_ICON_RIGHT_PADDING:int = -7;

    private static const CLOSE_BTN_HEIGHT_OFFSET:int = -1;

    private static const MAX_TEXT_AREA_HEIGHT:uint = 160;

    private static const CHECKBOX_VERTICAL_OFFSET:int = 27;

    private static const WARNING_TF_VERTICAL_OFFSET:int = 17;

    public var backImage:UILoaderAlt = null;

    public var awardImage:UILoaderAlt = null;

    public var packImage:UILoaderAlt = null;

    public var medalsList:MedalsList = null;

    public var headerTF:TextField = null;

    public var textArea:TextAreaSimple = null;

    public var textAreaIcon:UILoaderAlt = null;

    public var additionalTF:TextField = null;

    public var dashLine:DashLine = null;

    public var okButton:ISoundButtonEx = null;

    public var defaultTakeNextBtn:ISoundButtonEx = null;

    public var christmasTakeNextBtn:ISoundButtonEx = null;

    public var closeBtn:ISoundButtonEx = null;

    public var taskAwardsBlock:TaskAwardsBlock = null;

    public var checkBox:CheckBox = null;

    public var warningTF:TextField = null;

    public var warningHyperlink:HyperLink = null;

    private var _model:AwardWindowVO = null;

    private var _backAnimationLoader:IStoppableAnimationLoader = null;

    private var _animationsController:IAwardWindowAnimationController = null;

    private var _endAnimation:Boolean = false;

    private var _playAnimation:Boolean = false;

    private var _currentWidth:int = 0;

    private var _currentHeight:int = 0;

    private var _buttonsForFocus:Vector.<InteractiveObject> = null;

    private var _takeNextBtn:ISoundButtonEx = null;

    private var _isModal:Boolean = true;

    private var _canDrag:Boolean = false;

    public function AwardWindow() {
        super();
        isCentered = true;
        this._animationsController = AwardWindowAnimationController.instance;
    }

    override protected function onLeaveModalFocus():void {
        super.onLeaveModalFocus();
        this.disableAnimation();
    }

    override protected function configUI():void {
        super.configUI();
        this.okButton.minWidth = MIN_BUTTON_WIDTH;
        this.okButton.autoSize = TextFieldAutoSize.CENTER;
        this.okButton.addEventListener(ButtonEvent.CLICK, this.onOkButtonClickHandler);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.backImage.autoSize = false;
        this.backImage.addEventListener(UILoaderEvent.COMPLETE, this.onBackImageCompleteHandler);
        this.awardImage.autoSize = false;
        this.awardImage.addEventListener(UILoaderEvent.COMPLETE, this.onAwardImageCompleteHandler);
        this.headerTF.wordWrap = true;
        this.headerTF.multiline = true;
        this.dashLine.x = DASH_LINE_HORIZONTAL_OFFSET;
        this.dashLine.width = width - (DASH_LINE_HORIZONTAL_OFFSET << 1);
        this.textAreaIcon.visible = false;
        this.textAreaIcon.autoSize = false;
        this.checkBox.visible = false;
        this.checkBox.autoSize = TextFieldAutoSize.LEFT;
        this.warningHyperlink.visible = false;
        this._buttonsForFocus = new <InteractiveObject>[InteractiveObject(this.defaultTakeNextBtn), InteractiveObject(this.christmasTakeNextBtn), InteractiveObject(this.okButton), InteractiveObject(this.closeBtn), window.getCloseBtn()];
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.getButtonForFocus());
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(param1);
        setFocus(this.getButtonForFocus());
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.setContentHeight);
        this.okButton.removeEventListener(ButtonEvent.CLICK, this.onOkButtonClickHandler);
        this._takeNextBtn.removeEventListener(ButtonEvent.CLICK, this.onTakeNextBtnClickHandler);
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.okButton.dispose();
        this.okButton = null;
        this.dashLine.dispose();
        this.dashLine = null;
        this.backImage.removeEventListener(UILoaderEvent.COMPLETE, this.onBackImageCompleteHandler);
        this.backImage.dispose();
        this.backImage = null;
        this.awardImage.removeEventListener(UILoaderEvent.COMPLETE, this.onAwardImageCompleteHandler);
        this.awardImage.dispose();
        this.awardImage = null;
        this.packImage.dispose();
        this.packImage = null;
        this.textArea.dispose();
        this.textArea = null;
        this.medalsList.dispose();
        this.medalsList = null;
        this.headerTF = null;
        this.additionalTF = null;
        this.taskAwardsBlock.dispose();
        this.taskAwardsBlock = null;
        this.defaultTakeNextBtn.dispose();
        this.defaultTakeNextBtn = null;
        this.christmasTakeNextBtn.dispose();
        this.christmasTakeNextBtn = null;
        this._takeNextBtn = null;
        this.textAreaIcon.removeEventListener(UILoaderEvent.COMPLETE, this.onTextAreaIconCompleteHandler);
        this.textAreaIcon.dispose();
        this.textAreaIcon = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.checkBox.removeEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        this.checkBox.dispose();
        this.checkBox = null;
        this.warningTF = null;
        this.warningHyperlink.removeEventListener(ButtonEvent.CLICK, this.onWarningHyperlinkClickHandler);
        this.warningHyperlink.dispose();
        this.warningHyperlink = null;
        this._buttonsForFocus.splice(0, this._buttonsForFocus.length);
        this._buttonsForFocus = null;
        this._animationsController.unregisterAnimation(this);
        if (this._backAnimationLoader != null) {
            this._backAnimationLoader.removeEventListener(StoppableAnimationLoaderEvent.ANIMATION_START, this.onBackAnimationLoaderAnimationStartHandler);
            this._backAnimationLoader.dispose();
            this._backAnimationLoader = null;
        }
        this._animationsController = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:ICommons = null;
        var _loc2_:Boolean = false;
        var _loc3_:* = false;
        super.draw();
        if (this._model == null) {
            return;
        }
        if (this._model && isInvalid(InvalidationType.DATA)) {
            _loc1_ = App.utils.commons;
            this.updateComponentsVisible();
            window.title = this._model.windowTitle;
            _loc2_ = this._model.useBackAnimation;
            if (this._endAnimation) {
                _loc2_ = this._model.useEndedBackAnimation;
            }
            this.awardImage.visible = !_loc2_;
            if (this._backAnimationLoader != null) {
                this._backAnimationLoader.visible = _loc2_;
                if (!_loc2_) {
                    this._backAnimationLoader.endAnimation();
                }
            }
            if (_loc2_) {
                if (this._backAnimationLoader == null) {
                    this.createBackAnimationLoader();
                }
                this._backAnimationLoader.setData(this._model.animationData);
                if (this._endAnimation) {
                    this._backAnimationLoader.endAnimation();
                }
                else if (this._model.autoControlBackAnimation || this._playAnimation) {
                    this._backAnimationLoader.playAnimation();
                }
            }
            _loc3_ = !_loc2_;
            if (!_loc3_) {
                _loc3_ = Boolean(this._model.forceUseBackImage);
            }
            this.backImage.visible = _loc3_;
            if (_loc3_) {
                this.backImage.source = this._model.backImage;
            }
            if (this._model.hasAchievements) {
                if (this.medalsList.dataProvider != null) {
                    this.medalsList.dataProvider.cleanUp();
                }
                this.medalsList.dataProvider = new DataProvider(this._model.achievements);
            }
            else if (!_loc2_) {
                this.awardImage.source = this._model.awardImage;
            }
            if (this.packImage.visible = StringUtils.isNotEmpty(this._model.packImage)) {
                this.packImage.source = this._model.packImage;
            }
            this.headerTF.htmlText = this._model.header;
            _loc1_.updateTextFieldSize(this.headerTF, false, true);
            if (this._model.textAreaIconIsShow) {
                this.textAreaIcon.source = this._model.textAreaIconPath;
                this.textAreaIcon.addEventListener(UILoaderEvent.COMPLETE, this.onTextAreaIconCompleteHandler);
            }
            this.textArea.htmlText = this._model.description;
            this.textArea.position = 0;
            if (StringUtils.isNotEmpty(this._model.additionalText)) {
                this.additionalTF.htmlText = this._model.additionalText;
                _loc1_.updateTextFieldSize(this.additionalTF, false, true);
            }
            this.okButton.label = this._model.buttonText;
            this.closeBtn.label = this._model.closeBtnLabel;
            if (this._model.awardsBlock != null) {
                this.taskAwardsBlock.setAwardsData(this._model.awardsBlock);
            }
            if (this._model.hasCheckBox) {
                this.checkBox.label = this._model.checkBoxLabel;
                this.checkBox.selected = this._model.isCheckBoxSelected;
                this.checkBox.addEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
            }
            this.warningTF.htmlText = this._model.warningText;
            this.warningHyperlink.label = this._model.warningHyperlinkText;
            if (StringUtils.isNotEmpty(this.warningHyperlink.label)) {
                this.warningHyperlink.addEventListener(ButtonEvent.CLICK, this.onWarningHyperlinkClickHandler);
            }
            setFocus(this.getButtonForFocus());
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateComponentsPosition();
        }
    }

    override protected function setTakeNextBtn(param1:AwardWindowTakeNextBtnVO):void {
        this.defaultTakeNextBtn.visible = false;
        this.christmasTakeNextBtn.visible = false;
        if (StringUtils.isNotEmpty(param1.christmasTakeNextBtnLabel)) {
            this._takeNextBtn = this.christmasTakeNextBtn;
            this._takeNextBtn.label = param1.christmasTakeNextBtnLabel;
        }
        else {
            this._takeNextBtn = this.defaultTakeNextBtn;
            this._takeNextBtn.label = param1.takeNextBtnLabel;
        }
        if (param1.isTakeNextBtnEnabled) {
            this._takeNextBtn.visible = true;
            this._takeNextBtn.addEventListener(ButtonEvent.CLICK, this.onTakeNextBtnClickHandler);
        }
        invalidateSize();
    }

    override protected function setData(param1:AwardWindowVO):void {
        this._model = param1;
        if (this._model.useBackAnimation) {
            this._animationsController.registerAnimation(this);
        }
        invalidateData();
    }

    public function as_endAnimation():void {
        this.endAnimation();
    }

    public function as_startAnimation():void {
        this._playAnimation = true;
        if (this._backAnimationLoader != null) {
            this._backAnimationLoader.playAnimation();
        }
    }

    public function disableAnimation():void {
        if (this._model != null && !this._model.autoControlBackAnimation) {
            return;
        }
        this.endAnimation();
    }

    private function endAnimation():void {
        this._endAnimation = true;
        if (this._backAnimationLoader != null) {
            this._backAnimationLoader.endAnimation();
        }
    }

    private function createBackAnimationLoader():void {
        this._backAnimationLoader = new StoppableAnimationLoader();
        this._backAnimationLoader.addEventListener(StoppableAnimationLoaderEvent.ANIMATION_START, this.onBackAnimationLoaderAnimationStartHandler);
        addChildAt(DisplayObject(this._backAnimationLoader), getChildIndex(this.backImage));
        this._backAnimationLoader.x = this.backImage.x;
        this._backAnimationLoader.y = this.backImage.y;
    }

    private function updateComponentsPosition():void {
        var _loc7_:int = 0;
        this.headerTF.y = this._model.headerTextOffset;
        this.updateTextAreaBlockPosition();
        var _loc1_:int = 0;
        var _loc2_:int = Math.min(this.textArea.textHeight + 1, MAX_TEXT_AREA_HEIGHT);
        if (this._model.textAreaIconIsShow) {
            _loc1_ = this.textAreaIcon.height;
        }
        _loc1_ = Math.max(_loc1_, _loc2_);
        this.textArea.height = _loc1_;
        var _loc3_:int = this.textArea.y + _loc1_ + TEXT_ANTI_ALIASING_OFFSET;
        if (StringUtils.isNotEmpty(this.additionalTF.text)) {
            if (this._model.isDashLineEnabled) {
                this.dashLine.y = _loc3_ + DASH_LINE_VERTICAL_TOP_PADDING ^ 0;
                _loc3_ = this.dashLine.y + DASH_LINE_VERTICAL_BOTTOM_PADDING;
            }
            else {
                _loc3_ = _loc3_ + DEFAULT_VERTICAL_OFFSET;
            }
            this.additionalTF.y = _loc3_;
            _loc3_ = this.additionalTF.y + this.additionalTF.textHeight;
        }
        if (StringUtils.isNotEmpty(this.warningTF.text)) {
            this.warningTF.y = _loc3_ + WARNING_TF_VERTICAL_OFFSET;
            _loc3_ = this.warningTF.y + this.warningTF.textHeight;
        }
        if (this.warningHyperlink.visible) {
            this.warningHyperlink.y = _loc3_;
            this.warningHyperlink.x = width - this.warningHyperlink.actualWidth >> 1;
            _loc3_ = _loc3_ + this.warningHyperlink.height;
        }
        if (this._model.hasCheckBox) {
            this.checkBox.y = _loc3_ + CHECKBOX_VERTICAL_OFFSET;
            _loc3_ = this.checkBox.y + this.checkBox.height;
        }
        if (this._takeNextBtn.visible) {
            this._takeNextBtn.minWidth = MIN_BUTTON_WIDTH;
            this._takeNextBtn.autoSize = TextFieldAutoSize.CENTER;
            _loc3_ = _loc3_ + TAKE_NEXT_BUTTON_PADDING;
            this._takeNextBtn.y = _loc3_;
            _loc3_ = this._takeNextBtn.y + this._takeNextBtn.height;
        }
        this._takeNextBtn.x = this.width - this._takeNextBtn.width >> 1;
        _loc3_ = _loc3_ + this._model.bottomButtonsPadding;
        this.okButton.y = this.closeBtn.y = _loc3_;
        var _loc4_:Number = this.width;
        var _loc5_:Number = this.closeBtn.y + this.closeBtn.height + CLOSE_BTN_HEIGHT_OFFSET ^ 0;
        var _loc6_:int = this._model.minWindowHeight;
        if (_loc5_ < _loc6_) {
            _loc7_ = _loc6_ - _loc5_;
            _loc5_ = _loc6_;
            this.okButton.y = this.okButton.y + _loc7_;
            this.closeBtn.y = this.closeBtn.y + _loc7_;
            this._takeNextBtn.y = this._takeNextBtn.y + _loc7_;
        }
        if (_loc4_ != this._currentWidth || _loc5_ != this._currentHeight) {
            this._currentWidth = _loc4_;
            this._currentHeight = _loc5_;
            App.utils.scheduler.scheduleOnNextFrame(this.setContentHeight);
        }
    }

    private function updateComponentsVisible():void {
        var _loc1_:Boolean = StringUtils.isNotEmpty(this.additionalTF.text);
        var _loc2_:Boolean = this._model.hasAchievements;
        this.medalsList.visible = _loc2_;
        this.awardImage.visible = !_loc2_;
        this.okButton.visible = this._model.isOKBtnEnabled;
        this.closeBtn.visible = this._model.isCloseBtnEnabled;
        this.additionalTF.visible = _loc1_;
        this.dashLine.visible = _loc1_ && this._model.isDashLineEnabled;
        this.taskAwardsBlock.visible = this._model.awardsBlock != null;
        this.checkBox.visible = this._model.hasCheckBox;
        this.warningHyperlink.visible = StringUtils.isNotEmpty(this.warningHyperlink.label);
    }

    private function updateTextAreaBlockPosition():void {
        var _loc2_:int = 0;
        var _loc1_:int = this.headerTF.y + this.headerTF.height + TEXTAREA_VERTICAL_OFFSET;
        if (this._model.textAreaIconIsShow && this.textAreaIcon.visible) {
            _loc2_ = this.textAreaIcon.width;
            this.textArea.x = _loc2_ + TEXT_AREA_DEFAULT_X + TEXT_AREA_ICON_RIGHT_PADDING;
            this.textArea.width = TEXT_AREA_DEFAULT_WIDTH - _loc2_;
            this.textAreaIcon.y = _loc1_;
        }
        else {
            this.textArea.x = TEXT_AREA_DEFAULT_X;
            if (this.textArea.width != TEXT_AREA_DEFAULT_WIDTH) {
                this.textArea.width = TEXT_AREA_DEFAULT_WIDTH;
            }
        }
        this.textArea.y = _loc1_;
    }

    private function setContentHeight():void {
        window.updateSize(this._currentWidth, this._currentHeight, true);
    }

    private function getButtonForFocus():InteractiveObject {
        var _loc1_:int = this._buttonsForFocus.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            if (this._buttonsForFocus[_loc2_].visible) {
                break;
            }
            _loc2_++;
        }
        return this._buttonsForFocus[_loc2_];
    }

    override public function get isModal():Boolean {
        return this._isModal;
    }

    override public function set isModal(param1:Boolean):void {
        this._isModal = param1;
    }

    override public function get canDrag():Boolean {
        return this._canDrag;
    }

    override public function set canDrag(param1:Boolean):void {
        this._canDrag = param1;
    }

    private function onTextAreaIconCompleteHandler(param1:UILoaderEvent):void {
        this.textAreaIcon.removeEventListener(UILoaderEvent.COMPLETE, this.onTextAreaIconCompleteHandler);
        this.textAreaIcon.visible = true;
        this.updateTextAreaBlockPosition();
    }

    private function onAwardImageCompleteHandler(param1:UILoaderEvent):void {
        this.awardImage.x = this.backImage.x + (this.backImage.width - this.awardImage.width) >> 1;
        this.awardImage.y = this.backImage.y + this.backImage.height - this.awardImage.height - AWARD_IMAGE_BOTTOM_OFFSET | 0;
    }

    private function onBackImageCompleteHandler(param1:UILoaderEvent):void {
        this.backImage.scaleX = this.backImage.scaleY = 1;
        this.backImage.x = this.width - this.backImage.width >> 1;
    }

    private function onOkButtonClickHandler(param1:ButtonEvent):void {
        onOKClickS();
    }

    private function onTakeNextBtnClickHandler(param1:ButtonEvent):void {
        onTakeNextClickS();
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        onCloseClickS();
    }

    private function onCheckBoxSelectHandler(param1:Event):void {
        onCheckBoxSelectS(this.checkBox.selected);
    }

    private function onWarningHyperlinkClickHandler(param1:ButtonEvent):void {
        onWarningHyperlinkClickS();
    }

    private function onBackAnimationLoaderAnimationStartHandler(param1:StoppableAnimationLoaderEvent):void {
        onAnimationStartS();
    }
}
}

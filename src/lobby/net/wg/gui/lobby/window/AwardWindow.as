package net.wg.gui.lobby.window {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.advanced.DashLine;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.data.AwardWindowVO;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.battleResults.components.MedalsList;
import net.wg.gui.lobby.components.AwardWindowAnimationController;
import net.wg.gui.lobby.components.StoppableAnimationLoader;
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

    private static const MIN_WINDOW_HEIGHT:uint = 427;

    private static const BOTTOM_BUTTONS_PADDING:uint = 23;

    private static const TAKE_NEXT_BUTTON_PADDING:uint = 18;

    private static const TEXT_ANTI_ALIASING_OFFSET:uint = 5;

    private static const TEXT_AREA_DEFAULT_WIDTH:int = 417;

    private static const TEXT_AREA_DEFAULT_X:int = 18;

    private static const TEXT_AREA_ICON_RIGHT_PADDING:int = -7;

    private static const CLOSE_BTN_HEIGHT_OFFSET:int = -1;

    private static const MAX_TEXT_AREA_HEIGHT:uint = 160;

    public var backImage:UILoaderAlt = null;

    public var awardImage:UILoaderAlt = null;

    public var medalsList:MedalsList = null;

    public var headerTF:TextField = null;

    public var textArea:TextAreaSimple = null;

    public var textAreaIcon:UILoaderAlt = null;

    public var additionalTF:TextField = null;

    public var dashLine:DashLine = null;

    public var okButton:ISoundButtonEx = null;

    public var takeNextBtn:ISoundButtonEx = null;

    public var closeBtn:ISoundButtonEx = null;

    public var taskAwardsBlock:TaskAwardsBlock = null;

    private var _model:AwardWindowVO = null;

    private var _backAnimationLoader:IStoppableAnimationLoader = null;

    private var _animationsController:IAwardWindowAnimationController = null;

    private var _useAnimation:Boolean = false;

    private var _currentWidth:int = 0;

    private var _currentHeight:int = 0;

    private var _buttonsForFocus:Vector.<InteractiveObject> = null;

    public function AwardWindow() {
        super();
        isCentered = true;
        isModal = false;
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
        this.takeNextBtn.minWidth = MIN_BUTTON_WIDTH;
        this.takeNextBtn.autoSize = TextFieldAutoSize.CENTER;
        this.takeNextBtn.addEventListener(ButtonEvent.CLICK, this.onTakeNextBtnClickHandler);
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
        this._buttonsForFocus = new <InteractiveObject>[InteractiveObject(this.takeNextBtn), InteractiveObject(this.okButton), InteractiveObject(this.closeBtn), window.getCloseBtn()];
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
        this.takeNextBtn.removeEventListener(ButtonEvent.CLICK, this.onTakeNextBtnClickHandler);
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
        this.textArea.dispose();
        this.textArea = null;
        this.medalsList.dispose();
        this.medalsList = null;
        this.headerTF = null;
        this.additionalTF = null;
        this.taskAwardsBlock.dispose();
        this.taskAwardsBlock = null;
        this.takeNextBtn.dispose();
        this.takeNextBtn = null;
        this.textAreaIcon.removeEventListener(UILoaderEvent.COMPLETE, this.onTextAreaIconCompleteHandler);
        this.textAreaIcon.dispose();
        this.textAreaIcon = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        this._buttonsForFocus.splice(0, this._buttonsForFocus.length);
        this._buttonsForFocus = null;
        this._animationsController.unregisterAnimation(this);
        if (this._backAnimationLoader != null) {
            this._backAnimationLoader.dispose();
            this._backAnimationLoader = null;
        }
        this._animationsController = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:ICommons = null;
        super.draw();
        if (this._model == null) {
            return;
        }
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = App.utils.commons;
            this.updateComponentsVisible();
            window.title = this._model.windowTitle;
            this.awardImage.visible = !this._useAnimation;
            this.backImage.visible = !this._useAnimation;
            if (this._backAnimationLoader != null) {
                this._backAnimationLoader.visible = this._useAnimation;
                if (!this._useAnimation) {
                    this._backAnimationLoader.stopAnimation();
                }
            }
            if (this._useAnimation) {
                if (this._backAnimationLoader == null) {
                    this.createBackAnimationLoader();
                }
                this._backAnimationLoader.setData(this._model.backAnimationData);
            }
            else {
                this.backImage.source = this._model.backImage;
            }
            if (this._model.hasAchievements) {
                this.medalsList.dataProvider = new DataProvider(this._model.achievements);
            }
            else if (!this._useAnimation) {
                this.awardImage.source = this._model.awardImage;
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
            this.takeNextBtn.label = this._model.takeNextBtnLabel;
            this.closeBtn.label = this._model.closeBtnLabel;
            if (this._model.awardsBlock != null) {
                this.taskAwardsBlock.setAwardsData(this._model.awardsBlock);
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateComponentsPosition();
        }
    }

    override protected function setData(param1:AwardWindowVO):void {
        this._model = param1;
        this._useAnimation = this._model.useBackAnimation;
        if (this._useAnimation) {
            this._animationsController.registerAnimation(this);
        }
        invalidateData();
    }

    public function disableAnimation():void {
        this._useAnimation = false;
        if (this._backAnimationLoader != null) {
            this._backAnimationLoader.stopAnimation();
        }
    }

    private function createBackAnimationLoader():void {
        this._backAnimationLoader = new StoppableAnimationLoader();
        addChildAt(DisplayObject(this._backAnimationLoader), getChildIndex(this.backImage));
        this._backAnimationLoader.x = this.backImage.x;
        this._backAnimationLoader.y = this.backImage.y;
    }

    private function updateComponentsPosition():void {
        var _loc6_:int = 0;
        this.updateTextAreaBlockPosition();
        var _loc1_:int = 0;
        var _loc2_:int = Math.min(this.textArea.textHeight + 1, MAX_TEXT_AREA_HEIGHT);
        if (this._model.textAreaIconIsShow) {
            _loc1_ = this.textAreaIcon.height;
        }
        _loc1_ = Math.max(_loc1_, _loc2_);
        this.textArea.height = _loc1_;
        var _loc3_:int = this.textArea.y + _loc1_ + TEXT_ANTI_ALIASING_OFFSET;
        if (StringUtils.isNotEmpty(this._model.additionalText)) {
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
        if (this._model.isTakeNextBtnEnabled) {
            _loc3_ = _loc3_ + TAKE_NEXT_BUTTON_PADDING;
            this.takeNextBtn.y = _loc3_;
            _loc3_ = this.takeNextBtn.y + this.takeNextBtn.height;
        }
        this.takeNextBtn.x = this.width - this.takeNextBtn.width >> 1;
        _loc3_ = _loc3_ + BOTTOM_BUTTONS_PADDING;
        this.okButton.y = this.closeBtn.y = _loc3_;
        var _loc4_:Number = this.width;
        var _loc5_:Number = this.closeBtn.y + this.closeBtn.height + CLOSE_BTN_HEIGHT_OFFSET ^ 0;
        if (_loc5_ < MIN_WINDOW_HEIGHT) {
            _loc6_ = MIN_WINDOW_HEIGHT - _loc5_;
            _loc5_ = MIN_WINDOW_HEIGHT;
            this.okButton.y = this.okButton.y + _loc6_;
            this.closeBtn.y = this.closeBtn.y + _loc6_;
            this.takeNextBtn.y = this.takeNextBtn.y + _loc6_;
        }
        if (_loc4_ != this._currentWidth || _loc5_ != this._currentHeight) {
            this._currentWidth = _loc4_;
            this._currentHeight = _loc5_;
            App.utils.scheduler.scheduleOnNextFrame(this.setContentHeight);
        }
    }

    private function updateComponentsVisible():void {
        var _loc1_:Boolean = false;
        _loc1_ = StringUtils.isNotEmpty(this._model.additionalText);
        var _loc2_:Boolean = this._model.hasAchievements;
        this.medalsList.visible = _loc2_;
        this.awardImage.visible = !_loc2_;
        this.okButton.visible = this._model.isOKBtnEnabled;
        this.takeNextBtn.visible = this._model.isTakeNextBtnEnabled;
        this.closeBtn.visible = this._model.isCloseBtnEnabled;
        this.additionalTF.visible = _loc1_;
        this.dashLine.visible = _loc1_ && this._model.isDashLineEnabled;
        this.taskAwardsBlock.visible = this._model.awardsBlock != null;
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
}
}

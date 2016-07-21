package net.wg.gui.battle.views.battleMessenger {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;

import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
import net.wg.gui.battle.components.buttons.BattleButton;
import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerReceiverVO;
import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerSettingsVO;
import net.wg.gui.battle.views.battleMessenger.interfaces.IBattleMessenger;
import net.wg.infrastructure.base.meta.impl.BattleMessengerMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.utils.IScheduler;

import scaleform.clik.events.InputEvent;
import scaleform.gfx.MouseEventEx;
import scaleform.gfx.TextFieldEx;

public class BattleMessenger extends BattleMessengerMeta implements IBattleMessenger {

    public static const REMOVE_FOCUS:String = "removeFocus";

    public var receiverField:TextField = null;

    public var messageInputField:TextField = null;

    public var hintField:TextField = null;

    public var hintBackground:MovieClip = null;

    public var historyUpBtn:BattleButton = null;

    public var historyDownBtn:BattleButton = null;

    public var historyLastMessageBtn:BattleButton = null;

    public var tooltipSymbol:MovieClip = null;

    public var hit:MovieClip = null;

    public var itemBackground:MovieClip = null;

    public var backgroundLayer:Sprite = null;

    private var _receiverIdx:int = 0;

    private var _countPlaying:int = -1;

    private var _isHintAnimationPlaying:Boolean = false;

    private var _receivers:Vector.<BattleMessengerReceiverVO>;

    private var _tooltipStr:String = "";

    private var _isFocused:Boolean = true;

    private var _isActive:Boolean = false;

    private var _isHistoryEnabled:Boolean = false;

    private var _maxMessages:int = -1;

    private var _maxVisibleMessages:int = -1;

    private var _redMessagesPool:BattleMessengerPool = null;

    private var _greenMessagesPool:BattleMessengerPool = null;

    private var _blackMessagesPool:BattleMessengerPool = null;

    private var _selfMessagesPool:BattleMessengerPool = null;

    private var _messages:Vector.<BattleMessage>;

    private var _topMessageIndex:int = 0;

    private var _bottomMessageIndex:int = 0;

    private var _isTopMessageVisible:Boolean = false;

    private var _isBottomMessageVisible:Boolean = false;

    private var _isFullVisibleMessagesStack:Boolean = false;

    private var _isFullMessagesStack:Boolean = false;

    private var _inactiveStateAlpha:Number = 0.5;

    private var _scheduler:IScheduler;

    private var _isUnlimitedMessageStack:Boolean = false;

    private var _battleSmileyMap:BattleSmileyMap;

    private var _isChannelsInited:Boolean = false;

    private var _selectionBeginIndex:int = 0;

    private var _selectionEndIndex:int = 0;

    private var _defaultReceiverIndex:int = 0;

    private var _selectedTargetOnMouseDown:Object = null;

    private const HINT_ANIMATION_STEPS:int = 5;

    private const MESSAGE_FIELD_AVAILABLE_WIDTH:int = 218;

    private const DEFAULT_RECEIVER_COLOR:int = 9868414;

    public function BattleMessenger() {
        this._receivers = new Vector.<BattleMessengerReceiverVO>();
        this._messages = new Vector.<BattleMessage>();
        this._scheduler = App.utils.scheduler;
        this._battleSmileyMap = new BattleSmileyMap();
        super();
        TextFieldEx.setNoTranslate(this.receiverField, true);
        TextFieldEx.setNoTranslate(this.messageInputField, true);
        TextFieldEx.setNoTranslate(this.hintField, true);
    }

    private static function receiversSort(param1:BattleMessengerReceiverVO, param2:BattleMessengerReceiverVO):int {
        return param1.orderIndex - param2.orderIndex;
    }

    public function as_setReceiver(param1:Object, param2:Boolean):void {
        if (param2) {
            this.clearReceivers();
        }
        this._receivers.push(new BattleMessengerReceiverVO(param1));
        this.updateReveivers();
    }

    public function as_setActive(param1:Boolean):void {
        var _loc2_:BattleMessage = null;
        this._isActive = param1;
        if (!this._isActive && !this._isFocused) {
            for each(_loc2_ in this._messages) {
                _loc2_.setState(BattleMessage.HIDDEN_MES);
            }
        }
    }

    override public function as_setupList(param1:Object):void {
        var _loc2_:BattleMessengerSettingsVO = new BattleMessengerSettingsVO(param1);
        this._maxMessages = _loc2_.maxLinesCount;
        this._isUnlimitedMessageStack = this._maxMessages == -1;
        this._maxVisibleMessages = _loc2_.numberOfMessagesInHistory;
        this._inactiveStateAlpha = _loc2_.inactiveStateAlpha;
        this.setAlpha(this._inactiveStateAlpha);
        this.messageInputField.maxChars = _loc2_.maxMessageLength;
        this.hintField.htmlText = _loc2_.hintStr;
        this._tooltipStr = _loc2_.toolTipStr;
        this._isHistoryEnabled = _loc2_.isHistoryEnabled;
        var _loc3_:int = _loc2_.lifeTime;
        var _loc4_:int = _loc2_.alphaSpeed;
        var _loc5_:Number = _loc2_.lastMessageAlpha;
        var _loc6_:Number = _loc2_.recoveredLatestMessagesAlpha;
        var _loc7_:int = _loc2_.recoveredMessagesLifeTime;
        this._redMessagesPool = new BattleMessengerPool(this._maxMessages, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, BATTLE_MESSAGES_CONSTS.RED_MESSAGE_RENDERER, this._battleSmileyMap);
        this._greenMessagesPool = new BattleMessengerPool(this._maxMessages, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, BATTLE_MESSAGES_CONSTS.GREEN_MESSAGE_RENDERER, this._battleSmileyMap);
        this._blackMessagesPool = new BattleMessengerPool(this._maxMessages, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, BATTLE_MESSAGES_CONSTS.BLACK_MESSAGE_RENDERER, this._battleSmileyMap);
        this._selfMessagesPool = new BattleMessengerPool(this._maxMessages, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, BATTLE_MESSAGES_CONSTS.SELF_MESSAGE_RENDERER, this._battleSmileyMap);
        _loc2_.dispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.receiverField.autoSize = TextFieldAutoSize.LEFT;
        this.historyUpBtn.addClickCallBack(this);
        this.historyDownBtn.addClickCallBack(this);
        this.historyLastMessageBtn.addClickCallBack(this);
        this.unSetFocus();
        this.hit.buttonMode = true;
    }

    public function onButtonClick(param1:Object):void {
        if (param1.name == this.historyUpBtn.name) {
            this.showPrevVisibleMessages();
        }
        else if (param1.name == this.historyDownBtn.name) {
            this.showNextVisibleMessages();
        }
        else if (param1.name == this.historyLastMessageBtn.name) {
            this.showLastIndexMessages();
        }
    }

    override protected function onDispose():void {
        var _loc1_:BattleMessage = null;
        this._scheduler.cancelTask(this.showHintText);
        this._scheduler = null;
        this._battleSmileyMap.dispose();
        this._battleSmileyMap = null;
        this.hit.removeEventListener(MouseEvent.CLICK, this.onBattleMessengerMouseClickHandler);
        this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
        this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
        this.hintBackground.removeEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
        this.hintBackground.removeEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
        this.messageInputField.removeEventListener(KeyboardEvent.KEY_DOWN, this.onMessageInputFieldKeyDownHandler);
        this.messageInputField.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
        this.messageInputField.removeEventListener(InputEvent.INPUT, this.onMessageInputFieldInputHandler);
        App.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
        this.hit.removeEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
        this.hit.removeEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
        App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
        App.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUpHandler);
        App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.unSetFocus);
        for each(_loc1_ in this._messages) {
            this.backgroundLayer.removeChild(_loc1_.background);
            removeChild(_loc1_.messageField);
        }
        this.backgroundLayer = null;
        this._messages.fixed = false;
        this._messages.splice(0, this._messages.length);
        this._messages = null;
        this.clearReceivers();
        this._receivers = null;
        this._selectedTargetOnMouseDown = null;
        this._redMessagesPool.dispose();
        this._redMessagesPool = null;
        this._greenMessagesPool.dispose();
        this._greenMessagesPool = null;
        this._blackMessagesPool.dispose();
        this._blackMessagesPool = null;
        this._selfMessagesPool.dispose();
        this._selfMessagesPool = null;
        this.itemBackground = null;
        this.receiverField = null;
        this.messageInputField = null;
        this.hintField = null;
        this.hintBackground = null;
        this.historyUpBtn.dispose();
        this.historyUpBtn = null;
        this.historyDownBtn.dispose();
        this.historyDownBtn = null;
        this.historyLastMessageBtn.dispose();
        this.historyLastMessageBtn = null;
        this.tooltipSymbol = null;
        this.hit = null;
        super.onDispose();
    }

    public function as_enterPressed(param1:int):void {
        var _loc2_:String = null;
        if (this._isFocused) {
            _loc2_ = this.messageInputField.text;
            if (this._isChannelsInited) {
                if (_loc2_.length > 0) {
                    if (sendMessageToChannelS(param1, _loc2_)) {
                        this.unSetFocus();
                        this.showLastIndexMessages();
                    }
                }
                else {
                    this.unSetFocus();
                }
                this.messageInputField.text = Values.EMPTY_STR;
            }
        }
        else {
            this.receiverIdx = param1;
            this.setFocus();
        }
    }

    public function as_setUserPreferences(param1:String):void {
        this._tooltipStr = param1;
    }

    public function as_toggleCtrlPressFlag(param1:Boolean):void {
        this.hintBackground.mouseEnabled = param1;
        this.tooltipSymbol.mouseEnabled = param1;
        this.hit.mouseEnabled = param1;
    }

    public function as_setReceivers(param1:Array):void {
        this.clearReceivers();
        var _loc2_:int = param1.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this._receivers.push(new BattleMessengerReceiverVO(param1[_loc3_]));
            _loc3_++;
        }
        this.updateReveivers();
    }

    private function updateReveivers():void {
        this._receivers.sort(receiversSort);
        var _loc1_:int = this._receivers.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            if (this._receivers[_loc2_].isByDefault) {
                this._defaultReceiverIndex = _loc2_;
                this._receiverIdx = _loc2_;
                break;
            }
            _loc2_++;
        }
        this.updateReceiverField();
    }

    public function as_enableToSendMessage():void {
        this._isChannelsInited = true;
    }

    public function as_setFocus():void {
        this.setFocus();
    }

    public function as_changeReceiver(param1:int):void {
        this.receiverIdx = param1;
    }

    public function as_showBlackMessage(param1:String):void {
        this.showMessage(param1, this._blackMessagesPool);
    }

    public function as_showGreenMessage(param1:String):void {
        this.showMessage(param1, this._greenMessagesPool);
    }

    public function as_showRedMessage(param1:String):void {
        this.showMessage(param1, this._redMessagesPool);
    }

    public function as_showSelfMessage(param1:String):void {
        this.showMessage(param1, this._selfMessagesPool);
    }

    public function as_unSetFocus():void {
        this.unSetFocus();
        this.messageInputField.text = Values.EMPTY_STR;
    }

    public function getComponentForFocus():InteractiveObject {
        return this.messageInputField;
    }

    private function setAlpha(param1:Number):void {
        this.receiverField.alpha = param1;
        this.itemBackground.alpha = param1;
        this.messageInputField.alpha = param1;
    }

    private function setFocus():void {
        if (!this._isFocused) {
            this.hit.removeEventListener(MouseEvent.CLICK, this.onBattleMessengerMouseClickHandler);
            this._isFocused = true;
            focusable = true;
            this.hit.tabEnabled = false;
            this.receiverField.tabEnabled = false;
            this.hintField.tabEnabled = false;
            tabEnabled = false;
            this.onHideTooltipHandler(null);
            this.setPanelElementsVisibility(true);
            this.tooltipSymbol.addEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
            this.tooltipSymbol.addEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
            this.hintBackground.addEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
            this.hintBackground.addEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
            this.hit.removeEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
            this.hit.removeEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
            this.setAlpha(Values.DEFAULT_ALPHA);
            this.updateReceiverField();
            this.showLastIndexMessages();
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
            this.messageInputField.setSelection(0, this.messageInputField.length);
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUpHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.unSetFocus);
            focusReceivedS();
        }
    }

    private function unSetFocus():void {
        if (this._isFocused) {
            this.hit.addEventListener(MouseEvent.CLICK, this.onBattleMessengerMouseClickHandler);
            this._isFocused = false;
            focusable = false;
            this.onHideTooltipHandler(null);
            this.setPanelElementsVisibility(false);
            this.hintField.visible = false;
            this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
            this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
            this.hintBackground.removeEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
            this.hintBackground.removeEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
            this.hit.addEventListener(MouseEvent.MOUSE_OVER, this.onShowTooltipHandler);
            this.hit.addEventListener(MouseEvent.MOUSE_OUT, this.onHideTooltipHandler);
            this.setAlpha(this._inactiveStateAlpha);
            this.disableInput();
            this.showLastIndexMessages();
            this.historyUpBtn.enabled = false;
            this.historyDownBtn.enabled = false;
            this.historyLastMessageBtn.enabled = false;
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUpHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.unSetFocus);
            dispatchEvent(new Event(REMOVE_FOCUS));
            focusLostS();
        }
    }

    private function pushMessage(param1:BattleMessage):void {
        this._messages.push(param1);
        this.backgroundLayer.addChild(param1.background);
        addChild(param1.messageField);
        param1.x = 0;
        param1.y = -param1.height;
        if (this._isFullVisibleMessagesStack && this._isFocused) {
            if (this._isBottomMessageVisible) {
                if (this._isFullMessagesStack) {
                    this._topMessageIndex--;
                    this._bottomMessageIndex--;
                }
                this.showNextVisibleMessages();
                param1.show(!this._isFocused);
            }
            else if (this._isTopMessageVisible) {
                if (this._isFullMessagesStack) {
                    this.moveUpMessages();
                    this._messages[this._bottomMessageIndex - 1].setState(BattleMessage.VISIBLE_MES);
                }
                param1.setState(BattleMessage.HIDDEN_MES);
            }
            else {
                if (this._isFullMessagesStack) {
                    this._topMessageIndex--;
                    this._bottomMessageIndex--;
                    this.updateIndexes();
                }
                if (this._isTopMessageVisible) {
                    this._messages[this._topMessageIndex].setState(BattleMessage.VISIBLE_MES);
                }
                param1.setState(BattleMessage.HIDDEN_MES);
            }
            if (!this._isUnlimitedMessageStack && !this._isFullMessagesStack && this._messages.length == this._maxMessages) {
                this._isFullMessagesStack = true;
            }
        }
        else {
            if (!this._isFullMessagesStack) {
                this._bottomMessageIndex++;
            }
            this.moveUpMessages();
            if (this._messages.length == this._maxVisibleMessages) {
                this._isFullVisibleMessagesStack = true;
                this.updateIndexes();
            }
            if (!this._isUnlimitedMessageStack && !this._isFullMessagesStack && this._messages.length == this._maxMessages) {
                this._isFullMessagesStack = true;
            }
            param1.show(!(this._isFocused || this._isActive));
        }
        this.showAnimation(!this._isBottomMessageVisible);
    }

    private function setPanelElementsVisibility(param1:Boolean):void {
        this.hintBackground.visible = param1;
        this.tooltipSymbol.visible = param1;
        this.historyUpBtn.visible = param1;
        this.historyDownBtn.visible = param1;
        this.historyLastMessageBtn.visible = param1;
    }

    private function showAnimation(param1:Boolean):void {
        if (param1 && !this._isHintAnimationPlaying) {
            this._isHintAnimationPlaying = true;
            if (this.hintField.visible) {
                this.hintField.visible = false;
            }
            this._countPlaying = 1;
            this._scheduler.cancelTask(this.showHintText);
            this._scheduler.scheduleRepeatableTask(this.showHintText, Time.MILLISECOND_IN_SECOND, this.HINT_ANIMATION_STEPS);
        }
        else if (!param1) {
            this._isHintAnimationPlaying = false;
            this.hintField.visible = false;
            this._scheduler.cancelTask(this.showHintText);
        }
    }

    private function moveDownMessages():void {
        var _loc1_:int = this._messages[this._bottomMessageIndex].height;
        var _loc2_:int = this._topMessageIndex + 1;
        while (_loc2_ < this._bottomMessageIndex) {
            this._messages[_loc2_].y = this._messages[_loc2_].y + _loc1_;
            _loc2_++;
        }
    }

    private function showPrevVisibleMessages():void {
        this._topMessageIndex--;
        this._bottomMessageIndex--;
        this.updateIndexes();
        var _loc1_:BattleMessage = this._messages[this._topMessageIndex];
        _loc1_.setState(!!this._isTopMessageVisible ? int(BattleMessage.VISIBLE_MES) : int(BattleMessage.HIDEHALF_MES));
        this._messages[this._topMessageIndex + 1].setState(BattleMessage.VISIBLE_MES);
        this.moveDownMessages();
        _loc1_.y = this._messages[this._topMessageIndex + 1].y - _loc1_.height;
        this._messages[this._bottomMessageIndex].setState(BattleMessage.HIDDEN_MES);
    }

    private function moveUpMessages():void {
        var _loc1_:int = this._bottomMessageIndex - 1;
        var _loc2_:int = this._messages[_loc1_].height;
        var _loc3_:int = this._topMessageIndex;
        while (_loc3_ < _loc1_) {
            this._messages[_loc3_].y = this._messages[_loc3_].y - _loc2_;
            _loc3_++;
        }
    }

    private function showNextVisibleMessages():void {
        this._topMessageIndex++;
        this._bottomMessageIndex++;
        this.updateIndexes();
        this._messages[this._topMessageIndex - 1].setState(BattleMessage.HIDDEN_MES);
        this._messages[this._topMessageIndex].setState(!!this._isTopMessageVisible ? int(BattleMessage.VISIBLE_MES) : int(BattleMessage.HIDEHALF_MES));
        this.moveUpMessages();
        this._messages[this._bottomMessageIndex - 1].setState(BattleMessage.VISIBLE_MES);
    }

    private function showLastIndexMessages():void {
        var _loc2_:int = 0;
        var _loc6_:BattleMessage = null;
        var _loc1_:int = 0;
        var _loc3_:* = !(this._isFocused || this._isActive);
        var _loc4_:int = this._messages.length;
        var _loc5_:int = !!this._isFocused ? int(BattleMessage.VISIBLE_MES) : int(BattleMessage.RECOVERED_MES);
        _loc2_ = 0;
        while (_loc2_ < _loc4_) {
            this._messages[_loc2_].setState(BattleMessage.HIDDEN_MES);
            _loc2_++;
        }
        this._bottomMessageIndex = _loc4_;
        if (this._isFullVisibleMessagesStack) {
            this._topMessageIndex = this._bottomMessageIndex - this._maxVisibleMessages;
        }
        this.updateIndexes();
        _loc2_ = this._bottomMessageIndex - 1;
        while (_loc2_ >= this._topMessageIndex) {
            _loc6_ = this._messages[_loc2_];
            _loc1_ = _loc1_ - _loc6_.height;
            _loc6_.y = _loc1_;
            _loc6_.clear();
            _loc6_.setState(_loc5_);
            _loc6_.hidingState = _loc3_;
            _loc2_--;
        }
        if (!this._isTopMessageVisible && this._isFocused) {
            this._messages[this._topMessageIndex].setState(BattleMessage.HIDEHALF_MES);
        }
    }

    private function updateIndexes():void {
        this._isTopMessageVisible = this._topMessageIndex == 0;
        this._isBottomMessageVisible = this._bottomMessageIndex == this._messages.length;
        if (this._isBottomMessageVisible) {
            this.showAnimation(false);
        }
        if (this._isHistoryEnabled) {
            this.historyUpBtn.enabled = !this._isTopMessageVisible;
            this.historyDownBtn.enabled = !this._isBottomMessageVisible;
            this.historyLastMessageBtn.enabled = !this._isBottomMessageVisible;
        }
    }

    private function showHintText():void {
        this.hintField.visible = !this.hintField.visible;
        if (this._countPlaying == this.HINT_ANIMATION_STEPS) {
            this._isHintAnimationPlaying = false;
            this._scheduler.cancelTask(this.showHintText);
        }
        this._countPlaying++;
    }

    private function updateReceiverField():void {
        this.receiverField.htmlText = this.receiverLabel;
        var _loc1_:TextFormat = this.messageInputField.getTextFormat();
        _loc1_.color = this.receiverColor;
        this.messageInputField.setTextFormat(_loc1_);
        this.messageInputField.defaultTextFormat = _loc1_;
        if (this.isEnableReceiver && this._isFocused) {
            this.enableInput();
        }
        else {
            this.disableInput();
        }
        this.messageInputField.x = this.receiverField.x + this.receiverField.width;
        this.messageInputField.width = this.MESSAGE_FIELD_AVAILABLE_WIDTH - this.messageInputField.x;
    }

    private function enableInput():void {
        this.messageInputField.addEventListener(KeyboardEvent.KEY_DOWN, this.onMessageInputFieldKeyDownHandler);
        this.messageInputField.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
        this.messageInputField.addEventListener(InputEvent.INPUT, this.onMessageInputFieldInputHandler);
        App.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
        this.messageInputField.selectable = true;
        this.messageInputField.mouseEnabled = true;
        this.messageInputField.type = TextFieldType.INPUT;
    }

    private function disableInput():void {
        this.messageInputField.removeEventListener(KeyboardEvent.KEY_DOWN, this.onMessageInputFieldKeyDownHandler);
        this.messageInputField.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
        this.messageInputField.removeEventListener(InputEvent.INPUT, this.onMessageInputFieldInputHandler);
        App.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
        this.messageInputField.selectable = false;
        this.messageInputField.mouseEnabled = false;
        this.messageInputField.type = TextFieldType.DYNAMIC;
    }

    private function showMessage(param1:String, param2:BattleMessengerPool):void {
        var _loc4_:BattleMessage = null;
        if (this._isFullMessagesStack) {
            _loc4_ = this._messages.shift();
            _loc4_.close();
            this.backgroundLayer.removeChild(_loc4_.background);
            removeChild(_loc4_.messageField);
        }
        var _loc3_:BattleMessage = param2.createItem();
        _loc3_.setData(param1);
        this.pushMessage(_loc3_);
    }

    private function set receiverIdx(param1:int):void {
        if (this._receiverIdx == param1 || param1 >= this._receivers.length) {
            return;
        }
        this._receiverIdx = param1;
        this.updateReceiverField();
    }

    private function get receiverColor():int {
        return this._receivers.length > 0 ? int(this._receivers[this._receiverIdx].inputColor) : int(this.DEFAULT_RECEIVER_COLOR);
    }

    private function get receiverLabel():String {
        return this._receivers.length > 0 ? this._receivers[this._receiverIdx].labelStr : "";
    }

    private function get isEnableReceiver():Boolean {
        return this._receivers.length > 0 ? Boolean(this._receivers[this._receiverIdx].isEnabled) : false;
    }

    private function onHideTooltipHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onShowTooltipHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._tooltipStr);
    }

    private function onMessageInputFieldKeyDownHandler(param1:KeyboardEvent):void {
        var _loc2_:int = param1.keyCode;
        if (_loc2_ == Keyboard.UP) {
            if (!this._isTopMessageVisible) {
                this.showPrevVisibleMessages();
            }
            dispatchEvent(new Event(REMOVE_FOCUS));
        }
        else if (_loc2_ == Keyboard.DOWN) {
            if (!this._isBottomMessageVisible) {
                this.showNextVisibleMessages();
            }
            dispatchEvent(new Event(REMOVE_FOCUS));
        }
        else if (_loc2_ == Keyboard.PAGE_DOWN) {
            if (!this._isBottomMessageVisible) {
                this.showLastIndexMessages();
            }
            dispatchEvent(new Event(REMOVE_FOCUS));
        }
        else {
            this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
            this._selectionEndIndex = this.messageInputField.selectionEndIndex;
        }
    }

    private function onMessageInputFieldInputHandler(param1:InputEvent):void {
        param1.handled = true;
    }

    public function onKeyUpHandler(param1:KeyboardEvent):void {
        var _loc2_:int = param1.keyCode;
        if (_loc2_ == Keyboard.UP || _loc2_ == Keyboard.DOWN || _loc2_ == Keyboard.PAGE_DOWN) {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
            this.messageInputField.setSelection(this._selectionBeginIndex, this._selectionEndIndex);
        }
        else {
            this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
            this._selectionEndIndex = this.messageInputField.selectionEndIndex;
        }
    }

    private function onBattleMessengerMouseClickHandler(param1:MouseEvent):void {
        if (param1 is MouseEventEx) {
            if (MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON) {
                this.setFocus();
                this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
                this._selectionEndIndex = this.messageInputField.selectionEndIndex;
            }
        }
    }

    private function onStageMouseDownHandler(param1:MouseEvent):void {
        this._selectedTargetOnMouseDown = param1.target;
    }

    private function onStageMouseUpHandler(param1:MouseEvent):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (param1 is MouseEventEx) {
            _loc2_ = param1.stageX / stage.scaleX;
            _loc3_ = param1.stageY / stage.scaleY;
            if (param1.target == App.stage || !this.hitTestPoint(_loc2_, _loc3_, false)) {
                this.unSetFocus();
            }
            else if (MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON && this._selectedTargetOnMouseDown != this.messageInputField) {
                this.messageInputField.setSelection(0, this.messageInputField.length);
                dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
            }
        }
        this._selectedTargetOnMouseDown = null;
    }

    private function clearReceivers():void {
        var _loc1_:BattleMessengerReceiverVO = null;
        for each(_loc1_ in this._receivers) {
            _loc1_.dispose();
        }
        this._receivers.fixed = false;
        this._receivers.splice(0, this._receivers.length);
    }
}
}

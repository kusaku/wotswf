package net.wg.gui.battle.views.battleMessenger {
import flash.display.Shape;
import flash.filters.BitmapFilterQuality;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getTimer;

import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.Fonts;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Values;
import net.wg.gui.battle.components.BattleUIComponentsHolder;
import net.wg.infrastructure.managers.IAtlasManager;
import net.wg.utils.IScheduler;

import scaleform.gfx.TextFieldEx;

public class BattleMessage extends BattleUIComponentsHolder {

    public static const DEFAULT_TEXT_WIDTH:int = 360;

    public static const DEFAULT_TEXT_LINE_SPACING:int = 2;

    public static const DEFAULT_TEXT_SIZE:int = 14;

    public static const YELLOW_TEXT_COLOR:int = 16774325;

    public static const GREEN_TEXT_COLOR:int = 7653168;

    public static const RED_TEXT_COLOR:int = 14753553;

    public static const RECOVERED_MES:int = 0;

    public static const HIDEHALF_MES:int = 1;

    public static const HIDDEN_MES:int = 2;

    public static const PRESHOWANIM_MES:int = 3;

    public static const ANIM_MES:int = 4;

    public static const VISIBLE_MES:int = 5;

    public static const TEXT_RIGHT_PADDING:int = 40;

    public static const TEXT_BOTTOM_PADDING:int = 5;

    public static const ANIM_SHOW_INTERVAL:int = 5;

    public static const ANIM_SHOW_STEPS:int = 100;

    public static const ANIM_SHOW_STEP:Number = 0.01;

    public static const TEXT_HEIGHT_OFFSET:int = 4;

    public static const TEXT_OFFSET_X:int = 5;

    public static const TEXT_OFFSET_Y:int = 2;

    public static const RECT_X:int = 6;

    public static const RECT_Y:int = 9;

    public static const RECT_WIDTH:int = 310;

    public static const RECT_HEIGHT:int = 7;

    public static const PLAYER_GREEN_MESSAGE_LEFT_RENDERER:String = "PlayerGreenMessageLeftRenderer";

    public static const PLAYER_RED_MESSAGE_LEFT_RENDERER:String = "PlayerRedMessageLeftRenderer";

    private static const INVALID_MESSAGE_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALID_X_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const INVALID_Y_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    private var _endFadeTime:int = -1;

    private var _x:Number = -1;

    private var _y:Number = -1;

    private var _lifeTime:int = -1;

    private var _fadeTime:int = -1;

    private var _inverseFadeTime:Number = -1;

    public var messageField:TextField;

    public var background:Shape;

    private var _deleteFromPoolFunc:Function = null;

    private var _alphaCurrentStep:int = 0;

    private var _currentStateId:int = -1;

    private var _isHidingState:Boolean = false;

    private var _lastMessageAlpha:Number = -1;

    private var _recoveredLatestMessagesAlpha:Number = -1;

    private var _recoveredMessagesLifeTime:int = -1;

    private var _scheduler:IScheduler;

    private var _atlasManager:IAtlasManager;

    private var _textFormat:TextFormat;

    private var _isHidingShowState:Boolean = false;

    private var _isEnterFrameEnable:Boolean = false;

    public function BattleMessage(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:Function) {
        this.messageField = new TextField();
        this.background = new Shape();
        this._scheduler = App.utils.scheduler;
        this._atlasManager = App.atlasMgr;
        this._textFormat = new TextFormat();
        super();
        this._deleteFromPoolFunc = param6;
        this._lifeTime = param1;
        this._lastMessageAlpha = param3;
        this._recoveredLatestMessagesAlpha = param4;
        this._recoveredMessagesLifeTime = param5;
        this.fadeTime = param2;
        this._textFormat.font = Fonts.FIELD_FONT;
        this._textFormat.size = DEFAULT_TEXT_SIZE;
        this._textFormat.leading = DEFAULT_TEXT_LINE_SPACING;
        this.messageField.multiline = true;
        this.messageField.selectable = false;
        App.utils.commons.setShadowFilterWithParams(this.messageField, 1, 90, 0, 1, 2, 2, 1.2, BitmapFilterQuality.MEDIUM);
        this.messageField.wordWrap = true;
        TextFieldEx.setNoTranslate(this.messageField, true);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_MESSAGE_VISIBILITY)) {
            if (this._currentStateId == VISIBLE_MES) {
                this.background.alpha = Values.DEFAULT_ALPHA;
                this.background.visible = true;
                this.messageField.alpha = Values.DEFAULT_ALPHA;
                this.messageField.visible = true;
            }
            else if (this._currentStateId == RECOVERED_MES) {
                this.background.alpha = this._recoveredLatestMessagesAlpha;
                this.background.visible = true;
                this.messageField.alpha = this._recoveredLatestMessagesAlpha;
                this.messageField.visible = true;
            }
            else if (this._currentStateId == HIDEHALF_MES) {
                this.background.alpha = this._lastMessageAlpha;
                this.background.visible = true;
                this.messageField.alpha = this._lastMessageAlpha;
                this.messageField.visible = true;
            }
            else if (this._currentStateId == HIDDEN_MES) {
                this.clear();
                this.background.alpha = this._recoveredLatestMessagesAlpha;
                this.background.visible = false;
                this.messageField.alpha = this._recoveredLatestMessagesAlpha;
                this.messageField.visible = false;
            }
            else if (this._currentStateId == PRESHOWANIM_MES) {
                this.clear();
                this.background.alpha = 0;
                this.background.visible = true;
                this.messageField.alpha = 0;
                this.messageField.visible = true;
                this._alphaCurrentStep = 0;
                this._scheduler.scheduleRepeatableTask(this.showAnimation, ANIM_SHOW_INTERVAL, ANIM_SHOW_STEPS);
                if (this._isHidingShowState) {
                    if (this._lifeTime > 0) {
                        this._scheduler.scheduleTask(this.onEndLifeHandler, this._lifeTime);
                    }
                    this._isHidingState = true;
                }
            }
        }
        if (isInvalid(INVALID_X_POSITION)) {
            this.messageField.x = this._x + TEXT_OFFSET_X;
            this.background.x = this._x;
        }
        if (isInvalid(INVALID_Y_POSITION)) {
            this.messageField.y = this._y + TEXT_OFFSET_Y;
            this.background.y = this._y;
        }
    }

    public function clear():void {
        this._scheduler.cancelTask(this.showAnimation);
        this.hidingState = false;
        this._isEnterFrameEnable = false;
    }

    public function close():void {
        this.clear();
        this._deleteFromPoolFunc(this);
    }

    override protected function onDispose():void {
        this.clear();
        this._deleteFromPoolFunc = null;
        this.messageField = null;
        this.background = null;
        this._scheduler = null;
        this._atlasManager = null;
        this._textFormat = null;
        super.onDispose();
    }

    public function setData(param1:String):void {
        this.messageField.width = DEFAULT_TEXT_WIDTH;
        this.messageField.htmlText = param1;
        this.messageField.height = this.messageField.textHeight + TEXT_HEIGHT_OFFSET | 0;
        App.utils.commons.updateTextFieldSize(this.messageField, true, false);
        this.background.width = this.messageField.textWidth + TEXT_RIGHT_PADDING | 0;
        this.background.height = this.messageField.height + TEXT_BOTTOM_PADDING | 0;
    }

    public function setRenderer(param1:String):void {
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, param1, this.background.graphics, "", false, true);
        this.background.scale9Grid = new Rectangle(RECT_X, RECT_Y, RECT_WIDTH, RECT_HEIGHT);
        this.updateTextFieldProperties(param1);
    }

    private function updateTextFieldProperties(param1:String):void {
        if (param1 == PLAYER_GREEN_MESSAGE_LEFT_RENDERER) {
            this._textFormat.color = GREEN_TEXT_COLOR;
        }
        else if (param1 == PLAYER_RED_MESSAGE_LEFT_RENDERER) {
            this._textFormat.color = RED_TEXT_COLOR;
        }
        else {
            this._textFormat.color = YELLOW_TEXT_COLOR;
        }
        this.messageField.defaultTextFormat = this._textFormat;
    }

    public function setState(param1:int, param2:Boolean = false):void {
        if (this._currentStateId != param1 || param2) {
            this._currentStateId = param1;
            invalidate(INVALID_MESSAGE_VISIBILITY);
        }
    }

    public function show(param1:Boolean):void {
        this._isHidingShowState = param1;
        this.setState(PRESHOWANIM_MES, true);
    }

    private function showAnimation():void {
        this._alphaCurrentStep++;
        this.background.alpha = this.background.alpha + ANIM_SHOW_STEP;
        this.messageField.alpha = this.messageField.alpha + ANIM_SHOW_STEP;
        if (this._alphaCurrentStep == ANIM_SHOW_STEPS) {
            this.setState(VISIBLE_MES);
            this._scheduler.cancelTask(this.showAnimation);
        }
    }

    private function onEndLifeHandler():void {
        if (this._fadeTime > 0) {
            this._endFadeTime = getTimer() + this._fadeTime;
            this.setState(ANIM_MES);
            this._isEnterFrameEnable = true;
            this._scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
        }
        else {
            this.clear();
            this.setState(HIDDEN_MES);
        }
    }

    public function set hidingState(param1:Boolean):void {
        if (this._isHidingState != param1) {
            this._isHidingState = param1;
            if (this._isHidingState) {
                if (this._recoveredMessagesLifeTime > 0) {
                    this._scheduler.scheduleTask(this.onEndLifeHandler, this._recoveredMessagesLifeTime);
                }
            }
            else {
                this._scheduler.cancelTask(this.onEndLifeHandler);
            }
        }
    }

    public function set x(param1:Number):void {
        if (this._x != param1) {
            this._x = param1;
            invalidate(INVALID_X_POSITION);
        }
    }

    public function get y():Number {
        return this._y;
    }

    public function set y(param1:Number):void {
        if (param1 != this._y) {
            this._y = param1;
            invalidate(INVALID_Y_POSITION);
        }
    }

    public function get width():Number {
        return this.background.width;
    }

    public function get height():Number {
        return this.background.height;
    }

    public function set fadeTime(param1:int):void {
        this._fadeTime = param1;
        this._inverseFadeTime = 1 / this._fadeTime;
    }

    private function onEnterFrameHandler():void {
        if (!this._isEnterFrameEnable) {
            return;
        }
        var _loc1_:int = getTimer();
        var _loc2_:Number = (this._endFadeTime - _loc1_) * this._inverseFadeTime;
        if (_loc2_ < this.messageField.alpha) {
            this.messageField.alpha = _loc2_;
            this.background.alpha = _loc2_;
        }
        if (_loc2_ <= 0) {
            this.clear();
            this.setState(HIDDEN_MES);
        }
        else {
            this._scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
        }
    }
}
}

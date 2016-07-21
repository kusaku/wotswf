package net.wg.gui.battle.views.flagNotification {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.generated.FLAG_NOTIFICATION_CONSTS;
import net.wg.gui.battle.views.flagNotification.containers.FlagNotificationTFsContainer;
import net.wg.infrastructure.base.meta.IFlagNotificationMeta;
import net.wg.infrastructure.base.meta.impl.FlagNotificationMeta;

public class FlagNotification extends FlagNotificationMeta implements IFlagNotificationMeta {

    public static var LABEL_SHOW:String = "show";

    public static var LABEL_DELAY:String = "delay";

    public static var LABEL_HIDE:String = "hide";

    private static const DEFAULT_FRAME:int = 1;

    private static const DELIVERED_FRAME:int = 22;

    private static const HIDE_FRAME:int = 120;

    private static const INVALID_ANIMATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    public var icon:MovieClip = null;

    public var texts:FlagNotificationTFsContainer = null;

    private var _animStack:Vector.<String>;

    private var _messageTF:TextField = null;

    private var _flagCapturedTF:TextField = null;

    private var _flagDeliveredTF:TextField = null;

    private var _flagAbsorbedTF:TextField = null;

    private var _animationInProgress:Boolean = false;

    private var _state:String = "flagDropped";

    private var _lastState:String = "flagDropped";

    private var _animLabel:String;

    private var _isCompActive:Boolean = true;

    private var _isAnimVisible:Boolean = false;

    public function FlagNotification() {
        this._animStack = new Vector.<String>();
        this._animLabel = LABEL_HIDE;
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }

    override protected function configUI():void {
        super.configUI();
        this._messageTF = this.texts.messageTF;
        this._messageTF.text = INGAME_GUI.FLAGNOTIFICATION_FLAGINBASE;
        this._flagCapturedTF = this.texts.flagCapturedTF;
        this._flagCapturedTF.text = INGAME_GUI.FLAGNOTIFICATION_FLAGCAPTURED;
        this._flagDeliveredTF = this.texts.flagDeliveredTF;
        this._flagDeliveredTF.text = INGAME_GUI.FLAGNOTIFICATION_FLAGDELIVERED;
        this._flagAbsorbedTF = this.texts.flagAbsorbedTF;
        this._flagAbsorbedTF.text = INGAME_GUI.FLAGNOTIFICATION_FLAGABSORBED;
        addFrameScript(DELIVERED_FRAME, this.onAnimationFinished);
        addFrameScript(HIDE_FRAME, this.onAnimationFinished);
        this.hide();
    }

    public function as_setActive(param1:Boolean):void {
        this._isCompActive = param1;
        this.updateVisibility();
    }

    override protected function updateVisibility():void {
        visible = _isCompVisible && this._isCompActive && this._isAnimVisible;
    }

    override protected function onDispose():void {
        this.hide();
        this.icon = null;
        this.texts.dispose();
        this.texts = null;
        this._animStack.splice(0, this._animStack.length);
        this._animStack = null;
        this._messageTF = null;
        this._flagCapturedTF = null;
        this._flagDeliveredTF = null;
        this._flagAbsorbedTF = null;
        super.onDispose();
    }

    public function as_setState(param1:String):void {
        if (param1 == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_CAPTURED && this._lastState == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_CAPTURED) {
            this.startAnimation(FLAG_NOTIFICATION_CONSTS.STATE_FLAG_DROPPED);
        }
        this.startAnimation(param1);
        this._lastState = param1;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE)) {
            this._messageTF.visible = false;
            this._flagCapturedTF.visible = false;
            this._flagDeliveredTF.visible = false;
            this._flagAbsorbedTF.visible = false;
            if (this._state == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_CAPTURED) {
                this._messageTF.visible = true;
                this._flagCapturedTF.visible = true;
            }
            else if (this._state == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_DELIVERED) {
                this._flagDeliveredTF.visible = true;
            }
            else if (this._state == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_ABSORBED) {
                this._flagAbsorbedTF.visible = true;
            }
        }
        if (isInvalid(INVALID_ANIMATION)) {
            this.icon.play();
            gotoAndPlay(this._animLabel);
        }
    }

    protected function startAnimation(param1:String):void {
        this.isAnimVisible = true;
        if (this._animationInProgress) {
            this._animStack.push(param1);
        }
        else {
            this.showAnimation(param1);
        }
    }

    protected function showAnimation(param1:String):void {
        if (this._state != param1) {
            this._state = param1;
            if (this._state != FLAG_NOTIFICATION_CONSTS.STATE_FLAG_DROPPED) {
                invalidateState();
            }
        }
        this._animationInProgress = true;
        invalidate(INVALID_ANIMATION);
        this._animLabel = this._state == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_DROPPED ? LABEL_HIDE : LABEL_SHOW;
    }

    protected function onAnimationFinished():void {
        var _loc1_:Boolean = false;
        if (this._state == FLAG_NOTIFICATION_CONSTS.STATE_FLAG_CAPTURED) {
            if (currentLabel == LABEL_DELAY) {
                stop();
                _loc1_ = true;
            }
        }
        else if (currentLabel == LABEL_HIDE) {
            stop();
            _loc1_ = true;
        }
        if (_loc1_) {
            this._animationInProgress = false;
            if (this._animStack.length > 0) {
                this.showAnimation(this._animStack.shift());
            }
            else if (currentLabel == LABEL_HIDE) {
                this.hide();
            }
        }
    }

    private function set isAnimVisible(param1:Boolean):void {
        this._isAnimVisible = param1;
        this.updateVisibility();
    }

    private function hide():void {
        this.isAnimVisible = false;
        this.icon.gotoAndStop(DEFAULT_FRAME);
        gotoAndStop(DEFAULT_FRAME);
    }
}
}

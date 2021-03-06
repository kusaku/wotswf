package net.wg.gui.lobby.techtree.controls {
import fl.transitions.easing.Strong;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.SoundButton;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.ActionName;
import net.wg.gui.lobby.techtree.data.state.AnimationProperties;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.utils.ImageSubstitution;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.motion.Tween;
import scaleform.gfx.Extensions;
import scaleform.gfx.TextFieldEx;

public class ActionButton extends SoundButton {

    private static const NO_ICON_TEXT_TOP_POS:int = 19;

    private static const SEPARATOR:String = "_";

    private static const SELECTED_PREFIX:String = "selected_";

    private static const STATE_UP:String = "up";

    private static const STATE_DISABLED:String = "disabled";

    private static const RENDERER:String = "renderer";

    public var icon:MovieClip;

    public var disableIndicator:BitmapFill;

    private var _animProps:AnimationProperties = null;

    private var _animID:Number = -1;

    private var _animTween:Tween = null;

    private var _action:String = "unlock";

    private var _imgSubstitution:ImageSubstitution;

    public function ActionButton() {
        super();
    }

    override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false):Boolean {
        return hitArea != null ? Boolean(hitArea.hitTestPoint(param1, param2, param3)) : Boolean(super.hitTestPoint(param1, param2, param3));
    }

    override protected function onBeforeDispose():void {
        this.tryToClearImgSubstitution();
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.resetTween();
        if (this.disableIndicator != null) {
            this.disableIndicator.dispose();
            this.disableIndicator = null;
        }
        if (this._animProps != null) {
            App.utils.data.cleanupDynamicObject(this._animProps);
            this._animProps = null;
        }
        this.icon = null;
        owner = null;
        super.onDispose();
    }

    override protected function preInitialize():void {
        super.preInitialize();
        _state = STATE_UP;
    }

    override protected function initialize():void {
        this.makeStatesPrefixes();
        super.initialize();
    }

    override protected function draw():void {
        super.draw();
        if (_baseDisposed) {
            return;
        }
        if (isInvalid(InvalidationType.STATE)) {
            if (this.disableIndicator != null) {
                this.disableIndicator.visible = state == STATE_DISABLED;
            }
            if (this._action == ActionName.RESTORE && textField != null) {
                this.tryToClearImgSubstitution();
                textField.y = NO_ICON_TEXT_TOP_POS;
            }
        }
    }

    override protected function updateText():void {
        if (_label != null && textField != null) {
            if (this._imgSubstitution != null && this._imgSubstitution.valid) {
                TextFieldEx.setImageSubstitutions(textField, this._imgSubstitution);
                textField.text = label + this._imgSubstitution.subString;
            }
            else {
                textField.text = label;
            }
        }
    }

    override protected function handleClick(param1:uint = 0):void {
        super.handleClick(param1);
        this.doAction();
    }

    public function endAnimation(param1:Boolean):void {
        var _loc2_:DisplayObject = null;
        var _loc3_:Boolean = false;
        if (this._animProps != null) {
            _loc2_ = Extensions.getMouseTopMostEntity(true);
            _loc3_ = false;
            if (_loc2_ != null && owner != null) {
                _loc3_ = _loc2_ == owner || owner.contains(_loc2_);
            }
            if (!param1 && (owner.hitTestPoint(stage.mouseX, stage.mouseY, true) && _loc3_)) {
                return;
            }
            if (this.hitTestPoint(stage.mouseX, stage.mouseY, true) && _loc3_) {
                if (this._animTween != null) {
                    this._animTween.reset();
                }
                this._animProps.setTo(this);
            }
            else {
                this.resetTween();
                this._animTween = new Tween(this._animProps.duration, this, this._animProps.from, {
                    "ease": Strong.easeOut,
                    "onComplete": this.onTweenComplete,
                    "paused": false
                });
            }
        }
    }

    public function onTweenComplete():void {
        if (alpha == 0) {
            mouseEnabled = false;
        }
        else {
            mouseEnabled = enabled;
        }
    }

    public function setAnimation(param1:Number, param2:AnimationProperties):Boolean {
        if (this._animID == param1) {
            return false;
        }
        this._animID = param1;
        if (this._animProps != null) {
            this._animProps.setTo(this);
        }
        this._animProps = param2;
        if (param2 != null) {
            this._animProps.setFrom(this);
            if (alpha == 0) {
                enabled = false;
            }
        }
        return true;
    }

    public function setOwner(param1:UIComponent, param2:Boolean = false):void {
        if (_owner != param1) {
            _owner = param1;
            this.focusTarget = _owner;
        }
        if (param2) {
            validateNow();
        }
    }

    public function startAnimation():void {
        if (this._animProps != null) {
            this.resetTween();
            this._animTween = new Tween(this._animProps.duration, this, this._animProps.to, {
                "ease": Strong.easeOut,
                "onComplete": this.onTweenComplete,
                "paused": false
            });
        }
    }

    private function resetTween():void {
        if (this._animTween != null) {
            this._animTween.paused = true;
            this._animTween.dispose();
            this._animTween = null;
        }
    }

    private function doAction():void {
        var _loc2_:IRenderer = null;
        var _loc1_:String = null;
        switch (this._action) {
            case ActionName.UNLOCK:
                _loc1_ = TechTreeEvent.CLICK_2_UNLOCK;
                break;
            case ActionName.BUY:
            case ActionName.RENT:
                _loc1_ = TechTreeEvent.CLICK_2_BUY;
                break;
            case ActionName.RESTORE:
                _loc1_ = TechTreeEvent.RESTORE_VEHICLE;
        }
        if (_loc1_ != null && owner != null) {
            _loc2_ = owner as IRenderer;
            App.utils.asserter.assertNotNull(_loc2_, RENDERER + Errors.CANT_NULL);
            dispatchEvent(new TechTreeEvent(_loc1_, 0, _loc2_.index, _loc2_.getEntityType()));
        }
    }

    private function makeStatesPrefixes():void {
        var _loc1_:String = this._action + SEPARATOR;
        statesSelected = Vector.<String>([SELECTED_PREFIX, _loc1_]);
        statesDefault = Vector.<String>([_loc1_]);
    }

    private function tryToClearImgSubstitution():void {
        if (this._imgSubstitution != null) {
            if (textField != null) {
                TextFieldEx.setImageSubstitutions(textField, null);
            }
            this._imgSubstitution.dispose();
            this._imgSubstitution = null;
        }
    }

    public function get action():String {
        return this._action;
    }

    public function set action(param1:String):void {
        if (this._action == param1) {
            return;
        }
        this._action = param1;
        if (this._action == ActionName.RESTORE) {
            this.tryToClearImgSubstitution();
        }
        this.makeStatesPrefixes();
        setState(this.state);
    }

    public function set imgSubstitution(param1:Object):void {
        this.tryToClearImgSubstitution();
        if (param1 != null) {
            if (this._action != ActionName.RESTORE) {
                this._imgSubstitution = new ImageSubstitution(param1.subString, param1.source, param1.baseLineY, param1.width, param1.height, true);
            }
        }
        this.updateText();
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this.endAnimation(false);
    }

    override protected function handleReleaseOutside(param1:MouseEvent):void {
        super.handleReleaseOutside(param1);
        this.endAnimation(false);
    }
}
}

package net.wg.gui.battle.views.radialMenu {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.Dictionary;

import net.wg.data.constants.InteractiveStates;
import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.views.radialMenu.components.BackGround;
import net.wg.infrastructure.base.meta.IRadialMenuMeta;
import net.wg.infrastructure.base.meta.impl.RadialMenuMeta;

import scaleform.gfx.MouseEventEx;

public class RadialMenu extends RadialMenuMeta implements IRadialMenuMeta {

    private static const DEFAULT_NONE_KEY:String = "";

    private static const BACK_ALPHA:Number = 0.6;

    private static const INTERNAL_MENU_RADIUS:int = 50;

    private static const POINT_RADIUS:int = 160;

    private static const EFFECT_TIME:int = 900;

    private static const PAUSE_BEFORE_HIDE:int = 300;

    private static const CIRCLE_DEGREES:int = 360;

    private static const HIDE_STATE:String = "hide";

    public var negativeBtn:RadialButton = null;

    public var toBaseBtn:RadialButton = null;

    public var helpBtn:RadialButton = null;

    public var reloadBtn:RadialButton = null;

    public var attackBtn:RadialButton = null;

    public var positiveBtn:RadialButton = null;

    public var background:BackGround = null;

    public var pane:Sprite = null;

    private var _stateMap:Dictionary;

    private var _state:String = "default";

    private var _stageWidth:int = 0;

    private var _stageHeight:int = 0;

    private var _wheelPosition:int = -1;

    private var _aspectRatioWidth:int = 1;

    private var _aspectRatioHeight:int = 1;

    private var _scaleKoefX:Number = 1;

    private var _scaleKoefY:Number = 1;

    private var _mouseOffset:Point;

    private var _isAction:Boolean = false;

    private var _buttons:Vector.<RadialButton> = null;

    private var _buttonsCount:int = 6;

    private var _selectedButtonIndex:int = -1;

    public function RadialMenu() {
        this._stateMap = new Dictionary();
        this._mouseOffset = new Point(0, 0);
        super();
        this._buttons = new <RadialButton>[this.negativeBtn, this.toBaseBtn, this.helpBtn, this.reloadBtn, this.attackBtn, this.positiveBtn];
        this._buttonsCount = this._buttons.length;
        this.internalHide();
        this.updateButtons();
    }

    public function as_buildData(param1:Array):void {
        var _loc3_:String = null;
        var _loc2_:int = param1.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc2_) {
            _loc3_ = param1[_loc4_].state;
            this._stateMap[_loc3_] = param1[_loc4_].data;
            _loc4_++;
        }
    }

    private function updateData():void {
        var _loc2_:RadialButton = null;
        var _loc1_:Array = this._stateMap[this._state];
        var _loc3_:uint = 0;
        while (_loc3_ < this._buttonsCount) {
            _loc2_ = this._buttons[_loc3_];
            if (_loc1_[_loc3_]) {
                _loc2_.title = _loc1_[_loc3_].title;
                _loc2_.action = _loc1_[_loc3_].action;
                _loc2_.icon = _loc1_[_loc3_].icon;
                if (_loc1_[_loc3_].key) {
                    _loc2_.hotKey = App.utils.commons.keyToString(_loc1_[_loc3_].key).keyName;
                }
                else {
                    _loc2_.hotKey = DEFAULT_NONE_KEY;
                }
            }
            _loc2_.idx = _loc3_;
            _loc2_.enabled = false;
            _loc3_++;
        }
    }

    public function as_show(param1:String, param2:Array, param3:Array):void {
        this._isAction = false;
        this._state = param1;
        this._aspectRatioWidth = param3[0] * POINT_RADIUS;
        this._aspectRatioHeight = param3[1] * POINT_RADIUS;
        App.utils.scheduler.cancelTask(this.internalHide);
        App.utils.scheduler.cancelTask(this.hideButton);
        this.updateData();
        this.internalShow();
        x = param2[0];
        y = param2[1];
    }

    public function as_hide():void {
        this.action();
    }

    public function updateStage(param1:int, param2:int):void {
        this._stageWidth = param1;
        this._stageHeight = param2;
        this._scaleKoefX = 1 / App.stage.scaleX;
        this._scaleKoefY = 1 / App.stage.scaleY;
        invalidate(InvalidationType.SIZE);
    }

    private function selectButton(param1:int):void {
        if (this._selectedButtonIndex != param1) {
            this.unSelectButton();
            this._selectedButtonIndex = param1;
            this._buttons[this._selectedButtonIndex].state = InteractiveStates.OVER;
            onSelectS();
        }
    }

    private function unSelectButton():void {
        if (this._selectedButtonIndex != -1) {
            this._buttons[this._selectedButtonIndex].state = InteractiveStates.OUT;
            this._selectedButtonIndex = -1;
        }
    }

    private function cancelButton():void {
        if (this._selectedButtonIndex != -1) {
            this._buttons[this._selectedButtonIndex].state = InteractiveStates.UP;
            this._selectedButtonIndex = -1;
        }
    }

    private function internalShow():void {
        this.cancelButton();
        var _loc1_:int = 0;
        while (_loc1_ < this._buttonsCount) {
            this._buttons[_loc1_].visible = true;
            _loc1_++;
        }
        this.pane.visible = true;
        this.background.visible = true;
        visible = true;
        if (App.stage) {
            App.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDownHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
        }
        this._mouseOffset.x = 0;
        this._mouseOffset.y = 0;
        this._wheelPosition = -1;
    }

    private function hideWithAnimation():void {
        App.utils.scheduler.scheduleTask(this.internalHide, EFFECT_TIME);
        if (App.stage) {
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDownHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
        }
    }

    private function internalHide():void {
        visible = false;
        if (App.stage) {
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDownHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
        }
    }

    private function hideButton(param1:Array):void {
        param1[0].state = HIDE_STATE;
    }

    private function updateButtons():void {
        var _loc3_:Number = NaN;
        var _loc1_:Number = 45;
        var _loc2_:Number = (CIRCLE_DEGREES - (_loc1_ << 1)) / this._buttons.length;
        var _loc4_:int = 0;
        while (_loc4_ < this._buttonsCount) {
            _loc3_ = _loc2_ * _loc4_ + _loc1_;
            if (_loc4_ > this._buttonsCount >> 1 - 1) {
                _loc3_ = -CIRCLE_DEGREES + _loc3_ + _loc1_;
            }
            this._buttons[_loc4_].angle = _loc3_;
            _loc4_++;
        }
    }

    private function action():void {
        var _loc1_:Boolean = false;
        var _loc2_:RadialButton = null;
        var _loc3_:Number = NaN;
        if (visible) {
            _loc1_ = false;
            _loc3_ = 0;
            while (_loc3_ < this._buttonsCount) {
                _loc2_ = this._buttons[_loc3_];
                if (this._selectedButtonIndex == _loc3_) {
                    App.utils.scheduler.scheduleTask(this.hideButton, PAUSE_BEFORE_HIDE, [_loc2_]);
                    this._isAction = true;
                    onActionS(_loc2_.action);
                    _loc1_ = true;
                }
                else {
                    _loc2_.visible = false;
                }
                _loc3_++;
            }
            if (_loc1_) {
                this.pane.visible = false;
                this.background.visible = false;
                this.hideWithAnimation();
            }
            else {
                this.internalHide();
            }
        }
    }

    private function onButtonMouseDownHandler(param1:MouseEvent):void {
        if (param1 is MouseEventEx) {
            if (MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON) {
                this.internalHide();
            }
            else if (MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON) {
                this.action();
            }
        }
    }

    private function onMouseMoveHandler(param1:MouseEvent):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc6_:Point = null;
        var _loc7_:int = 0;
        if (visible && !this._isAction && param1.delta == 0) {
            this._wheelPosition = -1;
            _loc2_ = this.mouseX - this._mouseOffset.x;
            _loc3_ = this.mouseY - this._mouseOffset.y;
            _loc4_ = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
            if (_loc4_ > INTERNAL_MENU_RADIUS) {
                _loc5_ = Math.atan2(_loc3_, _loc2_);
                _loc6_ = new Point(this._aspectRatioWidth * Math.cos(_loc5_), this._aspectRatioHeight * Math.sin(_loc5_));
                if (_loc4_ > POINT_RADIUS) {
                    this._mouseOffset.x = this.mouseX - _loc6_.x;
                    this._mouseOffset.y = this.mouseY - _loc6_.y;
                }
                _loc6_ = this.localToGlobal(_loc6_);
                _loc7_ = 0;
                while (_loc7_ < this._buttonsCount) {
                    if (this._buttons[_loc7_].hitAreaSpr.hitTestPoint(_loc6_.x * this._scaleKoefX, _loc6_.y * this._scaleKoefY, true)) {
                        this.selectButton(_loc7_);
                        break;
                    }
                    _loc7_++;
                }
            }
            else {
                this.unSelectButton();
            }
        }
    }

    private function onMouseWheelHandler(param1:MouseEvent):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (visible && !this._isAction) {
            _loc2_ = param1.delta;
            if (this._wheelPosition == -1) {
                _loc3_ = 0;
                while (_loc3_ < this._buttonsCount) {
                    if (this._selectedButtonIndex == _loc3_) {
                        this._wheelPosition = _loc3_;
                        break;
                    }
                    _loc3_++;
                }
            }
            if (_loc2_ < 0) {
                this._wheelPosition++;
                if (this._wheelPosition >= this._buttonsCount) {
                    this._wheelPosition = 0;
                }
            }
            else {
                this._wheelPosition--;
                if (this._wheelPosition < 0) {
                    this._wheelPosition = this._buttonsCount - 1;
                }
            }
            this.selectButton(this._wheelPosition);
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.background.setSize(this._stageWidth, this._stageHeight);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.background.setBackgroundAlpha(BACK_ALPHA);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.internalHide);
        App.utils.scheduler.cancelTask(this.hideButton);
        this.internalHide();
        this._buttons.length = 0;
        App.utils.data.cleanupDynamicObject(this._stateMap);
        this.negativeBtn.dispose();
        this.negativeBtn = null;
        this.toBaseBtn.dispose();
        this.toBaseBtn = null;
        this.helpBtn.dispose();
        this.helpBtn = null;
        this.reloadBtn.dispose();
        this.reloadBtn = null;
        this.attackBtn.dispose();
        this.attackBtn = null;
        this.positiveBtn.dispose();
        this.positiveBtn = null;
        this.background.dispose();
        this.background = null;
        this.pane = null;
        this._stateMap = null;
        this._mouseOffset = null;
        this._buttons = null;
        super.onDispose();
    }
}
}

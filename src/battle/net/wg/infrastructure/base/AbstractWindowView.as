package net.wg.infrastructure.base {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.ui.Keyboard;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.windows.Window;
import net.wg.infrastructure.base.meta.impl.WindowViewMeta;
import net.wg.infrastructure.constants.WindowViewInvalidationType;
import net.wg.infrastructure.interfaces.IAbstractWindowView;
import net.wg.infrastructure.interfaces.IManagedContent;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.infrastructure.interfaces.IWindowGeometry;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InputValue;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class AbstractWindowView extends WindowViewMeta implements IAbstractWindowView {

    private static const BG_ENABLED:String = "enable";

    private static const BG_DISABLED:String = "disable";

    private var _window:IWindow;

    private var _canMinimize:Boolean = false;

    private var _enabledCloseBtn:Boolean = true;

    private var _canDrag:Boolean = true;

    private var _canClose:Boolean = true;

    private var _canResize:Boolean = false;

    private var _isCentered:Boolean = true;

    private var _showWindowBgForm:Boolean = true;

    private var _showWindowBg:Boolean = true;

    private var _isModal:Boolean = false;

    private var _geometry:IWindowGeometry;

    private var _isSourceTracked:Boolean = false;

    public function AbstractWindowView() {
        super();
        this._geometry = new DefaultWindowGeometry();
    }

    override public function playHideTween(param1:DisplayObject, param2:Function = null):Boolean {
        return false;
    }

    override public function playShowTween(param1:DisplayObject, param2:Function = null):Boolean {
        return false;
    }

    override public function setViewSize(param1:Number, param2:Number):void {
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        invalidate(WindowViewInvalidationType.POSITION_INVALID);
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(param1);
        App.utils.scheduler.scheduleOnNextFrame(this.changeBackgroundLabel, BG_ENABLED);
    }

    override protected function onLeaveModalFocus():void {
        super.onLeaveModalFocus();
        App.utils.scheduler.scheduleOnNextFrame(this.changeBackgroundLabel, BG_DISABLED);
    }

    override protected function getViewContainer():DisplayObjectContainer {
        return DisplayObjectContainer(this.window);
    }

    override protected function configUI():void {
        if (this.window) {
            this.window.addEventListener(InputEvent.INPUT, this.handleInput, false, 0, true);
        }
        initSize();
    }

    override protected function onBeforeDispose():void {
        if (this._window) {
            this._window.removeEventListener(InputEvent.INPUT, this.handleInput);
        }
        App.utils.scheduler.cancelTask(this.changeBackgroundLabel);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        if (this._window) {
            this._window.dispose();
            this._window.setWindowContent(null);
            this._window = null;
        }
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this.geometry && this._window && isInvalid(WindowViewInvalidationType.POSITION_INVALID)) {
            this.geometry.setPosition(this._window);
            this.checkAppBounds();
        }
    }

    public function as_getGeometry():Array {
        if (this._window) {
            return [this._window.x, this._window.y, this._window.width, this._window.height];
        }
        return null;
    }

    public function as_isModal():Boolean {
        return this._isModal;
    }

    public function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number):void {
        this._geometry = new StoredWindowGeometry(param1, param2, param3, param4);
        invalidate(WindowViewInvalidationType.POSITION_INVALID);
    }

    public function handleWindowClose():void {
        if (onTryClosingS()) {
            onWindowCloseS();
        }
    }

    public function handleWindowMinimize():void {
        onWindowMinimizeS();
    }

    public function setWindow(param1:IWindow):void {
        this._window = param1;
    }

    protected final function canCloseFromInputDetails(param1:InputDetails):Boolean {
        return param1.code == Keyboard.ESCAPE && param1.value == InputValue.KEY_DOWN && this._window.getBackground().currentLabel == BG_ENABLED;
    }

    protected function onClosingApproved():void {
    }

    protected function onClosingDeclined():void {
    }

    private function checkAppBounds():void {
        if (this._window.width > App.appWidth) {
            this._window.x = Math.round((App.appWidth - this._window.width) / 2);
        }
        else {
            if (this._window.x < 0) {
                this._window.x = 0;
            }
            if (this._window.x + this._window.width > App.appWidth) {
                this._window.x = Math.round(App.appWidth - this._window.width);
            }
        }
        if (this._window.height > App.appHeight) {
            this._window.y = Math.round((App.appHeight - this._window.height) / 2);
        }
        else {
            if (this._window.y < 0) {
                this._window.y = 0;
            }
            if (this._window.y + this._window.height > App.appHeight) {
                this._window.y = Math.round(App.appHeight - this._window.height);
            }
        }
    }

    private function validateView():void {
        if (this._window != null) {
            UIComponent(this._window).invalidate(Window.INVALID_SRC_VIEW);
        }
    }

    private function changeBackgroundLabel(param1:String):void {
        var _loc2_:MovieClip = null;
        if (this.window) {
            _loc2_ = this._window.getBackground();
            if (_loc2_ && _loc2_.currentLabel != param1) {
                _loc2_.gotoAndPlay(param1);
            }
        }
    }

    override public function get isModal():Boolean {
        return this._isModal;
    }

    public function set isModal(param1:Boolean):void {
        this._isModal = param1;
    }

    override public function get containerContent():IManagedContent {
        return this._window;
    }

    override public function get wrapper():IWrapper {
        return this._window;
    }

    override public function set wrapper(param1:IWrapper):void {
        this.setWindow(IWindow(param1));
    }

    public function get window():IWindow {
        return this._window;
    }

    public function get canMinimize():Boolean {
        return this._canMinimize;
    }

    public function set canMinimize(param1:Boolean):void {
        if (param1 != this._canMinimize) {
            this._canMinimize = param1;
            this.validateView();
        }
    }

    public function get enabledCloseBtn():Boolean {
        return this._enabledCloseBtn;
    }

    public function set enabledCloseBtn(param1:Boolean):void {
        if (param1 != this._enabledCloseBtn) {
            this._enabledCloseBtn = param1;
            this.validateView();
        }
    }

    public function get canDrag():Boolean {
        return this._canDrag;
    }

    public function set canDrag(param1:Boolean):void {
        if (param1 != this._canDrag) {
            this._canDrag = param1;
            this.validateView();
        }
    }

    public function get canClose():Boolean {
        return this._canClose;
    }

    public function set canClose(param1:Boolean):void {
        if (param1 != this._canClose) {
            this._canClose = param1;
            this.validateView();
        }
    }

    public function get canResize():Boolean {
        return this._canResize;
    }

    public function set canResize(param1:Boolean):void {
        if (param1 != this._canResize) {
            this._canResize = param1;
            this.validateView();
        }
    }

    public function get isCentered():Boolean {
        return this._isCentered;
    }

    public function set isCentered(param1:Boolean):void {
        this._isCentered = param1;
    }

    public function get showWindowBgForm():Boolean {
        return this._showWindowBgForm;
    }

    public function set showWindowBgForm(param1:Boolean):void {
        this._showWindowBgForm = param1;
    }

    public function get showWindowBg():Boolean {
        return this._showWindowBg;
    }

    public function set showWindowBg(param1:Boolean):void {
        this._showWindowBg = param1;
    }

    public function get geometry():IWindowGeometry {
        return this._geometry;
    }

    public function set geometry(param1:IWindowGeometry):void {
        if (!this._geometry.canOverwrite()) {
            return;
        }
        this._geometry = param1;
    }

    public function get isSourceTracked():Boolean {
        return this._isSourceTracked;
    }

    public function set isSourceTracked(param1:Boolean):void {
        this._isSourceTracked = param1;
    }

    public function get wrapperLinkage():String {
        return Linkages.WINDOW;
    }

    override public function handleInput(param1:InputEvent):void {
        super.handleInput(param1);
        if (param1.handled) {
            return;
        }
        var _loc2_:InputDetails = param1.details;
        if (this.canCloseFromInputDetails(_loc2_)) {
            param1.handled = true;
            if (onTryClosingS()) {
                this.onClosingApproved();
                onWindowCloseS();
            }
            else {
                this.onClosingDeclined();
            }
        }
    }
}
}

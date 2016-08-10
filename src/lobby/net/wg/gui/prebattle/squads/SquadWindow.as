package net.wg.gui.prebattle.squads {
import flash.display.DisplayObject;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.gui.components.windows.Window;
import net.wg.gui.components.windows.WindowEvent;
import net.wg.gui.prebattle.squads.ev.SquadViewEvent;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.infrastructure.base.meta.ISquadWindowMeta;
import net.wg.infrastructure.base.meta.impl.SquadWindowMeta;
import net.wg.infrastructure.interfaces.IWindow;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InputValue;
import scaleform.clik.events.InputEvent;
import scaleform.clik.utils.Padding;

public class SquadWindow extends SquadWindowMeta implements ISquadWindowMeta {

    private static const INVALID_CONTENT_SIZE:String = "invalidContentSize";

    private static const WINDOW_PADDING_BOTTOM:Number = 19;

    private static const WINDOW_PADDING_RIGHT:Number = 13;

    public var squadView:SquadView = null;

    private var _componentId:String;

    public function SquadWindow() {
        super();
    }

    override public function as_enableWndCloseBtn(param1:Boolean):void {
        super.as_enableWndCloseBtn(param1);
        this.squadView.leaveSquadBtn.enabled = param1;
    }

    override public function setWindow(param1:IWindow):void {
        super.setWindow(param1);
        this.initWindowProps();
    }

    override protected function configUI():void {
        super.configUI();
        currentView = this.squadView;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_CONTENT_SIZE)) {
            this.updateWindowSize();
            App.utils.scheduler.scheduleOnNextFrame(this.showWindow);
        }
    }

    override protected function onDispose():void {
        this.squadView.removeEventListener(SquadViewEvent.ON_POPULATED, this.onViewPopulatedHandler);
        this.squadView = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        this.squadView.addEventListener(SquadViewEvent.ON_POPULATED, this.onViewPopulatedHandler);
        registerFlashComponentS(this.squadView, this._componentId);
    }

    override protected function getWindowTitle():String {
        return MENU.HEADERBUTTONS_BATTLE_TYPES_SQUAD;
    }

    override protected function isChatFocusNeeded():Boolean {
        return true;
    }

    public function as_setComponentId(param1:String):void {
        this._componentId = param1;
    }

    public function as_setWindowTitle(param1:String):void {
        window.title = param1;
    }

    private function showWindow():void {
        if (!DisplayObject(window).visible) {
            DisplayObject(window).visible = true;
        }
    }

    private function updateWindowSize():void {
        this.width = this.squadView.width;
        this.height = this.squadView.height;
        window.updateSize(this.squadView.width, this.squadView.height, true);
    }

    private function initWindowProps():void {
        Window(window).visible = false;
        super.onPopulate();
        window.useBottomBtns = true;
        canDrag = true;
        canMinimize = true;
        isCentered = true;
        showWindowBgForm = false;
        var _loc1_:Padding = window.contentPadding as Padding;
        _loc1_.bottom = WINDOW_PADDING_BOTTOM;
        _loc1_.right = WINDOW_PADDING_RIGHT;
        window.contentPadding = _loc1_;
        window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
    }

    override public function handleInput(param1:InputEvent):void {
        super.handleInput(param1);
        if (param1.handled) {
            return;
        }
        if (param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP) {
            param1.handled = true;
            this.squadView.dispatchEvent(new RallyViewsEvent(RallyViewsEvent.SHOW_FAQ_WINDOW));
        }
    }

    override protected function onScaleChangedHandler(param1:WindowEvent):void {
    }

    private function onViewPopulatedHandler(param1:SquadViewEvent):void {
        this.squadView.removeEventListener(SquadViewEvent.ON_POPULATED, this.onViewPopulatedHandler);
        registerFlashComponentS(this.squadView.getChannelComponent(), Aliases.CHANNEL_COMPONENT);
        invalidate(INVALID_CONTENT_SIZE);
    }
}
}

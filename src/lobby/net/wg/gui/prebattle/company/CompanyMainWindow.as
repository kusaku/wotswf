package net.wg.gui.prebattle.company {
import flash.display.InteractiveObject;
import flash.ui.Keyboard;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.PREBATTLE_ALIASES;
import net.wg.gui.components.windows.WindowEvent;
import net.wg.gui.prebattle.meta.ICompanyMainWindowMeta;
import net.wg.gui.prebattle.meta.impl.CompanyMainWindowMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InputValue;
import scaleform.clik.events.InputEvent;

public class CompanyMainWindow extends CompanyMainWindowMeta implements ICompanyMainWindowMeta {

    public function CompanyMainWindow() {
        super();
        canMinimize = true;
        showWindowBgForm = false;
    }

    override public function as_loadView(param1:String, param2:String):void {
        super.as_loadView(param1, param2);
        setFocus(this);
    }

    override public function getClientItemID():Number {
        return getClientIDS();
    }

    override public function setWindow(param1:IWindow):void {
        if (window) {
            window.removeEventListener(WindowEvent.SCALE_X_CHANGED, this.onScaleChangedHandler);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED, this.onScaleChangedHandler);
        }
        super.setWindow(param1);
        if (window) {
            window.addEventListener(WindowEvent.SCALE_X_CHANGED, this.onScaleChangedHandler, false, 0, true);
            window.addEventListener(WindowEvent.SCALE_Y_CHANGED, this.onScaleChangedHandler, false, 0, true);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler, false, 0, true);
    }

    override protected function onDispose():void {
        removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        if (window) {
            window.removeEventListener(WindowEvent.SCALE_X_CHANGED, this.onScaleChangedHandler);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED, this.onScaleChangedHandler);
        }
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        var _loc2_:IFocusContainer = null;
        var _loc3_:InteractiveObject = null;
        super.onInitModalFocus(param1);
        if (stack.currentView) {
            _loc2_ = stack.currentView as IFocusContainer;
            assertNotNull(_loc2_, "iFocusContainer" + Errors.CANT_NULL);
            _loc3_ = _loc2_.getComponentForFocus();
            if (_loc3_) {
                setFocus(_loc2_.getComponentForFocus());
            }
        }
    }

    override protected function onViewLoadRequest(param1:*):void {
        super.onViewLoadRequest(param1);
        switch (param1.alias) {
            case PREBATTLE_ALIASES.COMPANY_LIST_VIEW_UI:
                onBrowseRalliesS();
                break;
            case PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI:
                if (param1.itemId) {
                    onJoinRallyS(param1.itemId, param1.slotIndex, param1.peripheryID);
                }
                else {
                    onCreateRallyS();
                }
        }
    }

    public function as_setWindowTitle(param1:String, param2:String):void {
        window.setTitleIcon(param2);
        window.title = param1;
    }

    override public function handleInput(param1:InputEvent):void {
        super.handleInput(param1);
        if (param1.handled) {
            return;
        }
        if (param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP) {
            showFAQWindowS();
            param1.handled = true;
        }
    }

    private function onRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(IFocusContainer(param1.target).getComponentForFocus());
    }

    private function onScaleChangedHandler(param1:WindowEvent):void {
        if (param1.type == WindowEvent.SCALE_X_CHANGED) {
            window.width = param1.prevValue;
        }
        else {
            window.height = param1.prevValue;
        }
    }
}
}

package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.Aliases;
import net.wg.gui.components.common.InputChecker;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.demountBuilding.FortDemountBuildingVO;
import net.wg.infrastructure.base.meta.IFortDemountBuildingWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortDemountBuildingWindowMeta;
import net.wg.infrastructure.events.FocusRequestEvent;

import scaleform.clik.events.ButtonEvent;

public class FortDemountBuildingWindow extends FortDemountBuildingWindowMeta implements IFortDemountBuildingWindowMeta {

    public var titleText:TextField;

    public var bodyText:TextField;

    public var applyButton:ISoundButtonEx;

    public var cancelButton:ISoundButtonEx;

    public var inputChecker:InputChecker;

    public function FortDemountBuildingWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.titleText.mouseEnabled = false;
        this.bodyText.mouseEnabled = false;
        this.applyButton.mouseEnabledOnDisabled = true;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        registerFlashComponentS(this.inputChecker, Aliases.INPUT_CHECKER_COMPONENT);
        this.inputChecker.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onInputCheckerRequestFocusHandler);
        this.applyButton.addEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
        this.applyButton.enabled = false;
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.updateFocus);
        this.inputChecker.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onInputCheckerRequestFocusHandler);
        this.inputChecker = null;
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.cancelButton.dispose();
        this.cancelButton = null;
        this.applyButton.removeEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
        this.applyButton.dispose();
        this.applyButton = null;
        this.titleText = null;
        this.bodyText = null;
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.inputChecker.textInput);
    }

    override protected function setData(param1:FortDemountBuildingVO):void {
        window.title = param1.windowTitle;
        this.titleText.htmlText = param1.headerQuestion;
        this.bodyText.htmlText = param1.bodyText;
        this.applyButton.label = param1.applyButtonLbl;
        this.cancelButton.label = param1.cancelButtonLbl;
    }

    private function updateFocus():void {
        setFocus(InteractiveObject(this.applyButton));
    }

    private function onApplyButtonClickHandler(param1:ButtonEvent):void {
        applyDemountS();
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onInputCheckerRequestFocusHandler(param1:Event):void {
        if (this.inputChecker.isInvalidUserText) {
            this.applyButton.enabled = true;
            App.utils.scheduler.scheduleOnNextFrame(this.updateFocus);
        }
        else {
            this.applyButton.enabled = false;
            setFocus(this.inputChecker.getComponentForFocus());
        }
    }
}
}

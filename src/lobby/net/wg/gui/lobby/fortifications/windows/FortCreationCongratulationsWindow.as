package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.infrastructure.base.meta.IFortCreationCongratulationsWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortCreationCongratulationsWindowMeta;

import scaleform.clik.events.ButtonEvent;

public class FortCreationCongratulationsWindow extends FortCreationCongratulationsWindowMeta implements IFortCreationCongratulationsWindowMeta {

    public var applyButton:ISoundButtonEx;

    public var body:TextField;

    public var title:TextField;

    public function FortCreationCongratulationsWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.applyButton));
    }

    override protected function onDispose():void {
        this.applyButton.addEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
        this.applyButton.dispose();
        this.applyButton = null;
        this.title = null;
        this.body = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.applyButton.addEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
    }

    public function as_setButtonLbl(param1:String):void {
        this.applyButton.label = param1;
    }

    public function as_setText(param1:String):void {
        this.body.htmlText = param1;
    }

    public function as_setTitle(param1:String):void {
        this.title.htmlText = param1;
    }

    public function as_setWindowTitle(param1:String):void {
        window.title = param1;
    }

    private function onApplyButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}

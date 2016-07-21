package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.infrastructure.base.meta.IFortNotCommanderFirstEnterWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortNotCommanderFirstEnterWindowMeta;

import scaleform.clik.events.ButtonEvent;

public class FortNotCommanderFirstEnterWindow extends FortNotCommanderFirstEnterWindowMeta implements IFortNotCommanderFirstEnterWindowMeta {

    public var titleTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var applyButton:ISoundButtonEx = null;

    public function FortNotCommanderFirstEnterWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.applyButton.addEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
    }

    override protected function onDispose():void {
        this.applyButton.removeEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
        this.applyButton.dispose();
        this.applyButton = null;
        this.descriptionTF = null;
        this.titleTF = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.applyButton));
    }

    public function as_setButtonLbl(param1:String):void {
        this.applyButton.label = param1;
    }

    public function as_setText(param1:String):void {
        this.descriptionTF.htmlText = param1;
    }

    public function as_setTitle(param1:String):void {
        this.titleTF.htmlText = param1;
    }

    public function as_setWindowTitle(param1:String):void {
        window.title = param1;
    }

    private function onApplyButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}

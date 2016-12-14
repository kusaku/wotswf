package net.wg.gui.lobby.fortifications.cmp.impl {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.fortBase.events.FortInitEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.events.ButtonEvent;

public class FortWelcomeCommanderContent extends UIComponentEx implements IFocusContainer {

    public var windowTitle:TextFieldShort = null;

    public var title1:TextField = null;

    public var title2:TextField = null;

    public var title3:TextField = null;

    public var titleDescr1:TextField = null;

    public var titleDescr2:TextField = null;

    public var titleDescr3:TextField = null;

    public var button:ISoundButtonEx = null;

    public function FortWelcomeCommanderContent() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.windowTitle.label = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_TITLE;
        this.title1.text = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION1_TITLE;
        this.titleDescr1.text = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION1_DESCR;
        this.title2.text = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION2_TITLE;
        this.titleDescr2.text = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION2_DESCR;
        this.title3.text = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION3_TITLE;
        this.titleDescr3.text = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION3_DESCR;
        this.button.label = FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_BUTTON_LABEL;
        this.button.addEventListener(ButtonEvent.CLICK, this.onButtonClickHandler);
    }

    override protected function onDispose():void {
        this.button.removeEventListener(ButtonEvent.CLICK, this.onButtonClickHandler);
        this.button.dispose();
        this.button = null;
        this.windowTitle.dispose();
        this.windowTitle = null;
        this.title1 = null;
        this.title2 = null;
        this.title3 = null;
        this.titleDescr1 = null;
        this.titleDescr2 = null;
        this.titleDescr3 = null;
        super.onDispose();
    }

    public function getComponentForFocus():InteractiveObject {
        return InteractiveObject(this.button);
    }

    private function onButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new FortInitEvent(FortInitEvent.COMMANDER_HELP_VIEW_BTN_CLICK, true));
    }
}
}

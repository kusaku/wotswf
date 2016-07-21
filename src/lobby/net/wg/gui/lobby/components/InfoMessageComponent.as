package net.wg.gui.lobby.components {
import flash.text.TextField;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.components.data.InfoMessageVO;
import net.wg.gui.lobby.components.events.FiltersEvent;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class InfoMessageComponent extends UIComponentEx {

    private static const RETURN_BUTTON_GAP:int = 12;

    public var titleTF:TextField;

    public var messageTF:TextField;

    public var returnBtn:SoundButtonEx;

    public function InfoMessageComponent() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
        this.titleTF.visible = false;
        this.returnBtn.visible = false;
        this.messageTF.visible = false;
    }

    override protected function onDispose():void {
        this.returnBtn.removeEventListener(ButtonEvent.CLICK, this.onReturnButtonClickHandler);
        this.titleTF = null;
        this.messageTF = null;
        this.returnBtn.dispose();
        this.returnBtn = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.returnBtn.addEventListener(ButtonEvent.CLICK, this.onReturnButtonClickHandler, false, 0, true);
    }

    public function setData(param1:InfoMessageVO):void {
        this.titleTF.visible = !StringUtils.isEmpty(param1.title);
        if (this.titleTF.visible) {
            this.titleTF.htmlText = param1.title;
        }
        this.returnBtn.visible = !StringUtils.isEmpty(param1.returnBtnLabel);
        if (this.returnBtn.visible) {
            this.returnBtn.label = param1.returnBtnLabel;
        }
        this.messageTF.htmlText = param1.message;
        this.messageTF.visible = true;
        this.doLayout();
    }

    protected function doLayout():void {
        App.utils.commons.updateTextFieldSize(this.titleTF, true, false);
        App.utils.commons.updateTextFieldSize(this.messageTF, false, true);
        this.returnBtn.y = this.messageTF.y + this.messageTF.height + RETURN_BUTTON_GAP;
        setSize(this.actualWidth, this.actualHeight);
    }

    private function onReturnButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new FiltersEvent(FiltersEvent.RESET_FILTERS));
    }
}
}

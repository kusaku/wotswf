package net.wg.gui.lobby.questsWindow.components {
import flash.display.InteractiveObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.questsWindow.components.interfaces.IConditionRenderer;
import net.wg.gui.lobby.questsWindow.data.TutorialQuestConditionRendererVO;
import net.wg.gui.lobby.questsWindow.events.TutorialQuestConditionEvent;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.events.ButtonEvent;

public class TutorialQuestConditionRenderer extends UIComponentEx implements IConditionRenderer {

    private static const TEXT_BUTTON_GAP:int = 10;

    private static const MIN_ACTION_BUTTON_WIDTH:int = 80;

    public var textTF:TextField;

    public var actionButton:SoundButtonEx;

    private var _data:TutorialQuestConditionRendererVO;

    public function TutorialQuestConditionRenderer() {
        super();
        this.actionButton.addEventListener(ButtonEvent.PRESS, this.onActionButtonPressedHandler);
        this.actionButton.usePreventUpdateDisable = true;
        this.actionButton.minWidth = MIN_ACTION_BUTTON_WIDTH;
    }

    override protected function onDispose():void {
        this.actionButton.removeEventListener(ButtonEvent.PRESS, this.onActionButtonPressedHandler);
        this.textTF = null;
        this.actionButton.dispose();
        this.actionButton = null;
        this._data = null;
        super.onDispose();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        return new <InteractiveObject>[this.actionButton];
    }

    public function layout():void {
        this.actionButton.x = width - this.actionButton.width | 0;
        this.textTF.width = width - this.actionButton.width - TEXT_BUTTON_GAP;
        App.utils.commons.updateTextFieldSize(this.textTF, false, true);
        if (this.textTF.numLines == 1) {
            this.textTF.y = this.actionButton.y + (this.actionButton.height - this.textTF.height) >> 1 | 0;
        }
        setSize(width, actualHeight);
    }

    public function update(param1:Object):void {
        this._data = TutorialQuestConditionRendererVO(param1);
        this.textTF.htmlText = this._data.text;
        this.actionButton.autoSize = TextFieldAutoSize.CENTER;
        this.actionButton.label = this._data.btnText;
        this.actionButton.validateNow();
    }

    public function get buttonWidth():Number {
        return this.actionButton.width;
    }

    public function set buttonWidth(param1:Number):void {
        if (this.actionButton.width < param1) {
            this.actionButton.autoSize = TextFieldAutoSize.NONE;
            this.actionButton.width = param1;
            this.actionButton.validateNow();
        }
    }

    private function onActionButtonPressedHandler(param1:ButtonEvent):void {
        dispatchEvent(new TutorialQuestConditionEvent(TutorialQuestConditionEvent.ACTION_BUTTON_PRESSED, this._data.id, this._data.type, true));
    }
}
}

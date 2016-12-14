package net.wg.gui.lobby.techtree.controls {
import flash.text.TextField;

import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Constraints;
import scaleform.gfx.Extensions;
import scaleform.gfx.TextFieldEx;

public class ResearchTitleBar extends UIComponentEx {

    public var titleField:TextField;

    public var infoField:TextField;

    public var returnButton:ReturnToTTButton;

    private var _title:String = "";

    private var _nation:String = "";

    public function ResearchTitleBar() {
        super();
        Extensions.enabled = true;
    }

    override protected function onDispose():void {
        if (this.returnButton != null) {
            constraints.removeElement(this.returnButton.name);
            this.returnButton.removeEventListener(ButtonEvent.CLICK, this.onReturnButtonClickHandler, false);
            this.returnButton.dispose();
            this.returnButton = null;
        }
        this.infoField = null;
        this.titleField = null;
        super.onDispose();
    }

    override protected function configUI():void {
        constraints = new Constraints(this);
        if (this.titleField != null) {
            constraints.addElement(this.titleField.name, this.titleField, Constraints.LEFT | Constraints.RIGHT);
        }
        if (this.returnButton != null) {
            constraints.addElement(this.returnButton.name, this.returnButton, Constraints.TOP | Constraints.LEFT);
            this.returnButton.addEventListener(ButtonEvent.CLICK, this.onReturnButtonClickHandler, false, 0, true);
        }
        super.configUI();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(TTInvalidationType.TITLE) && this.titleField != null) {
            TextFieldEx.setVerticalAlign(this.titleField, TextFieldEx.VALIGN_CENTER);
            this.titleField.htmlText = this._title;
        }
        if (isInvalid(TTInvalidationType.NATION) && this.returnButton != null) {
            if (this._nation.length > 0) {
                this.returnButton.label = this._nation;
                this.returnButton.visible = true;
            }
            else {
                this.returnButton.visible = false;
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            constraints.update(_width, _height);
            this.centerInfoField();
        }
    }

    public function setInfoMessage(param1:String):void {
        this.infoField.htmlText = param1;
        this.infoField.visible = param1 && param1.length > 0;
        this.centerInfoField();
    }

    public function setNation(param1:String):void {
        if (this._nation == param1) {
            return;
        }
        this._nation = param1;
        invalidate(TTInvalidationType.NATION);
    }

    public function setTitle(param1:String):void {
        if (this._title == param1) {
            return;
        }
        this._title = param1;
        invalidate(TTInvalidationType.TITLE);
    }

    private function centerInfoField():void {
        this.infoField.width = this.infoField.textWidth;
        this.infoField.x = this.titleField.width - this.infoField.width >> 1;
    }

    private function onReturnButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new TechTreeEvent(TechTreeEvent.RETURN_2_TECHTREE));
    }
}
}

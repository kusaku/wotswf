package net.wg.gui.lobby.fortifications.cmp.drctn.impl {
import flash.text.TextField;

import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.drctn.IDirectionCmp;
import net.wg.gui.lobby.fortifications.cmp.drctn.IDirectionListRenderer;
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.gui.lobby.fortifications.events.DirectionEvent;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class DirectionListRenderer extends UIComponentEx implements IDirectionListRenderer {

    public var textField:TextField;

    public var closeBtn:ISoundButtonEx;

    public var direction:IDirectionCmp;

    public var statusTF:TextField;

    private var _model:DirectionVO;

    public function DirectionListRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.closeBtn.label = FORTIFICATIONS.FORTDIRECTIONSWINDOW_BUTTON_CLOSEDIRECTION;
        this.closeBtn.mouseEnabledOnDisabled = true;
        this.direction.labelVisible = false;
        this.direction.solidMode = false;
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
    }

    override protected function onDispose():void {
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.direction.dispose();
        this.direction = null;
        this.textField = null;
        this.statusTF = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this._model) {
                this.setControlsVisible(true);
                this.textField.text = this._model.fullName;
                this.closeBtn.visible = this._model.closeButtonVisible;
                this.closeBtn.enabled = this._model.canBeClosed;
                this.closeBtn.tooltip = !!this.closeBtn.enabled ? TOOLTIPS.FORTIFICATION_CLOSEDIRECTIONBUTTON_ACTIVE : TOOLTIPS.FORTIFICATION_CLOSEDIRECTIONBUTTON_INACTIVE;
                if (this._model.hasBuildings) {
                    this.direction.visible = true;
                    this.statusTF.visible = false;
                }
                else {
                    this.direction.visible = false;
                    this.statusTF.visible = true;
                    this.statusTF.htmlText = !!this._model.isOpened ? FORTIFICATIONS.FORTDIRECTIONSWINDOW_LABEL_NOBUILDINGS : FORTIFICATIONS.FORTDIRECTIONSWINDOW_LABEL_NOTOPENED;
                }
            }
            else {
                this.setControlsVisible(false);
            }
        }
    }

    public function setData(param1:DirectionVO):void {
        this._model = param1;
        this.direction.setData(param1);
        invalidateData();
    }

    private function setControlsVisible(param1:Boolean):void {
        this.textField.visible = param1;
        this.closeBtn.visible = param1;
        this.direction.visible = param1;
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new DirectionEvent(DirectionEvent.CLOSE_DIRECTION, this._model.uid));
    }
}
}

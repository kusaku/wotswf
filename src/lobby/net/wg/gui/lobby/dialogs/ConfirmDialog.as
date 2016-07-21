package net.wg.gui.lobby.dialogs {
import flash.display.InteractiveObject;

import net.wg.data.VO.ConfirmDialogVO;
import net.wg.gui.components.common.ConfirmComponent;
import net.wg.infrastructure.base.meta.IConfirmDialogMeta;
import net.wg.infrastructure.base.meta.impl.ConfirmDialogMeta;
import net.wg.infrastructure.interfaces.IWindow;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class ConfirmDialog extends ConfirmDialogMeta implements IConfirmDialogMeta {

    private static const WINDOW_RIGHT_PADDING:int = 12;

    private static const WINDOW_BOTTOM_PADDING:int = 15;

    public var content:ConfirmComponent = null;

    private var _data:ConfirmDialogVO = null;

    public function ConfirmDialog() {
        super();
        isModal = true;
        canDrag = false;
    }

    override public function setWindow(param1:IWindow):void {
        var _loc2_:Padding = null;
        super.setWindow(param1);
        if (window) {
            _loc2_ = Padding(window.contentPadding);
            _loc2_.right = WINDOW_RIGHT_PADDING;
            _loc2_.bottom = WINDOW_BOTTOM_PADDING;
            window.useBottomBtns = true;
        }
    }

    override protected function onDispose():void {
        this.content.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.cancelBtnClickHandler);
        this.content.submitBtn.removeEventListener(ButtonEvent.CLICK, this.submitBtnClickHandler);
        this.content.dispose();
        this.content = null;
        this._data = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.content.cancelBtn.addEventListener(ButtonEvent.CLICK, this.cancelBtnClickHandler);
        this.content.submitBtn.addEventListener(ButtonEvent.CLICK, this.submitBtnClickHandler);
        this.moveFocusToButton();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this._data) {
                window.title = this._data.title;
                this.content.update(this._data);
            }
        }
    }

    override protected function setSettings(param1:ConfirmDialogVO):void {
        this._data = ConfirmDialogVO(param1);
        invalidateData();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        this.moveFocusToButton();
    }

    public function moveFocusToButton():void {
        setFocus(this.content.submitBtn);
    }

    override public function get height():Number {
        return this.content.height;
    }

    protected function submitBtnClickHandler(param1:ButtonEvent):void {
        submitS(this.content.checkBox.selected);
    }

    protected function cancelBtnClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}

package net.wg.gui.lobby.vehiclePreview.controls {
import flash.text.TextField;

import net.wg.gui.components.advanced.interfaces.IBackButton;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewHeaderVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class VehPreviewHeader extends UIComponentEx implements IVehPreviewHeader {

    private static const CLOSE_BTN_OFFSET:int = 15;

    public var background:VehPreviewBackground = null;

    public var titleTf:TextField;

    private var _closeBtn:ISoundButtonEx;

    private var _backBtn:IBackButton;

    public function VehPreviewHeader() {
        super();
    }

    override protected function onDispose():void {
        this._backBtn.removeEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this._closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.background.dispose();
        this.background = null;
        this._closeBtn.dispose();
        this._closeBtn = null;
        this._backBtn.dispose();
        this._backBtn = null;
        this.titleTf = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this._backBtn.addEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this._closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.background.width = width;
            this.layout();
        }
    }

    public function update(param1:Object):void {
        var _loc2_:VehPreviewHeaderVO = VehPreviewHeaderVO(param1);
        this._closeBtn.label = _loc2_.closeBtnLabel;
        this._backBtn.label = _loc2_.backBtnLabel;
        this._backBtn.descrLabel = _loc2_.backBtnDescrLabel;
        this.titleTf.htmlText = _loc2_.titleText;
        App.utils.commons.updateTextFieldSize(this.titleTf, true, false);
        this.layout();
    }

    private function layout():void {
        this.titleTf.x = width - this.titleTf.width >> 1;
        this._closeBtn.x = width - this._closeBtn.width - CLOSE_BTN_OFFSET | 0;
    }

    public function get backBtn():IBackButton {
        return this._backBtn;
    }

    public function set backBtn(param1:IBackButton):void {
        this._backBtn = param1;
    }

    public function get closeBtn():ISoundButtonEx {
        return this._closeBtn;
    }

    public function set closeBtn(param1:ISoundButtonEx):void {
        this._closeBtn = param1;
    }

    private function onBackBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new VehPreviewEvent(VehPreviewEvent.BACK_CLICK, true));
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new VehPreviewEvent(VehPreviewEvent.CLOSE_CLICK, true));
    }
}
}

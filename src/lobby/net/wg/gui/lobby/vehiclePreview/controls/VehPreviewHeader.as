package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.advanced.interfaces.IBackButton;
import net.wg.gui.components.tooltips.helpers.TankTypeIco;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.components.HeaderBackground;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewHeaderVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class VehPreviewHeader extends UIComponentEx implements IVehPreviewHeader {

    private static const CLOSE_BTN_OFFSET:int = 15;

    private static const GAP:int = 25;

    public var tankTypeIcon:TankTypeIco;

    public var txtTankInfo:TextField;

    public var background:HeaderBackground = null;

    public var titleTf:TextField;

    public var premiumIGRBg:Sprite = null;

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
        this.tankTypeIcon.dispose();
        this.tankTypeIcon = null;
        this.txtTankInfo = null;
        this.premiumIGRBg = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this._backBtn.addEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this._closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.premiumIGRBg.mouseEnabled = this.premiumIGRBg.mouseChildren = false;
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
        this.premiumIGRBg.visible = _loc2_.isPremiumIGR;
        this.tankTypeIcon.type = _loc2_.tankType;
        this.txtTankInfo.htmlText = _loc2_.tankInfo;
        this._closeBtn.label = _loc2_.closeBtnLabel;
        this._backBtn.label = _loc2_.backBtnLabel;
        this._backBtn.descrLabel = _loc2_.backBtnDescrLabel;
        this.titleTf.htmlText = _loc2_.titleText;
        App.utils.commons.updateTextFieldSize(this.titleTf, true, false);
        this.layout();
    }

    private function layout():void {
        var _loc1_:* = width >> 1;
        this.tankTypeIcon.x = _loc1_;
        this.titleTf.x = _loc1_ - this.titleTf.width - GAP;
        this.txtTankInfo.x = _loc1_ + GAP;
        this.premiumIGRBg.x = _loc1_ - (this.premiumIGRBg.width >> 1);
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

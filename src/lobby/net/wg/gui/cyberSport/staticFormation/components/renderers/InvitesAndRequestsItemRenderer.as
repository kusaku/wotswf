package net.wg.gui.cyberSport.staticFormation.components.renderers {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.components.controls.ButtonIconTransparent;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsItemVO;
import net.wg.gui.cyberSport.staticFormation.events.InvitesAndRequestsAcceptEvent;
import net.wg.infrastructure.interfaces.IUserProps;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class InvitesAndRequestsItemRenderer extends TableRenderer {

    public var progressIndicator:InviteIndicator;

    public var playerNameTF:TextField;

    public var ratingTF:TextField;

    public var statusTF:TextField;

    public var acceptBtn:IconTextButton;

    public var rejectBtn:ButtonIconTransparent;

    private var _playerId:int = -1;

    private var _playerName:String = "";

    public function InvitesAndRequestsItemRenderer() {
        super();
        this.progressIndicator.stop();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        if (param1 != null) {
            this._playerId = InvitesAndRequestsItemVO(param1).id;
        }
        invalidateData();
    }

    override protected function configUI():void {
        mouseEnabledOnDisabled = true;
        this.acceptBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_CHECKMARK;
        this.rejectBtn.constraintsDisabled = true;
        this.rejectBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_CROSS;
        this.playerNameTF.addEventListener(MouseEvent.ROLL_OUT, this.onPlayerNameTfRollOutHandler);
        this.playerNameTF.addEventListener(MouseEvent.ROLL_OVER, this.onPlayerNameRollOverHandler);
        this.acceptBtn.addEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.rejectBtn.addEventListener(ButtonEvent.CLICK, this.onRejectBtnClickHandler);
    }

    override protected function draw():void {
        var _loc1_:InvitesAndRequestsItemVO = null;
        var _loc2_:IUserProps = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            visible = data != null;
            if (visible) {
                _loc1_ = InvitesAndRequestsItemVO(data);
                this._playerName = _loc1_.name;
                _loc2_ = App.utils.commons.getUserProps(this._playerName);
                App.utils.commons.formatPlayerName(this.playerNameTF, _loc2_);
                this.ratingTF.text = _loc1_.rating.toString();
                this.acceptBtn.visible = _loc1_.showAcceptBtn;
                this.rejectBtn.visible = _loc1_.showRejectBtn;
                this.statusTF.visible = StringUtils.isNotEmpty(_loc1_.status);
                if (this.statusTF.visible) {
                    this.statusTF.htmlText = _loc1_.status;
                }
                this.progressIndicator.visible = _loc1_.showProgressIndicator;
                if (_loc1_.showProgressIndicator) {
                    this.progressIndicator.play();
                }
                else {
                    this.progressIndicator.stop();
                }
            }
        }
    }

    override protected function onDispose():void {
        this.acceptBtn.removeEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.rejectBtn.removeEventListener(ButtonEvent.CLICK, this.onRejectBtnClickHandler);
        this.playerNameTF.removeEventListener(MouseEvent.ROLL_OUT, this.onPlayerNameTfRollOutHandler);
        this.playerNameTF.removeEventListener(MouseEvent.ROLL_OVER, this.onPlayerNameRollOverHandler);
        this.playerNameTF = null;
        this.progressIndicator.stop();
        this.progressIndicator.dispose();
        this.progressIndicator = null;
        this.ratingTF = null;
        this.statusTF = null;
        this.acceptBtn.dispose();
        this.acceptBtn = null;
        this.rejectBtn.dispose();
        this.rejectBtn = null;
        super.onDispose();
    }

    private function dispatchInvitesAndRequestsAcceptEvent(param1:int, param2:Boolean):void {
        dispatchEvent(new InvitesAndRequestsAcceptEvent(param1, param2));
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        buttonMode = false;
        mouseChildren = true;
    }

    private function onAcceptBtnClickHandler(param1:ButtonEvent):void {
        this.dispatchInvitesAndRequestsAcceptEvent(this._playerId, true);
    }

    private function onRejectBtnClickHandler(param1:ButtonEvent):void {
        this.dispatchInvitesAndRequestsAcceptEvent(this._playerId, false);
    }

    private function onPlayerNameTfRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onPlayerNameRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._playerName)) {
            App.toolTipMgr.show(this._playerName);
        }
    }
}
}

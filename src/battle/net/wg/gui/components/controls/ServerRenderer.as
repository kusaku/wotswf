package net.wg.gui.components.controls {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.common.serverStats.ServerVO;
import net.wg.gui.components.controls.helpers.ServerCsisState;
import net.wg.gui.components.controls.helpers.ServerPingState;
import net.wg.gui.components.controls.interfaces.IServerIndicator;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.utils.Constraints;

public class ServerRenderer extends SoundListItemRenderer {

    private static const PING_RIGHT:int = 18;

    private static const LABEL_RIGHT:int = 60;

    private static const ALLERT_OFFSET_X:int = 4;

    private static const ALLERT_Y:int = 2;

    public var serverIndicator:IServerIndicator;

    public var alertIcon:Sprite;

    public var pingTF:TextField;

    private var _serverData:ServerVO;

    private var _commons:ICommons;

    public function ServerRenderer() {
        super();
        this._commons = App.utils.commons;
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        App.toolTipMgr.hide();
        this._serverData = ServerVO(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(this.pingTF.name, this.pingTF, 0);
        constraints.addElement(this.alertIcon.name, this.alertIcon, 0);
        constraints.addElement(textField.name, textField, Constraints.LEFT);
        constraints.addElement(this.serverIndicator.name, DisplayObject(this.serverIndicator), Constraints.RIGHT);
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onHideTooltipHandler);
        addEventListener(MouseEvent.CLICK, this.onHideTooltipHandler);
        this._commons.updateChildrenMouseEnabled(this, false);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onHideTooltipHandler);
        removeEventListener(MouseEvent.CLICK, this.onHideTooltipHandler);
        this.serverIndicator.dispose();
        this.serverIndicator = null;
        this.pingTF = null;
        this.alertIcon = null;
        this._serverData = null;
        this._commons = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:* = false;
        var _loc2_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._serverData != null;
            _loc2_ = false;
            if (_loc1_) {
                _loc2_ = this._serverData.pingState != ServerPingState.IGNORED;
                this.serverIndicator.visible = _loc2_;
                if (_loc2_) {
                    this.serverIndicator.setPingState(this._serverData.pingState);
                    this.serverIndicator.setColorBlindMode(this._serverData.colorBlind);
                    this.serverIndicator.validateNow();
                    this.pingTF.htmlText = this._serverData.pingValue;
                }
            }
            this.visible = _loc1_;
            this.pingTF.visible = _loc2_ && this._serverData.pingState != ServerPingState.UNDEFINED;
            this.alertIcon.visible = _loc1_ && this._serverData.csisStatus == ServerCsisState.NOT_RECOMMENDED;
            invalidateSize();
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateLayout();
        }
    }

    override protected function updateText():void {
        if (_label != null) {
            this._commons.truncateTextFieldText(textField, _label);
        }
    }

    private function updateLayout():void {
        this._commons.updateTextFieldSize(this.pingTF);
        this.pingTF.x = _originalWidth - this.pingTF.width - PING_RIGHT / scaleX | 0;
        textField.width = (_originalWidth - textField.x / textField.scaleX - LABEL_RIGHT) * scaleX | 0;
        this.updateText();
        var _loc1_:Number = textField.x + textField.textWidth * textField.scaleX;
        this.alertIcon.x = (_loc1_ * scaleX + ALLERT_OFFSET_X | 0) / scaleX;
        this.alertIcon.y = ALLERT_Y / scaleY;
    }

    private function onHideTooltipHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        if (this._serverData && StringUtils.isNotEmpty(this._serverData.tooltip)) {
            App.toolTipMgr.show(this._serverData.tooltip);
        }
        else if (_label && textField.text != _label) {
            App.toolTipMgr.show(_label);
        }
    }
}
}

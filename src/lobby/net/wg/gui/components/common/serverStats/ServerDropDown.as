package net.wg.gui.components.common.serverStats {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.helpers.ServerCsisState;
import net.wg.gui.components.controls.helpers.ServerPingState;
import net.wg.gui.components.controls.interfaces.IServerIndicator;
import net.wg.infrastructure.events.ListDataProviderEvent;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.utils.Constraints;

public class ServerDropDown extends DropdownMenu {

    private static const LABEL_RIGHT:int = 29;

    private static const LABEL_RIGHT_WITH_PING:int = 50;

    private static const LABEL_RIGHT_WITH_ALERT:int = 36;

    private static const PING_RIGHT:int = 39;

    public var pingTF:TextField;

    public var indicator:IServerIndicator;

    public var alertIcon:Sprite;

    private var _commons:ICommons;

    private var _serverData:ServerVO;

    public function ServerDropDown() {
        super();
        this._commons = App.utils.commons;
    }

    override protected function configUI():void {
        super.configUI();
        if (!constraintsDisabled) {
            constraints.addElement(textField.name, textField, Constraints.LEFT);
            constraints.addElement(this.pingTF.name, this.pingTF, 0);
            constraints.addElement(this.alertIcon.name, this.alertIcon, Constraints.RIGHT);
            constraints.addElement(this.indicator.name, DisplayObject(this.indicator), Constraints.RIGHT);
        }
        this.indicator.setPingState(ServerPingState.UNDEFINED);
        this.indicator.visible = false;
        this.pingTF.autoSize = TextFieldAutoSize.LEFT;
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onHideTooltipHandler);
        addEventListener(MouseEvent.CLICK, this.onHideTooltipHandler);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onHideTooltipHandler);
        removeEventListener(MouseEvent.CLICK, this.onHideTooltipHandler);
        this.indicator.dispose();
        this.indicator = null;
        this.pingTF = null;
        this.alertIcon = null;
        this._serverData = null;
        this._commons = null;
        super.onDispose();
    }

    override protected function updateText():void {
        if (_label != null) {
            ServerHelper.truncateTextFieldText(textField, _label);
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateLayout();
            this.updateText();
        }
    }

    override protected function populateText(param1:Object):void {
        super.populateText(param1);
        var _loc2_:* = param1 != null;
        textField.visible = _loc2_;
        var _loc3_:Boolean = false;
        if (_loc2_) {
            this._serverData = ServerVO(param1);
            this.indicator.setPingState(this._serverData.pingState);
            this.indicator.setColorBlindMode(this._serverData.colorBlind);
            _loc3_ = this._serverData.pingState != ServerPingState.IGNORED && this._serverData.pingState != ServerPingState.UNDEFINED;
            this.indicator.visible = _loc3_;
            if (_loc3_) {
                this.pingTF.htmlText = this._serverData.pingValue;
            }
        }
        else {
            this._serverData = null;
        }
        this.pingTF.visible = _loc3_;
        this.alertIcon.visible = this.showCsisIndicator();
        this.updateLayout();
    }

    private function showCsisIndicator():Boolean {
        return this._serverData != null && this._serverData.csisStatus == ServerCsisState.NOT_RECOMMENDED;
    }

    private function updateLayout():void {
        var _loc2_:int = 0;
        this._commons.updateTextFieldSize(this.pingTF);
        this.pingTF.x = _originalWidth - this.pingTF.width - PING_RIGHT / scaleX | 0;
        var _loc1_:Boolean = this.showCsisIndicator();
        if (_loc1_) {
            _loc2_ = LABEL_RIGHT_WITH_ALERT;
        }
        else if (this.indicator.visible) {
            _loc2_ = LABEL_RIGHT_WITH_PING;
        }
        else {
            _loc2_ = LABEL_RIGHT;
        }
        textField.width = (_originalWidth - textField.x / textField.scaleX - _loc2_) * scaleX | 0;
    }

    override public function set dataProvider(param1:IDataProvider):void {
        if (_dataProvider) {
            _dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM, this.onDataProviderUpdateItemHandler);
        }
        super.dataProvider = param1;
        if (_dataProvider) {
            _dataProvider.addEventListener(ListDataProviderEvent.UPDATE_ITEM, this.onDataProviderUpdateItemHandler);
        }
    }

    private function onHideTooltipHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onDataProviderUpdateItemHandler(param1:ListDataProviderEvent):void {
        if (param1.index == _selectedIndex) {
            this.populateText(param1.data);
        }
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

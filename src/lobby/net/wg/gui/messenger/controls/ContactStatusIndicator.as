package net.wg.gui.messenger.controls {
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.messenger.data.ContactItemVO;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class ContactStatusIndicator extends UIComponent implements IUpdatable {

    private static const BUSY_BLIND:String = "busyBlind";

    private static const ONLINE:String = "online";

    private static const OFFLINE:String = "offline";

    private static const BUSY:String = "busy";

    private static const WOT:String = "wot";

    public var statusIcon:BitmapFill = null;

    private var _showOfflineIndicator:Boolean = true;

    private var _linkage:String = null;

    private var _data:ContactItemVO = null;

    public function ContactStatusIndicator() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function onDispose():void {
        this.statusIcon.dispose();
        this.statusIcon = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._data) {
            if (this._data.resource != "" && this._data.resource != WOT) {
                this.updateIcon(this._data.resource);
            }
            else if (this._data.isOnline) {
                if (this._data.isBusy) {
                    this.updateIcon(!!this._data.isColorBlind ? BUSY_BLIND : BUSY);
                }
                else {
                    this.updateIcon(ONLINE);
                }
            }
            else if (this._showOfflineIndicator) {
                this.updateIcon(OFFLINE);
            }
            else {
                this.updateIcon("");
            }
        }
    }

    public function setLinkage(param1:String):void {
        this._linkage = param1;
    }

    public function update(param1:Object):void {
        if (this._data == param1) {
            return;
        }
        this._data = ContactItemVO(param1);
        invalidateData();
    }

    private function updateIcon(param1:String):void {
        this.statusIcon.visible = param1 != "" && this._linkage != null;
        if (this._linkage) {
            this.statusIcon.source = this._linkage + param1;
        }
        this.statusIcon.source = this._linkage + param1;
    }

    override public function get height():Number {
        return this.statusIcon.heightFill;
    }

    override public function get width():Number {
        return this.statusIcon.widthFill;
    }

    public function set showOfflineIndicator(param1:Boolean):void {
        if (this._showOfflineIndicator == param1) {
            return;
        }
        this._showOfflineIndicator = param1;
        invalidateData();
    }
}
}

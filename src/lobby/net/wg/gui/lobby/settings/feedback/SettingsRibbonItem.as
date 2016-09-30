package net.wg.gui.lobby.settings.feedback {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.lobby.settings.feedback.data.RibbonItemData;
import net.wg.infrastructure.base.UIComponentEx;

public class SettingsRibbonItem extends UIComponentEx {

    private static const RIBBON_TYPE_RIGHT_PADDING:int = 4;

    public var ribbonTypeTF:TextField = null;

    public var vehNameTF:TextField = null;

    public var valueTF:TextField = null;

    public var tankType:MovieClip = null;

    public var bg:MovieClip = null;

    private var _isWithRibbonType:Boolean = true;

    private var _isWithVehInfo:Boolean = true;

    private var _vehInfoIsEnabled:Boolean = false;

    public function SettingsRibbonItem() {
        super();
        stop();
        mouseEnabled = mouseChildren = false;
    }

    override protected function onDispose():void {
        this.ribbonTypeTF = null;
        this.vehNameTF = null;
        this.valueTF = null;
        this.tankType = null;
        this.bg = null;
        super.onDispose();
    }

    public function setData(param1:RibbonItemData):void {
        gotoAndStop(param1.ribbonType);
        this.bg.visible = this._isWithRibbonType || this._isWithVehInfo;
        this.ribbonTypeTF.text = param1.text;
        this._vehInfoIsEnabled = this.vehNameTF != null;
        if (this._vehInfoIsEnabled) {
            this.vehNameTF.text = param1.vehName;
            this.updateVehInfoPosition();
        }
        this.valueTF.text = param1.value;
    }

    public function updateSettings(param1:Boolean, param2:Boolean):void {
        if (this._isWithRibbonType != param1) {
            this._isWithRibbonType = param1;
            this.ribbonTypeTF.visible = param1;
            if (this._vehInfoIsEnabled) {
                this.updateVehInfoPosition();
            }
        }
        if (this._vehInfoIsEnabled && this._isWithVehInfo != param2) {
            this._isWithVehInfo = param2;
            this.vehNameTF.visible = this.tankType.visible = param2;
        }
        this.bg.visible = param1 || param2 && this.vehNameTF != null;
    }

    private function updateVehInfoPosition():void {
        var _loc1_:int = this.ribbonTypeTF.x;
        if (this._isWithRibbonType) {
            _loc1_ = _loc1_ + (this.ribbonTypeTF.textWidth + RIBBON_TYPE_RIGHT_PADDING);
        }
        this.tankType.x = _loc1_;
        this.vehNameTF.x = this.tankType.x + this.tankType.width;
    }
}
}

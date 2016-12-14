package net.wg.gui.lobby.questsWindow.components {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;

public class CustomizationItemRenderer extends UIComponentEx {

    public var loader:UILoaderAlt;

    private var _data:Object;

    private var _valueText:TextField;

    public function CustomizationItemRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.loader.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        this.loader.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
    }

    override protected function draw():void {
        super.draw();
        if (this.data && isInvalid(InvalidationType.DATA)) {
            this.loader.source = this.data.texture;
            if (this.data.valueStr) {
                this._valueText = App.textMgr.createTextField();
                this._valueText.selectable = false;
                this._valueText.htmlText = this.data.valueStr;
                this._valueText.x = Math.round(this.loader.originalWidth + 2);
                this._valueText.y = Math.round(this.loader.originalHeight - this._valueText.textHeight);
                this._valueText.width = this._valueText.textWidth + 4;
                this._valueText.height = this._valueText.textHeight + 4;
                addChild(this._valueText);
            }
        }
    }

    override protected function onDispose():void {
        this._data = null;
        this.loader.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        this.loader.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        this.loader.dispose();
        this.loader = null;
        if (this._valueText) {
            removeChild(this._valueText);
            this._valueText = null;
        }
        super.onDispose();
    }

    public function get data():Object {
        return this._data;
    }

    public function set data(param1:Object):void {
        this._data = param1;
        invalidateData();
    }

    private function get toolTipMgr():ITooltipMgr {
        return App.toolTipMgr;
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        this.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CUSTOMIZATION_ITEM, null, this.data.type, this.data.id, this.data.nationId, this.data.value, this.data.isPermanent, this.data.boundVehicle, this.data.boundToCurrentVehicle);
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        this.toolTipMgr.hide();
    }
}
}

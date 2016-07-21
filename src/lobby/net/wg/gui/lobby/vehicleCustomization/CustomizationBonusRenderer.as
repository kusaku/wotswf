package net.wg.gui.lobby.vehicleCustomization {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.Image;
import net.wg.gui.lobby.vehicleCustomization.controls.AnimatedBonus;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBonusRendererVO;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.controls.ListItemRenderer;

public class CustomizationBonusRenderer extends ListItemRenderer {

    public var bonusName:TextField = null;

    public var bonusIcon:Image = null;

    public var animatedBonus:AnimatedBonus = null;

    private var _bonusData:CustomizationBonusRendererVO = null;

    private var _tooltipMgr:ITooltipMgr = null;

    public function CustomizationBonusRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        if (_data != null) {
            this._bonusData = CustomizationBonusRendererVO(_data);
            this.bonusName.htmlText = this._bonusData.bonusName;
            this.bonusIcon.source = this._bonusData.bonusIcon;
            this.animatedBonus.data = this._bonusData.animation;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this._tooltipMgr = App.toolTipMgr;
        buttonMode = useHandCursor = false;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
    }

    override protected function onBeforeDispose():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._tooltipMgr.hide();
        this._tooltipMgr = null;
        this.bonusIcon.dispose();
        this.bonusIcon = null;
        this.animatedBonus.dispose();
        this.animatedBonus = null;
        this.bonusName = null;
        this._bonusData = null;
        super.onDispose();
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_BONUS, null, this._bonusData.bonusType);
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }
}
}

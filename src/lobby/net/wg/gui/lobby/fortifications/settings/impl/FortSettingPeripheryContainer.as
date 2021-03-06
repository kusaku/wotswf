package net.wg.gui.lobby.fortifications.settings.impl {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.fortifications.data.settings.PeripheryContainerVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.ISpriteEx;

import scaleform.clik.events.ButtonEvent;

public class FortSettingPeripheryContainer extends UIComponentEx implements ISpriteEx, IPopOverCaller {

    private static const TEXT_PADDING:int = 4;

    public var peripheryName:TextField = null;

    public var peripheryTitle:TextField = null;

    public var changePeriphery:IButtonIconLoader = null;

    public var tooltipHitArea:MovieClip = null;

    private var descriptionTooltip:String = "";

    public function FortSettingPeripheryContainer() {
        super();
        this.scaleX = this.scaleY = 1;
        this.changePeriphery.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SETTINGS;
        this.peripheryName.autoSize = TextFieldAutoSize.CENTER;
        this.peripheryTitle.autoSize = TextFieldAutoSize.CENTER;
    }

    public function update(param1:Object):void {
        var _loc2_:PeripheryContainerVO = PeripheryContainerVO(param1);
        this.peripheryTitle.htmlText = _loc2_.peripheryTitle;
        this.peripheryName.htmlText = _loc2_.peripheryName;
        this.peripheryName.x = Math.round(this.changePeriphery.x - this.peripheryName.width - TEXT_PADDING);
        this.peripheryTitle.x = Math.round(this.peripheryName.x - this.peripheryTitle.width - TEXT_PADDING);
        this.changePeriphery.enabled = _loc2_.buttonEnabled;
        this.changePeriphery.tooltip = _loc2_.buttonToolTip;
        this.descriptionTooltip = _loc2_.descriptionTooltip;
        this.tooltipHitArea.x = this.peripheryTitle.x;
        this.tooltipHitArea.width = this.peripheryName.x + this.peripheryName.width - this.peripheryTitle.x;
    }

    public function getTargetButton():DisplayObject {
        return this.changePeriphery as DisplayObject;
    }

    public function getHitArea():DisplayObject {
        return this.changePeriphery as DisplayObject;
    }

    override protected function configUI():void {
        this.changePeriphery.mouseEnabledOnDisabled = true;
        this.changePeriphery.addEventListener(ButtonEvent.CLICK, this.onClickChangePeriphery);
        this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OVER, this.onDescriptionRollOverHandler);
        this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OUT, this.onDescriptionRollOutHandler);
    }

    override protected function onDispose():void {
        this.changePeriphery.removeEventListener(ButtonEvent.CLICK, this.onClickChangePeriphery);
        this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OVER, this.onDescriptionRollOverHandler);
        this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OUT, this.onDescriptionRollOutHandler);
        this.changePeriphery.dispose();
        this.changePeriphery = null;
        this.peripheryName = null;
        this.peripheryTitle = null;
        this.tooltipHitArea = null;
        super.onDispose();
    }

    private function onClickChangePeriphery(param1:ButtonEvent):void {
        var _loc2_:Number = Math.round(this.changePeriphery.x);
        var _loc3_:Number = Math.round(this.changePeriphery.y);
        var _loc4_:Point = localToGlobal(new Point(_loc2_, _loc3_));
        App.popoverMgr.show(this, FORTIFICATION_ALIASES.FORT_SETTINGS_PERIPHERY_POPOVER_ALIAS);
    }

    private function onDescriptionRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this.descriptionTooltip);
    }

    private function onDescriptionRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}

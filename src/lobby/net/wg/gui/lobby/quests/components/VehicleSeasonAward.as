package net.wg.gui.lobby.quests.components {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.tooltips.helpers.TankTypeIco;
import net.wg.gui.lobby.quests.data.seasonAwards.VehicleSeasonAwardVO;
import net.wg.gui.lobby.quests.events.SeasonAwardWindowEvent;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class VehicleSeasonAward extends UIComponentEx {

    public var iconLoader:UILoaderAlt;

    public var typeIcon:TankTypeIco;

    public var nameTf:TextField;

    public var buttonAbout:SoundButtonEx;

    public var tokensCountTf:TextField;

    private var _vehicleId:Number;

    private var _tokensCountTooltip:String;

    public function VehicleSeasonAward() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.tokensCountTf.addEventListener(MouseEvent.ROLL_OVER, this.onTokensCountRollOverHandler);
        this.tokensCountTf.addEventListener(MouseEvent.ROLL_OUT, this.onTokensCountRollOutHandler);
        this.buttonAbout.addEventListener(ButtonEvent.CLICK, this.onButtonAboutClickHandler);
    }

    override protected function onDispose():void {
        this.tokensCountTf.removeEventListener(MouseEvent.ROLL_OVER, this.onTokensCountRollOverHandler);
        this.tokensCountTf.removeEventListener(MouseEvent.ROLL_OUT, this.onTokensCountRollOutHandler);
        this.iconLoader.dispose();
        this.iconLoader = null;
        this.buttonAbout.removeEventListener(ButtonEvent.CLICK, this.onButtonAboutClickHandler);
        this.buttonAbout.dispose();
        this.buttonAbout = null;
        this.typeIcon.dispose();
        this.typeIcon = null;
        this.nameTf = null;
        this.tokensCountTf = null;
        super.onDispose();
    }

    public function setData(param1:VehicleSeasonAwardVO):void {
        this.buttonAbout.label = param1.buttonText;
        this.buttonAbout.tooltip = param1.buttonTooltipId;
        this.typeIcon.type = param1.vehicleType;
        this.nameTf.htmlText = param1.name;
        this.iconLoader.source = param1.iconPath;
        this.tokensCountTf.htmlText = param1.tokensCountText;
        this._vehicleId = param1.vehicleId;
        this._tokensCountTooltip = param1.tokensCountTooltip;
        App.utils.commons.updateTextFieldSize(this.nameTf, false, true);
    }

    private function onButtonAboutClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new SeasonAwardWindowEvent(SeasonAwardWindowEvent.SHOW_VEHICLE_INFO, this._vehicleId, true));
    }

    private function onTokensCountRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._tokensCountTooltip)) {
            App.toolTipMgr.showSpecial(this._tokensCountTooltip, null);
        }
    }

    private function onTokensCountRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}

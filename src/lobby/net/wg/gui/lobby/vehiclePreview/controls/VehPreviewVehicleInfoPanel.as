package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.tooltips.helpers.TankTypeIco;
import net.wg.gui.interfaces.IUpdatableComponent;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewVehicleInfoPanelVO;
import net.wg.infrastructure.base.UIComponentEx;

public class VehPreviewVehicleInfoPanel extends UIComponentEx implements IUpdatableComponent {

    private static const ELITE_VEHICLE_HORIZONTAL_OFFSET:int = 86;

    private static const REGULAR_VEHICLE_HORIZONTAL_OFFSET:int = 96;

    private static const ELITE_POSTFIX:String = "_elite";

    private static const BOTTOM_MARGIN:int = 9;

    public var tankTypeIco:TankTypeIco = null;

    public var tankName:TextField = null;

    public var tankDescr:TextField = null;

    public var infoTf:TextField = null;

    public var premiumIGRBg:Sprite = null;

    public var bg:MovieClip = null;

    public function VehPreviewVehicleInfoPanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.mouseEnabled = false;
        this.bg.mouseEnabled = false;
        this.bg.mouseChildren = false;
        this.premiumIGRBg.mouseEnabled = this.premiumIGRBg.mouseChildren = false;
    }

    override protected function onDispose():void {
        this.premiumIGRBg = null;
        this.tankTypeIco.dispose();
        this.tankTypeIco = null;
        this.tankName = null;
        this.tankDescr = null;
        this.infoTf = null;
        this.bg = null;
        super.onDispose();
    }

    public function update(param1:Object):void {
        var _loc2_:VehPreviewVehicleInfoPanelVO = VehPreviewVehicleInfoPanelVO(param1);
        var _loc3_:Boolean = _loc2_.isElite;
        this.tankTypeIco.type = !!_loc3_ ? _loc2_.type + ELITE_POSTFIX : _loc2_.type;
        this.tankTypeIco.x = !!_loc3_ ? Number(ELITE_VEHICLE_HORIZONTAL_OFFSET) : Number(REGULAR_VEHICLE_HORIZONTAL_OFFSET);
        this.tankName.htmlText = _loc2_.name;
        this.tankDescr.htmlText = _loc2_.vDescription;
        this.infoTf.htmlText = _loc2_.info;
        this.premiumIGRBg.visible = _loc2_.isPremiumIGR;
        App.utils.commons.updateTextFieldSize(this.infoTf, false, true);
        this.bg.height = this.infoTf.y + this.infoTf.height + BOTTOM_MARGIN;
        height = actualHeight;
    }
}
}

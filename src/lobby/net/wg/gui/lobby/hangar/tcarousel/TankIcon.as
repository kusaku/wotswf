package net.wg.gui.lobby.hangar.tcarousel {
import flash.text.TextField;

import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;

import org.idmedia.as3commons.util.StringUtils;

public class TankIcon extends BaseTankIcon {

    public var txtRentInfo:TextField = null;

    public function TankIcon() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        imgFavorite.source = RES_ICONS.MAPS_ICONS_TOOLTIP_MAIN_TYPE;
    }

    override protected function onDispose():void {
        this.txtRentInfo = null;
        super.onDispose();
    }

    override protected function updateData(param1:VehicleCarouselVO):void {
        super.updateData(param1);
        var _loc2_:Boolean = StringUtils.isNotEmpty(param1.infoText);
        txtInfo.visible = _loc2_;
        if (_loc2_) {
            txtInfo.htmlText = param1.infoText;
        }
        this.txtRentInfo.htmlText = param1.rentLeft;
        imgIcon.source = param1.icon;
    }

    override protected function setVisibleVehicleInfo(param1:Boolean):void {
        super.setVisibleVehicleInfo(param1);
        this.txtRentInfo.visible = param1;
    }
}
}

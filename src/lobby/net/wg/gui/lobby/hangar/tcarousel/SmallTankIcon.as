package net.wg.gui.lobby.hangar.tcarousel {
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

public class SmallTankIcon extends BaseTankIcon {

    private var _commons:ICommons;

    public function SmallTankIcon() {
        super();
        this._commons = App.utils.commons;
    }

    override protected function configUI():void {
        super.configUI();
        imgFavorite.source = RES_ICONS.MAPS_ICONS_LIBRARY_FAVORITE_SMALL;
    }

    override protected function updateData(param1:VehicleCarouselVO):void {
        super.updateData(param1);
        clanLock.validateNow();
        var _loc2_:Boolean = StringUtils.isNotEmpty(param1.smallInfoText) && !clanLock.visible;
        txtInfo.visible = _loc2_;
        if (_loc2_) {
            txtInfo.htmlText = param1.smallInfoText;
            this._commons.updateTextFieldSize(txtInfo, false, true);
            txtInfo.y = height - txtInfo.height >> 1;
        }
        imgIcon.source = param1.iconSmall;
    }

    override protected function onDispose():void {
        this._commons = null;
        super.onDispose();
    }
}
}

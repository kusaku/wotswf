package net.wg.gui.lobby.hangar.tcarousel {
import flash.display.MovieClip;
import flash.filters.DropShadowFilter;
import flash.text.TextField;

import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.Image;
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
import net.wg.infrastructure.base.UIComponentEx;

public class BaseTankIcon extends UIComponentEx {

    private static const PREM_FILTER:DropShadowFilter = new DropShadowFilter(0, 90, 16723968, 0.7, 12, 12, 3, 2);

    private static const DEF_FILTER:DropShadowFilter = new DropShadowFilter(0, 90, 13224374, 0.2, 8, 8, 4, 2);

    public var mcFlag:MovieClip = null;

    public var imgIcon:Image = null;

    public var mcTankType:MovieClip = null;

    public var mcLevel:MovieClip = null;

    public var txtTankName:TextField = null;

    public var imgFavorite:Image = null;

    public var price:IconText = null;

    public var txtInfo:TextField = null;

    public var clanLock:ClanLockUI = null;

    public var actionPrice:ActionPrice = null;

    public var imgXp:Image = null;

    private var _visibleVehicleInfo:Boolean = true;

    public function BaseTankIcon() {
        super();
    }

    override protected function onDispose():void {
        this.mcFlag = null;
        this.imgIcon.dispose();
        this.imgIcon = null;
        this.mcTankType = null;
        this.mcLevel = null;
        this.txtTankName = null;
        this.imgFavorite.dispose();
        this.imgFavorite = null;
        this.price.dispose();
        this.price = null;
        this.txtInfo = null;
        this.clanLock.dispose();
        this.clanLock = null;
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.imgXp.dispose();
        this.imgXp = null;
        super.onDispose();
    }

    public final function setData(param1:VehicleCarouselVO):void {
        if (param1 != null) {
            this.updateData(param1);
        }
        else {
            visible = false;
        }
    }

    protected function updateData(param1:VehicleCarouselVO):void {
        this.price.visible = this.actionPrice.visible = false;
        if (param1.buyTank) {
            this.setVisibleVehicleInfo(false);
        }
        else if (param1.buySlot) {
            this.setVisibleVehicleInfo(false);
            if (param1.hasSale) {
                this.actionPrice.setData(param1.getActionPriceVO());
            }
            else {
                this.price.text = param1.slotPrice.toString();
            }
            this.price.visible = !param1.hasSale;
            this.actionPrice.visible = param1.hasSale;
        }
        else {
            this.mcFlag.gotoAndStop(param1.nation + 1);
            this.mcTankType.gotoAndStop(param1.tankType);
            this.mcLevel.gotoAndStop(param1.level);
            this.imgXp.source = param1.xpImgSource;
            this.txtTankName.htmlText = param1.label;
            this.txtTankName.filters = !!param1.premium ? [PREM_FILTER] : [DEF_FILTER];
            this.setVisibleVehicleInfo(true);
        }
        this.imgFavorite.visible = param1.favorite;
        this.clanLock.timer = param1.clanLock;
        visible = true;
    }

    protected function setVisibleVehicleInfo(param1:Boolean):void {
        if (this._visibleVehicleInfo != param1) {
            this._visibleVehicleInfo = param1;
            this.txtTankName.visible = this.imgXp.visible = this.mcTankType.visible = this.mcFlag.visible = this.mcLevel.visible = param1;
        }
    }
}
}

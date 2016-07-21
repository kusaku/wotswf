package net.wg.gui.lobby.vehicleBuyWindow {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.infrastructure.base.UIComponentEx;

public class HeaderMc extends UIComponentEx {

    public var tankName:TextField = null;

    public var icon:TankIcon = null;

    public var tankDescr:TextAreaSimple = null;

    public var tankPriceLabel:TextField = null;

    public var tankPrice:IconText = null;

    public var tankActionPrice:ActionPrice = null;

    public var rentIcon:MovieClip = null;

    public var rentDD:DropdownMenu;

    public var descriptionScrollBar:ScrollBar;

    public function HeaderMc() {
        super();
    }

    override protected function onDispose():void {
        this.tankName = null;
        this.tankPriceLabel = null;
        this.rentIcon = null;
        this.icon.dispose();
        this.icon = null;
        this.tankDescr.dispose();
        this.tankDescr = null;
        this.tankPrice.dispose();
        this.tankPrice = null;
        this.tankActionPrice.dispose();
        this.tankActionPrice = null;
        this.descriptionScrollBar = null;
        this.rentDD.dispose();
        this.rentDD = null;
        super.onDispose();
    }
}
}

package net.wg.gui.lobby.vehicleCompare.controls {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
import net.wg.infrastructure.interfaces.IImage;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class VehicleCompareAnimRenderer extends MovieClip implements IDisposable {

    public var typeIcon:IImage;

    public var tankName:TextField;

    public function VehicleCompareAnimRenderer() {
        super();
        this.tankName.autoSize = TextFieldAutoSize.LEFT;
    }

    public final function dispose():void {
        this.typeIcon.dispose();
        this.typeIcon = null;
        this.tankName = null;
    }

    public function setData(param1:VehicleCompareAnimVO):void {
        this.typeIcon.source = param1.vehType;
        this.tankName.htmlText = param1.vehName;
    }

    override public function get width():Number {
        return this.tankName.x + this.tankName.width - this.typeIcon.x >> 0;
    }
}
}

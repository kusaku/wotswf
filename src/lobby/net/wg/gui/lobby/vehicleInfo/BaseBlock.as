package net.wg.gui.lobby.vehicleInfo {
import flash.display.Sprite;
import flash.text.TextField;

public class BaseBlock extends Sprite {

    public var baseName:TextField;

    public function BaseBlock() {
        super();
    }

    public function setData(param1:String):void {
        this.baseName.text = param1;
    }
}
}

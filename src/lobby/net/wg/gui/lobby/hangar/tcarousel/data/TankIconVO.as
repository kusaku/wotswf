package net.wg.gui.lobby.hangar.tcarousel.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class TankIconVO extends DAAPIDataClass {

    public var image:String = "";

    public var label:String = "";

    public var level:Number = 0;

    public var elite:Boolean = false;

    public var premium:Boolean = false;

    public var favorite:Boolean = false;

    public var nation:Number = 0;

    public var doubleXPReceived:Number = 0;

    public var tankType:String = "";

    public var rentLeft:String = "";

    public function TankIconVO(param1:Object) {
        super(param1);
    }
}
}

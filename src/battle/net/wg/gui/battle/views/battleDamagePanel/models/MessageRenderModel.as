package net.wg.gui.battle.views.battleDamagePanel.models {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.daapi.base.DAAPIDataClass;

public class MessageRenderModel extends DAAPIDataClass {

    public var value:String = "";

    public var actionTypeImg:String = "";

    public var vehicleTypeImg:String = "";

    public var vehicleName:String = "";

    public var imageRenderInstance:Sprite = null;

    public var actionTypeInstance:Shape = null;

    public var vehicleIconInstance:Shape = null;

    public var bgImageInstance:Shape = null;

    public var renderInstanceYPosition:int;

    public var isEmptyImageData:Boolean = true;

    public var isEmptyTextData:Boolean = true;

    public var textRendererInstance:Sprite = null;

    public var valueTFInstance:TextField = null;

    public var vehicleNameTFInstance:TextField = null;

    public var valueColor:uint = 16777215;

    public function MessageRenderModel(param1:Object = null) {
        super(param1);
    }

    override protected function onDispose():void {
        this.imageRenderInstance = null;
        this.actionTypeInstance = null;
        this.vehicleIconInstance = null;
        this.bgImageInstance = null;
        this.textRendererInstance = null;
        this.valueTFInstance = null;
        this.vehicleNameTFInstance = null;
        super.onDispose();
    }
}
}

package net.wg.gui.components.tooltips.helpers {
import scaleform.clik.core.UIComponent;

public class TankTypeIco extends UIComponent {

    private var _type:String = null;

    public function TankTypeIco() {
        super();
        stop();
    }

    override protected function configUI():void {
        super.configUI();
        gotoAndStop(1);
    }

    override protected function draw():void {
        super.draw();
        if (_labelHash[this.type]) {
            gotoAndStop(this.type);
        }
    }

    public function get type():String {
        return this._type;
    }

    public function set type(param1:String):void {
        this._type = param1;
        invalidate();
    }
}
}

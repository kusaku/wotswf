package net.wg.gui.components.crosshair {
import flash.display.MovieClip;
import flash.events.Event;

public class CrosshairStrategic extends CrosshairBase {

    private static const NODE_TYPE_RED:String = "red";

    private static const NODE_TYPE_GREEN:String = "green";

    private static const NODE_TYPE_DEBUG:String = "debug";

    public var elem_1:MovieClip;

    public var elem_2:MovieClip;

    public var elem_3:MovieClip;

    public var elem_4:MovieClip;

    public var elem_5:MovieClip;

    public var elem_6:MovieClip;

    public var elem_7:MovieClip;

    public var elem_8:MovieClip;

    public var elem_9:MovieClip;

    public var elem_10:MovieClip;

    public var elem_11:MovieClip;

    public var elem_12:MovieClip;

    public var elem_13:MovieClip;

    public var elem_14:MovieClip;

    public var elem_15:MovieClip;

    public var elem_16:MovieClip;

    public var elem_17:MovieClip;

    public var elem_18:MovieClip;

    public var elem_19:MovieClip;

    public var elem_20:MovieClip;

    public var elem_21:MovieClip;

    public var elem_22:MovieClip;

    public var elem_23:MovieClip;

    public var elem_24:MovieClip;

    public var elem_25:MovieClip;

    public var elem_26:MovieClip;

    public var elem_27:MovieClip;

    public var elem_28:MovieClip;

    public var elem_29:MovieClip;

    public var elem_30:MovieClip;

    public var elem_31:MovieClip;

    public var elem_32:MovieClip;

    public var elem_33:MovieClip;

    public var elem_34:MovieClip;

    public var elem_35:MovieClip;

    public var elem_36:MovieClip;

    public var elem_37:MovieClip;

    private var _nodes:Vector.<MovieClip>;

    private var _nodesTotal:int = 0;

    public function CrosshairStrategic() {
        this._nodes = new Vector.<MovieClip>();
        super();
    }

    override public function setAsDebug():void {
        this.radiusNodesGotoAndStop(NODE_TYPE_DEBUG);
    }

    override public function setFilter():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._nodesTotal) {
            this._nodes[_loc1_].filters = [devModeColorFilter];
            _loc1_++;
        }
    }

    override public function setReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0):void {
        super.setReloading(param1, param2, param3, param4);
        this.radiusNodesGotoAndStop(param1 == 0 ? NODE_TYPE_GREEN : NODE_TYPE_RED);
    }

    override public function setReloadingAsPercent(param1:Number, param2:Boolean):void {
        super.setReloadingAsPercent(param1, param2);
        this.radiusNodesGotoAndStop(param1 < 100 ? NODE_TYPE_RED : NODE_TYPE_GREEN);
    }

    override protected function onDispose():void {
        super.onDispose();
        this._nodes.splice(0, this._nodes.length);
        this._nodes = null;
    }

    private function radiusNodesGotoAndStop(param1:String):void {
        var _loc2_:int = 0;
        while (_loc2_ < this._nodesTotal) {
            this._nodes[_loc2_].gotoAndStop(param1);
            _loc2_++;
        }
    }

    override protected function init(param1:Event = null):void {
        this._nodesTotal = this.numChildren;
        var _loc2_:int = 0;
        while (_loc2_ < this._nodesTotal) {
            this._nodes[_loc2_] = this.getChildAt(_loc2_) as MovieClip;
            _loc2_++;
        }
    }
}
}

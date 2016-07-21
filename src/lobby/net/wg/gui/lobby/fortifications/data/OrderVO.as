package net.wg.gui.lobby.fortifications.data {
import net.wg.gui.components.controls.VO.SlotVO;

public class OrderVO extends SlotVO {

    private var _enabled:Boolean = true;

    private var _buildingStr:String = "";

    private var _count:int = -1;

    private var _level:int = -1;

    private var _inProgress:Boolean = false;

    private var _isRecharged:Boolean = false;

    public var fortOrderTypeID:int = -1;

    public var orderUIID:uint = 0;

    public var slotID:int = -1;

    public function OrderVO(param1:Object) {
        super(param1);
    }

    public function get enabled():Boolean {
        return this._enabled;
    }

    public function set enabled(param1:Boolean):void {
        this._enabled = param1;
    }

    public function get count():int {
        return this._count;
    }

    public function set count(param1:int):void {
        this._count = param1;
    }

    public function get level():int {
        return this._level;
    }

    public function set level(param1:int):void {
        this._level = param1;
    }

    public function get inProgress():Boolean {
        return this._inProgress;
    }

    public function set inProgress(param1:Boolean):void {
        this._inProgress = param1;
    }

    public function get buildingStr():String {
        return this._buildingStr;
    }

    public function set buildingStr(param1:String):void {
        this._buildingStr = param1;
    }

    public function get isRecharged():Boolean {
        return this._isRecharged;
    }

    public function set isRecharged(param1:Boolean):void {
        this._isRecharged = param1;
    }
}
}

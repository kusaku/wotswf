package net.wg.gui.settings {
public class SettingsChangesMap {

    private var _data:Object;

    private var _len:uint;

    public function SettingsChangesMap() {
        super();
        this.clear();
    }

    public function clear():void {
        this._data = App.utils.data.cleanupDynamicObject(this._data);
        this._data = new Object();
        this._len = 0;
    }

    public function getChanges():Object {
        return this._data;
    }

    public function tryAddChanges(param1:String, param2:*):void {
        this.addChanges(this._data, param1, param2);
    }

    public function tryCutChanges(param1:String, param2:*):void {
        this.cutChanges(this._data, param1, param2);
    }

    private function addChanges(param1:Object, param2:String, param3:*):void {
        var _loc4_:* = null;
        if (!param1.hasOwnProperty(param2)) {
            this._len++;
            param1[param2] = param3;
        }
        else if (!(param3 is String) && !(param3 is Number) && !(param3 is Boolean) && !(param3 is Array)) {
            for (_loc4_ in param3) {
                this.addChanges(param1[param2], _loc4_, param3[_loc4_]);
            }
        }
        else {
            param1[param2] = param3;
        }
    }

    private function cutChanges(param1:Object, param2:String, param3:*):Boolean {
        var _loc4_:* = null;
        var _loc5_:Boolean = false;
        var _loc6_:uint = 0;
        var _loc7_:* = null;
        if (param1.hasOwnProperty(param2)) {
            if (!(param3 is String) && !(param3 is Number) && !(param3 is Boolean) && !(param3 is Array)) {
                for (_loc4_ in param3) {
                    _loc5_ = this.cutChanges(param1[param2], _loc4_, param3[_loc4_]);
                    if (_loc5_) {
                        _loc6_ = 0;
                        for (_loc7_ in param1[param2]) {
                            _loc6_++;
                        }
                        if (_loc6_ == 0) {
                            delete param1[param2];
                            return true;
                        }
                    }
                }
                return false;
            }
            this._len--;
            delete param1[param2];
            return true;
        }
        return false;
    }

    public function get length():uint {
        return this._len;
    }
}
}

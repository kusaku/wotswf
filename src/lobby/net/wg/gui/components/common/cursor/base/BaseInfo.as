package net.wg.gui.components.common.cursor.base {
import flash.display.InteractiveObject;

import net.wg.data.constants.Errors;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
import net.wg.utils.IAssertable;

public class BaseInfo implements IDisposable {

    public static const STATE_NONE:String = "none";

    public static const STATE_INITIALIZED:String = "initialized";

    public static const STATE_STARTED:String = "started";

    private var _cursor:String = "";

    private var _container:IDragDropHitArea = null;

    private var _processState:String = "none";

    public function BaseInfo(param1:IDragDropHitArea, param2:String, param3:String) {
        super();
        var _loc4_:* = "drag or drop object \'" + param1 + "\' must be InteractiveObject";
        var _loc5_:IAssertable = App.utils.asserter;
        _loc5_.assertNotNull(param1, "dragDropObject" + Errors.CANT_NULL);
        _loc5_.assert(param1 is InteractiveObject, _loc4_);
        this._container = param1;
        this._cursor = !!param2 ? param2 : param3;
    }

    public static function getHitFromContainer(param1:IDragDropHitArea):InteractiveObject {
        var _loc2_:InteractiveObject = param1.getHitArea();
        return !!_loc2_ ? _loc2_ : InteractiveObject(param1);
    }

    public function dispose():void {
        this._cursor = null;
        this._container = null;
        this._processState = null;
    }

    protected final function getContainer():IDragDropHitArea {
        return this._container;
    }

    protected final function getCursor():String {
        return this._cursor;
    }

    public function get hit():InteractiveObject {
        return BaseInfo.getHitFromContainer(this._container);
    }

    public function get cursor():String {
        return this._cursor;
    }

    public function get state():String {
        return this._processState;
    }

    public function set state(param1:String):void {
        if (this._processState == param1) {
            return;
        }
        App.utils.asserter.assert([STATE_NONE, STATE_INITIALIZED, STATE_STARTED].indexOf(param1) != -1, "unknown drag state:" + param1);
        this._processState = param1;
    }
}
}

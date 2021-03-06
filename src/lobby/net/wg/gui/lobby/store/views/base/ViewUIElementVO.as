package net.wg.gui.lobby.store.views.base {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IAssertable;

import scaleform.clik.controls.Button;

public class ViewUIElementVO implements IDisposable {

    private var _name:String = null;

    private var _instance:Button = null;

    private var _htmlIcon:String = " ";

    public function ViewUIElementVO(param1:String, param2:Button, param3:String = null) {
        var _loc4_:IAssertable = null;
        super();
        if (App.instance) {
            _loc4_ = App.utils.asserter;
            _loc4_.assertNotNull(param1, "name" + Errors.CANT_NULL);
            _loc4_.assertNotNull(param2, "instance" + Errors.CANT_NULL);
        }
        this._name = param1;
        this._instance = param2;
        this._htmlIcon = param3;
    }

    public function dispose():void {
        this._instance = null;
        this._name = null;
    }

    public function get name():String {
        return this._name;
    }

    public function get instance():Button {
        return this._instance;
    }

    public function get htmlIcon():String {
        return this._htmlIcon;
    }
}
}

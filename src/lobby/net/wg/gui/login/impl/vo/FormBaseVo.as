package net.wg.gui.login.impl.vo {
import net.wg.gui.login.IFormBaseVo;

public class FormBaseVo implements IFormBaseVo {

    private var _invalidType:String = "";

    private var _baseDisposed:Boolean = false;

    public function FormBaseVo() {
        super();
    }

    public function dispose():void {
        App.utils.asserter.assert(!this._baseDisposed, "Dispose method is called again");
        this._baseDisposed = true;
    }

    public function get invalidType():String {
        return this._invalidType;
    }

    public function set invalidType(param1:String):void {
        this._invalidType = param1;
    }
}
}

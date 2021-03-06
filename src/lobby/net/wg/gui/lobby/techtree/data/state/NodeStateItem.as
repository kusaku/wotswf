package net.wg.gui.lobby.techtree.data.state {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class NodeStateItem implements IDisposable {

    private var _state:uint;

    private var _props:StateProperties;

    public function NodeStateItem(param1:uint, param2:StateProperties) {
        super();
        this._state = param1;
        this._props = param2;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function getProps():StateProperties {
        return this._props;
    }

    public function getState():uint {
        return this._state;
    }

    protected function onDispose():void {
        if (this._props != null) {
            this._props.dispose();
            this._props = null;
        }
    }
}
}

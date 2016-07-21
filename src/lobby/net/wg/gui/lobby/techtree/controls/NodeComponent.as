package net.wg.gui.lobby.techtree.controls {
import net.wg.gui.lobby.techtree.interfaces.IHasRendererAsOwner;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;

import scaleform.clik.core.UIComponent;

public class NodeComponent extends UIComponent implements IHasRendererAsOwner {

    private var _state:String = "locked";

    protected var _owner:IRenderer = null;

    public function NodeComponent() {
        super();
    }

    public function get state():String {
        return this._state;
    }

    public function set state(param1:String):void {
        if (this._state == param1) {
            return;
        }
        this._state = param1;
    }

    public function setOwner(param1:IRenderer, param2:Boolean = false):void {
        if (this._owner != param1) {
            this._owner = param1;
        }
        invalidateData();
        if (param2) {
            validateNow();
        }
    }

    override protected function onDispose():void {
        this._owner = null;
        super.onDispose();
    }
}
}

package net.wg.gui.lobby.techtree.data.state {
import net.wg.data.constants.generated.NODE_STATE_FLAGS;

public class InventoryStateItem extends ResearchStateItem {

    private var _autoUnlocked:StateProperties;

    private var _parentLocked:StateProperties;

    private var _parentUnlocked:StateProperties;

    public function InventoryStateItem(param1:StateProperties, param2:StateProperties, param3:StateProperties, param4:StateProperties) {
        super(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY, param1);
        this._autoUnlocked = param2;
        this._parentLocked = param3;
        this._parentUnlocked = param4;
    }

    override public function resolveProps(param1:Number, param2:Number, param3:Boolean = false):StateProperties {
        var _loc4_:StateProperties = super.resolveProps(param1, param2, param3);
        if ((param2 & NODE_STATE_FLAGS.UNLOCKED) > 0) {
            _loc4_ = !!param3 ? this._parentUnlocked : this._parentLocked;
        }
        else if ((param1 & NODE_STATE_FLAGS.AUTO_UNLOCKED) > 0) {
            _loc4_ = this._autoUnlocked;
        }
        return _loc4_;
    }

    override protected function onDispose():void {
        if (this._autoUnlocked != null) {
            this._autoUnlocked.dispose();
            this._autoUnlocked = null;
        }
        if (this._parentLocked != null) {
            this._parentLocked.dispose();
            this._parentLocked = null;
        }
        if (this._parentUnlocked != null) {
            this._parentUnlocked.dispose();
            this._parentUnlocked = null;
        }
        super.onDispose();
    }
}
}

package net.wg.gui.lobby.techtree.data.state {
import net.wg.data.constants.generated.NODE_STATE_FLAGS;

public class UnlockedStateItem extends ResearchStateItem {

    private var _autoUnlocked:StateProperties;

    private var _rootNotInventory:StateProperties;

    private var _rootInInventory:StateProperties;

    public function UnlockedStateItem(param1:StateProperties, param2:StateProperties, param3:StateProperties, param4:StateProperties) {
        super(NODE_STATE_FLAGS.UNLOCKED, param1);
        this._autoUnlocked = param2;
        this._rootNotInventory = param3;
        this._rootInInventory = param4;
    }

    override public function resolveProps(param1:Number, param2:Number, param3:Boolean = false):StateProperties {
        var _loc4_:StateProperties = super.resolveProps(param1, param2, param3);
        if ((param2 & NODE_STATE_FLAGS.UNLOCKED) > 0) {
            _loc4_ = (param2 & NODE_STATE_FLAGS.IN_INVENTORY) > 0 ? this._rootInInventory : this._rootNotInventory;
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
        if (this._rootNotInventory != null) {
            this._rootNotInventory.dispose();
            this._rootNotInventory = null;
        }
        if (this._rootInInventory != null) {
            this._rootInInventory.dispose();
            this._rootInInventory = null;
        }
        super.onDispose();
    }
}
}

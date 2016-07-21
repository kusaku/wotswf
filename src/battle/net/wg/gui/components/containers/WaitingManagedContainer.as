package net.wg.gui.components.containers {
import flash.display.DisplayObject;

import net.wg.data.constants.ContainerTypes;
import net.wg.data.constants.Errors;
import net.wg.infrastructure.events.ChildVisibilityEvent;
import net.wg.infrastructure.managers.IWaitingView;
import net.wg.utils.IAssertable;

public class WaitingManagedContainer extends ManagedContainer {

    private var _waiting:DisplayObject = null;

    private var _managedChildAdding:Boolean = false;

    public function WaitingManagedContainer() {
        super();
        enabled = false;
        mouseEnabled = true;
        type = ContainerTypes.WAITING;
    }

    override public function addChild(param1:DisplayObject):DisplayObject {
        var _loc2_:String = null;
        var _loc3_:IAssertable = null;
        if (this._managedChildAdding) {
            return super.addChild(param1);
        }
        _loc2_ = "WaitingManagerContainer must be contain only waiting view!";
        _loc3_ = App.utils.asserter;
        _loc3_.assert(param1 is IWaitingView, _loc2_);
        _loc3_.assertNull(this._waiting, _loc2_);
        this._waiting = param1;
        this._waiting.addEventListener(ChildVisibilityEvent.CHILD_HIDDEN, this.onWaitingHiddenHandler);
        this._waiting.addEventListener(ChildVisibilityEvent.CHILD_SHOWN, this.onWaitingShownHandler);
        IWaitingView(this._waiting).validateNow();
        return param1;
    }

    private function onWaitingShownHandler(param1:ChildVisibilityEvent):void {
        App.utils.asserter.assertNotNull(this._waiting, "_waiting" + Errors.CANT_NULL);
        this._managedChildAdding = true;
        this.addChild(this._waiting);
        this._managedChildAdding = false;
    }

    private function onWaitingHiddenHandler(param1:ChildVisibilityEvent):void {
        App.utils.asserter.assertNotNull(this._waiting, "_waiting" + Errors.CANT_NULL);
        removeChild(this._waiting);
    }

    override protected function onDispose():void {
        this._waiting = null;
        super.onDispose();
    }
}
}

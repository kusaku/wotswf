package net.wg.infrastructure.managers.impl {
import net.wg.gui.components.containers.ManagedContainer;

public class ContainerManagerBattle extends ContainerManagerBase {

    public function ContainerManagerBattle() {
        super();
    }

    override public function as_showContainers(param1:Array):void {
        this.setVisibility(param1, true);
    }

    override public function as_hideContainers(param1:Array):void {
        this.setVisibility(param1, false);
    }

    override public function as_isContainerShown(param1:String):Boolean {
        assert(containersMap.hasOwnProperty(param1), "ContainerManagerBattle does not have container with type " + param1);
        var _loc2_:ManagedContainer = containersMap[param1] as ManagedContainer;
        return !!_loc2_ ? Boolean(_loc2_.visible) : false;
    }

    private function setVisibility(param1:Array, param2:Boolean):void {
        var _loc5_:String = null;
        var _loc6_:ManagedContainer = null;
        var _loc3_:Number = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = param1[_loc4_];
            assert(containersMap.hasOwnProperty(_loc5_), "ContainerManagerBattle does not have container with type " + _loc5_);
            _loc6_ = containersMap[_loc5_] as ManagedContainer;
            if (_loc6_) {
                _loc6_.visible = param2;
            }
            _loc4_++;
        }
    }
}
}

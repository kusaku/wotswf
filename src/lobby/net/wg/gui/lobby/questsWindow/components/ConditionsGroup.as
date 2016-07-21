package net.wg.gui.lobby.questsWindow.components {
import flash.display.InteractiveObject;

import net.wg.gui.components.common.containers.GroupEx;
import net.wg.gui.lobby.questsWindow.components.interfaces.IConditionRenderer;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

public class ConditionsGroup extends GroupEx implements IFocusChainContainer {

    public function ConditionsGroup() {
        super();
    }

    override protected function commitProperties():void {
        super.commitProperties();
        this.adjust();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:IFocusChainContainer = null;
        var _loc2_:int = 0;
        var _loc4_:Vector.<InteractiveObject> = null;
        var _loc3_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        var _loc5_:int = numChildren;
        _loc2_ = 0;
        while (_loc2_ < _loc5_) {
            _loc1_ = IFocusChainContainer(getChildAt(_loc2_));
            _loc4_ = _loc1_.getFocusChain();
            _loc3_ = _loc3_.concat(_loc4_);
            _loc4_.splice(0, _loc4_.length);
            _loc2_++;
        }
        return _loc3_;
    }

    private function adjust():void {
        var _loc1_:IConditionRenderer = null;
        var _loc2_:int = 0;
        var _loc3_:Number = 0;
        var _loc4_:int = numChildren;
        _loc2_ = 0;
        while (_loc2_ < _loc4_) {
            _loc1_ = IConditionRenderer(getChildAt(_loc2_));
            if (_loc3_ < _loc1_.buttonWidth) {
                _loc3_ = _loc1_.buttonWidth;
            }
            _loc2_++;
        }
        _loc2_ = 0;
        while (_loc2_ < _loc4_) {
            _loc1_ = IConditionRenderer(getChildAt(_loc2_));
            _loc1_.buttonWidth = _loc3_;
            _loc1_.layout();
            _loc2_++;
        }
        if (_loc4_ > 0) {
            invalidateLayout();
        }
    }
}
}

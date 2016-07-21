package net.wg.infrastructure.managers.impl {
import flash.display.DisplayObject;

import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.sub.ResearchItems;

public class TutorialManagerLobby extends TutorialManager {

    public function TutorialManagerLobby() {
        super();
    }

    override protected function getObjectByParams(param1:DisplayObject, param2:Object):DisplayObject {
        var _loc4_:ResearchItems = null;
        var _loc5_:int = 0;
        var _loc6_:IRenderer = null;
        var _loc7_:int = 0;
        var _loc8_:Object = null;
        var _loc3_:DisplayObject = super.getObjectByParams(param1, param2);
        if (_loc3_ != null) {
            return _loc3_;
        }
        if (param1 is ResearchItems) {
            _loc4_ = ResearchItems(param1);
            _loc5_ = 0;
            while (_loc5_ < _loc4_.rGraphics.numChildren) {
                if (_loc4_.rGraphics.getChildAt(_loc5_) is IRenderer) {
                    _loc6_ = IRenderer(_loc4_.rGraphics.getChildAt(_loc5_));
                    _loc7_ = _loc6_.index;
                    if (_loc7_ > -1 && _loc4_.dataProvider.length > _loc7_) {
                        _loc8_ = _loc4_.dataProvider.getItemAt(_loc7_);
                        if (checkForParamsMatch(_loc8_, param2)) {
                            return DisplayObject(_loc6_);
                        }
                    }
                }
                _loc5_++;
            }
        }
        return null;
    }
}
}

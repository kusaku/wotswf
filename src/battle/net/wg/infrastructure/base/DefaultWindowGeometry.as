package net.wg.infrastructure.base {
import net.wg.infrastructure.interfaces.IAbstractWindowView;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.infrastructure.interfaces.IWindowGeometry;

public class DefaultWindowGeometry implements IWindowGeometry {

    private var doPositionOnce:Boolean = true;

    private var minY:int = 0;

    public function DefaultWindowGeometry(param1:int = 0) {
        super();
        this.minY = param1;
    }

    public function canOverwrite():Boolean {
        return true;
    }

    public function setSize(param1:IWindow):Boolean {
        param1.updateSize(param1.getMinWidth(), param1.getMinHeight());
        return true;
    }

    public function setPosition(param1:IWindow):Boolean {
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc2_:IAbstractWindowView = param1.windowContent;
        if (_loc2_ && _loc2_.isCentered) {
            _loc3_ = Math.round(App.appWidth - param1.width >> 1);
            _loc4_ = Math.max(Math.round(App.appHeight - param1.height >> 1), this.minY);
            if (_loc2_.isModal) {
                param1.x = _loc3_;
                param1.y = _loc4_;
            }
            else if (this.doPositionOnce) {
                param1.x = param1.x + _loc3_;
                param1.y = param1.y + _loc4_;
                this.doPositionOnce = false;
            }
        }
        return true;
    }
}
}

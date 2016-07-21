package net.wg.mock {
import net.wg.infrastructure.interfaces.IClosePopoverCallback;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.managers.IPopoverManager;

public class MockPopoverManager implements IPopoverManager {

    public function MockPopoverManager() {
        super();
    }

    public function dispose():void {
    }

    public function hide():void {
    }

    public function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null):void {
    }

    public function get popoverCaller():IPopOverCaller {
        return null;
    }
}
}

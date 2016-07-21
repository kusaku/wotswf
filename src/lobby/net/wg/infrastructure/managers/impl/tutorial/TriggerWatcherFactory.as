package net.wg.infrastructure.managers.impl.tutorial {
import net.wg.data.constants.generated.TUTORIAL_TRIGGER_TYPES;
import net.wg.infrastructure.interfaces.ITriggerWatcher;

public class TriggerWatcherFactory {

    public function TriggerWatcherFactory() {
        super();
    }

    public static function createWatcher(param1:String, param2:String, param3:Function):ITriggerWatcher {
        var _loc4_:ITriggerWatcher = null;
        var _loc5_:Class = getClassByType(param2);
        _loc4_ = new _loc5_(param1, param2);
        _loc4_.addEventListener(TriggerEvent.TRIGGER_ACTIVATED, param3);
        return _loc4_;
    }

    private static function getClassByType(param1:String):Class {
        switch (param1) {
            case TUTORIAL_TRIGGER_TYPES.CLICK_OUTSIDE_TYPE:
                return ClickOutsideTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.CLICK_TYPE:
                return ClickTriggerWatcher;
            case TUTORIAL_TRIGGER_TYPES.ESCAPE:
                return EscapeTriggerWatcher;
            default:
                App.utils.asserter.assert(true, "Incorrect Trigger Type");
                return null;
        }
    }
}
}

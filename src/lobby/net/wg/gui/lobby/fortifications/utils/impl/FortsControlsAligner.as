package net.wg.gui.lobby.fortifications.utils.impl {
import flash.display.DisplayObject;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.utils.IFortsControlsAligner;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public class FortsControlsAligner implements IFortsControlsAligner {

    private static var ms_instance:IFortsControlsAligner = null;

    public function FortsControlsAligner() {
        super();
    }

    public static function get instance():IFortsControlsAligner {
        if (ms_instance == null) {
            ms_instance = new FortsControlsAligner();
        }
        return ms_instance;
    }

    public function centerControl(param1:IUIComponentEx, param2:Boolean):void {
        App.utils.asserter.assertNotNull(param1, "control" + Errors.CANT_NULL);
        if (param2) {
            param1.x = App.appWidth >> 1;
        }
        else {
            param1.x = Math.round(App.appWidth - param1.width >> 1);
        }
    }

    public function rightControl(param1:DisplayObject, param2:Number):void {
        App.utils.asserter.assertNotNull(param1, "control" + Errors.CANT_NULL);
        param1.x = App.appWidth - param1.width - param2;
    }
}
}

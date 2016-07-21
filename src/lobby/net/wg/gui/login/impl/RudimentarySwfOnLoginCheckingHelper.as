package net.wg.gui.login.impl {
import flash.utils.getDefinitionByName;

import net.wg.infrastructure.exceptions.InfrastructureException;

public class RudimentarySwfOnLoginCheckingHelper {

    private static const EXCLUDE_SWF_BY_LINKAGE_OF_COMPONENT_CONTROLS:String = "controlsSwfOnLogin";

    private static const EXCLUDE_SWF_BY_LINKAGE_OF_COMPONENT_ADVANCED:String = "advancedSwfOnLogin";

    private static const EXCLUDE_SWF:Vector.<String> = new <String>[EXCLUDE_SWF_BY_LINKAGE_OF_COMPONENT_CONTROLS, EXCLUDE_SWF_BY_LINKAGE_OF_COMPONENT_ADVANCED];

    private static var _instance:RudimentarySwfOnLoginCheckingHelper;

    private static var _allowInstantiation:Boolean = false;

    public function RudimentarySwfOnLoginCheckingHelper() {
        super();
        App.utils.asserter.assert(_allowInstantiation, "Error: Instantiation failed: Use RudimentarySwfOnLoginCheckingHelper.instance() instead of new.");
    }

    public static function get instance():RudimentarySwfOnLoginCheckingHelper {
        if (!_instance) {
            _allowInstantiation = true;
            _instance = new RudimentarySwfOnLoginCheckingHelper();
            _allowInstantiation = false;
        }
        return _instance;
    }

    public function checkRudimentarySwf():void {
        var _loc1_:String = null;
        var _loc2_:String = ": must not load into login screen!";
        var _loc3_:String = ", ";
        var _loc4_:Boolean = false;
        for each(_loc1_ in EXCLUDE_SWF) {
            try {
                getDefinitionByName(_loc1_);
                _loc2_ = _loc3_ + _loc1_ + _loc2_;
                _loc4_ = true;
            }
            catch (e:ReferenceError) {
                continue;
            }
        }
        if (_loc4_) {
            _loc2_ = _loc2_.substr(_loc3_.length);
            App.utils.asserter.assert(!_loc4_, _loc2_, InfrastructureException);
        }
    }
}
}

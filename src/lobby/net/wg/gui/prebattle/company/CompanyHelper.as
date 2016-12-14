package net.wg.gui.prebattle.company {
import flash.text.TextField;

public class CompanyHelper {

    private static var _instance:CompanyHelper;

    public function CompanyHelper(param1:PrivateClass) {
        super();
    }

    public static function get instance():CompanyHelper {
        if (_instance == null) {
            _instance = new CompanyHelper(new PrivateClass());
        }
        return _instance;
    }

    public function cutText(param1:TextField, param2:String):void {
        var _loc3_:* = null;
        var _loc4_:int = 0;
        param1.text = param2;
        if (param1.getLineLength(1) != -1) {
            _loc3_ = param2;
            _loc4_ = param1.getLineLength(0);
            _loc3_ = _loc3_.substr(0, _loc4_ - 2);
            _loc3_ = _loc3_ + "..";
            param1.text = _loc3_;
        }
    }
}
}
class PrivateClass {

    function PrivateClass() {
        super();
    }
}

package net.wg.gui.lobby.questsWindow {
import flash.display.DisplayObject;

import scaleform.clik.interfaces.IDataProvider;

public class QuestWindowUtils {

    private static var _instance:QuestWindowUtils = null;

    public function QuestWindowUtils() {
        super();
    }

    public static function get instance():QuestWindowUtils {
        if (_instance == null) {
            _instance = new QuestWindowUtils();
        }
        return _instance;
    }

    public function getDPItemIndex(param1:IDataProvider, param2:*, param3:String = "data"):int {
        var _loc5_:Object = null;
        var _loc4_:int = -1;
        for each(_loc5_ in param1) {
            if (_loc5_.hasOwnProperty(param3) && _loc5_[param3] == param2) {
                _loc4_ = param1.indexOf(_loc5_);
                break;
            }
        }
        return _loc4_;
    }

    public function setItemsVisible(param1:Vector.<DisplayObject>, param2:Boolean):void {
        var _loc3_:DisplayObject = null;
        for each(_loc3_ in param1) {
            _loc3_.visible = param2;
        }
    }
}
}

package net.wg.gui.components.icons {
public class PlayerActionMarkerController {

    private static var __instance:PlayerActionMarkerController;

    private static var __allowInstantiation:Boolean = false;

    private var __ACTIONS:Object;

    private var __allActions:Array;

    public function PlayerActionMarkerController() {
        super();
        if (__allowInstantiation) {
        }
    }

    public static function get instance():PlayerActionMarkerController {
        if (!__instance) {
            __allowInstantiation = true;
            __instance = new PlayerActionMarkerController();
            __allowInstantiation = false;
            __instance.init();
        }
        return __instance;
    }

    public function init():void {
        var _loc1_:* = null;
        var _loc2_:* = null;
        this.__ACTIONS = new Object();
        this.__ACTIONS["common"] = new Object();
        this.__ACTIONS["myteam"] = new Object();
        this.__ACTIONS["enemy"] = new Object();
        this.__ACTIONS["enemy"]["hunting"] = 1;
        this.__allActions = new Array();
        for (_loc1_ in this.__ACTIONS) {
            for (_loc2_ in this.__ACTIONS[_loc1_]) {
                this.__allActions.push(_loc2_);
            }
        }
    }

    public function get allActions():Array {
        return this.__allActions;
    }

    public function getActions(param1:String, param2:Number):Array {
        var _loc4_:* = null;
        var _loc5_:Number = NaN;
        var _loc3_:Array = new Array();
        for (_loc4_ in this.__ACTIONS[param1]) {
            _loc5_ = this.__ACTIONS[param1][_loc4_];
            if (_loc5_ & param2) {
                _loc3_.push(_loc4_);
            }
        }
        return _loc3_;
    }
}
}

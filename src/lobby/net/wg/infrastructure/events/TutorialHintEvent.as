package net.wg.infrastructure.events {
import flash.display.DisplayObject;
import flash.events.Event;

public class TutorialHintEvent extends Event {

    public static const SETUP_HINT:String = "setupHint";

    public static const SHOW_HINT:String = "showHint";

    public static const HIDE_HINT:String = "hideHint";

    private var _viewTutorialId:String = "";

    private var _component:DisplayObject = null;

    private var _data:Object = null;

    private var _handled:Boolean = false;

    private var _isCustomCmp:Boolean = false;

    public function TutorialHintEvent(param1:String, param2:String = "", param3:DisplayObject = null, param4:Object = null, param5:Boolean = false) {
        super(param1, false, false);
        this._viewTutorialId = param2;
        this._component = param3;
        this._data = param4;
        this._isCustomCmp = param5;
    }

    public function get viewTutorialId():String {
        return this._viewTutorialId;
    }

    public function get component():DisplayObject {
        return this._component;
    }

    public function get data():Object {
        return this._data;
    }

    public function get handled():Boolean {
        return this._handled;
    }

    public function set handled(param1:Boolean):void {
        if (param1) {
            preventDefault();
            this._handled = param1;
        }
    }

    public function get isCustomCmp():Boolean {
        return this._isCustomCmp;
    }
}
}

package net.wg.gui.lobby.vehicleBuyWindow {
import net.wg.gui.components.controls.SoundButton;

public class ExpandButton extends SoundButton {

    private static const EMPTY_STR:String = "";

    private static const STATE_UP:String = "up";

    private static const STATE_PREFIX_SELECTED:String = "selected_";

    private static const STATE_PREFIX_EXPANDED:String = "expanded_";

    private var _expanded:Boolean = false;

    public function ExpandButton() {
        super();
    }

    override protected function getStatePrefixes():Vector.<String> {
        var _loc1_:Vector.<String> = new Vector.<String>();
        if (this._expanded) {
            _loc1_.push(STATE_PREFIX_EXPANDED);
        }
        else if (_selected) {
            _loc1_.push(STATE_PREFIX_SELECTED);
            _loc1_.push(EMPTY_STR);
        }
        else {
            _loc1_.push(EMPTY_STR);
        }
        return _loc1_;
    }

    override public function set label(param1:String):void {
        if (_label == param1) {
            return;
        }
        _label = param1;
    }

    public function get expanded():Boolean {
        return this._expanded;
    }

    public function set expanded(param1:Boolean):void {
        this._expanded = param1;
        setState(STATE_UP);
    }
}
}

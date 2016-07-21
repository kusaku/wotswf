package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.cmp.base.impl.FortBuildingBase;

public class TrowelCmp extends FortBuildingBase {

    public var trowelLbl:TextField = null;

    private var _label:String = "";

    public function TrowelCmp() {
        super();
    }

    override public function setState(param1:String):void {
        super.setState(param1);
        this.trowelLbl.text = this._label;
    }

    public function set label(param1:String):void {
        this._label = App.utils.locale.makeString(param1);
    }
}
}

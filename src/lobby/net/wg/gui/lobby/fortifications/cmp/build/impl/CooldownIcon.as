package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.cmp.build.ICooldownIcon;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ITweenAnimator;

public class CooldownIcon extends UIComponentEx implements ICooldownIcon {

    public var loader:CooldownIconLoaderCtnr = null;

    private var _timeTextField:TextField = null;

    public function CooldownIcon() {
        super();
        mouseChildren = false;
        mouseEnabled = false;
    }

    private static function getTweenAnimator():ITweenAnimator {
        return App.utils.tweenAnimator;
    }

    override protected function onDispose():void {
        getTweenAnimator().removeAnims(this);
        this._timeTextField = null;
        this.loader.dispose();
        this.loader = null;
        super.onDispose();
    }

    public function get timeTextField():TextField {
        return this._timeTextField;
    }

    public function set timeTextField(param1:TextField):void {
        this._timeTextField = param1;
    }
}
}

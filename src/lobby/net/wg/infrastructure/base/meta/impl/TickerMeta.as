package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class TickerMeta extends BaseDAAPIComponent {

    public var showBrowser:Function;

    public function TickerMeta() {
        super();
    }

    public function showBrowserS(param1:String):void {
        App.utils.asserter.assertNotNull(this.showBrowser, "showBrowser" + Errors.CANT_NULL);
        this.showBrowser(param1);
    }
}
}

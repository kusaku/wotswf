package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class RssNewsFeedMeta extends BaseDAAPIComponent {

    public var openBrowser:Function;

    public function RssNewsFeedMeta() {
        super();
    }

    public function openBrowserS(param1:String):void {
        App.utils.asserter.assertNotNull(this.openBrowser, "openBrowser" + Errors.CANT_NULL);
        this.openBrowser(param1);
    }
}
}

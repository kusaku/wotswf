package net.wg.gui.prebattle.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.rally.AbstractRallyWindow;

public class CompanyMainWindowMeta extends AbstractRallyWindow {

    public var getCompanyName:Function;

    public var showFAQWindow:Function;

    public var getClientID:Function;

    public function CompanyMainWindowMeta() {
        super();
    }

    public function getCompanyNameS():String {
        App.utils.asserter.assertNotNull(this.getCompanyName, "getCompanyName" + Errors.CANT_NULL);
        return this.getCompanyName();
    }

    public function showFAQWindowS():void {
        App.utils.asserter.assertNotNull(this.showFAQWindow, "showFAQWindow" + Errors.CANT_NULL);
        this.showFAQWindow();
    }

    public function getClientIDS():Number {
        App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + Errors.CANT_NULL);
        return this.getClientID();
    }
}
}

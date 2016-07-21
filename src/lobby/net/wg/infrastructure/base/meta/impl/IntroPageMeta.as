package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class IntroPageMeta extends AbstractView {

    public var stopVideo:Function;

    public var handleError:Function;

    public function IntroPageMeta() {
        super();
    }

    public function stopVideoS():void {
        App.utils.asserter.assertNotNull(this.stopVideo, "stopVideo" + Errors.CANT_NULL);
        this.stopVideo();
    }

    public function handleErrorS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.handleError, "handleError" + Errors.CANT_NULL);
        this.handleError(param1);
    }
}
}

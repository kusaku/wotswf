package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class ResearchViewMeta extends AbstractView {

    public var request4Unlock:Function;

    public var request4Buy:Function;

    public var request4Info:Function;

    public var showSystemMessage:Function;

    public function ResearchViewMeta() {
        super();
    }

    public function request4UnlockS(param1:Number, param2:Number, param3:Number, param4:Number):void {
        App.utils.asserter.assertNotNull(this.request4Unlock, "request4Unlock" + Errors.CANT_NULL);
        this.request4Unlock(param1, param2, param3, param4);
    }

    public function request4BuyS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.request4Buy, "request4Buy" + Errors.CANT_NULL);
        this.request4Buy(param1);
    }

    public function request4InfoS(param1:Number, param2:Number):void {
        App.utils.asserter.assertNotNull(this.request4Info, "request4Info" + Errors.CANT_NULL);
        this.request4Info(param1, param2);
    }

    public function showSystemMessageS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.showSystemMessage, "showSystemMessage" + Errors.CANT_NULL);
        this.showSystemMessage(param1, param2);
    }
}
}

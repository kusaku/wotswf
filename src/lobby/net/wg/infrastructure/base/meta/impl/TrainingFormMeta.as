package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class TrainingFormMeta extends AbstractView {

    public var joinTrainingRequest:Function;

    public var createTrainingRequest:Function;

    public var onEscape:Function;

    public var onLeave:Function;

    public function TrainingFormMeta() {
        super();
    }

    public function joinTrainingRequestS(param1:String):void {
        App.utils.asserter.assertNotNull(this.joinTrainingRequest, "joinTrainingRequest" + Errors.CANT_NULL);
        this.joinTrainingRequest(param1);
    }

    public function createTrainingRequestS():void {
        App.utils.asserter.assertNotNull(this.createTrainingRequest, "createTrainingRequest" + Errors.CANT_NULL);
        this.createTrainingRequest();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }

    public function onLeaveS():void {
        App.utils.asserter.assertNotNull(this.onLeave, "onLeave" + Errors.CANT_NULL);
        this.onLeave();
    }
}
}

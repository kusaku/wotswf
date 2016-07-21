package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class TrainingWindowMeta extends AbstractWindowView {

    public var updateTrainingRoom:Function;

    public function TrainingWindowMeta() {
        super();
    }

    public function updateTrainingRoomS(param1:Number, param2:Number, param3:int, param4:String):void {
        App.utils.asserter.assertNotNull(this.updateTrainingRoom, "updateTrainingRoom" + Errors.CANT_NULL);
        this.updateTrainingRoom(param1, param2, param3, param4);
    }
}
}

package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class FortDeclarationOfWarWindowMeta extends AbstractWindowView {

    public var onDirectonChosen:Function;

    public var onDirectionSelected:Function;

    public function FortDeclarationOfWarWindowMeta() {
        super();
    }

    public function onDirectonChosenS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onDirectonChosen, "onDirectonChosen" + Errors.CANT_NULL);
        this.onDirectonChosen(param1);
    }

    public function onDirectionSelectedS():void {
        App.utils.asserter.assertNotNull(this.onDirectionSelected, "onDirectionSelected" + Errors.CANT_NULL);
        this.onDirectionSelected();
    }
}
}

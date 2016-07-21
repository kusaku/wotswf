package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class FalloutRespawnViewMeta extends BattleDisplayable {

    public var onVehicleSelected:Function;

    public var onPostmortemBtnClick:Function;

    public function FalloutRespawnViewMeta() {
        super();
    }

    public function onVehicleSelectedS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onVehicleSelected, "onVehicleSelected" + Errors.CANT_NULL);
        this.onVehicleSelected(param1);
    }

    public function onPostmortemBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onPostmortemBtnClick, "onPostmortemBtnClick" + Errors.CANT_NULL);
        this.onPostmortemBtnClick();
    }
}
}

package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.CombatReservesIntroVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortCombatReservesIntroMeta extends AbstractWindowView {

    private var _combatReservesIntroVO:CombatReservesIntroVO;

    public function FortCombatReservesIntroMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._combatReservesIntroVO) {
            this._combatReservesIntroVO.dispose();
            this._combatReservesIntroVO = null;
        }
        super.onDispose();
    }

    public function as_setData(param1:Object):void {
        if (this._combatReservesIntroVO) {
            this._combatReservesIntroVO.dispose();
        }
        this._combatReservesIntroVO = new CombatReservesIntroVO(param1);
        this.setData(this._combatReservesIntroVO);
    }

    protected function setData(param1:CombatReservesIntroVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

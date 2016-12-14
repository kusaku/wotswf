package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortFixedPlayersVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortFixedPlayersWindowMeta extends AbstractWindowView {

    public var assignToBuilding:Function;

    private var _fortFixedPlayersVO:FortFixedPlayersVO;

    public function FortFixedPlayersWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortFixedPlayersVO) {
            this._fortFixedPlayersVO.dispose();
            this._fortFixedPlayersVO = null;
        }
        super.onDispose();
    }

    public function assignToBuildingS():void {
        App.utils.asserter.assertNotNull(this.assignToBuilding, "assignToBuilding" + Errors.CANT_NULL);
        this.assignToBuilding();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:FortFixedPlayersVO = this._fortFixedPlayersVO;
        this._fortFixedPlayersVO = new FortFixedPlayersVO(param1);
        this.setData(this._fortFixedPlayersVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:FortFixedPlayersVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

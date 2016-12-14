package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.BattleDirectionPopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortBattleDirectionPopoverMeta extends SmartPopOverView {

    public var requestToJoin:Function;

    private var _battleDirectionPopoverVO:BattleDirectionPopoverVO;

    public function FortBattleDirectionPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._battleDirectionPopoverVO) {
            this._battleDirectionPopoverVO.dispose();
            this._battleDirectionPopoverVO = null;
        }
        super.onDispose();
    }

    public function requestToJoinS(param1:int):void {
        App.utils.asserter.assertNotNull(this.requestToJoin, "requestToJoin" + Errors.CANT_NULL);
        this.requestToJoin(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:BattleDirectionPopoverVO = this._battleDirectionPopoverVO;
        this._battleDirectionPopoverVO = new BattleDirectionPopoverVO(param1);
        this.setData(this._battleDirectionPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:BattleDirectionPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

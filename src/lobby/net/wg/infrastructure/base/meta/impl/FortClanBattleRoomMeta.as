package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
import net.wg.gui.rally.views.room.BaseRallyRoomViewWithOrdersPanel;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortClanBattleRoomMeta extends BaseRallyRoomViewWithOrdersPanel {

    public var onTimerAlert:Function;

    private var _clanBattleTimerVO:ClanBattleTimerVO;

    private var _connectedDirectionsVO:ConnectedDirectionsVO;

    private var _fortClanBattleRoomVO:FortClanBattleRoomVO;

    public function FortClanBattleRoomMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanBattleTimerVO) {
            this._clanBattleTimerVO.dispose();
            this._clanBattleTimerVO = null;
        }
        if (this._connectedDirectionsVO) {
            this._connectedDirectionsVO.dispose();
            this._connectedDirectionsVO = null;
        }
        if (this._fortClanBattleRoomVO) {
            this._fortClanBattleRoomVO.dispose();
            this._fortClanBattleRoomVO = null;
        }
        super.onDispose();
    }

    public function onTimerAlertS():void {
        App.utils.asserter.assertNotNull(this.onTimerAlert, "onTimerAlert" + Errors.CANT_NULL);
        this.onTimerAlert();
    }

    public final function as_setBattleRoomData(param1:Object):void {
        var _loc2_:FortClanBattleRoomVO = this._fortClanBattleRoomVO;
        this._fortClanBattleRoomVO = new FortClanBattleRoomVO(param1);
        this.setBattleRoomData(this._fortClanBattleRoomVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setTimerDelta(param1:Object):void {
        var _loc2_:ClanBattleTimerVO = this._clanBattleTimerVO;
        this._clanBattleTimerVO = new ClanBattleTimerVO(param1);
        this.setTimerDelta(this._clanBattleTimerVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_updateDirections(param1:Object):void {
        var _loc2_:ConnectedDirectionsVO = this._connectedDirectionsVO;
        this._connectedDirectionsVO = new ConnectedDirectionsVO(param1);
        this.updateDirections(this._connectedDirectionsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setBattleRoomData(param1:FortClanBattleRoomVO):void {
        var _loc2_:String = "as_setBattleRoomData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTimerDelta(param1:ClanBattleTimerVO):void {
        var _loc2_:String = "as_setTimerDelta" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateDirections(param1:ConnectedDirectionsVO):void {
        var _loc2_:String = "as_updateDirections" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

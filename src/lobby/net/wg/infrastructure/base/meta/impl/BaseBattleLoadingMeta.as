package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.battleloading.vo.PlayerStatusVO;
import net.wg.gui.lobby.battleloading.vo.VisualTipInfoVO;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class BaseBattleLoadingMeta extends AbstractView {

    private var _eventInfoPanelVO:EventInfoPanelVO;

    private var _visualTipInfoVO:VisualTipInfoVO;

    private var _playerStatusVO:PlayerStatusVO;

    public function BaseBattleLoadingMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._eventInfoPanelVO) {
            this._eventInfoPanelVO.dispose();
            this._eventInfoPanelVO = null;
        }
        if (this._visualTipInfoVO) {
            this._visualTipInfoVO.dispose();
            this._visualTipInfoVO = null;
        }
        if (this._playerStatusVO) {
            this._playerStatusVO.dispose();
            this._playerStatusVO = null;
        }
        super.onDispose();
    }

    public function as_setEventInfoPanelData(param1:Object):void {
        if (this._eventInfoPanelVO) {
            this._eventInfoPanelVO.dispose();
        }
        this._eventInfoPanelVO = new EventInfoPanelVO(param1);
        this.setEventInfoPanelData(this._eventInfoPanelVO);
    }

    public function as_setVisualTipInfo(param1:Object):void {
        if (this._visualTipInfoVO) {
            this._visualTipInfoVO.dispose();
        }
        this._visualTipInfoVO = new VisualTipInfoVO(param1);
        this.setVisualTipInfo(this._visualTipInfoVO);
    }

    public function as_setPlayerStatus(param1:Object):void {
        if (this._playerStatusVO) {
            this._playerStatusVO.dispose();
        }
        this._playerStatusVO = new PlayerStatusVO(param1);
        this.setPlayerStatus(this._playerStatusVO);
    }

    protected function setEventInfoPanelData(param1:EventInfoPanelVO):void {
        var _loc2_:String = "as_setEventInfoPanelData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setVisualTipInfo(param1:VisualTipInfoVO):void {
        var _loc2_:String = "as_setVisualTipInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setPlayerStatus(param1:PlayerStatusVO):void {
        var _loc2_:String = "as_setPlayerStatus" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

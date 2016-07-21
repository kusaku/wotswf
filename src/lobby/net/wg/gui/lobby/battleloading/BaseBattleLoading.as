package net.wg.gui.lobby.battleloading {
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.infrastructure.base.meta.IBaseBattleLoadingMeta;
import net.wg.infrastructure.base.meta.impl.BaseBattleLoadingMeta;
import net.wg.infrastructure.exceptions.AbstractException;

public class BaseBattleLoading extends BaseBattleLoadingMeta implements IBaseBattleLoadingMeta {

    private static const MSG_MUST_BE_OVERRIDEN:String = "Method must be overridden!";

    public function BaseBattleLoading() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        setFocus(this);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        App.contextMenuMgr.hide();
        updateStage(App.appWidth, App.appHeight);
    }

    override protected function setEventInfoPanelData(param1:EventInfoPanelVO):void {
        this.throwAbstractException();
    }

    public function as_addVehicleInfo(param1:Object):void {
        this.throwAbstractException();
    }

    public function as_setArenaInfo(param1:Object):void {
        this.throwAbstractException();
    }

    public function as_setMapIcon(param1:String):void {
        this.throwAbstractException();
    }

    public function as_setPlayerData(param1:Number, param2:Number):void {
        this.throwAbstractException();
    }

    public function as_setProgress(param1:Number):void {
        this.throwAbstractException();
    }

    public function as_setTip(param1:String):void {
        this.throwAbstractException();
    }

    public function as_setTipTitle(param1:String):void {
        this.throwAbstractException();
    }

    public function as_setVehicleStatus(param1:Object):void {
        this.throwAbstractException();
    }

    public function as_setVehiclesData(param1:Object):void {
        this.throwAbstractException();
    }

    public function as_updateVehicleInfo(param1:Object):void {
        this.throwAbstractException();
    }

    private function throwAbstractException():void {
        DebugUtils.LOG_ERROR(MSG_MUST_BE_OVERRIDEN);
        throw new AbstractException(MSG_MUST_BE_OVERRIDEN);
    }
}
}

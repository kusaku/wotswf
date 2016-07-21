package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleUIDisplayable;
import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerSettingsVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class BattleMessengerMeta extends BattleUIDisplayable {

    public var sendMessageToChannel:Function;

    public var focusReceived:Function;

    public var focusLost:Function;

    private var _battleMessengerSettingsVO:BattleMessengerSettingsVO;

    public function BattleMessengerMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._battleMessengerSettingsVO) {
            this._battleMessengerSettingsVO.dispose();
            this._battleMessengerSettingsVO = null;
        }
        super.onDispose();
    }

    public function sendMessageToChannelS(param1:int, param2:String):Boolean {
        App.utils.asserter.assertNotNull(this.sendMessageToChannel, "sendMessageToChannel" + Errors.CANT_NULL);
        return this.sendMessageToChannel(param1, param2);
    }

    public function focusReceivedS():void {
        App.utils.asserter.assertNotNull(this.focusReceived, "focusReceived" + Errors.CANT_NULL);
        this.focusReceived();
    }

    public function focusLostS():void {
        App.utils.asserter.assertNotNull(this.focusLost, "focusLost" + Errors.CANT_NULL);
        this.focusLost();
    }

    public function as_setupList(param1:Object):void {
        if (this._battleMessengerSettingsVO) {
            this._battleMessengerSettingsVO.dispose();
        }
        this._battleMessengerSettingsVO = new BattleMessengerSettingsVO(param1);
        this.setupList(this._battleMessengerSettingsVO);
    }

    protected function setupList(param1:BattleMessengerSettingsVO):void {
        var _loc2_:String = "as_setupList" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

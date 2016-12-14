package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.header.vo.AccountDataVo;
import net.wg.gui.lobby.header.vo.HangarMenuVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class LobbyHeaderMeta extends BaseDAAPIComponent {

    public var menuItemClick:Function;

    public var showLobbyMenu:Function;

    public var showExchangeWindow:Function;

    public var showExchangeXPWindow:Function;

    public var showPremiumDialog:Function;

    public var onPremShopClick:Function;

    public var onPayment:Function;

    public var showSquad:Function;

    public var fightClick:Function;

    private var _accountDataVo:AccountDataVo;

    private var _hangarMenuVO:HangarMenuVO;

    public function LobbyHeaderMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._accountDataVo) {
            this._accountDataVo.dispose();
            this._accountDataVo = null;
        }
        if (this._hangarMenuVO) {
            this._hangarMenuVO.dispose();
            this._hangarMenuVO = null;
        }
        super.onDispose();
    }

    public function menuItemClickS(param1:String):void {
        App.utils.asserter.assertNotNull(this.menuItemClick, "menuItemClick" + Errors.CANT_NULL);
        this.menuItemClick(param1);
    }

    public function showLobbyMenuS():void {
        App.utils.asserter.assertNotNull(this.showLobbyMenu, "showLobbyMenu" + Errors.CANT_NULL);
        this.showLobbyMenu();
    }

    public function showExchangeWindowS():void {
        App.utils.asserter.assertNotNull(this.showExchangeWindow, "showExchangeWindow" + Errors.CANT_NULL);
        this.showExchangeWindow();
    }

    public function showExchangeXPWindowS():void {
        App.utils.asserter.assertNotNull(this.showExchangeXPWindow, "showExchangeXPWindow" + Errors.CANT_NULL);
        this.showExchangeXPWindow();
    }

    public function showPremiumDialogS():void {
        App.utils.asserter.assertNotNull(this.showPremiumDialog, "showPremiumDialog" + Errors.CANT_NULL);
        this.showPremiumDialog();
    }

    public function onPremShopClickS():void {
        App.utils.asserter.assertNotNull(this.onPremShopClick, "onPremShopClick" + Errors.CANT_NULL);
        this.onPremShopClick();
    }

    public function onPaymentS():void {
        App.utils.asserter.assertNotNull(this.onPayment, "onPayment" + Errors.CANT_NULL);
        this.onPayment();
    }

    public function showSquadS():void {
        App.utils.asserter.assertNotNull(this.showSquad, "showSquad" + Errors.CANT_NULL);
        this.showSquad();
    }

    public function fightClickS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.fightClick, "fightClick" + Errors.CANT_NULL);
        this.fightClick(param1, param2);
    }

    public final function as_nameResponse(param1:Object):void {
        var _loc2_:AccountDataVo = this._accountDataVo;
        this._accountDataVo = new AccountDataVo(param1);
        this.nameResponse(this._accountDataVo);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setHangarMenuData(param1:Object):void {
        var _loc2_:HangarMenuVO = this._hangarMenuVO;
        this._hangarMenuVO = new HangarMenuVO(param1);
        this.setHangarMenuData(this._hangarMenuVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function nameResponse(param1:AccountDataVo):void {
        var _loc2_:String = "as_nameResponse" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setHangarMenuData(param1:HangarMenuVO):void {
        var _loc2_:String = "as_setHangarMenuData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}

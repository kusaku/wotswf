package net.wg.gui.components.common.serverStats {
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.ListDAAPIDataProvider;
import net.wg.gui.components.controls.events.DropdownMenuEvent;
import net.wg.gui.components.controls.helpers.ServerCsisState;
import net.wg.infrastructure.base.meta.IServerStatsMeta;
import net.wg.infrastructure.base.meta.impl.ServerStatsMeta;

import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;

public class ServerStats extends ServerStatsMeta implements IServerStatsMeta {

    private static const INVALIDATE_SERVER_INFO:String = "serverInfo";

    private static const INV_CSIS_LISTENING:String = "invCsisListening";

    private static const INV_TEXT_AND_STYLES:String = "invTextAndStyles";

    public var regionDD:ServerDropDown;

    public var serverInfo:ServerInfo;

    public var textField:TextField;

    private var _dataProvider:IDataProvider;

    private var _serverInfoStats:String = null;

    private var _serverInfoToolTipType:String = null;

    private var _startListenCSIS:Boolean = false;

    private var _serverResetMode:Boolean = false;

    private var _currentServerIndex:int = -1;

    private var _isChina:Boolean = false;

    public function ServerStats() {
        super();
        this._dataProvider = new ListDAAPIDataProvider(ServerVO);
        this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        this.regionDD.checkItemDisabledFunction = checkItemDisabledFunction;
        this._isChina = App.globalVarsMgr.isChinaS();
    }

    private static function checkItemDisabledFunction(param1:ServerVO):Boolean {
        return param1.csisStatus == ServerCsisState.NOT_AVAILABLE;
    }

    override protected function configUI():void {
        super.configUI();
        this.serverInfo.visible = App.globalVarsMgr.isShowServerStatsS();
        this.serverInfo.focusable = false;
        this.serverInfo.relativelyOwner = this.regionDD;
        this.regionDD.visible = !this._isChina;
        this.regionDD.dataProvider = this._dataProvider;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_SERVER_INFO)) {
            this.serverInfo.setValues(this._serverInfoStats, this._serverInfoToolTipType);
        }
        if (isInvalid(INV_CSIS_LISTENING)) {
            startListenCsisUpdateS(this._startListenCSIS);
        }
        if (isInvalid(INV_TEXT_AND_STYLES)) {
            this.updateTextAndState();
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.regionDD.addEventListener(ListEvent.INDEX_CHANGE, this.onRegionIndexChangeHandler);
        this.regionDD.addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN, this.onRegionShowDropDownHandler);
        this.regionDD.addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN, this.onRegionCloseDropDownHandler);
    }

    override protected function onDispose():void {
        this.regionDD.removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN, this.onRegionShowDropDownHandler);
        this.regionDD.removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN, this.onRegionCloseDropDownHandler);
        this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onRegionIndexChangeHandler);
        this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        this.serverInfo.dispose();
        this.serverInfo = null;
        this._dataProvider.cleanUp();
        this._dataProvider = null;
        this.regionDD.dispose();
        this.regionDD = null;
        this.textField = null;
        super.onDispose();
    }

    public function as_changePeripheryFailed():void {
        this.updateSelectedServer();
    }

    public function as_disableRoamingDD(param1:Boolean):void {
        this.regionDD.enabled = !param1;
    }

    public function as_getServersDP():Object {
        return this._dataProvider;
    }

    public function as_setSelectedServerIndex(param1:int):void {
        this._currentServerIndex = param1;
        this.updateSelectedServer();
    }

    public function as_setServerStats(param1:String, param2:String):void {
        this._serverInfoStats = param1;
        this._serverInfoToolTipType = param2;
        invalidate(INVALIDATE_SERVER_INFO);
    }

    public function as_setServerStatsInfo(param1:String):void {
        this.serverInfo.tooltipFullData = param1;
    }

    private function updateSelectedServer():void {
        this._serverResetMode = true;
        this.regionDD.selectedIndex = this._currentServerIndex;
        this._serverResetMode = false;
    }

    private function updateTextAndState():void {
        var _loc1_:String = null;
        var _loc3_:ServerVO = null;
        var _loc2_:Boolean = this._currentServerIndex > -1 && (this._isChina || this._dataProvider.length == 1);
        if (_loc2_) {
            _loc3_ = ServerVO(this._dataProvider.requestItemAt(this._currentServerIndex));
            this.textField.autoSize = TextFieldAutoSize.CENTER;
            _loc1_ = App.utils.locale.makeString(MENU.LOBBY_MENU_ONESERVER_TITLE, {"sName": _loc3_.label});
        }
        else {
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            _loc1_ = App.utils.locale.makeString(MENU.LOBBY_MENU_MANYSERVERS_TITLE);
        }
        this.regionDD.visible = !_loc2_;
        this.textField.htmlText = _loc1_;
    }

    private function onRegionCloseDropDownHandler(param1:DropdownMenuEvent):void {
        this._startListenCSIS = false;
        invalidate(INV_CSIS_LISTENING);
    }

    private function onRegionShowDropDownHandler(param1:DropdownMenuEvent):void {
        this._startListenCSIS = true;
        invalidate(INV_CSIS_LISTENING);
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        invalidate(INV_TEXT_AND_STYLES);
    }

    private function onRegionIndexChangeHandler(param1:ListEvent):void {
        if (!this._isChina && !this._serverResetMode) {
            reloginS(ServerVO(param1.itemData).id);
        }
    }
}
}

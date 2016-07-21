package net.wg.gui.lobby.header.headerButtonBar {
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
import net.wg.gui.lobby.header.vo.HeaderButtonVo;
import net.wg.gui.lobby.header.vo.IHBC_VO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IDataProvider;

public class HeaderButtonsHelper implements IDisposable {

    public static var ITEM_ID_SETTINGS:String = "settings";

    public static var ITEM_ID_ACCOUNT:String = "account";

    public static var ITEM_ID_PREM:String = "prem";

    public static var ITEM_ID_SQUAD:String = "squad";

    public static var ITEM_ID_BATTLE_SELECTOR:String = "battleSelector";

    public static var ITEM_ID_GOLD:String = "gold";

    public static var ITEM_ID_SILVER:String = "silver";

    public static var ITEM_ID_FREEXP:String = "freeXP";

    private var _settingsData:HeaderButtonVo;

    private var _accountData:HeaderButtonVo;

    private var _premData:HeaderButtonVo;

    private var _squadData:HeaderButtonVo;

    private var _battleSelectorData:HeaderButtonVo;

    private var _goldData:HeaderButtonVo;

    private var _silverData:HeaderButtonVo;

    private var _freeXPData:HeaderButtonVo;

    private var _buttonsArrData:Array = null;

    private var _headerButtonBar:HeaderButtonBar = null;

    public function HeaderButtonsHelper(param1:HeaderButtonBar) {
        this._settingsData = new HeaderButtonVo({
            "id": ITEM_ID_SETTINGS,
            "linkage": "HBC_Settings_UI",
            "direction": TextFieldAutoSize.LEFT,
            "align": TextFieldAutoSize.LEFT,
            "isUseFreeSize": false,
            "data": new HBC_SettingsVo(),
            "helpText": LOBBY_HELP.HEADER_SETTINGS_BUTTON,
            "helpDirection": "B",
            "enabled": true
        });
        this._accountData = new HeaderButtonVo({
            "id": ITEM_ID_ACCOUNT,
            "linkage": "HBC_Account_UI",
            "upperLinkage": "HBC_AccountUpper_UI",
            "direction": TextFieldAutoSize.LEFT,
            "align": TextFieldAutoSize.LEFT,
            "isUseFreeSize": true,
            "data": new HBC_AccountDataVo(),
            "helpText": LOBBY_HELP.HEADER_ACCOUNT_BUTTON,
            "helpDirection": "B",
            "enabled": true
        });
        this._premData = new HeaderButtonVo({
            "id": ITEM_ID_PREM,
            "linkage": "HBC_Prem_UI",
            "direction": TextFieldAutoSize.LEFT,
            "align": TextFieldAutoSize.LEFT,
            "isUseFreeSize": false,
            "data": new HBC_PremDataVo(),
            "helpText": LOBBY_HELP.HEADER_PREMIUM_BUTTON,
            "helpDirection": "B",
            "enabled": true
        });
        this._squadData = new HeaderButtonVo({
            "id": ITEM_ID_SQUAD,
            "linkage": "HBC_Squad_UI",
            "direction": TextFieldAutoSize.LEFT,
            "align": TextFieldAutoSize.RIGHT,
            "isUseFreeSize": false,
            "data": new HBC_SquadDataVo(),
            "helpText": LOBBY_HELP.HEADER_SQUAD_BUTTON,
            "helpDirection": "B",
            "enabled": true
        });
        this._battleSelectorData = new HeaderButtonVo({
            "id": ITEM_ID_BATTLE_SELECTOR,
            "linkage": "HBC_BattleSelector_UI",
            "direction": TextFieldAutoSize.RIGHT,
            "align": TextFieldAutoSize.LEFT,
            "isUseFreeSize": true,
            "data": new HBC_BattleTypeVo(),
            "helpText": LOBBY_HELP.HEADER_BATTLETYPE_BUTTON,
            "helpDirection": "B",
            "enabled": true
        });
        this._goldData = new HeaderButtonVo({
            "id": ITEM_ID_GOLD,
            "linkage": "HBC_Finance_UI",
            "direction": TextFieldAutoSize.RIGHT,
            "align": TextFieldAutoSize.RIGHT,
            "isUseFreeSize": false,
            "data": new HBC_FinanceVo(),
            "helpText": Values.EMPTY_STR,
            "helpDirection": "B",
            "enabled": true
        });
        this._silverData = new HeaderButtonVo({
            "id": ITEM_ID_SILVER,
            "linkage": "HBC_Finance_UI",
            "direction": TextFieldAutoSize.RIGHT,
            "align": TextFieldAutoSize.RIGHT,
            "isUseFreeSize": false,
            "data": new HBC_FinanceVo(),
            "helpText": Values.EMPTY_STR,
            "helpDirection": "B",
            "enabled": true
        });
        this._freeXPData = new HeaderButtonVo({
            "id": ITEM_ID_FREEXP,
            "linkage": "HBC_Finance_UI",
            "direction": TextFieldAutoSize.RIGHT,
            "align": TextFieldAutoSize.RIGHT,
            "isUseFreeSize": false,
            "data": new HBC_FinanceVo(),
            "helpText": Values.EMPTY_STR,
            "helpDirection": "B",
            "enabled": true
        });
        super();
        this._buttonsArrData = [this._settingsData, this._accountData, this._premData, this._squadData, this._battleSelectorData, this._goldData, this._silverData, this._freeXPData];
        this._headerButtonBar = param1;
    }

    public function dispose():void {
        var _loc3_:IDisposable = null;
        this._headerButtonBar = null;
        var _loc1_:int = this._buttonsArrData.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this._buttonsArrData[_loc2_];
            _loc3_.dispose();
            _loc2_++;
        }
        this._settingsData = null;
        this._accountData = null;
        this._premData = null;
        this._squadData = null;
        this._battleSelectorData = null;
        this._goldData = null;
        this._silverData = null;
        this._freeXPData = null;
        this._buttonsArrData.splice(0);
        this._buttonsArrData = null;
    }

    public function getContentDataById(param1:String):IHBC_VO {
        var _loc4_:HeaderButtonVo = null;
        var _loc2_:int = this._buttonsArrData.length;
        var _loc3_:Number = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this._buttonsArrData[_loc3_];
            if (param1 == _loc4_.id) {
                return _loc4_.data;
            }
            _loc3_++;
        }
        return null;
    }

    public function invalidateDataById(param1:String):void {
        var _loc2_:HeaderButton = this.searchButtonById(param1);
        if (_loc2_) {
            _loc2_.updateContentData();
        }
    }

    public function setButtonEnabled(param1:String, param2:Boolean):void {
        var _loc3_:HeaderButtonVo = this.getButtonDataById(param1);
        _loc3_.enabled = param2;
        if (_loc3_.headerButton) {
            _loc3_.headerButton.enabled = param2;
        }
    }

    public function setData():void {
        this._headerButtonBar.dataProvider = this.getHeaderDataProvider();
    }

    private function getButtonDataById(param1:String):HeaderButtonVo {
        var _loc4_:HeaderButtonVo = null;
        var _loc2_:int = this._buttonsArrData.length;
        var _loc3_:Number = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this._buttonsArrData[_loc3_];
            if (param1 == _loc4_.id) {
                return _loc4_;
            }
            _loc3_++;
        }
        return null;
    }

    private function searchButtonById(param1:String):HeaderButton {
        var _loc5_:HeaderButtonVo = null;
        var _loc2_:HeaderButton = null;
        var _loc3_:int = this._buttonsArrData.length;
        var _loc4_:Number = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = this._buttonsArrData[_loc4_];
            if (param1 == _loc5_.id) {
                if (_loc5_.headerButton) {
                    _loc2_ = _loc5_.headerButton;
                }
                break;
            }
            _loc4_++;
        }
        return _loc2_;
    }

    private function getHeaderDataProvider():IDataProvider {
        return new DataProvider(this._buttonsArrData);
    }
}
}

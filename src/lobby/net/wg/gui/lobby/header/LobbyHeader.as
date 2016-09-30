package net.wg.gui.lobby.header {
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.Aliases;
import net.wg.data.VO.UserVO;
import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.Errors;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.Linkages;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.tooltips.ToolTipComplex;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
import net.wg.gui.lobby.header.vo.AccountDataVo;
import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
import net.wg.gui.lobby.header.vo.HangarMenuVO;
import net.wg.gui.lobby.header.vo.HeaderButtonVo;
import net.wg.infrastructure.base.meta.ILobbyHeaderMeta;
import net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta;
import net.wg.utils.ICounterManager;
import net.wg.utils.IScheduler;
import net.wg.utils.IUtils;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.Button;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Constraints;

public class LobbyHeader extends LobbyHeaderMeta implements ILobbyHeaderMeta {

    public static const NARROW_SCREEN:String = "narrowScreen";

    public static const WIDE_SCREEN:String = "wideScreen";

    public static const MAX_SCREEN:String = "maxScreen";

    private static const NARROW_SCREEN_SIZE:int = 1024;

    private static const WIDE_SCREEN_SIZE:int = 1280;

    private static const MAX_SCREEN_SIZE:int = 1600;

    private static const BUBBLE_TOOLTIP_X:int = 16;

    private static const BUBBLE_TOOLTIP_Y:int = 7;

    private static const EMPTY_ACTION:String = "";

    public var centerBg:Sprite = null;

    public var resizeBg:Sprite = null;

    public var mainMenuGradient:Sprite = null;

    public var fightBtn:FightButton;

    public var mainMenuButtonBar:MainMenuButtonBar;

    public var headerButtonBar:HeaderButtonBar;

    public var onlineCounter:OnlineCounter;

    private var _headerButtonsHelper:HeaderButtonsHelper;

    private var _bubbleTooltip:ToolTipComplex;

    private var _actualEnabledVal:Boolean;

    private var _isInCoolDown:Boolean = false;

    private var _fightBtnTooltipStr:String = "";

    private var _utils:IUtils = null;

    private var _counterManager:ICounterManager = null;

    private var _scheduler:IScheduler = null;

    public function LobbyHeader() {
        super();
        this._utils = App.utils;
        this._counterManager = this._utils.counterManager;
        this._scheduler = this._utils.scheduler;
        this._headerButtonsHelper = new HeaderButtonsHelper(this.headerButtonBar);
    }

    override protected function configUI():void {
        super.configUI();
        constraints = new Constraints(this, ConstrainMode.REFLOW);
        constraints.addElement(this.centerBg.name, this.centerBg, Constraints.CENTER_H);
        constraints.addElement(this.resizeBg.name, this.resizeBg, Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
        constraints.addElement(this.fightBtn.name, this.fightBtn, Constraints.CENTER_H);
        constraints.addElement(this.mainMenuButtonBar.name, this.mainMenuButtonBar, Constraints.CENTER_H);
        constraints.addElement(this.mainMenuGradient.name, this.mainMenuGradient, Constraints.CENTER_H);
        this.centerBg.mouseChildren = this.centerBg.mouseEnabled = false;
        this.mainMenuGradient.mouseEnabled = false;
        this.mainMenuGradient.mouseChildren = false;
        this.hitArea = this.resizeBg;
        this.updateSize();
        this._headerButtonsHelper.setData();
        this.fightBtn.addEventListener(ButtonEvent.CLICK, this.onFightBtnClickHandler);
        this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
        this.mainMenuButtonBar.addEventListener(ButtonEvent.CLICK, this.onMainMenuButtonBarClickHandler, false, 0, true);
        this.headerButtonBar.addEventListener(ButtonEvent.CLICK, this.onHeaderButtonBarClickHandler, false, 0, true);
        this.fightBtn.mouseEnabledOnDisabled = true;
        _deferredDispose = true;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            constraints.update(width, height);
            this.updateSize();
        }
    }

    override protected function onBeforeDispose():void {
        this.mainMenuButtonBar.removeEventListener(ButtonEvent.CLICK, this.onMainMenuButtonBarClickHandler);
        this.headerButtonBar.removeEventListener(ButtonEvent.CLICK, this.onHeaderButtonBarClickHandler);
        this.fightBtn.removeEventListener(ButtonEvent.CLICK, this.onFightBtnClickHandler);
        this.fightBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.onFightBtnMouseOverHandler);
        this.fightBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.onFightBtnMouseOutHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.disposeBubbleToolTip();
        this._scheduler.cancelTask(this.stopReadyCoolDown);
        var _loc1_:int = this.mainMenuButtonBar.dataProvider.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._counterManager.removeCounter(this.mainMenuButtonBar.getButtonAt(_loc2_));
            _loc2_++;
        }
        this.mainMenuButtonBar.dispose();
        this.mainMenuButtonBar = null;
        this.headerButtonBar.dispose();
        this.headerButtonBar = null;
        this.fightBtn.dispose();
        this.fightBtn = null;
        this._headerButtonsHelper.dispose();
        this._headerButtonsHelper = null;
        this.onlineCounter.dispose();
        this.onlineCounter = null;
        this.mainMenuGradient = null;
        this.resizeBg = null;
        this.centerBg = null;
        this._counterManager = null;
        this._scheduler = null;
        this._utils = null;
        super.onDispose();
    }

    override protected function setHangarMenuData(param1:HangarMenuVO):void {
        if (this.mainMenuButtonBar.dataProvider != null) {
            this.mainMenuButtonBar.dataProvider.cleanUp();
        }
        this.mainMenuButtonBar.dataProvider = param1.tabDataProvider;
    }

    override protected function nameResponse(param1:AccountDataVo):void {
        var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
        if (_loc2_ != null) {
            if (_loc2_.userVO != null) {
                _loc2_.userVO.dispose();
            }
            _loc2_.userVO = new UserVO({
                "fullName": param1.userVO.fullName,
                "userName": param1.userVO.userName,
                "clanAbbrev": param1.userVO.clanAbbrev
            });
            _loc2_.isTeamKiller = param1.isTeamKiller;
            _loc2_.hasNew = param1.hasNew;
            _loc2_.hasActiveBooster = param1.hasActiveBooster;
            _loc2_.hasAvailableBoosters = param1.hasAvailableBoosters;
            _loc2_.boosterIcon = param1.boosterIcon;
            _loc2_.boosterBg = param1.boosterBg;
            _loc2_.boosterText = param1.boosterText;
            _loc2_.tooltip = param1.tooltip;
            _loc2_.tooltipType = param1.tooltipType;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
        }
    }

    public function as_creditsResponse(param1:String, param2:String, param3:String, param4:String):void {
        var _loc5_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SILVER));
        if (_loc5_) {
            _loc5_.money = param1;
            _loc5_.iconId = IconsTypes.CREDITS;
            _loc5_.tooltip = param3;
            _loc5_.tooltipType = param4;
            _loc5_.btnDoText = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SILVER);
        }
    }

    public function as_disableFightButton(param1:Boolean):void {
        this._actualEnabledVal = !param1;
        this.fightBtn.enabled = !this._isInCoolDown ? Boolean(this._actualEnabledVal) : !this._isInCoolDown;
        this.fightBtn.validateNow();
    }

    public function as_doDisableHeaderButton(param1:String, param2:Boolean):void {
        this._headerButtonsHelper.setButtonEnabled(param1, param2);
    }

    public function as_doDisableNavigation():void {
        this.mainMenuButtonBar.setDisableNav(true);
    }

    public function as_goldResponse(param1:String, param2:String, param3:String, param4:String):void {
        var _loc5_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_GOLD));
        if (_loc5_) {
            _loc5_.money = param1;
            _loc5_.iconId = IconsTypes.GOLD;
            _loc5_.tooltip = param3;
            _loc5_.tooltipType = param4;
            _loc5_.btnDoText = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_GOLD);
        }
    }

    public function as_initOnlineCounter(param1:Boolean):void {
        this.onlineCounter.initVisible(param1);
    }

    public function as_removeButtonCounter(param1:String):void {
        var _loc2_:Button = this.mainMenuButtonBar.getButtonByValue(param1);
        this.assertMainMenuButtonWasntFound(_loc2_, param1);
        this._counterManager.removeCounter(_loc2_);
    }

    public function as_setButtonCounter(param1:String, param2:String):void {
        var _loc3_:Button = this.mainMenuButtonBar.getButtonByValue(param1);
        if (_loc3_ == null) {
            this.mainMenuButtonBar.validateNow();
            _loc3_ = this.mainMenuButtonBar.getButtonByValue(param1);
        }
        this.assertMainMenuButtonWasntFound(_loc3_, param1);
        this._counterManager.setCounter(_loc3_, param2);
    }

    public function as_setClanEmblem(param1:String):void {
        var _loc2_:Object = this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
        if (_loc2_ != null) {
            _loc2_.clanEmblemId = !!StringUtils.isNotEmpty(param1) ? param1 : null;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
        }
    }

    public function as_setCoolDownForReady(param1:uint):void {
        this._isInCoolDown = true;
        this._scheduler.cancelTask(this.stopReadyCoolDown);
        this.fightBtn.enabled = false;
        this._scheduler.scheduleTask(this.stopReadyCoolDown, param1 * 1000);
    }

    public function as_setFightBtnTooltip(param1:String):void {
        if (StringUtils.isNotEmpty(param1)) {
            this._fightBtnTooltipStr = param1;
            this.fightBtn.addEventListener(MouseEvent.MOUSE_OVER, this.onFightBtnMouseOverHandler);
            this.fightBtn.addEventListener(MouseEvent.MOUSE_OUT, this.onFightBtnMouseOutHandler);
        }
        else {
            this.fightBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.onFightBtnMouseOverHandler);
            this.fightBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.onFightBtnMouseOutHandler);
        }
    }

    public function as_setFightButton(param1:String):void {
        this.fightBtn.label = param1;
        this.fightBtn.validateNow();
    }

    public function as_setFreeXP(param1:String, param2:String, param3:Boolean, param4:String, param5:String):void {
        var _loc6_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_FREEXP));
        if (_loc6_) {
            _loc6_.money = param1;
            _loc6_.iconId = IconsTypes.FREE_XP;
            _loc6_.isHasAction = param3;
            _loc6_.tooltip = param4;
            _loc6_.tooltipType = param5;
            _loc6_.btnDoText = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_FREEXP);
        }
    }

    public function as_setGoldFishEnabled(param1:Boolean, param2:Boolean, param3:String, param4:String):void {
        var _loc5_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_GOLD));
        if (_loc5_) {
            _loc5_.isDiscountEnabled = param1;
            _loc5_.playDiscountAnimation = param2;
            _loc5_.tooltip = param3;
            _loc5_.tooltipType = param4;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_GOLD);
        }
    }

    public function as_setPremShopData(param1:String, param2:String, param3:String, param4:String):void {
        var _loc5_:HBC_PremShopVO = HBC_PremShopVO(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREMSHOP));
        if (_loc5_) {
            _loc5_.iconSrc = param1;
            _loc5_.premShopText = param2;
            _loc5_.tooltip = param3;
            _loc5_.tooltipType = param4;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREMSHOP);
        }
    }

    public function as_setPremiumParams(param1:String, param2:String, param3:Boolean, param4:String, param5:String):void {
        var _loc6_:HBC_PremDataVo = HBC_PremDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREM));
        if (_loc6_) {
            _loc6_.btnLabel = param1;
            _loc6_.doLabel = param2;
            _loc6_.isHasAction = param3;
            _loc6_.tooltip = param4;
            _loc6_.tooltipType = param5;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREM);
        }
    }

    public function as_setScreen(param1:String):void {
        this.mainMenuButtonBar.setDisableNav(false);
        this.mainMenuButtonBar.setCurrent(param1);
    }

    public function as_setServer(param1:String, param2:String, param3:String):void {
        var _loc4_:HBC_SettingsVo = HBC_SettingsVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS));
        if (_loc4_) {
            _loc4_.serverName = param1;
            _loc4_.tooltip = param2;
            _loc4_.tooltipType = param3;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS);
        }
    }

    public function as_setWalletStatus(param1:Object):void {
        this._utils.voMgr.walletStatusVO.update(param1);
        this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_GOLD);
        this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_FREEXP);
    }

    public function as_showBubbleTooltip(param1:String, param2:int):void {
        this.disposeBubbleToolTip();
        var _loc3_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO, BUBBLE_TOOLTIP_X, BUBBLE_TOOLTIP_Y);
        this._bubbleTooltip = this._utils.classFactory.getComponent(Linkages.TOOL_TIP_COMPLEX, ToolTipComplex);
        addChild(this._bubbleTooltip);
        this._bubbleTooltip.build(param1, _loc3_);
        this._scheduler.scheduleTask(this.hideBubbleTooltip, param2);
    }

    public function as_updateBattleType(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:String):void {
        var _loc7_:HBC_BattleTypeVo = HBC_BattleTypeVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR));
        if (_loc7_) {
            _loc7_.battleTypeName = param1;
            _loc7_.battleTypeIcon = param2;
            _loc7_.battleTypeID = param6;
            _loc7_.tooltip = param4;
            _loc7_.tooltipType = param5;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
            this.as_doDisableHeaderButton(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR, param3);
        }
    }

    public function as_updateOnlineCounter(param1:String, param2:String, param3:String, param4:Boolean):void {
        this.onlineCounter.updateCount(param1, param2, param3, param4);
    }

    public function as_updatePingStatus(param1:int, param2:Boolean):void {
        var _loc3_:HBC_SettingsVo = HBC_SettingsVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS));
        if (_loc3_) {
            _loc3_.pingStatus = param1;
            _loc3_.isColorBlind = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS);
        }
    }

    public function as_updateSquad(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String):void {
        var _loc6_:HBC_SquadDataVo = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SQUAD));
        _loc6_.isInSquad = param1;
        _loc6_.tooltip = param2;
        _loc6_.tooltipType = param3;
        _loc6_.isEvent = param4;
        _loc6_.icon = param5;
        this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SQUAD);
    }

    private function assertMainMenuButtonWasntFound(param1:Button, param2:String):void {
        this._utils.asserter.assertNotNull(param1, "Main menu button alias:" + param2 + Errors.WASNT_FOUND);
    }

    private function updateSize():void {
        this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
        var _loc1_:String = WIDE_SCREEN;
        var _loc2_:Number = 0;
        var _loc3_:Number = 0;
        var _loc4_:Number = App.appWidth;
        if (_loc4_ <= NARROW_SCREEN_SIZE) {
            _loc1_ = NARROW_SCREEN;
        }
        else if (_loc4_ >= WIDE_SCREEN_SIZE) {
            _loc1_ = MAX_SCREEN;
            _loc2_ = 1;
            _loc3_ = Math.min((_loc4_ - WIDE_SCREEN_SIZE) / (MAX_SCREEN_SIZE - WIDE_SCREEN_SIZE), 1);
        }
        else {
            _loc2_ = Math.min((_loc4_ - NARROW_SCREEN_SIZE) / (WIDE_SCREEN_SIZE - NARROW_SCREEN_SIZE), 1);
        }
        this.headerButtonBar.updateScreen(_loc1_, _loc4_, _loc2_, _loc3_);
    }

    private function stopReadyCoolDown():void {
        this._isInCoolDown = false;
        this.fightBtn.enabled = this._actualEnabledVal;
    }

    private function disposeBubbleToolTip():void {
        if (this._bubbleTooltip) {
            this._scheduler.cancelTask(this.hideBubbleTooltip);
            this._utils.tweenAnimator.removeAnims(this._bubbleTooltip);
            removeChild(this._bubbleTooltip);
            this._bubbleTooltip.dispose();
            this._bubbleTooltip = null;
        }
    }

    private function hideBubbleTooltip():void {
        if (this._bubbleTooltip) {
            this._utils.tweenAnimator.addFadeOutAnim(this._bubbleTooltip, null);
        }
    }

    private function onMainMenuButtonBarClickHandler(param1:ButtonEvent):void {
        var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
        var _loc3_:HangarMenuTabItemVO = HangarMenuTabItemVO(_loc2_.data);
        if (_loc3_ != null) {
            menuItemClickS(_loc3_.value);
        }
    }

    private function onHeaderButtonBarClickHandler(param1:ButtonEvent):void {
        var _loc4_:HBC_SquadDataVo = null;
        var _loc2_:HeaderButton = HeaderButton(param1.target);
        var _loc3_:HeaderButtonVo = HeaderButtonVo(_loc2_.data);
        switch (_loc3_.id) {
            case HeaderButtonsHelper.ITEM_ID_SETTINGS:
                showLobbyMenuS();
                break;
            case HeaderButtonsHelper.ITEM_ID_ACCOUNT:
                App.popoverMgr.show(_loc2_, Aliases.ACCOUNT_POPOVER, null, _loc2_);
                _loc2_.content.parentButtonClicked();
                break;
            case HeaderButtonsHelper.ITEM_ID_PREM:
                showPremiumDialogS();
                break;
            case HeaderButtonsHelper.ITEM_ID_PREMSHOP:
                onPremShopClickS();
                break;
            case HeaderButtonsHelper.ITEM_ID_SQUAD:
                _loc4_ = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SQUAD));
                if (_loc4_.isEvent) {
                    App.popoverMgr.show(_loc2_, Aliases.SQUAD_TYPE_SELECT_POPOVER, null, _loc2_);
                }
                else {
                    showSquadS();
                }
                break;
            case HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR:
                App.popoverMgr.show(_loc2_, Aliases.BATTLE_TYPE_SELECT_POPOVER, null, _loc2_);
                break;
            case HeaderButtonsHelper.ITEM_ID_GOLD:
                onPaymentS();
                break;
            case HeaderButtonsHelper.ITEM_ID_SILVER:
                showExchangeWindowS();
                break;
            case HeaderButtonsHelper.ITEM_ID_FREEXP:
                showExchangeXPWindowS();
        }
    }

    private function onFightBtnClickHandler(param1:ButtonEvent):void {
        fightClickS(0, EMPTY_ACTION);
    }

    private function onFightBtnMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onFightBtnMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._fightBtnTooltipStr);
    }
}
}

package net.wg.gui.battle.windows {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.data.constants.generated.GLOBAL_VARS_MGR_CONSTS;
import net.wg.data.constants.generated.INTERFACE_STATES;
import net.wg.gui.components.common.bugreport.ReportBugPanel;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.meta.IIngameMenuMeta;
import net.wg.infrastructure.base.meta.impl.IngameMenuMeta;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class IngameMenu extends IngameMenuMeta implements IIngameMenuMeta {

    private static const TYPE_UNAVAILABLE:String = "unavailable";

    private static const TYPE_CLUSTER:String = "clusterCCU";

    private static const TYPE_FULL:String = "regionCCU/clusterCCU";

    private static const INVALIDATE_SERVER_INFO:String = "serverInfo";

    private static const INVALIDATE_SERVER_STATS:String = "serverStats";

    private static const PADDING:int = 5;

    private static const Y_OFFSET_HIDE_SERVER_STATS:int = -28;

    private static const Y_OFFSET_HIDE_ALL:int = -64;

    private static const REPORT_BUG_PANEL_PADDING:int = 31;

    private static const SERVER_SEPARATOR:String = ":";

    public var headerTF:TextField = null;

    public var serverNameTF:TextField = null;

    public var serverStatsTF:TextField = null;

    public var hitMC:Sprite = null;

    public var iconMC:Sprite = null;

    public var lipBottomMC:Sprite = null;

    public var background:MovieClip = null;

    public var reportBugPanel:ReportBugPanel = null;

    public var quitBattleBtn:SoundButtonEx = null;

    public var settingsBtn:SoundButtonEx = null;

    public var helpBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    private var _isSettingsCounterAdded:Boolean = false;

    private var _tooltipType:String = "unavailable";

    private var _tooltipFullData:String = "";

    private var _serverState:int = 0;

    private var _serverName:String = "";

    private var _serverStats:String = "";

    private var _isUpdtaePosition:Boolean = false;

    public function IngameMenu() {
        super();
        isCentered = true;
        isModal = true;
        canClose = false;
        showWindowBgForm = false;
        showWindowBg = false;
        canDrag = false;
        this._isUpdtaePosition = false;
        TextFieldEx.setNoTranslate(this.serverNameTF, true);
        TextFieldEx.setNoTranslate(this.serverStatsTF, true);
    }

    override protected function configUI():void {
        super.configUI();
        if (App.globalVarsMgr.isTutorialRunningS(GLOBAL_VARS_MGR_CONSTS.BATTLE)) {
            this.quitBattleBtn.label = MENU.LOBBY_MENU_BUTTONS_REFUSE_TRAINING;
        }
        else {
            this.quitBattleBtn.label = MENU.INGAME_MENU_BUTTONS_LOGOFF;
        }
        this.settingsBtn.label = MENU.INGAME_MENU_BUTTONS_SETTINGS;
        this.helpBtn.label = MENU.INGAME_MENU_BUTTONS_HELP;
        this.cancelBtn.label = MENU.INGAME_MENU_BUTTONS_BACK;
    }

    override protected function onPopulate():void {
        window.getBackground().tabEnabled = false;
        window.getBackground().tabChildren = false;
        this.quitBattleBtn.addEventListener(ButtonEvent.PRESS, this.onQuitBattleBtnPressHandler);
        this.settingsBtn.addEventListener(ButtonEvent.PRESS, this.onSettingsBtnPressHandler);
        this.helpBtn.addEventListener(ButtonEvent.PRESS, this.onHelpBtnPressHandler);
        this.cancelBtn.addEventListener(ButtonEvent.PRESS, this.onCancelBtnPressHandler);
        this.hitMC.useHandCursor = false;
        this.hitMC.addEventListener(MouseEvent.ROLL_OVER, this.showPlayersTooltip);
        this.hitMC.addEventListener(MouseEvent.ROLL_OUT, this.hideTooltip);
        this.headerTF.text = MENU.INGAME_MENU_TITLE;
        this.serverNameTF.autoSize = TextFieldAutoSize.CENTER;
        registerFlashComponentS(this.reportBugPanel, BATTLE_VIEW_ALIASES.REPORT_BUG);
        this.reportBugPanel.y = this.cancelBtn.y + this.cancelBtn.height + REPORT_BUG_PANEL_PADDING;
        super.onPopulate();
        updateStage(App.appWidth, App.appHeight);
    }

    override protected function onDispose():void {
        if (this._isSettingsCounterAdded) {
            App.utils.counterManager.removeCounter(this.settingsBtn);
        }
        this.quitBattleBtn.removeEventListener(ButtonEvent.PRESS, this.onQuitBattleBtnPressHandler);
        this.settingsBtn.removeEventListener(ButtonEvent.PRESS, this.onSettingsBtnPressHandler);
        this.helpBtn.removeEventListener(ButtonEvent.PRESS, this.onHelpBtnPressHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.PRESS, this.onCancelBtnPressHandler);
        this.hitMC.removeEventListener(MouseEvent.ROLL_OVER, this.showPlayersTooltip);
        this.hitMC.removeEventListener(MouseEvent.ROLL_OUT, this.hideTooltip);
        this.quitBattleBtn.dispose();
        this.settingsBtn.dispose();
        this.helpBtn.dispose();
        this.cancelBtn.dispose();
        this.quitBattleBtn = null;
        this.settingsBtn = null;
        this.helpBtn = null;
        this.cancelBtn = null;
        this.hitMC = null;
        this.iconMC = null;
        this.lipBottomMC = null;
        this.background = null;
        this.reportBugPanel = null;
        this.headerTF = null;
        this.serverNameTF = null;
        this.serverStatsTF = null;
        super.onDispose();
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(param1);
        setFocus(this.cancelBtn);
        onCounterNeedUpdateS();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:* = 0;
        super.draw();
        if (isInvalid(INVALIDATE_SERVER_INFO)) {
            this.serverNameTF.htmlText = App.utils.locale.makeString(MENU.INGAME_MENU_SERVERSTATS_SERVER) + SERVER_SEPARATOR + this._serverName;
            if (this._serverState == INTERFACE_STATES.HIDE_SERVER_STATS) {
                this.rePositionElements(Y_OFFSET_HIDE_SERVER_STATS);
                this.hideStats();
            }
            else if (this._serverState == INTERFACE_STATES.HIDE_ALL_SERVER_INFO) {
                this.rePositionElements(Y_OFFSET_HIDE_ALL);
                this.serverNameTF.visible = false;
                this.lipBottomMC.visible = false;
                this.hideStats();
            }
        }
        if (isInvalid(INVALIDATE_SERVER_STATS)) {
            if (this._serverStats && this._serverStats != Values.EMPTY_STR) {
                this.serverStatsTF.htmlText = this._serverStats;
            }
            this.serverStatsTF.width = this.serverStatsTF.textWidth + PADDING;
            _loc1_ = this.iconMC.width + this.serverStatsTF.width;
            _loc2_ = this.width - _loc1_ >> 1;
            this.hitMC.width = _loc1_;
            this.hitMC.x = _loc2_;
            this.iconMC.x = _loc2_;
            this.serverStatsTF.x = _loc2_ + this.iconMC.width;
        }
    }

    private function rePositionElements(param1:int = 0):void {
        if (!this._isUpdtaePosition) {
            this.lipBottomMC.y = this.lipBottomMC.y + param1;
            this.quitBattleBtn.y = this.quitBattleBtn.y + param1;
            this.settingsBtn.y = this.settingsBtn.y + param1;
            this.helpBtn.y = this.helpBtn.y + param1;
            this.cancelBtn.y = this.cancelBtn.y + param1;
            this.background.height = this.background.height + param1;
            this.reportBugPanel.y = this.cancelBtn.y + this.cancelBtn.height + REPORT_BUG_PANEL_PADDING;
            this._isUpdtaePosition = true;
        }
    }

    private function hideStats():void {
        this.hitMC.visible = false;
        this.iconMC.visible = false;
        this.serverStatsTF.visible = false;
    }

    private function hideTooltip(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function showPlayersTooltip(param1:MouseEvent):void {
        switch (this._tooltipType) {
            case TYPE_UNAVAILABLE:
                App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_UNAVAILABLE);
                break;
            case TYPE_CLUSTER:
                App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
                break;
            case TYPE_FULL:
                App.toolTipMgr.showComplex(this._tooltipFullData);
                break;
            default:
                App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
        }
    }

    private function onQuitBattleBtnPressHandler(param1:ButtonEvent):void {
        quitBattleClickS();
    }

    private function onSettingsBtnPressHandler(param1:ButtonEvent):void {
        settingsClickS();
    }

    private function onHelpBtnPressHandler(param1:ButtonEvent):void {
        helpClickS();
    }

    private function onCancelBtnPressHandler(param1:ButtonEvent):void {
        cancelClickS();
    }

    public function as_setServerSetting(param1:String, param2:String, param3:int):void {
        this._serverState = param3;
        this._serverName = param1;
        this._tooltipFullData = param2;
        invalidate(INVALIDATE_SERVER_INFO);
    }

    public function as_setServerStats(param1:String, param2:String):void {
        this._tooltipType = param2 != Values.EMPTY_STR ? param2 : TYPE_UNAVAILABLE;
        this._serverStats = param1;
        invalidate(INVALIDATE_SERVER_STATS);
    }

    public function as_setSettingsBtnCounter(param1:String):void {
        this._isSettingsCounterAdded = true;
        App.utils.counterManager.setCounter(this.settingsBtn, param1);
    }
}
}

package net.wg.gui.lobby.menu {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.Aliases;
import net.wg.gui.components.common.bugreport.ReportBugPanel;
import net.wg.gui.components.common.serverStats.ServerStats;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.data.VersionMessageVO;
import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
import net.wg.infrastructure.base.meta.impl.LobbyMenuMeta;
import net.wg.infrastructure.interfaces.ITextContainer;
import net.wg.utils.ICommons;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class LobbyMenu extends LobbyMenuMeta implements ILobbyMenuMeta {

    private static const STATE_SHOW_SERVER_NAME:String = "show_server_name";

    private static const STATE_HIDE_SERVER_STATS_ITEM:String = "hide_server_stats_item";

    private static const STATE_SHOW_ALL:String = "showAll";

    private static const TITLE_BUTTON_TEXT_SIZE:int = 20;

    private static const TITLE_BUTTON_VERTICAL_OFFSET:int = 7;

    public var header:TextField;

    public var serverStats:ServerStats;

    public var reportBugPanel:ReportBugPanel;

    public var background:MovieClip;

    public var logoffBtn:SoundButtonEx;

    public var settingsBtn:SoundButtonEx;

    public var quitBtn:SoundButtonEx;

    public var cancelBtn:SoundButtonEx;

    public var versionTF:TextField;

    public var versionButton:SoundButtonEx;

    private var _isSettingsCounterAdded:Boolean = false;

    private var _commons:ICommons;

    public function LobbyMenu() {
        this._commons = App.utils.commons;
        super();
        isCentered = true;
        isModal = true;
        canClose = false;
        showWindowBgForm = false;
        showWindowBg = false;
        canDrag = false;
    }

    override protected function configUI():void {
        super.configUI();
        TextFieldEx.setVerticalAlign(this.versionTF, TextFieldEx.VALIGN_CENTER);
        this.logoffBtn.label = MENU.LOBBY_MENU_BUTTONS_LOGOFF;
        this.settingsBtn.label = MENU.LOBBY_MENU_BUTTONS_SETTINGS;
        this.quitBtn.label = MENU.LOBBY_MENU_BUTTONS_EXIT;
        this.cancelBtn.label = MENU.LOBBY_MENU_BUTTONS_BACK;
    }

    override protected function onPopulate():void {
        var _loc1_:String = STATE_SHOW_ALL;
        if (App.globalVarsMgr.isChinaS()) {
            _loc1_ = STATE_SHOW_SERVER_NAME;
        }
        else if (!App.globalVarsMgr.isShowServerStatsS()) {
            _loc1_ = STATE_HIDE_SERVER_STATS_ITEM;
        }
        this.gotoAndPlay(_loc1_);
        var _loc2_:MovieClip = window.getBackground();
        _loc2_.tabEnabled = false;
        _loc2_.tabChildren = false;
        this.logoffBtn.addEventListener(ButtonEvent.CLICK, this.onLogoffBtnClickHandler);
        this.settingsBtn.addEventListener(ButtonEvent.CLICK, this.onSettingsBtnClickHandler);
        this.quitBtn.addEventListener(ButtonEvent.CLICK, this.onQuitBtnClickHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.versionButton.addEventListener(ButtonEvent.CLICK, this.onVersionButtonClickHandler);
        var _loc3_:ITextContainer = window.getTitleBtnEx();
        _loc3_.textSize = TITLE_BUTTON_TEXT_SIZE;
        _loc3_.textAlign = TextFieldAutoSize.CENTER;
        _loc3_.x = window.width - _loc3_.width >> 1;
        _loc3_.y = TITLE_BUTTON_VERTICAL_OFFSET;
        window.title = "";
        this.header.text = MENU.LOBBY_MENU_TITLE;
        this.versionButton.mouseEnabledOnDisabled = true;
        registerFlashComponentS(this.serverStats, Aliases.SERVER_STATS);
        registerFlashComponentS(this.reportBugPanel, Aliases.REPORT_BUG);
        super.onPopulate();
        updateStage(App.appWidth, App.appHeight);
    }

    override protected function onDispose():void {
        if (this._isSettingsCounterAdded) {
            App.utils.counterManager.removeCounter(this.settingsBtn);
        }
        this.logoffBtn.removeEventListener(ButtonEvent.CLICK, this.onLogoffBtnClickHandler);
        this.settingsBtn.removeEventListener(ButtonEvent.CLICK, this.onSettingsBtnClickHandler);
        this.quitBtn.removeEventListener(ButtonEvent.CLICK, this.onQuitBtnClickHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.versionButton.removeEventListener(ButtonEvent.CLICK, this.onVersionButtonClickHandler);
        this.logoffBtn.dispose();
        this.settingsBtn.dispose();
        this.quitBtn.dispose();
        this.cancelBtn.dispose();
        this.versionButton.dispose();
        this.logoffBtn = null;
        this.settingsBtn = null;
        this.quitBtn = null;
        this.cancelBtn = null;
        this.versionButton = null;
        this.versionTF = null;
        this.header = null;
        this.background = null;
        this.serverStats = null;
        this.reportBugPanel = null;
        this._commons = null;
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.cancelBtn);
    }

    override protected function setVersionMessage(param1:VersionMessageVO):void {
        this.versionTF.htmlText = param1.message;
        this.versionButton.label = param1.label;
        this.versionButton.tooltip = param1.tooltip;
        this.versionButton.enabled = param1.promoEnabel;
    }

    private function onVersionButtonClickHandler(param1:ButtonEvent):void {
        versionInfoClickS();
    }

    private function onLogoffBtnClickHandler(param1:ButtonEvent):void {
        logoffClickS();
    }

    private function onSettingsBtnClickHandler(param1:ButtonEvent):void {
        settingsClickS();
    }

    private function onQuitBtnClickHandler(param1:ButtonEvent):void {
        quitClickS();
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent = null):void {
        cancelClickS();
    }

    public function as_setSettingsBtnCounter(param1:String):void {
        this._isSettingsCounterAdded = true;
        App.utils.counterManager.setCounter(this.settingsBtn, param1);
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(param1);
        onCounterNeedUpdateS();
    }
}
}

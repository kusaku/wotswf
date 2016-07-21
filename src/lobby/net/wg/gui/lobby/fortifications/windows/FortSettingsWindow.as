package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsActivatedViewVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsClanInfoVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
import net.wg.gui.lobby.fortifications.settings.IFortSettingsActivatedContainer;
import net.wg.infrastructure.base.meta.IFortSettingsWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortSettingsWindowMeta;
import net.wg.infrastructure.constants.WindowViewInvalidationType;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.ISpriteEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.gfx.TextFieldEx;

public class FortSettingsWindow extends FortSettingsWindowMeta implements IFortSettingsWindowMeta {

    private static const STATUS_PADDING:int = 2;

    private static const NOT_ACTIVATED_HEIGHT:int = 596;

    private static const ACTIVATED_HEIGHT:int = 450;

    private static const INV_FORT_SETTINGS_CLAN_INFO:String = "InvFortSettingsClanInfo";

    private static const INV_CAN_DISABLE_DEF_HOUR:String = "InvCanDisableDefHour";

    public var mainStatusTitle:TextField = null;

    public var mainStatusMsg:TextField = null;

    public var clanInfo:ISpriteEx = null;

    public var viewStack:ViewStack = null;

    private var _fortActiveData:FortSettingsActivatedViewVO = null;

    private var _fortNotActiveData:FortSettingsNotActivatedViewVO = null;

    private var _fortSettingsClanInfo:FortSettingsClanInfoVO = null;

    private var _statusMsgTooltip:String = "";

    public function FortSettingsWindow() {
        super();
        isModal = false;
        isCentered = true;
        this.mainStatusTitle.autoSize = TextFormatAlign.LEFT;
        this.mainStatusMsg.autoSize = TextFormatAlign.LEFT;
        TextFieldEx.setVerticalAlign(this.mainStatusMsg, TextFieldEx.VALIGN_CENTER);
        addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
    }

    override protected function setDataForActivated(param1:FortSettingsActivatedViewVO):void {
        this._fortActiveData = param1;
        invalidateData();
    }

    override protected function setDataForNotActivated(param1:FortSettingsNotActivatedViewVO):void {
        this._fortNotActiveData = param1;
        invalidateData();
    }

    override protected function setFortClanInfo(param1:FortSettingsClanInfoVO):void {
        this._fortSettingsClanInfo = param1;
        invalidate(INV_FORT_SETTINGS_CLAN_INFO);
    }

    override protected function configUI():void {
        super.configUI();
        this.mainStatusMsg.addEventListener(MouseEvent.ROLL_OVER, this.onMainStatusMsgRollOverHandler);
        this.mainStatusMsg.addEventListener(MouseEvent.ROLL_OUT, this.onMainStatusMsgRollOutHandler);
        addEventListener(FortSettingsEvent.ACTIVATE_DEFENCE_PERIOD, this.onActivateDefencePeriodHandler);
        addEventListener(FortSettingsEvent.DISABLE_DEFENCE_PERIOD, this.onDisableDefencePeriodHandler);
        addEventListener(FortSettingsEvent.CANCEL_DISABLE_DEFENCE_PERIOD, this.onCancelDisableDefencePeriodHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE, this.onViewStackNeedUpdateHandler);
        window.title = FORTIFICATIONS.SETTINGSWINDOW_WINDOWTITLE;
    }

    override protected function draw():void {
        super.draw();
        if (this._fortSettingsClanInfo && isInvalid(INV_FORT_SETTINGS_CLAN_INFO)) {
            this.clanInfo.update(this._fortSettingsClanInfo);
        }
        if ((this._fortActiveData || this._fortNotActiveData) && isInvalid(InvalidationType.DATA)) {
            this.updateView();
        }
        if (this._fortActiveData && isInvalid(INV_CAN_DISABLE_DEF_HOUR)) {
            this.callAdditionalUpdate(this._fortActiveData.canDisableDefencePeriod);
        }
    }

    override protected function onDispose():void {
        removeEventListener(FortSettingsEvent.ACTIVATE_DEFENCE_PERIOD, this.onActivateDefencePeriodHandler);
        removeEventListener(FortSettingsEvent.DISABLE_DEFENCE_PERIOD, this.onDisableDefencePeriodHandler);
        removeEventListener(FortSettingsEvent.CANCEL_DISABLE_DEFENCE_PERIOD, this.onCancelDisableDefencePeriodHandler);
        removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE, this.onViewStackNeedUpdateHandler);
        this.viewStack.dispose();
        this.viewStack = null;
        this.clanInfo.dispose();
        this.clanInfo = null;
        this.mainStatusMsg.removeEventListener(MouseEvent.ROLL_OVER, this.onMainStatusMsgRollOverHandler);
        this.mainStatusMsg.removeEventListener(MouseEvent.ROLL_OUT, this.onMainStatusMsgRollOutHandler);
        this.mainStatusMsg = null;
        this.mainStatusTitle = null;
        this._statusMsgTooltip = null;
        this._fortSettingsClanInfo = null;
        this._fortActiveData = null;
        this._fortNotActiveData = null;
        super.onDispose();
    }

    public function as_setCanDisableDefencePeriod(param1:Boolean):void {
        if (this._fortActiveData) {
            this._fortActiveData.canDisableDefencePeriod = param1;
            invalidate(INV_CAN_DISABLE_DEF_HOUR);
        }
    }

    public function as_setMainStatus(param1:String, param2:String, param3:String):void {
        if (this.mainStatusTitle.htmlText != param1) {
            this.mainStatusTitle.htmlText = param1;
        }
        if (this.mainStatusMsg.htmlText != param2) {
            this.mainStatusMsg.htmlText = param2;
        }
        this.mainStatusMsg.x = this.mainStatusTitle.x + this.mainStatusTitle.width + STATUS_PADDING ^ 0;
        this._statusMsgTooltip = param3;
    }

    public function as_setView(param1:String):void {
        if (this.viewStack.currentLinkage != param1) {
            setFocus(this);
            this.viewStack.show(param1);
        }
    }

    private function callAdditionalUpdate(param1:Boolean):void {
        if (this.viewStack.currentLinkage == FORTIFICATION_ALIASES.FORT_SETTINGS_ACTIVATED_VIEW) {
            IFortSettingsActivatedContainer(this.viewStack.currentView).canDisableDefHour(param1);
        }
    }

    private function updateView():void {
        if (this.viewStack.currentLinkage == FORTIFICATION_ALIASES.FORT_SETTINGS_NOTACTIVATED_VIEW) {
            IViewStackContent(this.viewStack.currentView).update(this._fortNotActiveData);
        }
        else if (this.viewStack.currentLinkage == FORTIFICATION_ALIASES.FORT_SETTINGS_ACTIVATED_VIEW) {
            IViewStackContent(this.viewStack.currentView).update(this._fortActiveData);
        }
    }

    private function updateWindowSize(param1:int):void {
        window.updateSize(window.windowContent.width, param1, true);
        invalidate(WindowViewInvalidationType.POSITION_INVALID);
    }

    private function onViewStackNeedUpdateHandler(param1:ViewStackEvent):void {
        var _loc2_:int = 0;
        if (param1.linkage == FORTIFICATION_ALIASES.FORT_SETTINGS_NOTACTIVATED_VIEW) {
            param1.view.update(this._fortNotActiveData);
            _loc2_ = NOT_ACTIVATED_HEIGHT;
        }
        else if (param1.linkage == FORTIFICATION_ALIASES.FORT_SETTINGS_ACTIVATED_VIEW) {
            param1.view.update(this._fortActiveData);
            _loc2_ = ACTIVATED_HEIGHT;
        }
        this.updateWindowSize(_loc2_);
    }

    private function onMainStatusMsgRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this._statusMsgTooltip);
    }

    private function onMainStatusMsgRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onActivateDefencePeriodHandler(param1:FortSettingsEvent):void {
        activateDefencePeriodS();
    }

    private function onDisableDefencePeriodHandler(param1:FortSettingsEvent):void {
        disableDefencePeriodS();
    }

    private function onCancelDisableDefencePeriodHandler(param1:FortSettingsEvent):void {
        cancelDisableDefencePeriodS();
    }

    private function onRequestFocusHandler(param1:FocusRequestEvent):void {
        var _loc2_:InteractiveObject = param1.focusContainer.getComponentForFocus();
        setFocus(_loc2_ != null ? _loc2_ : window.getCloseBtn());
    }
}
}

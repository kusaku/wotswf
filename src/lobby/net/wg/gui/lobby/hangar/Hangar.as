package net.wg.gui.lobby.hangar {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.HANGAR_ALIASES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.common.serverStats.ServerInfo;
import net.wg.gui.components.controls.CrewOperationBtn;
import net.wg.gui.components.miniclient.HangarMiniClientComponent;
import net.wg.gui.events.LobbyEvent;
import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
import net.wg.gui.lobby.hangar.crew.Crew;
import net.wg.gui.lobby.hangar.interfaces.IHangar;
import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
import net.wg.infrastructure.base.meta.impl.HangarMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IEventCollector;
import net.wg.utils.IGameInputManager;
import net.wg.utils.IUtils;
import net.wg.utils.helpLayout.IHelpLayout;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ComponentEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class Hangar extends HangarMeta implements IHangar {

    private static const INVALIDATE_SERVER_INFO:String = "serverInfo";

    private static const INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";

    private static const INVALIDATE_CAROUSEL:String = "InvalidateCarousel";

    private static const CAROUSEL_NAME:String = "carousel";

    private static const PARAMS_TOP_MARGIN:int = 113;

    private static const PARAMS_BOTTOM_MARGIN:int = 80;

    private static const RESEARCH_PANEL_RIGHT_MARGIN:int = 297;

    private static const MESSENGER_BAR_PADDING:int = 45;

    private static const START_IGR_Y_POS:Number = 34;

    private static const IGR_Y_SERVER_OFFSET:int = -5;

    private static const IGR_Y_LABEL_OFFSET:int = 1;

    private static const IGR_Y_ACTION_DAYS_OFFSET:int = -45;

    public var vehResearchPanel:ResearchPanel = null;

    public var tmenXpPanel:TmenXpPanel = null;

    public var crewOperationBtn:CrewOperationBtn = null;

    public var crew:Crew = null;

    public var params:IVehicleParameters = null;

    public var ammunitionPanel:AmmunitionPanel = null;

    public var bottomBg:Sprite = null;

    public var carouselContainer:Sprite = null;

    public var igrLabel:IgrLabel = null;

    public var igrActionDaysLeft:IgrActionDaysLeft = null;

    public var questsControl:QuestsControl = null;

    public var serverInfo:ServerInfo = null;

    public var serverInfoBg:Sprite = null;

    public var switchModePanel:SwitchModePanel = null;

    private var _carousel:TankCarousel = null;

    private var _miniClient:HangarMiniClientComponent = null;

    private var _serverInfoStats:String = null;

    private var _serverInfoToolTipType:String = null;

    private var _crewEnabled:Boolean = true;

    private var _gameInputMgr:IGameInputManager;

    private var _globalVarsMgr:IGlobalVarsMgrMeta;

    private var _toolTipMgr:ITooltipMgr;

    private var _utils:IUtils;

    private var _helpLayout:IHelpLayout;

    private var _isControlsVisible:Boolean = false;

    private var _carouselAlias:String = null;

    public function Hangar() {
        this._gameInputMgr = App.gameInputMgr;
        this._globalVarsMgr = App.globalVarsMgr;
        this._toolTipMgr = App.toolTipMgr;
        this._utils = App.utils;
        this._helpLayout = App.utils.helpLayout;
        super();
        _deferredDispose = true;
        this.switchModePanel.visible = false;
    }

    override public function updateStage(param1:Number, param2:Number):void {
        _originalWidth = param1;
        _originalHeight = param2;
        setSize(param1, param2);
        if (this._carousel != null) {
            this._carousel.width = param1;
            this.updateCarouselPosition();
        }
        if (this.bottomBg != null) {
            this.bottomBg.x = 0;
            this.bottomBg.y = _originalHeight - this.bottomBg.height + MESSENGER_BAR_PADDING;
            this.bottomBg.width = _originalWidth;
        }
        this.alignToCenter(this.switchModePanel);
        this.alignToCenter(this.igrLabel);
        this.alignToCenter(this.igrActionDaysLeft);
        this.alignToCenter(this._miniClient);
        this.updatePlayerCounterPosition();
        this.updateParamsPosition();
        if (this.ammunitionPanel != null) {
            this.updateAmmunitionPanelPosition();
        }
        if (this.vehResearchPanel != null) {
            this.vehResearchPanel.x = param1 - RESEARCH_PANEL_RIGHT_MARGIN;
        }
        this._helpLayout.hide();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.crew, HANGAR_ALIASES.CREW);
        registerFlashComponentS(this.tmenXpPanel, HANGAR_ALIASES.TMEN_XP_PANEL);
        registerFlashComponentS(this.ammunitionPanel, HANGAR_ALIASES.AMMUNITION_PANEL);
        registerFlashComponentS(this.questsControl, Aliases.QUESTS_CONTROL);
        registerFlashComponentS(this.switchModePanel, Aliases.SWITCH_MODE_PANEL);
        registerFlashComponentS(this.params, HANGAR_ALIASES.VEHICLE_PARAMETERS);
        addEventListener(CrewDropDownEvent.SHOW_DROP_DOWN, this.onHangarShowDropDownHandler);
        if (this.vehResearchPanel != null) {
            registerFlashComponentS(this.vehResearchPanel, HANGAR_ALIASES.RESEARCH_PANEL);
        }
        this.updateControlsVisibility();
        this.updateElementsPosition();
    }

    override protected function onBeforeDispose():void {
        this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this.igrLabel.removeEventListener(MouseEvent.ROLL_OVER, this.onIgrRollOverHandler);
        this.igrLabel.removeEventListener(MouseEvent.ROLL_OUT, this.onIgrRollOutHandler);
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
        removeEventListener(CrewDropDownEvent.SHOW_DROP_DOWN, this.onHangarShowDropDownHandler);
        this._gameInputMgr.clearKeyHandler(Keyboard.F1, KeyboardEvent.KEY_DOWN);
        this._gameInputMgr.clearKeyHandler(Keyboard.F1, KeyboardEvent.KEY_UP);
        this.crewOperationBtn.removeEventListener(ButtonEvent.CLICK, this.onCrewOperationBtnClickHandler);
        if (this._globalVarsMgr.isDevelopmentS()) {
            this._gameInputMgr.clearKeyHandler(Keyboard.F2, KeyboardEvent.KEY_UP);
        }
        this.ammunitionPanel.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onAmmunitionPanelRequestFocusHandler);
        this.switchModePanel.removeEventListener(ComponentEvent.SHOW, this.onSwitchModePanelShowHandler);
        this.switchModePanel.removeEventListener(ComponentEvent.HIDE, this.onSwitchModePanelHideHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.crewOperationBtn.dispose();
        this.crewOperationBtn = null;
        this.igrLabel.dispose();
        this.igrLabel = null;
        this.igrActionDaysLeft.dispose();
        this.igrActionDaysLeft = null;
        this.serverInfo.dispose();
        this.serverInfo = null;
        this.serverInfoBg = null;
        this.bottomBg = null;
        this._miniClient = null;
        this.vehResearchPanel = null;
        this.tmenXpPanel = null;
        this.crew = null;
        this.params = null;
        this.ammunitionPanel = null;
        this._carousel = null;
        this.switchModePanel = null;
        this.questsControl = null;
        this._gameInputMgr = null;
        this._globalVarsMgr = null;
        this._toolTipMgr = null;
        this._utils = null;
        this._helpLayout = null;
        this.carouselContainer = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.serverInfo.visible = this.serverInfoBg.visible = this._globalVarsMgr.isShowServerStatsS();
        this.serverInfo.relativelyOwner = this.serverInfoBg;
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
        this.updateStage(parent.width, parent.height);
        mouseEnabled = false;
        this.bottomBg.mouseEnabled = false;
        this.igrLabel.addEventListener(MouseEvent.ROLL_OVER, this.onIgrRollOverHandler);
        this.igrLabel.addEventListener(MouseEvent.ROLL_OUT, this.onIgrRollOutHandler);
        this._gameInputMgr.setKeyHandler(Keyboard.F1, KeyboardEvent.KEY_DOWN, this.showLayoutHandler, true);
        this._gameInputMgr.setKeyHandler(Keyboard.F1, KeyboardEvent.KEY_UP, this.closeLayoutHandler, true);
        this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.handleEscapeHandler, true);
        if (this._globalVarsMgr.isDevelopmentS()) {
            this._gameInputMgr.setKeyHandler(Keyboard.F2, KeyboardEvent.KEY_UP, this.toggleGUIEditorHandler, true);
        }
        this.crewOperationBtn.tooltip = CREW_OPERATIONS.CREWOPERATIONS_BTN_TOOLTIP;
        this.crewOperationBtn.helpText = LOBBY_HELP.HANGAR_CREWOPERATIONBTN;
        this.crewOperationBtn.addEventListener(ButtonEvent.CLICK, this.onCrewOperationBtnClickHandler, false, 0, true);
        this.crewOperationBtn.iconSource = RES_ICONS.MAPS_ICONS_TANKMEN_CREW_CREWOPERATIONS;
        this.ammunitionPanel.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onAmmunitionPanelRequestFocusHandler);
        this.switchModePanel.addEventListener(ComponentEvent.SHOW, this.onSwitchModePanelShowHandler);
        this.switchModePanel.addEventListener(ComponentEvent.HIDE, this.onSwitchModePanelHideHandler);
        this.carouselContainer.mouseEnabled = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_ENABLED_CREW)) {
            this.crew.enabled = this._crewEnabled;
            this.crewOperationBtn.enabled = this._crewEnabled;
        }
        if (isInvalid(INVALIDATE_SERVER_INFO)) {
            this.serverInfo.setValues(this._serverInfoStats, this._serverInfoToolTipType);
        }
        if (isInvalid(INVALIDATE_CAROUSEL)) {
            this.updateCarouselLayout();
        }
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        if (param1 == null) {
            param1 = this;
        }
        super.onSetModalFocus(param1);
    }

    public function as_closeHelpLayout():void {
        this._helpLayout.hide();
    }

    public function as_hide3DSceneTooltip():void {
        this.hideTooltip();
    }

    public function as_setCarousel(param1:String, param2:String):void {
        if (this._carousel != null) {
            this.carouselContainer.removeChild(this._carousel);
            unregisterFlashComponentS(this._carouselAlias);
        }
        this._carouselAlias = param2;
        this._carousel = App.instance.utils.classFactory.getComponent(param1, TankCarousel);
        this._carousel.width = _originalWidth;
        this._carousel.name = CAROUSEL_NAME;
        this.carouselContainer.addChild(this._carousel);
        registerFlashComponentS(this._carousel, this._carouselAlias);
        this._carousel.validateNow();
        invalidate(INVALIDATE_CAROUSEL);
    }

    public function as_setCarouselEnabled(param1:Boolean):void {
        this._carousel.enabled = param1;
    }

    public function as_setControlsVisible(param1:Boolean):void {
        if (param1 != this._isControlsVisible) {
            this._isControlsVisible = param1;
            this.updateControlsVisibility();
        }
    }

    public function as_setCrewEnabled(param1:Boolean):void {
        this._crewEnabled = param1;
        invalidate(INVALIDATE_ENABLED_CREW);
    }

    public function as_setIsIGR(param1:Boolean, param2:String):void {
        if (param1) {
            this.igrLabel.visible = true;
            this.igrLabel.mouseChildren = false;
            this.igrLabel.useHandCursor = this.igrLabel.buttonMode = true;
            this.igrLabel.igrText.htmlText = param2;
        }
        else {
            this.igrLabel.visible = false;
        }
        this.updateElementsPosition();
    }

    public function as_setServerStats(param1:String, param2:String):void {
        this._serverInfoStats = param1;
        this._serverInfoToolTipType = param2;
        invalidate(INVALIDATE_SERVER_INFO);
    }

    public function as_setServerStatsInfo(param1:String):void {
        this.serverInfo.tooltipFullData = param1;
    }

    public function as_setVehicleIGR(param1:String):void {
        this.igrActionDaysLeft.updateText(param1);
        this.updateElementsPosition();
    }

    public function as_setVisible(param1:Boolean):void {
        this.visible = param1;
    }

    public function as_setupAmmunitionPanel(param1:Boolean, param2:String, param3:Boolean, param4:String):void {
        this.ammunitionPanel.updateAmmunitionPanel(param1, param2);
        this.ammunitionPanel.updateTuningButton(param3, param4);
    }

    public function as_show3DSceneTooltip(param1:String, param2:Array):void {
        this._toolTipMgr.showSpecial.apply(this._toolTipMgr, [param1, null].concat(param2));
    }

    public function as_showHelpLayout():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        if (this.crewOperationBtn.visible) {
            _loc1_ = this.crewOperationBtn.width;
            _loc1_ = _loc1_ + (!!this.tmenXpPanel.panelVisible ? this.tmenXpPanel.width : 0);
            this.crewOperationBtn.showHelpLayoutEx(1, _loc1_);
        }
        if (this.params.visible) {
            _loc2_ = Math.max(this.params.getHelpLayoutWidth(), this.vehResearchPanel.getHelpLayoutWidth());
            this.params.showHelpLayoutEx(this.vehResearchPanel.x - this.params.x, _loc2_);
        }
        if (this.vehResearchPanel.visible) {
            this.vehResearchPanel.showHelpLayoutEx(this.params.x - this.vehResearchPanel.x, _loc2_);
        }
        this._helpLayout.show();
    }

    public function as_showMiniClientInfo(param1:String, param2:String):void {
        this._miniClient = HangarMiniClientComponent(this._utils.classFactory.getComponent(Linkages.HANGAR_MINI_CLIENT_COMPONENT, HangarMiniClientComponent));
        this._miniClient.update(param1, param2);
        addChild(this._miniClient);
        registerFlashComponentS(this._miniClient, Aliases.MINI_CLIENT_LINKED);
        this.updateElementsPosition();
    }

    public function getHitArea():DisplayObject {
        return this.crewOperationBtn;
    }

    public function getTargetButton():DisplayObject {
        return this.crewOperationBtn;
    }

    private function updateControlsVisibility():void {
        this.params.visible = this._isControlsVisible;
        this.crew.visible = this._isControlsVisible;
        this.crewOperationBtn.visible = this._isControlsVisible;
        this.ammunitionPanel.visible = this._isControlsVisible;
        this.bottomBg.visible = this._isControlsVisible;
        this.vehResearchPanel.visible = this._isControlsVisible;
    }

    private function updateParamsPosition():void {
        this.params.x = _originalWidth - this.params.width ^ 0;
        this.params.y = PARAMS_TOP_MARGIN;
        this.params.height = this.ammunitionPanel.y - PARAMS_TOP_MARGIN + PARAMS_BOTTOM_MARGIN;
    }

    private function hideTooltip():void {
        this._toolTipMgr.hide();
    }

    private function updateAmmunitionPanelPosition():void {
        if (this._carousel != null) {
            this.ammunitionPanel.x = _width - this.ammunitionPanel.width >> 1;
            this.ammunitionPanel.y = this._carousel.y - this.ammunitionPanel.height;
            this.ammunitionPanel.updateStage(_width, this._carousel.y);
        }
        this.updateParamsPosition();
    }

    private function updateCarouselPosition():void {
        this._carousel.y = _height - this._carousel.getBottom() ^ 0;
    }

    private function updateElementsPosition():void {
        var _loc1_:int = 0;
        if (this._globalVarsMgr.isShowServerStatsS()) {
            _loc1_ = this.serverInfo.y + this.serverInfo.height + IGR_Y_SERVER_OFFSET;
        }
        else {
            _loc1_ = START_IGR_Y_POS;
        }
        if (this._miniClient) {
            this._miniClient.y = _loc1_;
            _loc1_ = _loc1_ + this._miniClient.height;
        }
        if (this.igrLabel.visible) {
            this.igrLabel.y = _loc1_;
            _loc1_ = _loc1_ + (this.igrLabel.height + IGR_Y_LABEL_OFFSET);
        }
        if (this.igrActionDaysLeft.visible) {
            this.igrActionDaysLeft.y = _loc1_;
            _loc1_ = _loc1_ + (this.igrActionDaysLeft.height + IGR_Y_ACTION_DAYS_OFFSET);
        }
        if (this.switchModePanel.visible) {
            this.switchModePanel.y = _loc1_;
        }
    }

    private function alignToCenter(param1:DisplayObject):void {
        if (param1) {
            param1.x = width - param1.width >> 1;
        }
    }

    private function updatePlayerCounterPosition():void {
        this.serverInfoBg.x = width - this.serverInfoBg.width >> 1;
        this.serverInfo.invalidateSize();
    }

    private function closeLayoutHandler():void {
        closeHelpLayoutS();
    }

    private function updateCrewSize():void {
        var _loc1_:int = this.ammunitionPanel.y + this.ammunitionPanel.gun.y - this.crew.y;
        this.crew.updateSize(_loc1_);
    }

    private function updateCarouselLayout():void {
        this.updateCarouselPosition();
        this.updateAmmunitionPanelPosition();
        this.updateCrewSize();
    }

    private function onAmmunitionPanelRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }

    private function onCrewOperationBtnClickHandler(param1:Event):void {
        App.popoverMgr.show(this, Aliases.CREW_OPERATIONS_POPOVER);
    }

    private function toggleGUIEditorHandler(param1:InputEvent):void {
        toggleGUIEditorS();
    }

    private function handleEscapeHandler(param1:InputEvent):void {
        App.contextMenuMgr.hide();
        if (!this._helpLayout.isShown()) {
            onEscapeS();
        }
    }

    private function onHangarShowDropDownHandler(param1:CrewDropDownEvent):void {
        var _loc2_:MovieClip = param1.dropDownref;
        var _loc3_:Point = globalToLocal(new Point(_loc2_.x, _loc2_.y));
        var _loc4_:IEventCollector = this._utils.events;
        _loc4_.disableDisposingForObj(_loc2_);
        addChild(_loc2_);
        _loc4_.enableDisposingForObj(_loc2_);
        _loc2_.x = _loc3_.x;
        _loc2_.y = _loc3_.y;
    }

    private function showLayoutHandler(param1:InputEvent):void {
        var _loc2_:InputDetails = param1.details;
        if (_loc2_.altKey || _loc2_.ctrlKey || _loc2_.shiftKey) {
            return;
        }
        showHelpLayoutS();
    }

    private function onIgrRollOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.IGR_INFO, null);
    }

    private function onIgrRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onSwitchModePanelShowHandler(param1:ComponentEvent):void {
        this.updateElementsPosition();
    }

    private function onSwitchModePanelHideHandler(param1:ComponentEvent):void {
        this.updateElementsPosition();
    }
}
}

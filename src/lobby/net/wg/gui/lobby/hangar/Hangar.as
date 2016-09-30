package net.wg.gui.lobby.hangar {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.HANGAR_ALIASES;
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

    private static const INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";

    private static const INVALIDATE_CAROUSEL_SIZE:String = "InvalidateCarouselSize";

    private static const CAROUSEL_NAME:String = "carousel";

    private static const PARAMS_TOP_MARGIN:int = 2;

    private static const PARAMS_BOTTOM_MARGIN:int = 80;

    private static const MESSENGER_BAR_PADDING:int = 45;

    private static const TOP_MARGIN:Number = 34;

    private static const MINI_CLIENT_GAP:Number = 1;

    public var vehResearchPanel:ResearchPanel;

    public var tmenXpPanel:TmenXpPanel;

    public var crewOperationBtn:CrewOperationBtn;

    public var crew:Crew;

    public var params:IVehicleParameters;

    public var ammunitionPanel:AmmunitionPanel;

    public var bottomBg:Sprite;

    public var carouselContainer:Sprite;

    public var questsControl:QuestsControl;

    public var switchModePanel:SwitchModePanel;

    public var header:HangarHeader;

    private var _carousel:TankCarousel;

    private var _miniClient:HangarMiniClientComponent;

    private var _crewEnabled:Boolean = true;

    private var _gameInputMgr:IGameInputManager;

    private var _globalVarsMgr:IGlobalVarsMgrMeta;

    private var _toolTipMgr:ITooltipMgr;

    private var _utils:IUtils;

    private var _helpLayout:IHelpLayout;

    private var _isControlsVisible:Boolean = false;

    private var _carouselAlias:String;

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
            this._carousel.updateStage(param1, param2);
            this.updateCarouselPosition();
        }
        if (this.bottomBg != null) {
            this.bottomBg.x = 0;
            this.bottomBg.y = _originalHeight - this.bottomBg.height + MESSENGER_BAR_PADDING;
            this.bottomBg.width = _originalWidth;
        }
        this.alignToCenter(this.switchModePanel);
        this.alignToCenter(this._miniClient);
        this.updateParamsPosition();
        if (this.ammunitionPanel != null) {
            this.updateAmmunitionPanelPosition();
        }
        this.header.x = param1 >> 1;
        if (this.vehResearchPanel != null) {
            this.vehResearchPanel.x = param1;
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
        registerFlashComponentS(this.header, HANGAR_ALIASES.HEADER);
        addEventListener(CrewDropDownEvent.SHOW_DROP_DOWN, this.onHangarShowDropDownHandler);
        if (this.vehResearchPanel != null) {
            registerFlashComponentS(this.vehResearchPanel, HANGAR_ALIASES.RESEARCH_PANEL);
        }
        this.updateControlsVisibility();
        this.updateElementsPosition();
    }

    override protected function onBeforeDispose():void {
        this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
        removeEventListener(CrewDropDownEvent.SHOW_DROP_DOWN, this.onHangarShowDropDownHandler);
        this._gameInputMgr.clearKeyHandler(Keyboard.F1, KeyboardEvent.KEY_DOWN);
        this._gameInputMgr.clearKeyHandler(Keyboard.F1, KeyboardEvent.KEY_UP);
        this.crewOperationBtn.removeEventListener(ButtonEvent.CLICK, this.onCrewOperationBtnClickHandler);
        if (this._globalVarsMgr.isDevelopmentS()) {
            this._gameInputMgr.clearKeyHandler(Keyboard.F2, KeyboardEvent.KEY_UP);
        }
        this.ammunitionPanel.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onAmmunitionPanelRequestFocusHandler);
        this.vehResearchPanel.removeEventListener(Event.RESIZE, this.onVehResearchPanelResizeHandler);
        this.switchModePanel.removeEventListener(ComponentEvent.SHOW, this.onSwitchModePanelShowHandler);
        this.switchModePanel.removeEventListener(ComponentEvent.HIDE, this.onSwitchModePanelHideHandler);
        this._carousel.removeEventListener(Event.RESIZE, this.onCarouselResizeHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.crewOperationBtn.dispose();
        this.crewOperationBtn = null;
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
        this.header = null;
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
        App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
        this.updateStage(parent.width, parent.height);
        mouseEnabled = false;
        this.bottomBg.mouseEnabled = false;
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
        this.vehResearchPanel.addEventListener(Event.RESIZE, this.onVehResearchPanelResizeHandler);
        this.carouselContainer.mouseEnabled = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_ENABLED_CREW)) {
            this.crew.enabled = this._crewEnabled;
            this.crewOperationBtn.enabled = this._crewEnabled;
        }
        if (isInvalid(INVALIDATE_CAROUSEL_SIZE)) {
            this.updateCarouselPosition();
            this.updateAmmunitionPanelPosition();
            this.updateCrewSize();
            if (hasEventListener(Event.RESIZE)) {
                dispatchEvent(new Event(Event.RESIZE));
            }
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
            this._carousel.removeEventListener(Event.RESIZE, this.onCarouselResizeHandler);
            this.carouselContainer.removeChild(this._carousel);
            unregisterFlashComponentS(this._carouselAlias);
        }
        this._carouselAlias = param2;
        this._carousel = App.instance.utils.classFactory.getComponent(param1, TankCarousel);
        this._carousel.addEventListener(Event.RESIZE, this.onCarouselResizeHandler);
        this._carousel.updateStage(_originalWidth, _originalHeight);
        this._carousel.name = CAROUSEL_NAME;
        this.carouselContainer.addChild(this._carousel);
        registerFlashComponentS(this._carousel, this._carouselAlias);
        this._carousel.validateNow();
        invalidate(INVALIDATE_CAROUSEL_SIZE);
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
        this.params.y = this.vehResearchPanel.y + this.vehResearchPanel.height + PARAMS_TOP_MARGIN;
        this.params.height = this.ammunitionPanel.y - this.params.y + PARAMS_BOTTOM_MARGIN;
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
        var _loc1_:int = TOP_MARGIN;
        if (this._miniClient != null) {
            this._miniClient.y = _loc1_;
            _loc1_ = _loc1_ + (this._miniClient.height + MINI_CLIENT_GAP);
        }
        this.header.y = _loc1_;
        if (this.switchModePanel.visible) {
            this.switchModePanel.y = _loc1_;
        }
    }

    private function alignToCenter(param1:DisplayObject):void {
        if (param1) {
            param1.x = width - param1.width >> 1;
        }
    }

    private function closeLayoutHandler():void {
        closeHelpLayoutS();
    }

    private function updateCrewSize():void {
        var _loc1_:int = this.ammunitionPanel.y + this.ammunitionPanel.gun.y - this.crew.y;
        this.crew.updateSize(_loc1_);
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

    private function onSwitchModePanelShowHandler(param1:ComponentEvent):void {
        this.updateElementsPosition();
    }

    private function onSwitchModePanelHideHandler(param1:ComponentEvent):void {
        this.updateElementsPosition();
    }

    private function onCarouselResizeHandler(param1:Event):void {
        invalidate(INVALIDATE_CAROUSEL_SIZE);
    }

    private function onVehResearchPanelResizeHandler(param1:Event):void {
        this.updateParamsPosition();
    }
}
}

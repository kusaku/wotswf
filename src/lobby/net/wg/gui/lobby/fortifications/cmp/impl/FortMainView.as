package net.wg.gui.lobby.fortifications.cmp.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.fortBase.IFortLandscapeCmp;
import net.wg.gui.fortBase.events.FortInitEvent;
import net.wg.gui.lobby.fortifications.cmp.IFortMainView;
import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
import net.wg.gui.lobby.fortifications.cmp.main.IMainHeader;
import net.wg.gui.lobby.fortifications.data.BattleNotifiersDataVO;
import net.wg.gui.lobby.fortifications.data.FortConstants;
import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
import net.wg.gui.lobby.fortifications.data.FortModeVO;
import net.wg.gui.lobby.fortifications.data.FortificationVO;
import net.wg.gui.lobby.fortifications.data.FunctionalStates;
import net.wg.gui.lobby.fortifications.events.DirectionEvent;
import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
import net.wg.gui.lobby.fortifications.utils.IFortModeSwitcher;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
import net.wg.infrastructure.base.meta.impl.FortMainViewMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.events.IconLoaderEvent;
import net.wg.infrastructure.exceptions.LifecycleException;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IAssertable;
import net.wg.utils.IClassFactory;

import scaleform.clik.constants.InputValue;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class FortMainView extends FortMainViewMeta implements IFortMainView {

    private static const TOOLTIP_MAX_WIDTH:int = 370;

    public var landscapeMask:IUIComponentEx = null;

    public var commanderHelpView:FortWelcomeCommanderView = null;

    private var _mode:String = null;

    private var _switcher:IFortModeSwitcher = null;

    private var _stateMethods:Object;

    private var _buildings:IFortLandscapeCmp = null;

    private var _header:IMainHeader = null;

    private var _footer:IMainFooter = null;

    private var _loadersList:Vector.<DisplayObject> = null;

    private var _classFactory:IClassFactory = null;

    private var _asserter:IAssertable = null;

    private var _tooltipMgr:ITooltipMgr = null;

    private var _tooltipClanListBtn:String = null;

    public function FortMainView() {
        this._stateMethods = {};
        super();
        this._classFactory = App.utils.classFactory;
        this._asserter = App.utils.asserter;
        this._tooltipMgr = App.toolTipMgr;
        addEventListener(DirectionEvent.OPEN_DIRECTION, this.onOpenDirectionHandler);
        addEventListener(FortBuildingEvent.FIRST_TRANSPORTING_STEP, this.onFirstTransportingStepHandler);
        addEventListener(FortBuildingEvent.NEXT_TRANSPORTING_STEP, this.onNextTransportingStepHandler);
        visible = false;
    }

    private static function getFortMode(param1:String):Number {
        if (param1 == FORTIFICATION_ALIASES.MODE_TRANSPORTING_NEXT_STEP) {
            return FunctionalStates.TRANSPORTING_NEXT_STEP;
        }
        if (param1 == FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_FIRST_STEP) {
            return FunctionalStates.TRANSPORTING_TUTORIAL_FIRST_STEP;
        }
        return FunctionalStates.UNKNOWN;
    }

    private static function isInTransportingMode(param1:String):Boolean {
        return FORTIFICATION_ALIASES.TRANSPORTING_MODES.indexOf(param1) != -1;
    }

    private static function isInDirectionMode(param1:String):Boolean {
        return FORTIFICATION_ALIASES.MODE_DIRECTIONS == param1;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this._buildings, FORTIFICATION_ALIASES.FORT_BUILDING_COMPONENT_ALIAS);
        registerFlashComponentS(this._footer.ordersPanel, FORTIFICATION_ALIASES.FORT_ORDERS_PANEL_COMPONENT_ALIAS);
    }

    override protected function configUI():void {
        super.configUI();
        this.addLoaderHandlers();
        this._header.transportBtn.addEventListener(ButtonEvent.CLICK, this.onHeaderTransportBtnClickHandler);
        this._header.transportBtn.addEventListener(MouseEvent.ROLL_OVER, this.onHeaderTransportBtnRollOverHandler);
        this._header.transportBtn.addEventListener(MouseEvent.ROLL_OUT, this.onHeaderComponentRollOutHandler);
        this._header.statsBtn.addEventListener(ButtonEvent.CLICK, this.onHeaderStatsBtnClickHandler);
        this._header.clanProfileBtn.addEventListener(ButtonEvent.CLICK, this.onHeaderClanProfileBtnClickHandler);
        this._header.clanListBtn.addEventListener(ButtonEvent.CLICK, this.onHeaderClanListBtnClickHandler);
        this._header.clanListBtn.addEventListener(MouseEvent.ROLL_OVER, this.onHeaderClanListBtnRollOverHandler);
        this._header.clanListBtn.addEventListener(MouseEvent.ROLL_OUT, this.onHeaderComponentRollOutHandler);
        this._header.calendarBtn.addEventListener(ButtonEvent.CLICK, this.onHeaderCalendarBtnClickHandler);
        this._header.settingBtn.addEventListener(ButtonEvent.CLICK, this.onHeaderSettingBtnClickHandler);
        this._footer.intelligenceButton.addEventListener(ButtonEvent.CLICK, this.onFooterIntelligenceButtonClickHandler);
        this._footer.sortieBtn.addEventListener(ButtonEvent.CLICK, this.onFooterSortieBtnClickHandler);
        this._footer.leaveModeBtn.addEventListener(ButtonEvent.CLICK, this.onFooterLeaveModeBtnClickHandler);
        this._footer.orderSelector.addEventListener(Event.SELECT, this.onFooterOrderSelectorSelectHandler);
        this._switcher = IFortModeSwitcher(this._classFactory.getObject(Linkages.FORT_MODE_SWITCHER));
        this._switcher.init(this);
        this.initStateMethods();
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateControlPositions();
        }
    }

    override protected function onDispose():void {
        var _loc1_:DisplayObject = null;
        App.utils.scheduler.cancelTask(this.updateFooter);
        removeEventListener(DirectionEvent.OPEN_DIRECTION, this.onOpenDirectionHandler);
        removeEventListener(FortBuildingEvent.FIRST_TRANSPORTING_STEP, this.onFirstTransportingStepHandler);
        removeEventListener(FortBuildingEvent.NEXT_TRANSPORTING_STEP, this.onNextTransportingStepHandler);
        removeEventListener(InputEvent.INPUT, this.onInputHandler);
        for each(_loc1_ in this._loadersList) {
            this.removeItemLoaderHandlers(_loc1_);
        }
        this._loadersList.splice(0, this._loadersList.length);
        this._loadersList = null;
        this._switcher.dispose();
        this._switcher = null;
        this._footer.leaveModeBtn.removeEventListener(ButtonEvent.CLICK, this.onFooterLeaveModeBtnClickHandler);
        this._footer.intelligenceButton.removeEventListener(ButtonEvent.CLICK, this.onFooterIntelligenceButtonClickHandler);
        this._footer.sortieBtn.removeEventListener(ButtonEvent.CLICK, this.onFooterSortieBtnClickHandler);
        this._footer.orderSelector.removeEventListener(Event.SELECT, this.onFooterOrderSelectorSelectHandler);
        this._footer.dispose();
        this._footer = null;
        this._header.transportBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onHeaderTransportBtnRollOverHandler);
        this._header.transportBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onHeaderComponentRollOutHandler);
        this._header.transportBtn.removeEventListener(ButtonEvent.CLICK, this.onHeaderTransportBtnClickHandler);
        this._header.statsBtn.removeEventListener(ButtonEvent.CLICK, this.onHeaderStatsBtnClickHandler);
        this._header.clanListBtn.removeEventListener(ButtonEvent.CLICK, this.onHeaderClanListBtnClickHandler);
        this._header.clanListBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onHeaderClanListBtnRollOverHandler);
        this._header.clanListBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onHeaderComponentRollOutHandler);
        this._header.clanProfileBtn.removeEventListener(ButtonEvent.CLICK, this.onHeaderClanProfileBtnClickHandler);
        this._header.calendarBtn.removeEventListener(ButtonEvent.CLICK, this.onHeaderCalendarBtnClickHandler);
        this._header.settingBtn.removeEventListener(ButtonEvent.CLICK, this.onHeaderSettingBtnClickHandler);
        this._header.dispose();
        this._header = null;
        App.utils.data.cleanupDynamicObject(this._stateMethods);
        this._stateMethods = null;
        if (this.commanderHelpView) {
            this.disposeCommanderHelp();
        }
        this._buildings = null;
        this.landscapeMask.dispose();
        this.landscapeMask = null;
        this._classFactory = null;
        this._asserter = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function setMainData(param1:FortificationVO):void {
        this._header.clanProfileBtn.label = param1.clanProfileBtnLbl;
        this._header.totalDepotQuantityText.htmlText = param1.defResText;
        this._header.clanInfo.applyClanData(param1);
        this._footer.orderSelector.update(param1.orderSelectorVO);
        this._tooltipClanListBtn = param1.clanListBtnTooltip;
        this.updateControlPositions();
    }

    override protected function switchMode(param1:FortModeStateVO):void {
        var _loc2_:String = param1.mode;
        if (_loc2_ != this._mode) {
            this._asserter.assert(FORTIFICATION_ALIASES.MODES.indexOf(_loc2_) != -1, "unknown fort mode:" + _loc2_);
            if (isInTransportingMode(_loc2_) || isInDirectionMode(_loc2_)) {
                addEventListener(InputEvent.INPUT, this.onInputHandler);
            }
            else {
                removeEventListener(InputEvent.INPUT, this.onInputHandler);
            }
            this.invokeStateMethod(false, this._mode, getFortMode(_loc2_));
            this.invokeStateMethod(true, _loc2_, getFortMode(_loc2_));
            this._mode = _loc2_;
        }
        this._switcher.applyMode(param1);
        this._header.statsBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_STATISTICS;
        this._header.calendarBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_CALENDARBTN;
        this._header.settingBtn.tooltip = TOOLTIPS.FORTIFICATION_HEADER_SETTINGSBTN;
        var _loc3_:Boolean = isInTransportingMode(_loc2_);
        if (!_loc3_) {
            App.utils.scheduler.scheduleOnNextFrame(this.updateFooter);
        }
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    override protected function setBattlesDirectionData(param1:BattleNotifiersDataVO):void {
        this._buildings.directionsContainer.updateBattleDirectionNotifiers(param1.directionsBattles);
    }

    public function as_setClanIconId(param1:String):void {
        this._header.clanInfo.setClanImage(param1);
    }

    public function as_setHeaderMessage(param1:String, param2:Boolean):void {
        this._header.infoTF.htmlText = param1;
        this._header.timeAlert.showAlert(true, param2, false, false, Values.DEFAULT_INT);
    }

    public function as_setTutorialArrowVisibility(param1:String, param2:Boolean):void {
        if (param1 == FORTIFICATION_ALIASES.TUTORIAL_ARROW_DEFENCE) {
            FortCommonUtils.instance.updateTutorialArrow(param2, DisplayObject(this._header.tutorialArrowDefense));
        }
        else if (param1 == FORTIFICATION_ALIASES.TUTORIAL_ARROW_INTELLIGENCE) {
            FortCommonUtils.instance.updateTutorialArrow(param2, DisplayObject(this._footer.tutorialArrowIntelligence));
        }
        else {
            this._asserter.assert(false, "Unknown arrow alias: " + param1);
        }
    }

    public function as_toggleCommanderHelp(param1:Boolean):void {
        if (param1) {
            this._asserter.assertNull(this.commanderHelpView, "toggleCommanderHelp already shown");
            this.commanderHelpView = this._classFactory.getComponent(FORTIFICATION_ALIASES.WELCOME_COMMANDER_VIEW_LINKAGE, FortWelcomeCommanderView);
            this.commanderHelpView.addEventListener(FortInitEvent.COMMANDER_HELP_VIEW_BTN_CLICK, this.onCommanderHelpViewCommanderHelpViewBtnClickHandler);
            addChild(this.commanderHelpView);
            this.updateControlPositions();
        }
        else {
            this._asserter.assertNotNull(this.commanderHelpView, "toggleCommanderHelp not shown, can`t be hidden.");
            this.disposeCommanderHelp();
        }
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    public function canShowAutomatically():Boolean {
        return false;
    }

    public function getComponentForFocus():InteractiveObject {
        return this.getActiveFocusContainer().getComponentForFocus();
    }

    public function update(param1:Object):void {
    }

    private function getActiveFocusContainer():IFocusContainer {
        var _loc1_:IFocusContainer = null;
        if (this.commanderHelpView) {
            _loc1_ = this.commanderHelpView;
        }
        else if (isInTransportingMode(this._mode) || isInDirectionMode(this._mode)) {
            _loc1_ = this._footer;
        }
        else if (FORTIFICATION_ALIASES.MODE_DIRECTIONS_TUTORIAL == this._mode) {
            _loc1_ = this._buildings;
        }
        else {
            _loc1_ = this._header;
        }
        return _loc1_;
    }

    private function initStateMethods():void {
        this._stateMethods[FORTIFICATION_ALIASES.MODE_COMMON] = this._buildings.updateCommonMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_DIRECTIONS] = this._buildings.updateDirectionsMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_FIRST_STEP] = this._buildings.updateTransportMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_NEXT_STEP] = this._buildings.updateTransportMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_NOT_AVAILABLE] = this._buildings.updateTransportMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_COMMON_TUTORIAL] = this._buildings.updateCommonMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_DIRECTIONS_TUTORIAL] = this._buildings.updateDirectionsMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL] = this._buildings.updateTransportMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_FIRST_STEP] = this._buildings.updateTransportMode;
        this._stateMethods[FORTIFICATION_ALIASES.MODE_TRANSPORTING_TUTORIAL_NEXT_STEP] = this._buildings.updateTransportMode;
    }

    private function updateFooter():void {
        this.footer.updateControls();
    }

    private function show():void {
        visible = true;
    }

    private function invokeStateMethod(param1:Boolean, param2:String, param3:Number):void {
        var _loc4_:FortModeVO = null;
        if (param2 != null) {
            _loc4_ = new FortModeVO();
            _loc4_.isEntering = param1;
            _loc4_.isTutorial = FORTIFICATION_ALIASES.TUTORIAL_MODES.indexOf(param2) != -1;
            _loc4_.currentMode = param3;
            this._stateMethods[param2](_loc4_);
        }
    }

    private function disposeCommanderHelp():void {
        this.commanderHelpView.removeEventListener(FortInitEvent.COMMANDER_HELP_VIEW_BTN_CLICK, this.onCommanderHelpViewCommanderHelpViewBtnClickHandler);
        this.commanderHelpView.dispose();
        removeChild(this.commanderHelpView);
        this.commanderHelpView = null;
    }

    private function updateControlPositions():void {
        var _loc1_:Number = localToGlobal(new Point(0, 0)).y / App.appScale >> 0;
        var _loc2_:Number = App.appHeight - _loc1_ - FortConstants.CHAT_HEIGHT;
        var _loc3_:Number = App.appWidth;
        this.landscapeMask.setActualSize(_loc3_, _loc2_);
        FortsControlsAligner.instance.centerControl(this._buildings, false);
        this._buildings.y = this.landscapeMask.height - this._buildings.height >> 1;
        this._buildings.updateControlPositions();
        this._header.updateControls();
        this._footer.updateControls();
        if (this.commanderHelpView) {
            this.commanderHelpView.setSize(_loc3_, _loc2_);
        }
        this._header.widthFill = this._footer.widthFill = _loc3_;
        this._footer.y = this.landscapeMask.actualHeight - this._footer.heightFill;
    }

    private function addLoaderHandlers():void {
        var _loc1_:DisplayObject = null;
        this._loadersList = new Vector.<DisplayObject>();
        this._loadersList.push(this._buildings.landscapeBG);
        this._loadersList.push(this._header.clanListBtn);
        for each(_loc1_ in this._loadersList) {
            _loc1_.addEventListener(IconLoaderEvent.ICON_LOADED, this.onItemIconLoadedHandler);
            _loc1_.addEventListener(IconLoaderEvent.ICON_LOADING_FAILED, this.onItemIconLoadingFailedHandler);
        }
    }

    private function removeItemLoaderHandlers(param1:DisplayObject):void {
        param1.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onItemIconLoadedHandler);
        param1.removeEventListener(IconLoaderEvent.ICON_LOADING_FAILED, this.onItemIconLoadingFailedHandler);
    }

    public function get buildings():IFortLandscapeCmp {
        return this._buildings;
    }

    public function set buildings(param1:IFortLandscapeCmp):void {
        this._buildings = param1;
    }

    public function get header():IMainHeader {
        return this._header;
    }

    public function set header(param1:IMainHeader):void {
        this._header = param1;
    }

    public function get footer():IMainFooter {
        return this._footer;
    }

    public function set footer(param1:IMainFooter):void {
        this._footer = param1;
    }

    private function onHeaderClanProfileBtnClickHandler(param1:ButtonEvent):void {
        onClanProfileClickS();
    }

    private function onItemIconLoadingFailedHandler(param1:IconLoaderEvent):void {
        this.loadItemCompleted(DisplayObject(param1.target));
    }

    private function onItemIconLoadedHandler(param1:IconLoaderEvent):void {
        this.loadItemCompleted(DisplayObject(param1.target));
    }

    private function loadItemCompleted(param1:DisplayObject):void {
        if (param1) {
            this.removeItemLoaderHandlers(param1);
            this._loadersList.splice(this._loadersList.indexOf(param1), 1);
            if (this._loadersList.length == 0) {
                onViewReadyS();
                this.show();
            }
        }
    }

    private function onCommanderHelpViewCommanderHelpViewBtnClickHandler(param1:FortInitEvent):void {
        onEnterBuildDirectionClickS();
    }

    private function onHeaderClanListBtnClickHandler(param1:ButtonEvent):void {
        onClanClickS();
    }

    private function onHeaderStatsBtnClickHandler(param1:ButtonEvent):void {
        onStatsClickS();
    }

    private function onHeaderCalendarBtnClickHandler(param1:ButtonEvent):void {
        onCalendarClickS();
    }

    private function onHeaderSettingBtnClickHandler(param1:ButtonEvent):void {
        onSettingClickS();
    }

    private function onHeaderTransportBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:String = "onTransportButtonClickHandler invoked after dispose!";
        this._asserter.assert(!_baseDisposed, _loc2_, LifecycleException);
        if (isInTransportingMode(this._mode)) {
            onLeaveTransportingClickS();
        }
        else {
            onEnterTransportingClickS();
        }
        this.updateControlPositions();
    }

    private function onHeaderClanListBtnRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(this._tooltipClanListBtn, new TooltipProps(BaseTooltips.TYPE_INFO, 0, 0, TOOLTIP_MAX_WIDTH));
    }

    private function onHeaderTransportBtnRollOverHandler(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (this._header.transportBtn.selected) {
            _loc2_ = TOOLTIPS.FORTIFICATION_TRANPORTINGBUTTON_ACTIVE;
        }
        else {
            _loc2_ = TOOLTIPS.FORTIFICATION_TRANPORTINGBUTTON_INACTIVE;
        }
        this._tooltipMgr.showComplex(_loc2_);
    }

    private function onHeaderComponentRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }

    private function onFooterIntelligenceButtonClickHandler(param1:ButtonEvent):void {
        onIntelligenceClickS();
    }

    private function onFooterSortieBtnClickHandler(param1:ButtonEvent):void {
        onSortieClickS();
    }

    private function onFooterLeaveModeBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:String = this._mode;
        if (isInTransportingMode(_loc2_)) {
            removeEventListener(InputEvent.INPUT, this.onInputHandler);
            onLeaveTransportingClickS();
        }
        else if (isInDirectionMode(_loc2_)) {
            onLeaveBuildDirectionClickS();
        }
        this.updateControlPositions();
    }

    private function onOpenDirectionHandler(param1:DirectionEvent):void {
        onCreateDirectionClickS(param1.id);
    }

    private function onFirstTransportingStepHandler(param1:FortBuildingEvent):void {
        onFirstTransportingStepS();
    }

    private function onNextTransportingStepHandler(param1:FortBuildingEvent):void {
        onNextTransportingStepS();
    }

    private function onInputHandler(param1:InputEvent):void {
        if (param1.handled) {
            return;
        }
        var _loc2_:InputDetails = param1.details;
        if (_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN) {
            param1.handled = true;
            if (FORTIFICATION_ALIASES.TRANSPORTING_TUTORIAL_MODES.indexOf(this._mode) == -1) {
                removeEventListener(InputEvent.INPUT, this.onInputHandler);
                onLeaveTransportingClickS();
            }
            if (FORTIFICATION_ALIASES.MODE_DIRECTIONS != this._mode) {
                removeEventListener(InputEvent.INPUT, this.onInputHandler);
                onLeaveBuildDirectionClickS();
            }
        }
    }

    private function onFooterOrderSelectorSelectHandler(param1:Event):void {
        onSelectOrderSelectorS(this._footer.orderSelector.isSelected());
    }
}
}

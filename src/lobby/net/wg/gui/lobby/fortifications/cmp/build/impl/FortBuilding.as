package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.fortBase.IArrowWithNut;
import net.wg.gui.fortBase.IBuildingToolTipDataProvider;
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IFortBuilding;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.lobby.fortifications.data.FortBuildingConstants;
import net.wg.gui.lobby.fortifications.data.FunctionalStates;
import net.wg.gui.lobby.fortifications.events.FortBuildingAnimationEvent;
import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.exceptions.InfrastructureException;
import net.wg.infrastructure.managers.IContextMenuManager;
import net.wg.infrastructure.managers.IPopoverManager;
import net.wg.utils.IAssertable;
import net.wg.utils.ICommons;
import net.wg.utils.ILocale;
import net.wg.utils.IScheduler;
import net.wg.utils.ITweenAnimator;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class FortBuilding extends FortBuildingUIBase implements IFortBuilding {

    private static const ALPHA_DISABLED:Number = 0.25;

    private static const ALPHA_ENABLED:Number = 1;

    private static const HALF_TURN_SCHEDULER_TIME:int = 2000;

    private static const BUILDING_SHAPE_Y_OFFSET:int = 40;

    private static const STATE_TROWEL_SHAPE_SIZE:int = 64;

    private static const FORT_BASE_ICON_OFFSET:int = -15;

    private static const HIT_AREA:Vector.<Rectangle> = new <Rectangle>[new Rectangle(15, 50, 140, 82), new Rectangle(6, 54, 160, 91), new Rectangle(49, 58, 83, 65), new Rectangle(15, 51, 134, 81), new Rectangle(10, 49, 145, 85), new Rectangle(13, 51, 137, 82), new Rectangle(28, 52, 118, 82), new Rectangle(34, 57, 82, 56), new Rectangle(12, 52, 135, 82), new Rectangle(25, 52, 95, 65), new Rectangle(11, 48, 147, 87), new Rectangle(4, 42, 150, 96)];

    private static const TOOLTIP_TYPE_SIMPLE:String = "simple";

    private static const TOOLTIP_TYPE_ADVANCED:String = "advanced";

    private static const TOOLTIP_TYPE_TRANSPORT:String = "transport";

    private static const FRAME_NORMAL:String = "normal";

    private static const FRAME_PAUSE:String = "pause";

    private static const MIN_MODERNIZATION_LEVEL:int = 2;

    private var _model:IBuildingVO = null;

    private var _toolTipDataProvider:IBuildingToolTipDataProvider;

    private var _commons:ICommons = null;

    private var _animator:ITweenAnimator;

    private var _scheduler:IScheduler;

    private var _asserter:IAssertable;

    private var _popover:IPopoverManager;

    private var _contextMenu:IContextMenuManager;

    private var _locale:ILocale;

    private var _showCtxMenu:Boolean = false;

    private var _mouseOverTrigger:Boolean = true;

    private var _requestOpenPopOver:Boolean = false;

    private var _requestOpenCtxMenu:Boolean = false;

    private var _inExporting:Boolean = false;

    private var _inImporting:Boolean = false;

    private var _inDirectionMode:Boolean = false;

    private var _isInOverviewMode:Boolean = false;

    private var _disableCursor:Boolean = false;

    private var _lastState:Number = -1;

    private var _isTutorial:Boolean = false;

    private var _latestUID:String = null;

    private var _latestLevel:int = -1;

    private var _userCanAddBuilding:Boolean = false;

    private var _uid:String = "";

    private var _selected:Boolean = false;

    private var _currentToolTipType:String;

    public function FortBuilding() {
        super();
        this._commons = App.utils.commons;
        this._animator = App.utils.tweenAnimator;
        this._scheduler = App.utils.scheduler;
        this._asserter = App.utils.asserter;
        this._popover = App.popoverMgr;
        this._contextMenu = App.contextMenuMgr;
        this._locale = App.utils.locale;
        this.updateInteractionEnabling(false);
        indicators.mouseEnabled = indicators.mouseChildren = false;
        trowel.mouseEnabled = trowel.mouseChildren = false;
        this.updateOrderTime();
        hitAreaControl.alpha = 0;
        this.addCommonBuildingListeners();
    }

    private static function getRequiredBuildingState(param1:Number):String {
        return FortBuildingConstants.BUILD_CODE_TO_NAME_MAP[param1];
    }

    override public function onPopoverClose():void {
        this._requestOpenPopOver = false;
        if (!this._mouseOverTrigger) {
            this.forceSelected = false;
        }
    }

    override public function updateCommonMode(param1:IFortModeVO):void {
        this._isTutorial = param1.isTutorial;
    }

    override public function updateDirectionsMode(param1:IFortModeVO):void {
        this._inDirectionMode = param1.isEntering;
        this.updateEnabling();
        this.checkAnimationState();
    }

    override public function updateTransportMode(param1:IFortModeVO):void {
        var _loc2_:Number = FortCommonUtils.instance.getFunctionalState(param1);
        if (FunctionalStates.ENTER == _loc2_) {
            this._inExporting = true;
            this._inImporting = false;
            cooldownIcon.visible = false;
            this.showCooldown(this.isInCooldown());
            if (this.isExportAvailable()) {
                this.addTransportingListeners();
            }
            this.showIndicators(true);
            this.updateEnabling();
        }
        else if (FunctionalStates.LEAVE == _loc2_) {
            this._inExporting = false;
            this._inImporting = false;
            this.showIndicators(false);
            cooldownIcon.visible = this.isInCooldown();
            this.showCooldown(false);
            if (!exportArrow.isHidden) {
                exportArrow.hide();
            }
            if (!importArrow.isHidden) {
                importArrow.hide();
            }
            this.updateEnabling();
        }
        if (param1.isEntering) {
            this.addTransportingListeners();
        }
        else {
            this.removeTransportingListeners();
        }
        this.checkAnimationState();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE)) {
            buildingMc.mouseEnabled = buildingMc.mouseChildren = false;
            indicators.mouseEnabled = indicators.mouseChildren = false;
            trowel.mouseEnabled = trowel.mouseChildren = false;
        }
    }

    override protected function onDispose():void {
        buildingMc.removeEventListener(Event.COMPLETE, this.onBuildingMcCompleteHandler);
        this.removeAllListeners();
        this._animator.removeAnims(DisplayObject(cooldownIcon));
        this._animator.removeAnims(DisplayObject(indicators));
        this._animator.removeAnims(orderProcess.hourglasses);
        this._animator.removeAnims(indicators.labels);
        this._scheduler.cancelTask(this.doHalfTurnHourglasses);
        this._uid = null;
        this._model = null;
        this._contextMenu.hide();
        animationController.removeEventListener(FortBuildingAnimationEvent.END_ANIMATION, this.onAnimationControllerEndAnimationHandler);
        this._toolTipDataProvider = null;
        this._commons = null;
        this._animator = null;
        this._scheduler = null;
        this._asserter = null;
        this._popover = null;
        this._contextMenu = null;
        this._locale = null;
        this._requestOpenPopOver = false;
        this._mouseOverTrigger = true;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        buildingMc.addEventListener(Event.COMPLETE, this.onBuildingMcCompleteHandler);
        cooldownIcon.visible = false;
    }

    public function getCustomHitArea():InteractiveObject {
        return hitAreaControl;
    }

    public function getHitArea():DisplayObject {
        return hitAreaControl;
    }

    public function getTargetButton():DisplayObject {
        return buildingMc.getBuildingShape();
    }

    public function isAvailable():Boolean {
        return this._model != null;
    }

    public function isExportAvailable():Boolean {
        return this.isAvailable() && this._model.isExportAvailable;
    }

    public function isImportAvailable():Boolean {
        return this.isAvailable() && this._model.isImportAvailable;
    }

    public function nextTransportingStep(param1:Boolean):void {
        this._inExporting = false;
        this._inImporting = true;
        if (this.isImportAvailable() && !param1) {
            this.addTransportingListeners();
        }
        else {
            this.removeTransportingListeners();
        }
        this.updateEnabling();
    }

    public function onComplete():void {
    }

    public function setData(param1:IBuildingVO):void {
        var _loc2_:String = null;
        _loc2_ = null;
        if (this._model != null) {
            _loc2_ = this._model.cooldown;
        }
        if (this._model && this._requestOpenCtxMenu && param1.uid == FORTIFICATION_ALIASES.FORT_UNKNOWN) {
            this._requestOpenCtxMenu = false;
            this._contextMenu.hide();
        }
        this._model = param1;
        visible = this._model != null;
        hitAreaControl.enabled = visible;
        this.updateVisibleState(_loc2_, param1);
    }

    public function setEmptyPlace():void {
        ground.visible = true;
        buildingMc.visible = false;
        trowel.visible = false;
        indicators.visible = false;
        hitAreaControl.visible = false;
        visible = true;
    }

    public function setIsInOverviewMode(param1:Boolean):void {
        this._isInOverviewMode = param1;
        buildingMc.isInOverviewMode = param1;
        this.updateEnabling();
    }

    public function setToolTipData(param1:String, param2:String, param3:String, param4:String = ""):void {
        if (param1 == this._currentToolTipType) {
            this.showToolTip(param2, param3, param4);
        }
    }

    private function updateToolTipState():void {
        if (this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this._model.progress == FORTIFICATION_ALIASES.STATE_BUILDING || this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION) {
            this.setCurrentToolTip(TOOLTIP_TYPE_ADVANCED);
        }
        else {
            this.setCurrentToolTip(TOOLTIP_TYPE_SIMPLE);
        }
    }

    private function setCurrentToolTip(param1:String):void {
        if (param1 == this._currentToolTipType) {
            return;
        }
        App.toolTipMgr.hide();
        this._currentToolTipType = param1;
        this.requestToolTipData(param1);
    }

    private function requestToolTipData(param1:String):void {
        var _loc2_:String = null;
        var _loc3_:String = null;
        if (TOOLTIP_TYPE_SIMPLE == param1) {
            if (this._userCanAddBuilding) {
                _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_HEADER;
                if (this._model.isFortFrozen || this._model.isBaseBuildingDamaged) {
                    _loc3_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_NOTAVAILABLE_BODY;
                }
                else {
                    _loc3_ = TOOLTIPS.FORTIFICATION_FOUNDATIONCOMMANDER_BODY;
                }
            }
            else {
                _loc2_ = TOOLTIPS.FORTIFICATION_FOUNDATIONNOTCOMMANDER_HEADER;
                _loc3_ = TOOLTIPS.FORTIFICATION_FOUNDATIONNOTCOMMANDER_BODY;
            }
            this.setToolTipData(param1, this._locale.makeString(_loc2_), this._locale.makeString(_loc3_));
        }
        else if (TOOLTIP_TYPE_ADVANCED == param1) {
            this._toolTipDataProvider.requestToolTipDataForBuilding(this._model.uid, param1);
        }
        else if (TOOLTIP_TYPE_TRANSPORT == param1 && this._model.transportTooltipData && this._model.transportTooltipData.length > 0) {
            this.setToolTipData(param1, this._model.transportTooltipData[0], this._model.transportTooltipData[1]);
        }
    }

    private function showToolTip(param1:String, param2:String, param3:String):void {
        var _loc4_:String = App.toolTipMgr.getNewFormatter().addHeader(param1).addBody(param2).addNote(param3, false).make();
        if (_loc4_.length > 0) {
            App.toolTipMgr.showComplex(_loc4_);
        }
    }

    private function gotoBuildingState(param1:Number, param2:String):void {
        var _loc3_:Rectangle = null;
        var _loc4_:Array = null;
        gotoAndPlay(getRequiredBuildingState(this._model.progress));
        if (param1 == FORTIFICATION_ALIASES.STATE_BUILDING) {
            _loc4_ = FORTIFICATION_ALIASES.HIT_AREA_BUILDINGS;
            _loc3_ = HIT_AREA[_loc4_.indexOf(param2)];
            buildingMc.setBuildingShapeBounds(new Rectangle(_loc3_.x, _loc3_.y - BUILDING_SHAPE_Y_OFFSET, _loc3_.width, _loc3_.height));
        }
        else if (this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION) {
            _loc3_ = HIT_AREA[0];
            buildingMc.setBuildingShapeBounds(new Rectangle(_loc3_.x, _loc3_.y - BUILDING_SHAPE_Y_OFFSET, _loc3_.width, _loc3_.height));
        }
        else if (this._model.progress == FORTIFICATION_ALIASES.STATE_TROWEL) {
            _loc3_ = new Rectangle(trowel.x, trowel.y, STATE_TROWEL_SHAPE_SIZE, STATE_TROWEL_SHAPE_SIZE);
        }
        if (_loc3_ != null) {
            hitAreaControl.x = _loc3_.x;
            hitAreaControl.y = _loc3_.y;
            hitAreaControl.width = _loc3_.width;
            hitAreaControl.height = _loc3_.height;
        }
    }

    private function updateVisibleState(param1:String, param2:IBuildingVO):void {
        if (this._model == null) {
            return;
        }
        if (param1 != param2.cooldown && !this.isInNormalMode() && !this._inDirectionMode) {
            this.showCooldown(this.isInCooldown());
        }
        this.updateCursorState();
        this._asserter.assertNotNull(this._model, "model" + Errors.CANT_NULL);
        this._model.validate();
        this._uid = this._model.uid;
        this.buildingCtxMenu();
        this.setState(this._model.progress);
        indicators.applyVOData(this._model);
        hitAreaControl.soundType = this._model.uid;
        if (this._inExporting && !this._model.isExportAvailable || this._inImporting && !this._model.isImportAvailable) {
            this.removeTransportingListeners();
        }
        this.updateEnabling();
    }

    private function updateCursorState():void {
        var _loc1_:Boolean = !this._userCanAddBuilding || this._model.isFortFrozen || this._model.isBaseBuildingDamaged;
        this._disableCursor = this.isTrowelState() && _loc1_;
    }

    private function initSelectedState():void {
        if (!this._selected && this._mouseOverTrigger) {
            if (this._requestOpenPopOver || this._requestOpenCtxMenu) {
                this._selected = true;
                this.updateSelectedState(this._selected);
            }
            else {
                this.setOverState();
            }
        }
        else {
            this.updateSelectedState(this._selected);
        }
        this.updateBlinkingBtn();
    }

    private function isInNormalMode():Boolean {
        return !this._inExporting && !this._inImporting && !this._inDirectionMode;
    }

    private function checkAnimationState():void {
        if (this._model && !this.isInNormalMode() && animationController.isPlayingAnimation) {
            animationController.resetAnimationType();
            this.updateBuildingState();
        }
    }

    private function updateEnabling():void {
        var _loc1_:Boolean = false;
        if (this._isInOverviewMode) {
            this.enableForOverview();
        }
        else {
            _loc1_ = true;
            if (this._model && this._model.isDefenceHour && this.isInNormalMode()) {
                this.disableDefenceHour();
            }
            else if (this.isInNormalMode()) {
                this.enableForAll();
            }
            else if (this._inDirectionMode) {
                this.disableForDirectionMode();
            }
            else if (this.isNotInCooldown()) {
                this.switchTransportingMode();
            }
            else {
                cooldownIcon.timeTextField.text = String(this._model.cooldown);
                this.disableForCooldown();
                _loc1_ = false;
            }
            this.updateOrderTime();
            if (_loc1_) {
                this.updateBlinkingBtn();
            }
        }
    }

    private function switchTransportingMode():void {
        var _loc1_:Boolean = this.isExportAvailable() && this._inExporting;
        var _loc2_:Boolean = this.isImportAvailable() && this._inImporting;
        var _loc3_:Boolean = (_loc1_ || _loc2_) && this.isNotTrowelState();
        if (_loc3_) {
            this.enableForTransporting();
        }
        else {
            this.disableForTransporting();
        }
    }

    private function isInCooldown():Boolean {
        return this._model != null && this._model.cooldown != null;
    }

    private function isNotInCooldown():Boolean {
        return !this.isInCooldown();
    }

    private function isTrowelState():Boolean {
        return this._model && this._model.progress == FORTIFICATION_ALIASES.STATE_TROWEL;
    }

    private function isNotTrowelState():Boolean {
        return !this.isTrowelState();
    }

    private function disableDefenceHour():void {
        trowel.alpha = 0;
        ground.alpha = ALPHA_ENABLED;
        this.updateInteractionEnabling(false);
        indicators.visible = this.isNotTrowelState();
        this.removeCommonBuildingListeners();
    }

    private function enableForOverview():void {
        buildingMc.building.alpha = ALPHA_ENABLED;
        buildingMc.blinkingButton.alpha = 0;
        hitAreaControl.buttonMode = false;
        hitAreaControl.useHandCursor = false;
        buildingMc.mouseEnabled = true;
        buildingMc.mouseChildren = true;
        buildingMc.buttonMode = false;
        buildingMc.useHandCursor = false;
        indicators.visible = this.isNotTrowelState();
        indicators.showBars = false;
        orderProcess.visible = false;
        hitAreaControl.removeEventListener(MouseEvent.CLICK, this.onHitAreaControlClickHandler);
    }

    private function enableForAll():void {
        buildingMc.building.alpha = ALPHA_ENABLED;
        buildingMc.blinkingButton.alpha = ALPHA_ENABLED;
        trowel.alpha = ALPHA_ENABLED;
        ground.alpha = ALPHA_ENABLED;
        this.updateInteractionEnabling(!this._disableCursor);
        indicators.visible = this.isNotTrowelState();
        this.addCommonBuildingListeners();
    }

    private function disableForDirectionMode():void {
        buildingMc.building.alpha = ALPHA_DISABLED;
        buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
        trowel.alpha = 0;
        ground.alpha = ALPHA_DISABLED;
        this.updateInteractionEnabling(false);
        indicators.visible = false;
        this.removeCommonBuildingListeners();
    }

    private function enableForTransporting():void {
        buildingMc.building.alpha = ALPHA_ENABLED;
        buildingMc.blinkingButton.alpha = ALPHA_ENABLED;
        trowel.alpha = 0;
        ground.alpha = ALPHA_DISABLED;
        this.updateInteractionEnabling(true);
        this.updateIndicatorsVisibility();
        this.removeCommonBuildingListeners();
    }

    private function disableForTransporting():void {
        buildingMc.building.alpha = ALPHA_DISABLED;
        buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
        trowel.alpha = 0;
        ground.alpha = ALPHA_DISABLED;
        this.updateInteractionEnabling(false);
        this.updateIndicatorsVisibility();
        this.removeCommonBuildingListeners();
    }

    private function disableForCooldown():void {
        buildingMc.building.alpha = ALPHA_DISABLED;
        buildingMc.blinkingButton.alpha = ALPHA_DISABLED;
        trowel.alpha = 0;
        this.updateInteractionEnabling(false);
        this.updateIndicatorsVisibility();
        this.removeCommonBuildingListeners();
    }

    private function showCooldown(param1:Boolean):void {
        var _loc2_:DisplayObject = null;
        if (cooldownIcon.visible != param1) {
            _loc2_ = DisplayObject(cooldownIcon);
            this._animator.removeAnims(_loc2_);
            if (param1) {
                cooldownIcon.timeTextField.text = String(this._model.cooldown);
                this._animator.addFadeInAnim(_loc2_, null);
            }
            else {
                this._animator.addFadeOutAnim(_loc2_, null);
            }
        }
    }

    private function updateInteractionEnabling(param1:Boolean):void {
        hitAreaControl.buttonMode = param1;
        hitAreaControl.useHandCursor = param1;
        buildingMc.mouseEnabled = param1;
        buildingMc.mouseChildren = param1;
        buildingMc.buttonMode = param1;
        buildingMc.useHandCursor = param1;
    }

    private function setOutState():void {
        if (!this._selected) {
            buildingMc.updateRollOutState();
            if (trowel.visible) {
                trowel.updateRollOutState();
            }
            if (this.isNotTrowelState()) {
                this.showIndicators(false);
            }
        }
    }

    private function setOverState():void {
        if (!this._selected) {
            buildingMc.updateRollOverState();
            if (trowel.visible) {
                trowel.updateRollOverState();
            }
            if (this.isNotTrowelState()) {
                this.showIndicators(true);
            }
        }
    }

    private function updateSelectedState(param1:Boolean):void {
        this.showIndicators(param1);
        if (buildingMc.selected != param1) {
            buildingMc.updatePressState = param1;
        }
        if (trowel.visible && trowel.selected != param1) {
            trowel.updatePressState = param1;
        }
    }

    private function showIndicators(param1:Boolean):void {
        this._animator.removeAnims(indicators.labels);
        if (param1) {
            if (indicators.visible && (!indicators.labels.visible || indicators.labels.alpha < 1)) {
                this._animator.addFadeInAnim(indicators.labels, this);
            }
        }
        else if (indicators.labels.visible && indicators.labels.stage) {
            this._animator.addFadeOutAnim(indicators.labels, this);
        }
    }

    private function updateIndicatorsVisibility():void {
        indicators.visible = this.isNotTrowelState();
        if (indicators.labels.visible != this.isNotTrowelState()) {
            this.showIndicators(indicators.visible);
        }
    }

    private function addCommonBuildingListeners():void {
        hitAreaControl.addEventListener(MouseEvent.ROLL_OUT, this.onHitAreaControlRollOutHandler);
        hitAreaControl.addEventListener(MouseEvent.ROLL_OVER, this.onHitAreaControlRollOverHandler);
        hitAreaControl.addEventListener(MouseEvent.CLICK, this.onHitAreaControlClickHandler);
    }

    private function removeCommonBuildingListeners():void {
        hitAreaControl.removeEventListener(MouseEvent.ROLL_OUT, this.onHitAreaControlRollOutHandler);
        hitAreaControl.removeEventListener(MouseEvent.ROLL_OVER, this.onHitAreaControlRollOverHandler);
        hitAreaControl.removeEventListener(MouseEvent.CLICK, this.onHitAreaControlClickHandler);
    }

    private function addTransportingListeners():void {
        hitAreaControl.addEventListener(MouseEvent.MOUSE_OVER, this.onHitAreaControlTooltipMouseOverHandler);
        hitAreaControl.addEventListener(MouseEvent.MOUSE_OUT, this.onHitAreaControlTooltipMouseOutHandler);
    }

    private function removeTransportingListeners():void {
        hitAreaControl.removeEventListener(MouseEvent.MOUSE_OVER, this.onHitAreaControlTooltipMouseOverHandler);
        hitAreaControl.removeEventListener(MouseEvent.MOUSE_OUT, this.onHitAreaControlTooltipMouseOutHandler);
    }

    private function removeAllListeners():void {
        this.removeCommonBuildingListeners();
        this.removeTransportingListeners();
    }

    private function buildingCtxMenu():void {
        this._showCtxMenu = this._model.progress >= FORTIFICATION_ALIASES.STATE_TROWEL && this._model.isOpenCtxMenu;
    }

    private function updateOrderTime():void {
        var _loc1_:Boolean = this.canShowOrderTime();
        var _loc2_:String = orderProcess.currentLabel;
        orderProcess.visible = _loc1_;
        if (_loc1_) {
            if (this._model && this._model.productionInPause) {
                this._scheduler.cancelTask(this.doHalfTurnHourglasses);
                orderProcess.rotation = 0;
                this._animator.removeAnims(orderProcess.hourglasses);
                orderProcess.gotoAndStop(FRAME_PAUSE);
            }
            else {
                if (_loc2_ != FRAME_NORMAL) {
                    orderProcess.gotoAndStop(FRAME_NORMAL);
                }
                if (orderProcess.rotation == 0) {
                    this.doHalfTurnHourglasses();
                }
            }
        }
        else if (!_loc1_) {
            this._animator.removeAnims(orderProcess.hourglasses);
        }
    }

    private function doHalfTurnHourglasses():void {
        if (orderProcess != null) {
            if (orderProcess.visible) {
                this._scheduler.scheduleTask(this.doHalfTurnHourglasses, HALF_TURN_SCHEDULER_TIME);
            }
            this._animator.removeAnims(orderProcess.hourglasses);
            orderProcess.hourglasses.rotation = 0;
            this._asserter.assertNotNull(orderProcess.hourglasses.stage, "building order hourglasses not on stage " + [name, stage, orderProcess, orderProcess.hourglasses]);
            this._animator.addHalfTurnAnim(orderProcess.hourglasses);
        }
    }

    private function canShowOrderTime():Boolean {
        return this._model != null && StringUtils.isNotEmpty(this._model.orderTime) && this.isInNormalMode();
    }

    private function isForceResetAnimation():Boolean {
        var _loc1_:Boolean = false;
        if (this._model.uid == FORTIFICATION_ALIASES.FORT_UNKNOWN && this._latestUID != null) {
            _loc1_ = true;
            this._latestUID = null;
        }
        if (this._model.uid != FORTIFICATION_ALIASES.FORT_UNKNOWN && this._latestUID == null) {
            this._latestUID = this._model.uid;
            _loc1_ = true;
        }
        if (this._model.buildingLevel > this._latestLevel && this._model.buildingLevel >= MIN_MODERNIZATION_LEVEL) {
            _loc1_ = true;
            this._latestLevel = this._model.buildingLevel;
        }
        return _loc1_;
    }

    private function isDemountOrBuildAnimation():Boolean {
        var _loc1_:String = null;
        if (this._model.animationType == FORTIFICATION_ALIASES.BUILD_FOUNDATION_ANIMATION) {
            animationController.setAnimationType(this._model.animationType, FORTIFICATION_ALIASES.FORT_FOUNDATION);
            this.updateBuildingState();
            return true;
        }
        if (this._model.animationType == FORTIFICATION_ALIASES.DEMOUNT_BUILDING_ANIMATION) {
            this.gotoBuildingState(this._model.progress, this._model.uid);
            trowel.visible = false;
            _loc1_ = this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF ? FORTIFICATION_ALIASES.FORT_FOUNDATION : buildingMc.currentState();
            animationController.setAnimationType(this._model.animationType, _loc1_);
            return true;
        }
        return false;
    }

    private function setState(param1:Number):void {
        this._asserter.assert(FORTIFICATION_ALIASES.STATES.indexOf(param1) != -1, "Unknown build state:" + param1, InfrastructureException);
        if (!this.isInNormalMode()) {
            this.updateBuildingState();
            return;
        }
        if (animationController.isPlayingAnimation) {
            if (this.isForceResetAnimation()) {
                this._lastState = -1;
                animationController.resetAnimationType();
            }
            else {
                this._model.animationType = FORTIFICATION_ALIASES.WITHOUT_ANIMATION;
                return;
            }
        }
        if (this._model.uid != FORTIFICATION_ALIASES.FORT_UNKNOWN) {
            this._latestUID = this._model.uid;
        }
        else {
            this._latestUID = null;
        }
        if (this._lastState != param1 && this._model.animationType > FORTIFICATION_ALIASES.WITHOUT_ANIMATION) {
            animationController.addEventListener(FortBuildingAnimationEvent.END_ANIMATION, this.onAnimationControllerEndAnimationHandler);
            if (this.isDemountOrBuildAnimation()) {
                return;
            }
        }
        this.checkUpgradeAnimation();
        this.updateBuildingState();
    }

    private function checkUpgradeAnimation():void {
        if (this._model.animationType == FORTIFICATION_ALIASES.UPGRADE_BUILDING_ANIMATION) {
            animationController.addEventListener(FortBuildingAnimationEvent.END_ANIMATION, this.onAnimationControllerEndAnimationHandler);
            animationController.setAnimationType(this._model.animationType, null);
            this._model.animationType = FORTIFICATION_ALIASES.WITHOUT_ANIMATION;
        }
    }

    private function updateBuildingState():void {
        if (this._lastState != this._model.progress) {
            this.gotoBuildingState(this._model.progress, this._model.uid);
        }
        this._lastState = this._model.progress;
        var _loc1_:* = this._model.progress == FORTIFICATION_ALIASES.STATE_TROWEL;
        trowel.label = FORTIFICATIONS.BUILDINGS_TROWELLABEL;
        trowel.visible = this._userCanAddBuilding && _loc1_ && !this._model.isFortFrozen && !this._model.isBaseBuildingDamaged;
        ground.visible = _loc1_;
        if (_loc1_) {
            buildingMc.removeEventListener(Event.COMPLETE, this.onBuildingMcCompleteHandler);
            dispatchEvent(new Event(Event.COMPLETE));
        }
        this.setCurrentBuildingState();
        this._latestLevel = this._model.buildingLevel;
    }

    private function setCurrentBuildingState():void {
        if (this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF || this._model.progress == FORTIFICATION_ALIASES.STATE_FOUNDATION) {
            buildingMc.setCurrentState(RES_FORT.MAPS_FORT_BUILDINGS_LARGE_FOUNDATION_STATE);
        }
        else if (this._model.progress == FORTIFICATION_ALIASES.STATE_BUILDING) {
            buildingMc.setCurrentState(this._model.iconSource);
            if (this._model.uid == FORTIFICATION_ALIASES.FORT_BASE_BUILDING) {
                buildingMc.setIconOffsets(FORT_BASE_ICON_OFFSET, 0);
            }
            else {
                buildingMc.setIconOffsets(0, 0);
            }
            if (!this.selected) {
                this.updateBlinkingBtn();
            }
        }
    }

    private function updateBlinkingBtn():void {
        buildingMc.setLevelUpState(this.canBlinking());
    }

    private function canBlinking():Boolean {
        var _loc1_:Boolean = false;
        if (this._model != null) {
            if (this._inExporting || this._inImporting) {
                _loc1_ = this._inExporting && this._model.isExportAvailable;
                _loc1_ = _loc1_ || this._inImporting && this._model.isImportAvailable && !exportArrow.isShowed;
                return !this.selected && _loc1_;
            }
            return !this.selected && this._model.isLevelUp;
        }
        return false;
    }

    private function callPopOver():void {
        if (!this._model || this._model.uid == FortBuildingConstants.FORT_UNKNOWN) {
            return;
        }
        var _loc1_:Object = {"uid": this._model.uid};
        if (this._popover.popoverCaller != this) {
            this._popover.show(this, FORTIFICATION_ALIASES.FORT_BUILDING_CARD_POPOVER_EVENT, _loc1_, this);
        }
        else {
            this._popover.hide();
        }
    }

    private function updateExternalRequest(param1:Boolean):void {
        this._requestOpenCtxMenu = param1;
        this._requestOpenPopOver = !param1;
    }

    private function dispatchBuyBuildingEvent():void {
        var _loc1_:FortBuildingEvent = new FortBuildingEvent(FortBuildingEvent.BUY_BUILDINGS);
        _loc1_.position = this._model.position;
        _loc1_.direction = this._model.direction;
        dispatchEvent(_loc1_);
    }

    private function onProcessingLeftButton():void {
        this.updateExternalRequest(false);
        this._contextMenu.hide();
        this.dispatchBuildingEvent();
    }

    private function onProcessingRightButton():void {
        this.updateExternalRequest(true);
        this._popover.hide();
        this._contextMenu.show(CONTEXT_MENU_HANDLER_TYPE.FORT_BUILDING, buildingMc, this._model);
        this._requestOpenCtxMenu = false;
        this.dispatchBuildingEvent();
    }

    private function dispatchBuildingEvent():void {
        var _loc1_:FortBuildingEvent = new FortBuildingEvent(FortBuildingEvent.BUILDING_SELECTED);
        _loc1_.uid = this.uid;
        _loc1_.isOpenedCtxMenu = this._requestOpenCtxMenu;
        dispatchEvent(_loc1_);
    }

    public function get buildingLevel():int {
        if (this._model != null) {
            return this._model.buildingLevel;
        }
        return 0;
    }

    public function set userCanAddBuilding(param1:Boolean):void {
        this._userCanAddBuilding = param1;
        if (this._model != null) {
            this.setState(this._model.progress);
        }
    }

    public function get uid():String {
        return this._uid;
    }

    public function set uid(param1:String):void {
        this._uid = param1;
    }

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        if (this._selected == param1) {
            return;
        }
        if (this._requestOpenPopOver) {
            this.callPopOver();
        }
        this._selected = param1;
        this.initSelectedState();
    }

    public function set toolTipDataProvider(param1:IBuildingToolTipDataProvider):void {
        this._toolTipDataProvider = param1;
    }

    public function set forceSelected(param1:Boolean):void {
        if (this._selected == param1) {
            return;
        }
        this.selected = param1;
    }

    private function onAnimationControllerEndAnimationHandler(param1:FortBuildingAnimationEvent):void {
        animationController.resetAnimationType();
        animationController.removeEventListener(FortBuildingAnimationEvent.END_ANIMATION, this.onAnimationControllerEndAnimationHandler);
        this.updateBuildingState();
    }

    private function onHitAreaControlMouseEventHandler(param1:MouseEvent):void {
        var _loc2_:String = "onTransportMouseEventHandler can be invoked in transporting mode only!";
        this._asserter.assert(this._inImporting || this._inExporting, _loc2_, InfrastructureException);
        var _loc3_:IArrowWithNut = null;
        if (this._inImporting) {
            _loc3_ = importArrow;
        }
        else if (this._inExporting) {
            _loc3_ = exportArrow;
        }
        if (param1.type == MouseEvent.MOUSE_OUT) {
            _loc3_.hide();
        }
        else if (param1.type == MouseEvent.MOUSE_OVER) {
            _loc3_.show();
        }
        else {
            throw new InfrastructureException("onTransportMouseEventHandler can not be handle \"" + param1.type + "\" event.");
        }
    }

    private function onHitAreaControlTooltipMouseOutHandler(param1:MouseEvent):void {
        this.setCurrentToolTip(null);
    }

    private function onHitAreaControlTooltipMouseOverHandler(param1:MouseEvent):void {
        if (this._model.transportTooltipData && this._model.transportTooltipData.length > 0) {
            this.setCurrentToolTip(TOOLTIP_TYPE_TRANSPORT);
        }
        else {
            this.updateToolTipState();
        }
    }

    private function onHitAreaControlRollOutHandler(param1:MouseEvent):void {
        this._mouseOverTrigger = false;
        this.setCurrentToolTip(null);
        if (!this._isInOverviewMode) {
            if (this.selected && !this._requestOpenPopOver && !this._requestOpenCtxMenu) {
                this.selected = false;
            }
            if (!this.selected) {
                this.setOutState();
            }
        }
    }

    private function onHitAreaControlRollOverHandler(param1:MouseEvent):void {
        this._mouseOverTrigger = true;
        if (!this._isInOverviewMode) {
            if (!this.selected) {
                this.setOverState();
            }
        }
        this.updateToolTipState();
    }

    private function onHitAreaControlClickHandler(param1:MouseEvent):void {
        if (!this._userCanAddBuilding && this._commons.isLeftButton(param1) && this.isTrowelState()) {
            return;
        }
        if (!this._model.isOpenCtxMenu && this._commons.isRightButton(param1)) {
            return;
        }
        if (this._model.progress == FORTIFICATION_ALIASES.STATE_TROWEL && this._userCanAddBuilding && !this._model.isFortFrozen && !this._model.isBaseBuildingDamaged && this._commons.isLeftButton(param1)) {
            this.dispatchBuyBuildingEvent();
            return;
        }
        if (this._commons.isRightButton(param1) && this._showCtxMenu) {
            if (this._isTutorial) {
                return;
            }
            this.onProcessingRightButton();
        }
        else if (this._commons.isLeftButton(param1)) {
            this.onProcessingLeftButton();
        }
    }

    private function onBuildingMcCompleteHandler(param1:Event):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}

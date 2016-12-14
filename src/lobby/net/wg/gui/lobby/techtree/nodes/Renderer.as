package net.wg.gui.lobby.techtree.nodes {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.EventPhase;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.ColorIndex;
import net.wg.gui.lobby.techtree.constants.IconTextResolver;
import net.wg.gui.lobby.techtree.constants.TTSoundID;
import net.wg.gui.lobby.techtree.controls.ActionButton;
import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
import net.wg.gui.lobby.techtree.data.state.StateProperties;
import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.math.MatrixPosition;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.InputEvent;
import scaleform.gfx.Extensions;
import scaleform.gfx.MouseEventEx;

public class Renderer extends SoundListItemRenderer implements IRenderer {

    private static const LINES_AND_ARROWS_NAME:String = "linesAndArrows";

    private static const STATE_PREFIX_SELECTED:String = "selected_";

    private static const STATE_UP:String = "up";

    private static const EMPTY_STR:String = "";

    public var actionPrice:ActionPrice;

    public var hit:MovieClip;

    public var button:ActionButton;

    private var _enabledChildren:Vector.<DisplayObjectContainer>;

    private var _stateProps:StateProperties;

    private var _dataInited:Boolean;

    private var _isDelegateEvents:Boolean = false;

    private var _container:INodesContainer = null;

    private var _entityType:uint = 0;

    private var _tooltipID:String = null;

    private var _doValidateNow:Boolean = false;

    private var _valueObject:NodeData;

    private var _matrixPosition:MatrixPosition;

    public function Renderer() {
        this._enabledChildren = new Vector.<DisplayObjectContainer>();
        Extensions.enabled = true;
        super();
        if (this.actionPrice) {
            this.actionPrice.visible = false;
        }
    }

    override protected function onDispose():void {
        this.container = null;
        if (this.button != null) {
            this.button.removeEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOverHandler, false);
            this.button.removeEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOutHandler, false);
            this.button.dispose();
            this.button = null;
        }
        if (this._isDelegateEvents && this.hit != null) {
            this.removeEventsHandlers();
        }
        if (this.actionPrice != null) {
            this.actionPrice.dispose();
            this.actionPrice = null;
        }
        this._enabledChildren.splice(0, this._enabledChildren.length);
        this._enabledChildren = null;
        this.hit = null;
        this._valueObject = null;
        this._dataInited = false;
        this._stateProps = null;
        this._matrixPosition = null;
        if (this._stateProps != null) {
            this._stateProps.dispose();
            this._stateProps = null;
        }
        this._container = null;
        super.onDispose();
    }

    override protected function preInitialize():void {
        preventAutosizing = false;
        constraintsDisabled = true;
        super.preInitialize();
        _state = STATE_UP;
        this._dataInited = false;
        soundType = TTSoundID.SUPER_TYPE;
        soundId = TTSoundID.UNDEFINED;
    }

    override protected function initialize():void {
        super.initialize();
        this.updateStatesProps();
    }

    override protected function configUI():void {
        if (this._isDelegateEvents && this.hit != null) {
            this.delegateEventsHandlers();
            if (App.soundMgr) {
                App.soundMgr.addSoundsHdlrs(this);
            }
        }
        else {
            super.configUI();
        }
    }

    override protected function draw():void {
        super.draw();
        if (!_baseDisposed) {
            if (isInvalid(InvalidationType.DATA)) {
                if (this._valueObject != null) {
                    visible = true;
                    this.populateUI();
                }
                else {
                    visible = false;
                }
            }
        }
    }

    override protected function updateAfterStateChange():void {
        if (this._isDelegateEvents) {
            this.disableMouseChildren();
        }
        super.updateAfterStateChange();
    }

    public function getActualWidth():Number {
        return this.hit != null ? Number(this.hit.width) : Number(_width);
    }

    public function getColorIdx(param1:Number = -1):Number {
        var _loc2_:Number = ColorIndex.LOCKED;
        if (this.isUnlocked()) {
            if (param1 == -1 || param1 > 0 && this.isParentUnlocked(param1)) {
                _loc2_ = ColorIndex.UNLOCKED;
            }
        }
        else if (this.isNext2Unlock()) {
            if (param1 == -1 || param1 > 0 && this.isParentUnlocked(param1)) {
                _loc2_ = ColorIndex.NEXT2UNLOCK;
            }
        }
        return _loc2_;
    }

    public function getColorIdxEx(param1:IRenderer):Number {
        var _loc2_:Number = ColorIndex.LOCKED;
        if (this.isUnlocked()) {
            if (param1 == null || param1.isUnlocked()) {
                _loc2_ = ColorIndex.UNLOCKED;
            }
        }
        else if (this.isNext2Unlock()) {
            if (param1 == null || param1.isUnlocked()) {
                _loc2_ = ColorIndex.NEXT2UNLOCK;
            }
        }
        return _loc2_;
    }

    public function getDisplayInfo():Object {
        return !!this._dataInited ? this._valueObject.displayInfo : null;
    }

    public function getEarnedXP():Number {
        return !!this._dataInited ? Number(this._valueObject.earnedXP) : Number(0);
    }

    public function getEntityType():uint {
        return this._entityType;
    }

    public function getExtraState():Object {
        return null;
    }

    public function getGraphicsName():String {
        return LINES_AND_ARROWS_NAME + this._entityType.toString() + _index.toString();
    }

    public function getID():Number {
        return !!this._dataInited ? Number(this._valueObject.id) : Number(0);
    }

    public function getIconPath():String {
        return !!this._dataInited ? this._valueObject.iconPath : EMPTY_STR;
    }

    public function getInX():Number {
        return Math.round(x + (this.hit != null ? this.hit.x : 0));
    }

    public function getItemName():String {
        return !!this._dataInited ? this._valueObject.nameString : EMPTY_STR;
    }

    public function getItemType():String {
        return !!this._dataInited ? this._valueObject.primaryClassName : EMPTY_STR;
    }

    public function getLevel():int {
        return !!this._dataInited ? int(this._valueObject.level) : -1;
    }

    public function getNamedLabel(param1:String):String {
        if (!this._dataInited) {
            return EMPTY_STR;
        }
        return this._valueObject.getNamedLabel(param1);
    }

    public function getNamedValue(param1:String):Number {
        if (!this._dataInited) {
            return 0;
        }
        return this._valueObject.getNamedValue(param1);
    }

    public function getOutX():Number {
        return x + (this.hit != null ? this.hit.x + Math.round(this.hit.width) : Math.round(_width));
    }

    public function getRatioY():Number {
        return this.hit != null ? Number(Math.round(this.hit.height) >> 1) : Number(Math.round(_height) >> 1);
    }

    public function getStatus():String {
        return !!this._dataInited ? this._valueObject.status : EMPTY_STR;
    }

    public function getStatusLevel():String {
        return !!this._dataInited ? this._valueObject.statusLevel : EMPTY_STR;
    }

    public function getY():Number {
        return y + (this.hit != null ? this.hit.y + (Math.round(this.hit.height) >> 1) : Math.round(_height) >> 1);
    }

    public function inInventory():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.IN_INVENTORY) > 0;
    }

    public function invalidateNodeState(param1:Number):void {
        this.updateStatesProps();
        setState(state);
        if (param1 > -1) {
            App.contextMenuMgr.hide();
            dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED, param1, _index, this._entityType));
        }
    }

    public function isActionEnabled():Boolean {
        if (!this._dataInited) {
            return false;
        }
        return this._stateProps.enough == 0 || (this._valueObject.state & this._stateProps.enough) > 0;
    }

    public function isAvailable4Buy():Boolean {
        if (!this._dataInited) {
            return false;
        }
        var _loc1_:Number = this._valueObject.state;
        return (_loc1_ & NODE_STATE_FLAGS.UNLOCKED) > 0 && (_loc1_ & NODE_STATE_FLAGS.ENOUGH_MONEY) > 0 && ((_loc1_ & NODE_STATE_FLAGS.IN_INVENTORY) == 0 || (_loc1_ & NODE_STATE_FLAGS.VEHICLE_IN_RENT) > 0);
    }

    public function isAvailable4Sell():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.CAN_SELL) > 0;
    }

    public function isAvailable4Unlock():Boolean {
        if (!this._dataInited) {
            return false;
        }
        var _loc1_:Number = this._valueObject.state;
        return (_loc1_ & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0 && (_loc1_ & NODE_STATE_FLAGS.ENOUGH_XP) > 0;
    }

    public function isButtonVisible():Boolean {
        return this._stateProps.visible && this._stateProps.animation == null;
    }

    public function isElite():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.ELITE) > 0;
    }

    public function isEnoughMoney():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.ENOUGH_MONEY) > 0;
    }

    public function isEnoughXp():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.ENOUGH_XP) > 0;
    }

    public function isFake():Boolean {
        return false;
    }

    public function isInAction():Boolean {
        return this.isShopAction() && (this.button != null && this._stateProps.visible);
    }

    public function isNext2Unlock():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0;
    }

    public function isParentUnlocked(param1:Number):Boolean {
        return this._container != null ? Boolean(this._container.isParentUnlocked(param1, this._valueObject.id)) : true;
    }

    public function isPremium():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.PREMIUM) > 0;
    }

    public function isRentAvailable():Boolean {
        if (!this._dataInited) {
            return false;
        }
        return (this._valueObject.state & NODE_STATE_FLAGS.RENT_AVAILABLE) > 0;
    }

    public function isRented():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.VEHICLE_IN_RENT) > 0;
    }

    public function isRestoreAvailable():Boolean {
        if (!this._dataInited) {
            return false;
        }
        return (this._valueObject.state & NODE_STATE_FLAGS.RESTORE_AVAILABLE) > 0;
    }

    public function isSelected():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.SELECTED) > 0;
    }

    public function isShopAction():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.SHOP_ACTION) > 0;
    }

    public function isUnlocked():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.UNLOCKED) > 0;
    }

    public function isVehicleCanBeChanged():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.VEHICLE_CAN_BE_CHANGED) > 0;
    }

    public function isWasInBattle():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.WAS_IN_BATTLE) > 0;
    }

    public function populateUI():void {
        var _loc1_:ActionPriceVO = null;
        if (this.actionPrice != null && this._dataInited) {
            _loc1_ = this._valueObject.getActionData(this._stateProps.label);
            this.actionPrice.visible = this.isInAction() && !this.isWasInBattle();
            if (_loc1_) {
                _loc1_.ico = IconTextResolver.getFromNamedLabel(this._stateProps.label);
            }
            this.actionPrice.setData(_loc1_);
            if (this._doValidateNow) {
                this.actionPrice.validateNow();
            }
        }
        this._doValidateNow = false;
        if (this.button != null) {
            this.button.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOverHandler, false, 0, true);
            this.button.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOutHandler, false, 0, true);
        }
    }

    public function setPosition(param1:Point):void {
        if (this.hit != null) {
            this.x = Math.round(param1.x - this.hit.x);
            this.y = Math.round(param1.y - this.hit.y);
        }
        else {
            this.x = param1.x;
            this.y = param1.y;
        }
    }

    public function setup(param1:uint, param2:NodeData, param3:uint = 0, param4:MatrixPosition = null):void {
        var _loc6_:Point = null;
        if (param3 != 0) {
            this._entityType = param3;
        }
        this._index = param1;
        this._matrixPosition = param4;
        if (this._valueObject == param2 || param2 == null) {
            return;
        }
        this._valueObject = param2;
        this._dataInited = true;
        this.updateStatesProps();
        setState(state);
        var _loc5_:Object = this.getDisplayInfo();
        if (_loc5_ != null && _loc5_ is NTDisplayInfo) {
            _loc6_ = NTDisplayInfo(_loc5_).position;
            if (_loc6_ != null) {
                this.setPosition(_loc6_);
            }
        }
    }

    public function showContextMenu():void {
    }

    public function validateNowEx():void {
        this._doValidateNow = true;
        super.validateNow();
    }

    protected function getMouseEnabledChildren():Vector.<DisplayObjectContainer> {
        this._enabledChildren.splice(0, this._enabledChildren.length);
        if (this.hit != null) {
            this._enabledChildren.push(this.hit);
        }
        if (this.button != null) {
            this._enabledChildren.push(this.button);
        }
        return this._enabledChildren;
    }

    private function disableMouseChildren():void {
        var _loc1_:DisplayObject = null;
        var _loc2_:DisplayObjectContainer = null;
        var _loc3_:Vector.<DisplayObjectContainer> = this.getMouseEnabledChildren();
        var _loc4_:int = numChildren;
        var _loc5_:Number = 0;
        while (_loc5_ < _loc4_) {
            _loc1_ = getChildAt(_loc5_);
            if (_loc1_ is DisplayObjectContainer && _loc3_.indexOf(_loc1_) == -1) {
                _loc2_ = DisplayObjectContainer(_loc1_);
                _loc2_.mouseEnabled = _loc2_.mouseChildren = false;
            }
            _loc5_++;
        }
    }

    private function delegateEventsHandlers():void {
        mouseEnabled = false;
        this.disableMouseChildren();
        this.hit.buttonMode = this.hit.mouseEnabled = true;
        this.hit.addEventListener(MouseEvent.ROLL_OVER, this.onHitRollOverHandler, false, 0, true);
        this.hit.addEventListener(MouseEvent.ROLL_OUT, this.onHitRollOutHandler, false, 0, true);
        this.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.onHitMouseDownHandler, false, 0, true);
        this.hit.addEventListener(MouseEvent.CLICK, this.onHitClickHandler, false, 0, true);
        this.hit.addEventListener(MouseEvent.DOUBLE_CLICK, this.onHitDoubleClickHandler, false, 0, true);
        this.hit.addEventListener(InputEvent.INPUT, this.onHitInputHandler, false, 0, true);
    }

    private function removeEventsHandlers():void {
        this.hit.removeEventListener(MouseEvent.ROLL_OVER, this.onHitRollOverHandler, false);
        this.hit.removeEventListener(MouseEvent.ROLL_OUT, this.onHitRollOutHandler, false);
        this.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHitMouseDownHandler, false);
        this.hit.removeEventListener(MouseEvent.CLICK, this.onHitClickHandler, false);
        this.hit.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onHitDoubleClickHandler, false);
        this.hit.removeEventListener(InputEvent.INPUT, this.onHitInputHandler, false);
    }

    private function updateStatesProps():void {
        this._stateProps = NodeStateCollection.getStateProps(this._entityType, !!this._dataInited ? Number(this._valueObject.state) : Number(0), this.getExtraState());
        var _loc1_:String = NodeStateCollection.getStatePrefix(this._stateProps.index);
        statesSelected = Vector.<String>([STATE_PREFIX_SELECTED, _loc1_]);
        statesDefault = Vector.<String>([_loc1_]);
    }

    public function get stateProps():StateProperties {
        return this._stateProps;
    }

    public function get dataInited():Boolean {
        return this._dataInited;
    }

    public function set isDelegateEvents(param1:Boolean):void {
        this._isDelegateEvents = param1;
    }

    public function get container():INodesContainer {
        return this._container;
    }

    public function set container(param1:INodesContainer):void {
        this._container = param1;
    }

    public function get entityType():uint {
        return this._entityType;
    }

    public function set entityType(param1:uint):void {
        this._entityType = param1;
    }

    public function set tooltipID(param1:String):void {
        this._tooltipID = param1;
    }

    public function get doValidateNow():Boolean {
        return this._doValidateNow;
    }

    public function get valueObject():NodeData {
        return this._valueObject;
    }

    public function get matrixPosition():MatrixPosition {
        return this._matrixPosition;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        if (this._tooltipID && this._valueObject && this._valueObject.dataIsReady && App.toolTipMgr != null) {
            App.toolTipMgr.showSpecial(this._tooltipID, null, this._valueObject, this._container != null ? this._container.getRootNode().getID() : null);
        }
        super.handleMouseRollOver(param1);
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        if (App.toolTipMgr != null) {
            App.toolTipMgr.hide();
        }
        super.handleMouseRollOut(param1);
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        super.handleMouseRelease(param1);
        if (param1.eventPhase == EventPhase.AT_TARGET && param1 is MouseEventEx && App.utils.commons.isRightButton(param1)) {
            this.showContextMenu();
        }
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        if (App.toolTipMgr != null) {
            App.toolTipMgr.hide();
        }
        super.handleMousePress(param1);
    }

    private function onHitInputHandler(param1:InputEvent):void {
        handleInput(param1);
    }

    private function onHitDoubleClickHandler(param1:MouseEvent):void {
        this.handleMouseRelease(param1);
    }

    private function onHitClickHandler(param1:MouseEvent):void {
        this.handleMouseRelease(param1);
    }

    private function onHitMouseDownHandler(param1:MouseEvent):void {
        this.handleMousePress(param1);
    }

    private function onHitRollOutHandler(param1:MouseEvent):void {
        this.handleMouseRollOut(param1);
    }

    private function onButtonMouseOutHandler(param1:MouseEvent):void {
        if (this.actionPrice != null) {
            this.actionPrice.hideTooltip();
        }
    }

    private function onButtonMouseOverHandler(param1:MouseEvent):void {
        if (this.actionPrice != null && this.actionPrice.visible) {
            this.actionPrice.showTooltip();
        }
    }

    private function onHitRollOverHandler(param1:MouseEvent):void {
        this.handleMouseRollOver(param1);
    }
}
}

package net.wg.gui.lobby.vehicleCompare.nodes {
import flash.display.MovieClip;
import flash.geom.Point;

import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
import net.wg.gui.lobby.techtree.math.MatrixPosition;

import scaleform.clik.constants.InvalidationType;

public class ModuleRenderer extends SoundListItemRenderer implements IRenderer {

    public static const LINES_AND_ARROWS_NAME:String = "linesAndArrows";

    private static const STATE_UP:String = "up";

    public var hit:MovieClip;

    private var _dataInited:Boolean;

    private var _container:IResearchContainer = null;

    private var _entityType:uint = 0;

    private var _valueObject:NodeData;

    private var _matrixPosition:MatrixPosition;

    public function ModuleRenderer() {
        super();
    }

    override protected function onDispose():void {
        hitArea = null;
        this.hit = null;
        this._valueObject = null;
        this._dataInited = false;
        this._matrixPosition = null;
        this._container = null;
        super.onDispose();
    }

    override protected function preInitialize():void {
        constraintsDisabled = true;
        super.preInitialize();
        _state = STATE_UP;
        this._dataInited = false;
    }

    override protected function configUI():void {
        super.configUI();
        hitArea = this.hit;
    }

    override protected function draw():void {
        super.draw();
        if (!_baseDisposed) {
            if (isInvalid(InvalidationType.DATA)) {
                if (this._valueObject != null) {
                    visible = true;
                    this.applyData();
                }
                else {
                    visible = false;
                }
            }
        }
    }

    public function applyData():void {
    }

    public function getActualWidth():Number {
        return this.hit != null ? Number(this.hit.width) : Number(_width);
    }

    public function getColorIdx(param1:Number = -1):Number {
        return 0;
    }

    public function getColorIdxEx(param1:IRenderer):Number {
        return 0;
    }

    public function getDisplayInfo():Object {
        return !!this._dataInited ? this._valueObject.displayInfo : null;
    }

    public function getEarnedXP():Number {
        return 0;
    }

    public function getEntityType():uint {
        return this._entityType;
    }

    public function getGraphicsName():String {
        return LINES_AND_ARROWS_NAME + this._entityType.toString() + _index.toString();
    }

    public function getID():Number {
        return !!this._dataInited ? Number(this._valueObject.id) : Number(0);
    }

    public function getIconPath():String {
        return !!this._dataInited ? this._valueObject.iconPath : "";
    }

    public function getInX():Number {
        return Math.round(x + (this.hit != null ? this.hit.x : 0));
    }

    public function getItemName():String {
        return !!this._dataInited ? this._valueObject.nameString : "";
    }

    public function getItemType():String {
        return !!this._dataInited ? this._valueObject.primaryClassName : "";
    }

    public function getLevel():int {
        return !!this._dataInited ? int(this._valueObject.level) : -1;
    }

    public function getNamedLabel(param1:String):String {
        return "";
    }

    public function getNamedValue(param1:String):Number {
        return NaN;
    }

    public function getOutX():Number {
        return x + (this.hit != null ? this.hit.x + Math.round(this.hit.width) : Math.round(_width));
    }

    public function getRatioY():Number {
        return this.hit != null ? Number(Math.round(this.hit.height) >> 1) : Number(Math.round(_height) >> 1);
    }

    public function getY():Number {
        return y + (this.hit != null ? this.hit.y + (Math.round(this.hit.height) >> 1) : Math.round(_height) >> 1);
    }

    public function inInventory():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.IN_INVENTORY) > 0;
    }

    public function invalidateNodeState(param1:Number):void {
        setState(state);
        if (param1 > -1) {
            App.contextMenuMgr.hide();
            dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED, param1, _index, this._entityType));
        }
    }

    public function isActionEnabled():Boolean {
        return false;
    }

    public function isAvailable4Buy():Boolean {
        return false;
    }

    public function isAvailable4Sell():Boolean {
        return false;
    }

    public function isAvailable4Unlock():Boolean {
        return false;
    }

    public function isButtonVisible():Boolean {
        return false;
    }

    public function isElite():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.ELITE) > 0;
    }

    public function isFake():Boolean {
        return false;
    }

    public function isNext2Unlock():Boolean {
        return false;
    }

    public function isPremium():Boolean {
        return false;
    }

    public function isRented():Boolean {
        return false;
    }

    public function isSelected():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.SELECTED) > 0;
    }

    public function isUnlocked():Boolean {
        return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.UNLOCKED) > 0;
    }

    public function isVehicleCanBeChanged():Boolean {
        return false;
    }

    public function isWasInBattle():Boolean {
        return false;
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
        setState(state);
        var _loc5_:Object = this.getDisplayInfo();
        if (_loc5_ != null && _loc5_ is NTDisplayInfo) {
            _loc6_ = NTDisplayInfo(_loc5_).position;
            if (_loc6_ != null) {
                this.setPosition(_loc6_);
            }
        }
    }

    public function validateNowEx():void {
        super.validateNow();
    }

    public function get container():INodesContainer {
        return this._container;
    }

    public function set container(param1:INodesContainer):void {
        this._container = IResearchContainer(param1);
    }

    public function get matrixPosition():MatrixPosition {
        return this._matrixPosition;
    }

    public function get valueObject():NodeData {
        return this._valueObject;
    }

    public function get entityType():uint {
        return this._entityType;
    }

    public function set entityType(param1:uint):void {
        this._entityType = param1;
    }
}
}

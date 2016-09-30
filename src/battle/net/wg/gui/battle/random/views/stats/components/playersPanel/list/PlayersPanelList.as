package net.wg.gui.battle.random.views.stats.components.playersPanel.list {
import flash.display.Sprite;

import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.Errors;
import net.wg.data.constants.PlayerStatus;
import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelListEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
import net.wg.gui.battle.views.minimap.MinimapEntryController;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class PlayersPanelList extends Sprite implements IDisposable {

    private static const ITEM_HEIGHT:int = 25;

    private var _state:int = 0;

    private var _items:Vector.<IPlayersPanelListItemHolder> = null;

    private var _panelListItems:Vector.<PlayersPanelListItem> = null;

    private var _currOrder:Vector.<Number> = null;

    private var _itemUnderMouse:PlayersPanelListItem = null;

    private var _isInviteReceived:Boolean = false;

    private var _isVehicleLevelVisible:Boolean = true;

    private var _isInteractive:Boolean = false;

    private var _isInviteShown:Boolean = false;

    private var _isCursorVisible:Boolean = false;

    public var inviteReceivedIndicator:InviteReceivedIndicator;

    public function PlayersPanelList() {
        super();
        this._state = PLAYERS_PANEL_STATE.FULL;
        this._items = new Vector.<IPlayersPanelListItemHolder>();
        this._panelListItems = new Vector.<PlayersPanelListItem>();
        this._currOrder = new Vector.<Number>();
        this.inviteReceivedIndicator.visible = false;
    }

    public function get state():int {
        return this._state;
    }

    public function set state(param1:int):void {
        var _loc2_:IPlayersPanelListItemHolder = null;
        if (this._state == param1) {
            return;
        }
        for each(_loc2_ in this._items) {
            _loc2_.listItem.setState(param1);
        }
        this._state = param1;
        this.updateInviteIndicator();
    }

    public function setIsInteractive(param1:Boolean):void {
        var _loc2_:IPlayersPanelListItemHolder = null;
        if (this._isInteractive == param1) {
            return;
        }
        this._isInteractive = param1;
        for each(_loc2_ in this._items) {
            _loc2_.listItem.setIsInteractive(param1);
        }
    }

    public function setIsCursorVisible(param1:Boolean):void {
        var _loc2_:IPlayersPanelListItemHolder = null;
        if (this._isCursorVisible == param1) {
            return;
        }
        this._isCursorVisible = param1;
        this.setMouseListenersEnabled(param1);
        if (this._itemUnderMouse) {
            if (this._isCursorVisible) {
                _loc2_ = this._items[this._itemUnderMouse.holderItemID];
                MinimapEntryController.instance.highlight(_loc2_.vehicleID);
            }
            else {
                this._itemUnderMouse = null;
                MinimapEntryController.instance.unhighlight();
            }
        }
    }

    public function setIsInviteShown(param1:Boolean):void {
        var _loc2_:IPlayersPanelListItemHolder = null;
        if (this._isInviteShown == param1) {
            return;
        }
        this._isInviteShown = param1;
        for each(_loc2_ in this._items) {
            _loc2_.listItem.setIsInviteShown(param1);
        }
    }

    public function setVehicleLevelVisible(param1:Boolean):void {
        var _loc2_:IPlayersPanelListItemHolder = null;
        if (this._isVehicleLevelVisible == param1) {
            return;
        }
        for each(_loc2_ in this._items) {
            _loc2_.listItem.setVehicleLevelVisible(param1);
        }
        this._isVehicleLevelVisible = param1;
    }

    public function setVehicleData(param1:Vector.<DAAPIVehicleInfoVO>):void {
        var _loc3_:DAAPIVehicleInfoVO = null;
        var _loc4_:IPlayersPanelListItemHolder = null;
        var _loc2_:uint = this._items.length;
        for each(_loc3_ in param1) {
            _loc4_ = this.getHolderByVehicleID(_loc3_.vehicleID);
            if (_loc4_) {
                _loc4_.setVehicleData(_loc3_);
            }
            else {
                this.addItem(_loc3_, _loc2_);
                _loc2_++;
            }
        }
        this.updatePlayerNameWidth();
        this.updateInviteIndicator();
        dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_COUNT_CHANGE, 0));
    }

    public function setFrags(param1:Number, param2:int):void {
        var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
        if (_loc3_) {
            _loc3_.setFrags(param2);
        }
    }

    public function updateOrder(param1:Vector.<Number>):void {
        if (!param1 || !this.checkIfOrderIsValid(param1)) {
            return;
        }
        var _loc2_:int = this._items.length;
        var _loc3_:Number = 0;
        var _loc4_:PlayersPanelListItemHolder = null;
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_) {
            _loc3_ = param1[_loc5_];
            if (this._currOrder[_loc5_] != _loc3_) {
                _loc4_ = this.getHolderByVehicleID(_loc3_);
                if (_loc4_) {
                    _loc4_.listItem.y = ITEM_HEIGHT * _loc5_;
                    this._currOrder[_loc5_] = _loc3_;
                }
            }
            _loc5_++;
        }
    }

    public function setInvitationStatus(param1:Number, param2:uint):void {
        var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
        if (!_loc3_) {
            return;
        }
        _loc3_.setInvitationStatus(param2);
        if (_loc3_.isInviteReceived) {
            this._isInviteReceived = true;
        }
        else {
            this._isInviteReceived = false;
            for each(_loc3_ in this._items) {
                if (_loc3_.isInviteReceived) {
                    this._isInviteReceived = true;
                    break;
                }
            }
        }
        this.updateInviteIndicator();
    }

    public function setPlayerStatus(param1:Number, param2:uint):void {
        var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
        if (_loc3_) {
            _loc3_.setPlayerStatus(param2);
        }
    }

    public function setUserTags(param1:Number, param2:Array):void {
        var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
        if (_loc3_) {
            _loc3_.setUserTags(param2);
        }
    }

    public function setVehicleStatus(param1:Number, param2:uint):void {
        var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
        if (_loc3_) {
            _loc3_.setVehicleStatus(param2);
        }
    }

    public function setSpeaking(param1:Number, param2:Boolean):void {
        var _loc3_:IPlayersPanelListItemHolder = this.getHolderByAccountID(param1);
        if (_loc3_) {
            _loc3_.listItem.setIsSpeaking(param2);
        }
    }

    public function get itemsHeight():Number {
        return this._items.length * ITEM_HEIGHT;
    }

    public function updateColorBlind():void {
        var _loc1_:PlayersPanelListItemHolder = null;
        for each(_loc1_ in this._items) {
            _loc1_.listItem.updateColorBlind();
        }
    }

    public function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        var _loc3_:PlayersPanelListItem = null;
        this.setMouseListenersEnabled(false);
        this.inviteReceivedIndicator.dispose();
        this.inviteReceivedIndicator = null;
        this._itemUnderMouse = null;
        var _loc1_:int = this._items.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._items[_loc2_].dispose();
            _loc2_++;
        }
        this._items.length = 0;
        this._currOrder.length = 0;
        for each(_loc3_ in this._panelListItems) {
            _loc3_.dispose();
        }
        if (this._panelListItems) {
            this._panelListItems.splice(0, this._panelListItems.length);
            this._panelListItems = null;
        }
        this._items = null;
        this._currOrder = null;
    }

    protected function get itemLinkage():String {
        throw new AbstractException(Errors.ABSTRACT_INVOKE);
    }

    protected function get isRightAligned():Boolean {
        throw new AbstractException(Errors.ABSTRACT_INVOKE);
    }

    private function onPlayersPanelItemOverHandler(param1:PlayersPanelItemEvent):void {
        var _loc2_:IPlayersPanelListItemHolder = this._items[param1.holderItemID];
        this._itemUnderMouse = param1.playersListItem;
        MinimapEntryController.instance.highlight(_loc2_.vehicleID);
    }

    private function onPlayersPanelItemOutHandler(param1:PlayersPanelItemEvent):void {
        this._itemUnderMouse = null;
        MinimapEntryController.instance.unhighlight();
    }

    private function onPlayersPanelItemClickHandler(param1:PlayersPanelItemEvent):void {
        var _loc2_:IPlayersPanelListItemHolder = this._items[param1.holderItemID];
        if (App.utils.commons.isRightButton(param1.mEvent)) {
            if (!PlayerStatus.isActionDisabled(_loc2_.playerStatus) && !_loc2_.isCurrentPlayer) {
                param1.playersListItem.dynamicSquad.onItemOut();
                App.contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL, this, new PlayersPanelContextMenuSentData(_loc2_.vehicleID));
                MinimapEntryController.instance.unhighlight();
                App.toolTipMgr.hide();
            }
        }
        else {
            dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED, _loc2_.vehicleID));
        }
    }

    private function addItem(param1:DAAPIVehicleInfoVO, param2:uint):void {
        var _loc3_:PlayersPanelListItem = App.utils.classFactory.getComponent(this.itemLinkage, PlayersPanelListItem);
        _loc3_.setIsInviteShown(this._isInviteShown);
        _loc3_.setIsInteractive(this._isInteractive);
        _loc3_.setVehicleLevelVisible(this._isVehicleLevelVisible);
        _loc3_.setState(this._state);
        _loc3_.y = this._items.length * ITEM_HEIGHT;
        _loc3_.setIsRightAligned(this.isRightAligned);
        _loc3_.holderItemID = param2;
        addChild(_loc3_);
        this._panelListItems.push(_loc3_);
        var _loc4_:IPlayersPanelListItemHolder = new PlayersPanelListItemHolder(_loc3_);
        _loc4_.setVehicleData(param1);
        this._items.push(_loc4_);
        this._currOrder.push(param1.vehicleID);
    }

    private function setMouseListenersEnabled(param1:Boolean):void {
        var _loc2_:PlayersPanelListItem = null;
        if (param1) {
            for each(_loc2_ in this._panelListItems) {
                _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OVER, this.onPlayersPanelItemOverHandler);
                _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OUT, this.onPlayersPanelItemOutHandler);
                _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK, this.onPlayersPanelItemClickHandler);
            }
        }
        else {
            for each(_loc2_ in this._panelListItems) {
                _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OVER, this.onPlayersPanelItemOverHandler);
                _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OUT, this.onPlayersPanelItemOutHandler);
                _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK, this.onPlayersPanelItemClickHandler);
            }
        }
    }

    private function updatePlayerNameWidth():void {
        var _loc3_:int = 0;
        var _loc1_:int = this._items.length;
        if (!_loc1_) {
            return;
        }
        var _loc2_:Number = 0;
        _loc3_ = 0;
        while (_loc3_ < _loc1_) {
            _loc2_ = Math.max(_loc2_, this._items[_loc3_].listItem.getPlayerNameFullWidth());
            _loc3_++;
        }
        _loc3_ = 0;
        while (_loc3_ < _loc1_) {
            this._items[_loc3_].listItem.setPlayerNameFullWidth(_loc2_);
            _loc3_++;
        }
    }

    private function updateInviteIndicator():void {
        this.inviteReceivedIndicator.visible = this.state == PLAYERS_PANEL_STATE.HIDEN && this._isInviteReceived;
    }

    private function getHolderByVehicleID(param1:Number):PlayersPanelListItemHolder {
        var _loc2_:PlayersPanelListItemHolder = null;
        for each(_loc2_ in this._items) {
            if (_loc2_.vehicleID == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    private function getHolderByAccountID(param1:Number):PlayersPanelListItemHolder {
        var _loc2_:PlayersPanelListItemHolder = null;
        for each(_loc2_ in this._items) {
            if (_loc2_.accDBID == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    private function checkIfOrderIsValid(param1:Vector.<Number>):Boolean {
        var _loc2_:int = param1.length;
        if (_loc2_ != this._currOrder.length) {
            return false;
        }
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (this._currOrder.indexOf(param1[_loc3_]) == -1) {
                return false;
            }
            _loc3_++;
        }
        return true;
    }
}
}

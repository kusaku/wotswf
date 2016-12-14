package net.wg.gui.lobby.christmas.dragDrop {
import flash.display.InteractiveObject;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

import net.wg.data.constants.Cursors;
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.event.ChristmasDropEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropActor;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropDelegate;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropItem;
import net.wg.infrastructure.events.DropEvent;
import net.wg.infrastructure.exceptions.ArgumentException;
import net.wg.infrastructure.interfaces.ICursor;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.interfaces.entity.IDropItem;
import net.wg.infrastructure.interfaces.entity.IUpdatable;
import net.wg.utils.IAssertable;

import org.idmedia.as3commons.util.StringUtils;

public class ChristmasDragDropController extends EventDispatcher implements IDisposable {

    private static const DROP_SOURCE_ALPHA:Number = 0.3;

    private static const DEFAULT_DROP_SOURCE_ALPHA:Number = 1;

    private var _dropActors:Vector.<IChristmasDropActor> = null;

    private var _delegates:Vector.<IChristmasDropDelegate> = null;

    private var _currentDroppedItem:IChristmasDropItem = null;

    private var _asserter:IAssertable;

    private var _canReceiveFunc:Function;

    private var _dropDelegateClass:Class;

    private var _dropElementLinkage:String;

    public function ChristmasDragDropController(param1:Class, param2:String, param3:Function) {
        super();
        this._canReceiveFunc = param3;
        this._asserter = App.utils.asserter;
        this.assertLinkage(param2);
        this._dropDelegateClass = param1;
        this._dropElementLinkage = param2;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function setDropActors(param1:Vector.<IChristmasDropActor>):void {
        var _loc2_:IChristmasDropDelegate = null;
        var _loc4_:IChristmasDropActor = null;
        this.tryClearActors();
        this.tryClearDelegates();
        this._dropActors = param1;
        this._delegates = new Vector.<IChristmasDropDelegate>(0);
        var _loc3_:ICursor = App.cursor;
        for each(_loc4_ in param1) {
            _loc2_ = new this._dropDelegateClass(InteractiveObject(_loc4_), this._dropElementLinkage);
            _loc2_.setDropReceivers(new Vector.<InteractiveObject>(0));
            _loc3_.registerDragging(_loc2_, Cursors.DRAG_CLOSE);
            _loc2_.addEventListener(DropEvent.BEFORE_DROP, this.onDelegateBeforeDropHandler);
            _loc2_.addEventListener(DropEvent.START_DROP, this.onDelegateStartDropHandler);
            _loc2_.addEventListener(DropEvent.AFTER_DROP, this.onDelegateAfterDropHandler);
            _loc2_.addEventListener(DropEvent.END_DROP, this.onDelegateEndDropHandler);
            this._delegates.push(_loc2_);
        }
    }

    protected function onDispose():void {
        this.tryClearDelegates();
        this.tryClearActors();
        this._currentDroppedItem = null;
        this._asserter = null;
        this._canReceiveFunc = null;
        this._dropDelegateClass = null;
    }

    private function tryClearActors():void {
        var _loc1_:IChristmasDropActor = null;
        if (this._dropActors != null) {
            for each(_loc1_ in this._dropActors) {
                this.removeReceiverListeners(_loc1_);
            }
            this._dropActors.splice(0, this._dropActors.length);
            this._dropActors = null;
        }
    }

    private function tryClearDelegates():void {
        var _loc1_:ICursor = null;
        var _loc2_:IChristmasDropDelegate = null;
        if (this._delegates != null) {
            _loc1_ = App.cursor;
            for each(_loc2_ in this._delegates) {
                _loc2_.removeEventListener(DropEvent.BEFORE_DROP, this.onDelegateBeforeDropHandler);
                _loc2_.removeEventListener(DropEvent.START_DROP, this.onDelegateStartDropHandler);
                _loc2_.removeEventListener(DropEvent.AFTER_DROP, this.onDelegateAfterDropHandler);
                _loc2_.removeEventListener(DropEvent.END_DROP, this.onDelegateEndDropHandler);
                _loc1_.unRegisterDragging(_loc2_);
                _loc2_.dispose();
            }
            this._delegates.splice(0, this._delegates.length);
            this._delegates = null;
        }
    }

    private function getFilteredReceivers(param1:DecorationInfoVO, param2:IChristmasDropActor = null):Vector.<IChristmasDropActor> {
        var _loc4_:IChristmasDropActor = null;
        var _loc3_:Vector.<IChristmasDropActor> = new Vector.<IChristmasDropActor>(0);
        for each(_loc4_ in this._dropActors) {
            if (!(param2 != null && _loc4_ == param2)) {
                if (this._canReceiveFunc(_loc4_, param1.slotType)) {
                    _loc3_.push(_loc4_);
                }
            }
        }
        return _loc3_;
    }

    private function assertLinkage(param1:String):void {
        if (StringUtils.isEmpty(param1)) {
            this._asserter.assert(false, "dropElementLinkage must has correct linkage value!", ArgumentException);
        }
    }

    private function assertNotNull(param1:Object, param2:String):void {
        if (param1 == null) {
            this._asserter.assertNotNull(false, param2 + Errors.CANT_EMPTY);
        }
    }

    private function addReceiverListeners(param1:IChristmasDropActor):void {
        param1.addEventListener(MouseEvent.ROLL_OVER, this.onReceiverRollOverHandler);
        param1.addEventListener(MouseEvent.ROLL_OUT, this.onReceiverRollOutHandler);
    }

    private function removeReceiverListeners(param1:IChristmasDropActor):void {
        param1.removeEventListener(MouseEvent.ROLL_OVER, this.onReceiverRollOverHandler);
        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onReceiverRollOutHandler);
    }

    private function onReceiverRollOverHandler(param1:MouseEvent):void {
        var _loc2_:IChristmasDropActor = null;
        if (this._currentDroppedItem != null) {
            _loc2_ = IChristmasDropActor(param1.currentTarget);
            _loc2_.highlightDropHover();
        }
    }

    private function onReceiverRollOutHandler(param1:MouseEvent):void {
        var _loc2_:IChristmasDropActor = null;
        if (this._currentDroppedItem != null) {
            _loc2_ = IChristmasDropActor(param1.currentTarget);
            _loc2_.highlightDropping();
        }
    }

    private function onDelegateBeforeDropHandler(param1:DropEvent):void {
        var _loc4_:IChristmasDropActor = null;
        var _loc2_:IChristmasDropDelegate = IChristmasDropDelegate(param1.currentTarget);
        this._currentDroppedItem = ChristmasDragDropUtils.instance.getDropItem(param1.draggedItem);
        var _loc3_:Vector.<IChristmasDropActor> = this.getFilteredReceivers(this._currentDroppedItem.decorationInfo, IChristmasDropActor(_loc2_.getHitArea()));
        _loc2_.setDropReceivers(Vector.<InteractiveObject>(_loc3_));
        for each(_loc4_ in _loc3_) {
            _loc4_.highlightDropping();
            this.addReceiverListeners(_loc4_);
        }
    }

    private function onDelegateAfterDropHandler(param1:DropEvent):void {
        var _loc2_:IChristmasDropActor = null;
        this.assertNotNull(this._currentDroppedItem, "_currentDroppedItem");
        for each(_loc2_ in this._dropActors) {
            _loc2_.hideHighlight();
            this.removeReceiverListeners(_loc2_);
        }
        IChristmasDropDelegate(param1.currentTarget).setDropReceivers(new Vector.<InteractiveObject>(0));
        param1.sender.alpha = DEFAULT_DROP_SOURCE_ALPHA;
        this._currentDroppedItem = null;
    }

    private function onDelegateEndDropHandler(param1:DropEvent):void {
        this.assertNotNull(this._currentDroppedItem, "_currentDroppedItem");
        var _loc2_:IChristmasDropActor = IChristmasDropActor(param1.sender);
        var _loc3_:IChristmasDropActor = IChristmasDropActor(param1.receiver);
        dispatchEvent(new ChristmasDropEvent(ChristmasDropEvent.ITEM_DROPPED, _loc2_, _loc3_, this._currentDroppedItem.decorationInfo));
    }

    private function onDelegateStartDropHandler(param1:DropEvent):void {
        var _loc2_:IDropItem = ChristmasDragDropUtils.instance.getDropItem(param1.draggedItem);
        var _loc3_:IUpdatable = IUpdatable(App.cursor.getAttachedSprite());
        if (_loc2_ != null && _loc3_ != null) {
            param1.sender.alpha = DROP_SOURCE_ALPHA;
            _loc3_.update(_loc2_.data);
        }
        else {
            ChristmasDragDropUtils.instance.detachCursorItem();
        }
    }
}
}

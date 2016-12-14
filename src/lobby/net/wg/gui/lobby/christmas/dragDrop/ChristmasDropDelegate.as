package net.wg.gui.lobby.christmas.dragDrop {
import flash.display.InteractiveObject;
import flash.display.Sprite;

import net.wg.gui.lobby.christmas.interfaces.IChristmasDropDelegate;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropItem;
import net.wg.infrastructure.events.DropEvent;

public class ChristmasDropDelegate extends Sprite implements IChristmasDropDelegate {

    private var _dropAcceptors:Vector.<InteractiveObject>;

    private var _dropElementLinkage:String;

    private var _hitArea:InteractiveObject = null;

    public function ChristmasDropDelegate(param1:InteractiveObject, param2:String) {
        super();
        this._hitArea = param1;
        this._dropElementLinkage = param2;
    }

    public final function dispose():void {
        this.tryClearDropAcceptors();
        this.detachCursorItem();
        this._hitArea = null;
    }

    public function getDropGroup():Vector.<InteractiveObject> {
        return this._dropAcceptors;
    }

    public function getHitArea():InteractiveObject {
        return this._hitArea;
    }

    public function onAfterDrop(param1:InteractiveObject, param2:InteractiveObject):void {
        this.dispatchDropEvent(DropEvent.AFTER_DROP, param1, null, param2);
        this.detachCursorItem();
    }

    public function onBeforeDrop(param1:InteractiveObject, param2:InteractiveObject):Boolean {
        var _loc3_:IChristmasDropItem = ChristmasDragDropUtils.instance.getDropItem(param2);
        if (_loc3_ != null && _loc3_.enabled && _loc3_.decorationInfo.decorationId >= 0) {
            this.dispatchDropEvent(DropEvent.BEFORE_DROP, param1, null, param2);
            return true;
        }
        return false;
    }

    public function onEndDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject):void {
        this.dispatchDropEvent(DropEvent.END_DROP, param1, param2, param3);
    }

    public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number):Boolean {
        var _loc5_:Sprite = App.utils.classFactory.getComponent(this._dropElementLinkage, Sprite);
        App.cursor.attachToCursor(_loc5_, -_loc5_.width, -_loc5_.height);
        this.dispatchDropEvent(DropEvent.START_DROP, param1, null, param2);
        return true;
    }

    public function setDropReceivers(param1:Vector.<InteractiveObject>):void {
        this.tryClearDropAcceptors();
        this._dropAcceptors = param1;
    }

    private function tryClearDropAcceptors():void {
        if (this._dropAcceptors != null) {
            this._dropAcceptors.splice(0, this._dropAcceptors.length);
            this._dropAcceptors = null;
        }
    }

    private function detachCursorItem():void {
        ChristmasDragDropUtils.instance.detachCursorItem();
    }

    private function dispatchDropEvent(param1:String, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject):void {
        dispatchEvent(new DropEvent(param1, param2, param3, param4));
    }
}
}

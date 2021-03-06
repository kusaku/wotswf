package net.wg.infrastructure.helpers {
import flash.display.InteractiveObject;
import flash.events.IEventDispatcher;

import net.wg.data.constants.Cursors;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.infrastructure.events.DropEvent;
import net.wg.infrastructure.exceptions.ArgumentException;
import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DropListDelegateCtrlr implements IDisposable {

    protected var _delegates:Vector.<IDropListDelegate> = null;

    private var _currentDroppedItem:InteractiveObject = null;

    public function DropListDelegateCtrlr(param1:Vector.<InteractiveObject>, param2:Class, param3:String) {
        var _loc4_:InteractiveObject = null;
        var _loc5_:IDropListDelegate = null;
        super();
        if (App.instance) {
            this.assertLinkage(param3);
            this._delegates = new Vector.<IDropListDelegate>();
            for each(_loc4_ in param1) {
                _loc5_ = new param2(_loc4_, param3);
                _loc5_.setPairedDropLists(this.getPairedElementsFromVector(_loc4_, param1));
                this._delegates.push(_loc5_);
                App.cursor.registerDragging(_loc5_, Cursors.DRAG_CLOSE);
                _loc4_.addEventListener(DropEvent.BEFORE_DROP, this.onControllerBeforeDropHandler);
                _loc4_.addEventListener(DropEvent.START_DROP, this.onControllerStartDropHandler);
                _loc4_.addEventListener(DropEvent.AFTER_DROP, this.onControllerAfterDropHandler);
            }
        }
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        var _loc1_:IDropListDelegate = null;
        var _loc2_:IEventDispatcher = null;
        for each(_loc1_ in this._delegates) {
            _loc2_ = _loc1_.getHitArea();
            _loc2_.removeEventListener(DropEvent.BEFORE_DROP, this.onControllerBeforeDropHandler);
            _loc2_.removeEventListener(DropEvent.START_DROP, this.onControllerStartDropHandler);
            _loc2_.removeEventListener(DropEvent.AFTER_DROP, this.onControllerAfterDropHandler);
            App.cursor.unRegisterDragging(_loc1_);
            _loc1_.dispose();
        }
        this._currentDroppedItem = null;
        this._delegates.splice(0, this._delegates.length);
        this._delegates = null;
    }

    protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject):void {
    }

    protected final function getDelegates():Vector.<IDropListDelegate> {
        return this._delegates;
    }

    protected function getPairedElementsFromVector(param1:InteractiveObject, param2:Vector.<InteractiveObject>):Vector.<InteractiveObject> {
        var checker:Function = null;
        var pairsFor:InteractiveObject = param1;
        var vector:Vector.<InteractiveObject> = param2;
        checker = function (param1:InteractiveObject, param2:int, param3:Vector.<InteractiveObject>):Boolean {
            return param1 != pairsFor;
        };
        return vector.filter(checker, null);
    }

    private function assertLinkage(param1:String):void {
        var _loc2_:String = "dropElementLinkage must has correct linkage value!";
        App.utils.asserter.assert(param1 != Values.EMPTY_STR, _loc2_, ArgumentException);
        this.assertNotNull(param1, "linkage");
    }

    private function assertNotNull(param1:Object, param2:String):void {
        App.utils.asserter.assertNotNull(param1, param2 + Errors.CANT_EMPTY);
    }

    private function onControllerBeforeDropHandler(param1:DropEvent):void {
        this._currentDroppedItem = param1.draggedItem;
        this.onHighlightHitAreas(true, this._currentDroppedItem);
    }

    private function onControllerAfterDropHandler(param1:DropEvent):void {
        this.assertNotNull(this._currentDroppedItem, "_currentDroppedItem");
        this.onHighlightHitAreas(false, this._currentDroppedItem);
        this._currentDroppedItem = null;
    }

    private function onControllerStartDropHandler(param1:DropEvent):void {
    }
}
}

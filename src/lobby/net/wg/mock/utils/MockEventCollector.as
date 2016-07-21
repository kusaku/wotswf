package net.wg.mock.utils {
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.utils.IEventCollector;

public class MockEventCollector implements IEventCollector {

    public function MockEventCollector() {
        super();
    }

    public function addEvent(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false):void {
    }

    public function disableDisposingForObj(param1:DisplayObject):void {
    }

    public function dispose():void {
    }

    public function enableDisposingForObj(param1:DisplayObject):void {
    }

    public function hasRegisteredEvent(param1:Object, param2:String, param3:Function, param4:Boolean):Boolean {
        return false;
    }

    public function logState():void {
    }

    public function objectIsRegistered(param1:Object):Boolean {
        return false;
    }

    public function removeAllEvents():void {
    }

    public function removeEvent(param1:Object, param2:String, param3:Function, param4:Boolean = false):void {
    }

    public function removeModuleEvents(param1:IDAAPIModule):void {
    }

    public function removeObjectEvents(param1:Object, param2:Boolean = true):void {
    }

    public function setEnabled(param1:Boolean):void {
    }
}
}

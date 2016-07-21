package net.wg.mock {
import flash.events.Event;

import net.wg.infrastructure.interfaces.IManagedContainer;
import net.wg.infrastructure.interfaces.IView;
import net.wg.infrastructure.managers.IContainerManager;
import net.wg.infrastructure.managers.ILoaderManager;

public class MockContainerManager implements IContainerManager {

    public function MockContainerManager() {
        super();
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
    }

    public function getContainersFocusOrder():Vector.<String> {
        return null;
    }

    public function hasEventListener(param1:String):Boolean {
        return false;
    }

    public function hide(param1:Array):void {
    }

    public function isModalViewsExisting():Boolean {
        return false;
    }

    public function isShown(param1:String):void {
    }

    public function registerContainer(param1:IManagedContainer):void {
    }

    public function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
    }

    public function show(param1:Array):void {
    }

    public function updateFocus(param1:Object = null):void {
    }

    public function updateStage(param1:Number, param2:Number):void {
    }

    public function willTrigger(param1:String):Boolean {
        return false;
    }

    public function set loader(param1:ILoaderManager):void {
    }

    public function get lastFocusedView():IView {
        return null;
    }

    public function set lastFocusedView(param1:IView):void {
    }

    public function dispatchEvent(param1:Event):Boolean {
        return false;
    }
}
}

package net.wg.infrastructure.interfaces {
public interface IManagedContainer extends IUIComponentEx {

    function updateStage(param1:Number, param2:Number):void;

    function tryToSetFocus(param1:Boolean = false):Boolean;

    function tryToUpdateContent():void;

    function setFocusedView(param1:IManagedContent):void;

    function getTopmostView():IManagedContent;

    function get type():String;

    function set type(param1:String):void;

    function get manageSize():Boolean;

    function set manageSize(param1:Boolean):void;
}
}

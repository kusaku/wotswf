package net.wg.gui.fortBase {
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public interface IBattleNotifierVO extends IDAAPIDataClass {

    function get battleType():String;

    function set battleType(param1:String):void;

    function get hasActiveBattles():Boolean;

    function set hasActiveBattles(param1:Boolean):void;

    function get tooltip():String;

    function set tooltip(param1:String):void;

    function get direction():int;

    function set direction(param1:int):void;
}
}

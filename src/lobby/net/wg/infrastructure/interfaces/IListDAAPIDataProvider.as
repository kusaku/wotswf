package net.wg.infrastructure.interfaces {
import scaleform.clik.interfaces.IDataProvider;

public interface IListDAAPIDataProvider extends IDAAPISortable, IDataProvider, IDAAPIModule {

    function invalidateItem(param1:int, param2:Object):void;

    function invalidateItems(param1:Array, param2:Array):void;

    function get maxCacheSize():int;

    function set maxCacheSize(param1:int):void;
}
}

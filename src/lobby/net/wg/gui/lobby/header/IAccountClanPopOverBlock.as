package net.wg.gui.lobby.header {
import net.wg.infrastructure.interfaces.IDAAPIDataClass;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IAccountClanPopOverBlock extends IUIComponentEx {

    function setData(param1:IDAAPIDataClass):void;

    function setEmblem(param1:String):void;
}
}

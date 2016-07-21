package net.wg.gui.lobby.fortifications.cmp.main {
import net.wg.gui.lobby.fortifications.data.FortificationVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IFortHeaderClanInfo extends IUIComponentEx {

    function applyClanData(param1:FortificationVO):void;

    function setClanImage(param1:String):void;
}
}

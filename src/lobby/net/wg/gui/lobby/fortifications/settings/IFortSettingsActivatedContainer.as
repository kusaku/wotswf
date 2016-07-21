package net.wg.gui.lobby.fortifications.settings {
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.ISpriteEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

public interface IFortSettingsActivatedContainer extends ISpriteEx, IViewStackContent, IPopOverCaller {

    function canDisableDefHour(param1:Boolean):void;
}
}

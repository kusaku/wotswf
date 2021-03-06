package net.wg.gui.lobby.fortifications.utils {
import net.wg.gui.lobby.fortifications.cmp.IFortMainView;
import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IFortModeSwitcher extends IDisposable {

    function init(param1:IFortMainView):void;

    function applyMode(param1:FortModeStateVO):void;
}
}

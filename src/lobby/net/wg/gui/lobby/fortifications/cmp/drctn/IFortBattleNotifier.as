package net.wg.gui.lobby.fortifications.cmp.drctn {
import net.wg.gui.fortBase.IBattleNotifierVO;
import net.wg.gui.fortBase.IDirectionModeClient;
import net.wg.gui.fortBase.ITransportModeClient;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;

public interface IFortBattleNotifier extends IPopOverCaller, IDirectionModeClient, ITransportModeClient, ITweenAnimatorHandler {

    function setData(param1:IBattleNotifierVO):void;
}
}

package net.wg.gui.lobby.fortifications.utils {
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.fortBase.ITransportModeClient;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface ITransportingHelper extends IDisposable, ITransportModeClient {

    function getModeVO(param1:Boolean, param2:Boolean):IFortModeVO;
}
}

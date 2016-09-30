package net.wg.infrastructure.managers.impl {
import net.wg.data.Aliases;
import net.wg.data.daapi.LoadViewVO;

public class LoaderManagerLobby extends LoaderManagerBase {

    private var firstTimeLoadLobby:Boolean = false;

    public function LoaderManagerLobby() {
        super();
    }

    override protected function loadView(param1:LoadViewVO):void {
        if (param1.alias == Aliases.LOBBY && !this.firstTimeLoadLobby) {
            loadLibraries(Vector.<String>(["guiControlsLobbyBattleDynamic.swf", "guiControlsLobbyDynamic.swf", "popovers.swf", "IconLibrary.swf"]));
            this.firstTimeLoadLobby = true;
        }
        super.loadView(param1);
    }
}
}
